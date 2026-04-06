// ============================================================
// Players Routes — Full CRUD + Transfer + Stats
// ============================================================
// SQL Concepts: INSERT, UPDATE, DELETE, SELECT with WHERE,
//               JOIN, subquery, SUM, AVG, GROUP BY
// ============================================================

const express = require('express');
const router = express.Router();

// GET /api/players — List all players with filters
// SQL: SELECT + WHERE + optional JOIN for sport/team filtering
router.get('/', (req, res) => {
    try {
        const db = req.app.locals.db;
        const { sport_id, team_id, status, position, search } = req.query;

        let sql = `
            SELECT 
                p.player_id, p.first_name, p.last_name, p.email,
                p.date_of_birth, p.gender, p.jersey_number, p.position,
                p.status, p.joined_date,
                t.team_id, t.name AS team_name,
                s.sport_id, s.name AS sport_name
            FROM players p
            LEFT JOIN teams t  ON p.team_id  = t.team_id
            LEFT JOIN sports s ON t.sport_id = s.sport_id
            WHERE p.is_deleted = 0
        `;

        const params = [];

        if (sport_id) {
            sql += ' AND s.sport_id = ?';
            params.push(sport_id);
        }
        if (team_id) {
            sql += ' AND p.team_id = ?';
            params.push(team_id);
        }
        if (status) {
            sql += ' AND p.status = ?';
            params.push(status);
        }
        if (position) {
            sql += ' AND p.position = ?';
            params.push(position);
        }
        if (search) {
            sql += ' AND (p.first_name LIKE ? OR p.last_name LIKE ? OR p.email LIKE ?)';
            const term = `%${search}%`;
            params.push(term, term, term);
        }

        sql += ' ORDER BY p.last_name, p.first_name';

        const players = db.prepare(sql).all(...params);
        res.json(players);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET /api/players/:id — Player detail + match history
// SQL: JOIN, subquery for match history
router.get('/:id', (req, res) => {
    try {
        const db = req.app.locals.db;

        const player = db.prepare(`
            SELECT 
                p.player_id, p.first_name, p.last_name, p.email,
                p.date_of_birth, p.gender, p.jersey_number, p.position,
                p.status, p.joined_date,
                t.team_id, t.name AS team_name,
                s.sport_id, s.name AS sport_name
            FROM players p
            LEFT JOIN teams t  ON p.team_id  = t.team_id
            LEFT JOIN sports s ON t.sport_id = s.sport_id
            WHERE p.player_id = ? AND p.is_deleted = 0
        `).get(req.params.id);

        if (!player) return res.status(404).json({ error: 'Player not found' });

        // Match history (subquery + JOIN)
        const matchHistory = db.prepare(`
            SELECT 
                m.match_id, m.match_date, m.status AS match_status,
                m.result_summary, e.name AS event_name,
                pms.runs_scored, pms.wickets_taken, pms.goals_scored,
                pms.assists, pms.points_won, pms.sets_won, pms.rating
            FROM player_match_stats pms
            JOIN matches m ON pms.match_id = m.match_id
            LEFT JOIN events e ON m.event_id = e.event_id
            WHERE pms.player_id = ?
            ORDER BY m.match_date DESC
        `).all(req.params.id);

        res.json({ ...player, match_history: matchHistory });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// POST /api/players — Create player
// SQL: INSERT
router.post('/', (req, res) => {
    try {
        const db = req.app.locals.db;
        const { first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position } = req.body;

        if (!first_name || !last_name) {
            return res.status(400).json({ error: 'First name and last name are required' });
        }

        const result = db.prepare(`
            INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        `).run(
            first_name, last_name, email || null, date_of_birth || null,
            gender || null, team_id || null, jersey_number || null, position || null
        );

        const player = db.prepare('SELECT * FROM players WHERE player_id = ?').get(result.lastInsertRowid);
        res.status(201).json(player);
    } catch (err) {
        if (err.message.includes('UNIQUE constraint failed')) {
            return res.status(409).json({ error: 'A player with this email already exists' });
        }
        res.status(500).json({ error: err.message });
    }
});

// PUT /api/players/:id — Edit player
// SQL: UPDATE
router.put('/:id', (req, res) => {
    try {
        const db = req.app.locals.db;
        const { first_name, last_name, email, date_of_birth, gender, jersey_number, position, status } = req.body;

        const existing = db.prepare('SELECT * FROM players WHERE player_id = ? AND is_deleted = 0').get(req.params.id);
        if (!existing) return res.status(404).json({ error: 'Player not found' });

        db.prepare(`
            UPDATE players 
            SET first_name = ?, last_name = ?, email = ?, date_of_birth = ?,
                gender = ?, jersey_number = ?, position = ?, status = ?
            WHERE player_id = ?
        `).run(
            first_name || existing.first_name,
            last_name || existing.last_name,
            email !== undefined ? email : existing.email,
            date_of_birth !== undefined ? date_of_birth : existing.date_of_birth,
            gender !== undefined ? gender : existing.gender,
            jersey_number !== undefined ? jersey_number : existing.jersey_number,
            position !== undefined ? position : existing.position,
            status || existing.status,
            req.params.id
        );

        const player = db.prepare('SELECT * FROM players WHERE player_id = ?').get(req.params.id);
        res.json(player);
    } catch (err) {
        if (err.message.includes('UNIQUE constraint failed')) {
            return res.status(409).json({ error: 'A player with this email already exists' });
        }
        res.status(500).json({ error: err.message });
    }
});

// DELETE /api/players/:id — Soft-delete player
// SQL: UPDATE is_deleted = 1 (soft delete preserves historical stats)
router.delete('/:id', (req, res) => {
    try {
        const db = req.app.locals.db;
        const existing = db.prepare('SELECT * FROM players WHERE player_id = ? AND is_deleted = 0').get(req.params.id);
        if (!existing) return res.status(404).json({ error: 'Player not found' });

        // Soft delete: set is_deleted = 1 instead of hard DELETE
        db.prepare('UPDATE players SET is_deleted = 1 WHERE player_id = ?').run(req.params.id);

        res.json({ 
            message: 'Player soft-deleted successfully',
            note: 'Historical stats are preserved. Player will no longer appear in active lists.'
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// PUT /api/players/:id/transfer — Transfer player to different team
// SQL: UPDATE team_id
router.put('/:id/transfer', (req, res) => {
    try {
        const db = req.app.locals.db;
        const { team_id } = req.body;

        if (!team_id) return res.status(400).json({ error: 'team_id is required for transfer' });

        const player = db.prepare(`
            SELECT p.*, t.sport_id AS current_sport_id
            FROM players p
            LEFT JOIN teams t ON p.team_id = t.team_id
            WHERE p.player_id = ? AND p.is_deleted = 0
        `).get(req.params.id);

        if (!player) return res.status(404).json({ error: 'Player not found' });

        // Validate target team exists and is same sport
        const targetTeam = db.prepare('SELECT * FROM teams WHERE team_id = ?').get(team_id);
        if (!targetTeam) return res.status(400).json({ error: 'Target team not found' });

        if (player.current_sport_id && targetTeam.sport_id !== player.current_sport_id) {
            return res.status(400).json({ error: 'Cannot transfer to a team in a different sport' });
        }

        db.prepare('UPDATE players SET team_id = ? WHERE player_id = ?').run(team_id, req.params.id);

        res.json({ 
            message: 'Player transferred successfully',
            from_team: player.team_id,
            to_team: team_id
        });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET /api/players/:id/stats — Career stats aggregated
// SQL: SUM, AVG, GROUP BY
router.get('/:id/stats', (req, res) => {
    try {
        const db = req.app.locals.db;

        const stats = db.prepare(`
            SELECT 
                p.player_id,
                p.first_name || ' ' || p.last_name AS player_name,
                COUNT(pms.match_id) AS matches_played,
                COALESCE(SUM(pms.runs_scored), 0)   AS total_runs,
                COALESCE(SUM(pms.balls_faced), 0)    AS total_balls,
                COALESCE(SUM(pms.wickets_taken), 0)  AS total_wickets,
                COALESCE(SUM(pms.goals_scored), 0)   AS total_goals,
                COALESCE(SUM(pms.assists), 0)        AS total_assists,
                COALESCE(SUM(pms.yellow_cards), 0)   AS total_yellows,
                COALESCE(SUM(pms.red_cards), 0)      AS total_reds,
                COALESCE(SUM(pms.points_won), 0)     AS total_points,
                COALESCE(SUM(pms.sets_won), 0)       AS total_sets,
                ROUND(AVG(pms.rating), 2)            AS avg_rating
            FROM players p
            LEFT JOIN player_match_stats pms ON p.player_id = pms.player_id
            WHERE p.player_id = ? AND p.is_deleted = 0
            GROUP BY p.player_id
        `).get(req.params.id);

        if (!stats) return res.status(404).json({ error: 'Player not found' });

        res.json(stats);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
