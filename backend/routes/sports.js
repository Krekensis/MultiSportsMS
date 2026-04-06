// ============================================================
// Sports Routes — GET only (read-only reference data)
// ============================================================
// SQL Concepts: Simple SELECT, JOIN, WHERE
// ============================================================

const express = require('express');
const router = express.Router();

// GET /api/sports — List all sports with rules
// SQL: Simple SELECT from sports table
router.get('/', (req, res) => {
    try {
        const db = req.app.locals.db;
        const sports = db.prepare(`
            SELECT 
                sport_id, name, category, 
                max_players_per_team, min_players_per_team, 
                scoring_unit, description, rules_json, created_at
            FROM sports
            ORDER BY sport_id
        `).all();

        // Parse rules_json for each sport
        const result = sports.map(s => ({
            ...s,
            rules: s.rules_json ? JSON.parse(s.rules_json) : null
        }));

        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// GET /api/sports/:id — Sport detail with teams
// SQL: JOIN sports with teams, LEFT JOIN to count players
router.get('/:id', (req, res) => {
    try {
        const db = req.app.locals.db;
        const { id } = req.params;

        // Get sport details
        const sport = db.prepare(`
            SELECT sport_id, name, category, 
                   max_players_per_team, min_players_per_team,
                   scoring_unit, description, rules_json, created_at
            FROM sports 
            WHERE sport_id = ?
        `).get(id);

        if (!sport) {
            return res.status(404).json({ error: 'Sport not found' });
        }

        sport.rules = sport.rules_json ? JSON.parse(sport.rules_json) : null;

        // Get teams in this sport with player counts
        // SQL: LEFT JOIN teams with players, GROUP BY to count
        const teams = db.prepare(`
            SELECT 
                t.team_id, t.name, t.status, t.founded_year,
                COUNT(p.player_id) AS player_count,
                COALESCE(c.first_name || ' ' || c.last_name, 'No Coach') AS coach_name
            FROM teams t
            LEFT JOIN players p ON t.team_id = p.team_id AND p.is_deleted = 0
            LEFT JOIN coaches c ON t.coach_id = c.coach_id
            WHERE t.sport_id = ?
            GROUP BY t.team_id
            ORDER BY t.name
        `).all(id);

        res.json({ ...sport, teams });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
