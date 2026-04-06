-- ============================================================
-- Multi-Sports Management System — Seed Data
-- ============================================================
-- Populates the database with realistic sample data for demonstration.
-- 4 sports, 6 venues, 8 coaches, 8 teams, 48 players,
-- 4 events, 8 matches, 60+ match events, player stats.
-- ============================================================

-- ============================================================
-- SPORTS (4 sports with detailed rules JSON)
-- ============================================================
INSERT INTO sports (name, category, max_players_per_team, min_players_per_team, scoring_unit, description, rules_json) VALUES
('Cricket', 'Outdoor', 11, 11, 'runs',
 'A bat-and-ball game played between two teams of eleven players on a field.',
 '{"overs_per_innings": 20, "innings": 2, "wicket_types": ["bowled","caught","lbw","run_out","stumped","hit_wicket"], "extras": ["wide","no_ball","bye","leg_bye"], "boundary_4": 4, "boundary_6": 6}'),

('Football', 'Outdoor', 11, 7, 'goals',
 'A team sport played between two teams of eleven players with a spherical ball.',
 '{"halves": 2, "half_duration_minutes": 45, "extra_time_minutes": 30, "cards": ["yellow","red"], "offside": true, "substitutions_allowed": 5}'),

('Tennis', 'Outdoor', 2, 1, 'points',
 'A racket sport played individually (singles) or in pairs (doubles).',
 '{"sets_to_win": 2, "games_per_set": 6, "points": ["0","15","30","40","deuce","advantage"], "tiebreak_at": 6, "final_set_tiebreak": true}'),

('Badminton', 'Indoor', 2, 1, 'points',
 'A racket sport played using racquets to hit a shuttlecock across a net.',
 '{"sets_to_win": 2, "points_per_set": 21, "win_by": 2, "max_points": 30, "rally_point_scoring": true}');

-- ============================================================
-- VENUES (6 venues — 2 cricket, 2 football, 1 tennis, 1 badminton)
-- ============================================================
INSERT INTO venues (name, location, capacity, surface_type) VALUES
('Greenfield Cricket Stadium', 'Mumbai, India', 33000, 'Natural Turf'),
('Riverside Cricket Ground',   'Chennai, India', 25000, 'Natural Turf'),
('Metro Football Arena',       'Bangalore, India', 40000, 'Artificial Turf'),
('Thunderdome Stadium',        'Delhi, India', 35000, 'Natural Turf'),
('Ace Tennis Club',             'Hyderabad, India', 5000, 'Hard Court'),
('Shuttle Sports Complex',     'Pune, India', 3000, 'Wooden');

-- ============================================================
-- COACHES (8 coaches with varied specializations)
-- ============================================================
INSERT INTO coaches (first_name, last_name, email, phone, specialization, experience_years) VALUES
('Rahul',   'Dravid',    'rahul.dravid@msms.com',    '+91-9001000001', 'Cricket Batting',       18),
('Anil',    'Kumble',    'anil.kumble@msms.com',      '+91-9001000002', 'Cricket Bowling',       15),
('Marco',   'Silva',     'marco.silva@msms.com',      '+91-9001000003', 'Football Tactics',      12),
('Elena',   'Rodriguez', 'elena.rodriguez@msms.com',  '+91-9001000004', 'Football Defense',      10),
('Patrick', 'Mouratoglou', 'patrick.m@msms.com',      '+91-9001000005', 'Tennis Strategy',       20),
('Li',      'Wei',       'li.wei@msms.com',            '+91-9001000006', 'Tennis Conditioning',   8),
('Pullela', 'Gopichand', 'pullela.g@msms.com',         '+91-9001000007', 'Badminton Singles',     22),
('Tan',     'Kim Her',   'tan.kimher@msms.com',        '+91-9001000008', 'Badminton Doubles',     14);

-- ============================================================
-- TEAMS (8 teams — 2 per sport)
-- ============================================================
INSERT INTO teams (name, sport_id, coach_id, founded_year, home_venue_id, status) VALUES
('Royal Strikers',  1, 1, 2018, 1, 'active'),    -- Cricket, Coach Rahul, Greenfield
('Thunder Lions',   1, 2, 2019, 2, 'active'),    -- Cricket, Coach Anil, Riverside
('Phoenix FC',      2, 3, 2017, 3, 'active'),    -- Football, Coach Marco, Metro Arena
('Storm United',    2, 4, 2020, 4, 'active'),    -- Football, Coach Elena, Thunderdome
('Ace Elite',       3, 5, 2016, 5, 'active'),    -- Tennis, Coach Patrick, Ace Club
('Net Blazers',     3, 6, 2021, 5, 'active'),    -- Tennis, Coach Li, Ace Club
('Shuttle Kings',   4, 7, 2015, 6, 'active'),    -- Badminton, Coach Pullela, Shuttle Complex
('Smash Warriors',  4, 8, 2019, 6, 'active');    -- Badminton, Coach Tan, Shuttle Complex

-- ============================================================
-- PLAYERS (48 total — 11 per cricket team, 11 per football team, 3 per tennis team, 4 per badminton team)
-- ============================================================

-- Royal Strikers (Cricket - Team 1) — 11 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('Virat',    'Sharma',   'virat.sharma@msms.com',    '1998-05-15', 'Male', 1, 18, 'Batsman',        'active'),
('Rohit',    'Patel',    'rohit.patel@msms.com',     '1997-03-22', 'Male', 1, 45, 'Batsman',        'active'),
('Shubman', 'Gill',     'shubman.gill@msms.com',    '1999-09-08', 'Male', 1, 7,  'Batsman',        'active'),
('Hardik',   'Pandya',   'hardik.pandya@msms.com',   '1996-11-11', 'Male', 1, 33, 'All-Rounder',    'active'),
('Ravindra', 'Jadeja',   'ravindra.jadeja@msms.com', '1995-12-06', 'Male', 1, 8,  'All-Rounder',    'active'),
('Jasprit',  'Bumrah',   'jasprit.bumrah@msms.com',  '1997-01-28', 'Male', 1, 93, 'Bowler',         'active'),
('Mohammed', 'Shami',    'mohammed.shami@msms.com',  '1994-09-03', 'Male', 1, 11, 'Bowler',         'active'),
('Rishabh',  'Iyer',     'rishabh.iyer@msms.com',    '2000-04-12', 'Male', 1, 77, 'Wicket-Keeper',  'active'),
('Kuldeep',  'Yadav',    'kuldeep.yadav@msms.com',   '1998-08-14', 'Male', 1, 23, 'Bowler',         'active'),
('Axar',     'Singh',    'axar.singh@msms.com',      '1997-06-20', 'Male', 1, 28, 'All-Rounder',    'active'),
('Shreyas',  'Kumar',    'shreyas.kumar@msms.com',   '1999-02-18', 'Male', 1, 41, 'Batsman',        'active');

-- Thunder Lions (Cricket - Team 2) — 11 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('KL',       'Rahul',    'kl.rahul@msms.com',        '1996-04-18', 'Male', 2, 1,  'Batsman',        'active'),
('Suryakumar','Yadav',   'suryakumar.y@msms.com',    '1998-09-14', 'Male', 2, 63, 'Batsman',        'active'),
('Ishan',    'Kishan',   'ishan.kishan@msms.com',    '2000-07-18', 'Male', 2, 32, 'Wicket-Keeper',  'active'),
('Shardul',  'Thakur',   'shardul.thakur@msms.com',  '1995-10-16', 'Male', 2, 54, 'All-Rounder',    'active'),
('Yuzvendra','Chahal',   'yuzvendra.c@msms.com',     '1997-07-23', 'Male', 2, 3,  'Bowler',         'active'),
('Bhuvneshwar','Kumar',  'bhuvneshwar.k@msms.com',   '1993-02-05', 'Male', 2, 15, 'Bowler',         'active'),
('Dinesh',   'Karthik',  'dinesh.karthik@msms.com',  '1992-06-01', 'Male', 2, 21, 'Batsman',        'active'),
('Washington','Sundar',  'washington.s@msms.com',     '2001-10-05', 'Male', 2, 29, 'All-Rounder',    'active'),
('Deepak',   'Chahar',   'deepak.chahar@msms.com',   '1996-08-07', 'Male', 2, 9,  'Bowler',         'active'),
('Prithvi',  'Shaw',     'prithvi.shaw@msms.com',    '2001-11-09', 'Male', 2, 44, 'Batsman',        'active'),
('Navdeep',  'Saini',    'navdeep.saini@msms.com',   '1996-11-23', 'Male', 2, 19, 'Bowler',         'active');

-- Phoenix FC (Football - Team 3) — 11 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('Carlos',   'Martinez', 'carlos.m@msms.com',        '1995-03-12', 'Male', 3, 1,  'Goalkeeper',  'active'),
('Ahmed',    'Hassan',   'ahmed.hassan@msms.com',     '1997-07-08', 'Male', 3, 4,  'Defender',    'active'),
('David',    'Kim',      'david.kim@msms.com',        '1996-11-25', 'Male', 3, 5,  'Defender',    'active'),
('Lucas',    'Santos',   'lucas.santos@msms.com',     '1998-05-14', 'Male', 3, 3,  'Defender',    'active'),
('James',    'Wilson',   'james.wilson@msms.com',     '1997-09-30', 'Male', 3, 6,  'Midfielder',  'active'),
('Omar',     'Ali',      'omar.ali@msms.com',         '1999-01-17', 'Male', 3, 8,  'Midfielder',  'active'),
('Yuki',     'Tanaka',   'yuki.tanaka@msms.com',      '1998-04-22', 'Male', 3, 10, 'Midfielder',  'active'),
('Leo',      'Fernandez','leo.fernandez@msms.com',    '1996-12-05', 'Male', 3, 7,  'Forward',     'active'),
('Marcus',   'Johnson',  'marcus.johnson@msms.com',   '1997-08-19', 'Male', 3, 9,  'Forward',     'active'),
('Ravi',     'Nair',     'ravi.nair@msms.com',        '2000-02-28', 'Male', 3, 11, 'Forward',     'active'),
('Pedro',    'Garcia',   'pedro.garcia@msms.com',     '1995-06-13', 'Male', 3, 2,  'Defender',    'active');

-- Storm United (Football - Team 4) — 11 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('Viktor',   'Petrov',   'viktor.petrov@msms.com',    '1994-10-05', 'Male', 4, 1,  'Goalkeeper',  'active'),
('Arjun',    'Reddy',    'arjun.reddy@msms.com',      '1997-03-18', 'Male', 4, 4,  'Defender',    'active'),
('Chen',     'Wei',      'chen.wei@msms.com',          '1996-08-27', 'Male', 4, 5,  'Defender',    'active'),
('Bruno',    'Costa',    'bruno.costa@msms.com',       '1998-01-09', 'Male', 4, 3,  'Defender',    'active'),
('Takeshi',  'Yamamoto', 'takeshi.y@msms.com',         '1999-05-21', 'Male', 4, 6,  'Midfielder',  'active'),
('Sanjay',   'Gupta',    'sanjay.gupta@msms.com',      '1997-12-14', 'Male', 4, 8,  'Midfielder',  'active'),
('Felix',    'Mueller',  'felix.mueller@msms.com',     '1998-07-03', 'Male', 4, 10, 'Midfielder',  'active'),
('Diego',    'Rivera',   'diego.rivera@msms.com',      '1996-04-16', 'Male', 4, 7,  'Forward',     'active'),
('Kwame',    'Asante',   'kwame.asante@msms.com',      '1999-09-28', 'Male', 4, 9,  'Forward',     'active'),
('Nikolai',  'Ivanov',   'nikolai.iv@msms.com',        '2000-06-11', 'Male', 4, 11, 'Forward',     'active'),
('Hassan',   'Omar',     'hassan.omar@msms.com',       '1995-11-22', 'Male', 4, 2,  'Defender',    'active');

-- Ace Elite (Tennis - Team 5) — 3 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('Rafael',   'Mendez',   'rafael.mendez@msms.com',    '1996-06-03', 'Male', 5, 1, 'Singles Player', 'active'),
('Sofia',    'Laurent',  'sofia.laurent@msms.com',     '1998-10-21', 'Female', 5, 2, 'Singles Player', 'active'),
('Andrei',   'Volkov',   'andrei.volkov@msms.com',     '1997-02-14', 'Male', 5, 3, 'Doubles Player', 'active');

-- Net Blazers (Tennis - Team 6) — 3 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('Nina',     'Petrova',  'nina.petrova@msms.com',      '1999-04-07', 'Female', 6, 1, 'Singles Player', 'active'),
('Kenji',    'Watanabe', 'kenji.watanabe@msms.com',    '1997-08-30', 'Male', 6, 2, 'Singles Player', 'active'),
('Maria',    'Gonzalez', 'maria.gonzalez@msms.com',    '1998-12-15', 'Female', 6, 3, 'Doubles Player', 'active');

-- Shuttle Kings (Badminton - Team 7) — 4 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('Lakshya',  'Sen',      'lakshya.sen@msms.com',       '2001-08-16', 'Male', 7, 1, 'Singles Player', 'active'),
('Saina',    'Patil',    'saina.patil@msms.com',       '1998-03-17', 'Female', 7, 2, 'Singles Player', 'active'),
('Chirag',   'Shetty',   'chirag.shetty@msms.com',    '1997-07-04', 'Male', 7, 3, 'Doubles Player', 'active'),
('Satwiksai','Rankireddy','satwik.r@msms.com',         '2000-08-13', 'Male', 7, 4, 'Doubles Player', 'active');

-- Smash Warriors (Badminton - Team 8) — 4 players
INSERT INTO players (first_name, last_name, email, date_of_birth, gender, team_id, jersey_number, position, status) VALUES
('Viktor',   'Axelsen',  'viktor.axelsen@msms.com',    '1994-01-04', 'Male', 8, 1, 'Singles Player', 'active'),
('PV',       'Sindhu',   'pv.sindhu@msms.com',          '1995-07-05', 'Female', 8, 2, 'Singles Player', 'active'),
('Aaron',    'Chia',     'aaron.chia@msms.com',         '1998-06-15', 'Male', 8, 3, 'Doubles Player', 'active'),
('Soh',      'Wooi Yik', 'soh.wooiyik@msms.com',       '1998-02-23', 'Male', 8, 4, 'Doubles Player', 'active');

-- ============================================================
-- EVENTS (4 tournaments — 1 per sport)
-- ============================================================
INSERT INTO events (name, sport_id, event_type, format, start_date, end_date, status, description) VALUES
('Premier Cricket League 2026',    1, 'league',      'round-robin',   '2026-03-01', '2026-05-30', 'ongoing',   'Top-tier T20 cricket league with round-robin format'),
('Champions Football Cup 2026',    2, 'tournament',  'knockout',      '2026-04-01', '2026-06-15', 'ongoing',   'Elite football tournament in knockout format'),
('Grand Slam Tennis Open 2026',    3, 'championship','group+knockout','2026-03-15', '2026-04-15', 'ongoing',   'Premier tennis championship event'),
('National Badminton Trophy 2026', 4, 'tournament',  'knockout',      '2026-04-01', '2026-04-30', 'upcoming',  'National-level badminton knockout tournament');

-- ============================================================
-- EVENT_TEAMS (Register teams to their tournaments)
-- ============================================================
INSERT INTO event_teams (event_id, team_id, seed_rank) VALUES
(1, 1, 1),   -- Royal Strikers in Cricket League (seed 1)
(1, 2, 2),   -- Thunder Lions in Cricket League (seed 2)
(2, 3, 1),   -- Phoenix FC in Football Cup (seed 1)
(2, 4, 2),   -- Storm United in Football Cup (seed 2)
(3, 5, 1),   -- Ace Elite in Tennis Open (seed 1)
(3, 6, 2),   -- Net Blazers in Tennis Open (seed 2)
(4, 7, 1),   -- Shuttle Kings in Badminton Trophy (seed 1)
(4, 8, 2);   -- Smash Warriors in Badminton Trophy (seed 2)

-- ============================================================
-- MATCHES (8 matches — 2 per sport: 1 completed + 1 upcoming each)
-- ============================================================
INSERT INTO matches (event_id, venue_id, match_date, status, round_name, result_summary) VALUES
-- Cricket matches
(1, 1, '2026-03-15 14:00:00', 'completed', 'Round 1', 'Royal Strikers won by 25 runs'),
(1, 2, '2026-04-10 14:00:00', 'scheduled', 'Round 2', NULL),

-- Football matches
(2, 3, '2026-04-05 18:00:00', 'completed', 'Semifinal', 'Phoenix FC won 3-1'),
(2, 4, '2026-04-20 18:00:00', 'scheduled', 'Final', NULL),

-- Tennis matches
(3, 5, '2026-03-20 10:00:00', 'completed', 'Group Stage', 'Ace Elite won 2-1 in sets'),
(3, 5, '2026-04-08 10:00:00', 'scheduled', 'Semifinal', NULL),

-- Badminton matches
(4, 6, '2026-04-05 16:00:00', 'completed', 'Semifinal', 'Shuttle Kings won 2-0 in sets'),
(4, 6, '2026-04-15 16:00:00', 'scheduled', 'Final', NULL);

-- ============================================================
-- MATCH_TEAMS (Link teams to matches with scores)
-- ============================================================
INSERT INTO match_teams (match_id, team_id, score, is_winner, innings_1_score, innings_2_score, sets_won) VALUES
-- Cricket Match 1: Royal Strikers 185 vs Thunder Lions 160
(1, 1, 185, 1, 185, NULL, NULL),
(1, 2, 160, 0, 160, NULL, NULL),
-- Cricket Match 2 (scheduled)
(2, 1, 0, 0, NULL, NULL, NULL),
(2, 2, 0, 0, NULL, NULL, NULL),

-- Football Match 3: Phoenix FC 3 vs Storm United 1
(3, 3, 3, 1, NULL, NULL, NULL),
(3, 4, 1, 0, NULL, NULL, NULL),
-- Football Match 4 (scheduled)
(4, 3, 0, 0, NULL, NULL, NULL),
(4, 4, 0, 0, NULL, NULL, NULL),

-- Tennis Match 5: Ace Elite 2 sets vs Net Blazers 1 set
(5, 5, 2, 1, NULL, NULL, 2),
(5, 6, 1, 0, NULL, NULL, 1),
-- Tennis Match 6 (scheduled)
(6, 5, 0, 0, NULL, NULL, NULL),
(6, 6, 0, 0, NULL, NULL, NULL),

-- Badminton Match 7: Shuttle Kings 2 sets vs Smash Warriors 0 sets
(7, 7, 2, 1, NULL, NULL, 2),
(7, 8, 0, 0, NULL, NULL, 0),
-- Badminton Match 8 (scheduled)
(8, 7, 0, 0, NULL, NULL, NULL),
(8, 8, 0, 0, NULL, NULL, NULL);

-- ============================================================
-- SCHEDULES (scheduling metadata for all matches)
-- ============================================================
INSERT INTO schedules (match_id, scheduled_time, actual_start_time, actual_end_time, notes) VALUES
(1, '2026-03-15 14:00:00', '2026-03-15 14:05:00', '2026-03-15 17:30:00', 'Match completed without delays'),
(2, '2026-04-10 14:00:00', NULL, NULL, 'Upcoming round 2 fixture'),
(3, '2026-04-05 18:00:00', '2026-04-05 18:02:00', '2026-04-05 19:50:00', 'Exciting semifinal'),
(4, '2026-04-20 18:00:00', NULL, NULL, 'Upcoming final'),
(5, '2026-03-20 10:00:00', '2026-03-20 10:10:00', '2026-03-20 12:45:00', 'Three-set thriller'),
(6, '2026-04-08 10:00:00', NULL, NULL, 'Semifinal matchup'),
(7, '2026-04-05 16:00:00', '2026-04-05 16:05:00', '2026-04-05 17:15:00', 'Dominant performance by Shuttle Kings'),
(8, '2026-04-15 16:00:00', NULL, NULL, 'Anticipated final');

-- ============================================================
-- MATCH_EVENTS (60+ events for completed matches)
-- ============================================================

-- CRICKET MATCH 1 (match_id=1): Royal Strikers vs Thunder Lions
-- Royal Strikers batting — some key events
INSERT INTO match_events (match_id, team_id, player_id, event_type, minute_or_over, ball_in_over, runs_scored, detail) VALUES
(1, 1, 1,  'run',    1, 1, 4, 'Driven through covers for four'),
(1, 1, 1,  'run',    1, 2, 1, 'Single to mid-on'),
(1, 1, 2,  'run',    1, 3, 6, 'Massive six over long-on'),
(1, 1, 2,  'run',    1, 4, 0, 'Dot ball, good length delivery'),
(1, 1, 2,  'run',    1, 5, 2, 'Quick double to deep square leg'),
(1, 1, 1,  'boundary_4', 2, 1, 4, 'Pulled to fine leg boundary'),
(1, 1, 1,  'run',    2, 2, 1, 'Rotated strike'),
(1, 1, 2,  'run',    2, 3, 4, 'Flicked off pads for four'),
(1, 2, 2,  'wicket', 3, 4, 0, 'Caught at slip, bowler: Bhuvneshwar'),
(1, 1, 3,  'run',    4, 1, 6, 'Lofted straight for six'),
(1, 1, 3,  'run',    4, 2, 2, 'Pushed through gap on off side'),
(1, 1, 4,  'run',    5, 1, 4, 'Clean drive through extra cover'),
(1, 1, 4,  'boundary_6', 5, 3, 6, 'Deposited into the stands'),
(1, 1, 1,  'run',    6, 1, 2, 'Quick running between wickets'),
(1, 2, 3,  'wicket', 7, 2, 0, 'LBW, hitting middle stump'),
(1, 1, 5,  'run',    8, 1, 4, 'Late cut to third man boundary'),
(1, 1, 5,  'run',    8, 3, 1, 'Nudged to leg side'),
(1, 1, 1,  'run',    9, 1, 6, 'Tonked over midwicket'),
(1, 2, 1,  'wicket', 10, 3, 0, 'Bowled through the gate'),

-- Thunder Lions batting — key events
(1, 2, 12, 'run',    1, 1, 4, 'Elegant cover drive'),
(1, 2, 12, 'run',    1, 3, 2, 'Tucked off the pads'),
(1, 2, 13, 'run',    2, 1, 6, 'Scooped over fine leg'),
(1, 2, 13, 'run',    2, 4, 1, 'Single to mid-off'),
(1, 2, 12, 'run',    3, 1, 4, 'Cut past point'),
(1, 1, 12, 'wicket', 4, 2, 0, 'Caught behind, bowler: Jasprit'),
(1, 2, 14, 'run',    5, 1, 2, 'Worked to leg side'),
(1, 2, 14, 'run',    5, 3, 4, 'Swept fine for four'),
(1, 1, 13, 'wicket', 6, 5, 0, 'Run out, direct hit from cover'),
(1, 2, 15, 'run',    7, 1, 1, 'Pushed to cover'),
(1, 2, 15, 'run',    7, 4, 4, 'Driven through mid-off');

-- FOOTBALL MATCH 3 (match_id=3): Phoenix FC 3-1 Storm United
INSERT INTO match_events (match_id, team_id, player_id, secondary_player_id, event_type, minute_or_over, detail) VALUES
(3, 3, 30, 28, 'goal',         12, 'Header from corner kick'),
(3, 3, 29, 30, 'goal',         34, 'Counter-attack finish'),
(3, 4, 41, 39, 'goal',         52, 'Penalty kick converted'),
(3, 4, 35, NULL, 'yellow_card', 55, 'Tactical foul on the edge of the box'),
(3, 3, 29, NULL, 'yellow_card', 62, 'Late tackle in midfield'),
(3, 3, 31, 29, 'goal',         78, 'Curling shot from outside the box'),
(3, 4, 37, 40,  'substitution', 65, 'Tactical change, fresh legs'),
(3, 3, 26, 30,  'substitution', 80, 'Defensive reinforcement');

-- TENNIS MATCH 5 (match_id=5): Ace Elite 2-1 Net Blazers (sets)
INSERT INTO match_events (match_id, team_id, player_id, event_type, set_number, detail) VALUES
(5, 5, 45, 'set_won',   1, 'Won set 6-4'),
(5, 6, 48, 'set_won',   2, 'Won set 7-5 in tiebreak'),
(5, 5, 45, 'set_won',   3, 'Won set 6-3'),
(5, 5, 45, 'match_won', 3, 'Won the match 2-1 in sets'),
(5, 5, 45, 'point_won', 1, 'Ace on serve'),
(5, 5, 45, 'point_won', 1, 'Winner down the line'),
(5, 6, 48, 'point_won', 1, 'Cross-court backhand winner'),
(5, 5, 45, 'point_won', 2, 'Drop shot winner'),
(5, 6, 48, 'point_won', 2, 'Serve and volley point'),
(5, 5, 45, 'point_won', 3, 'Forehand winner'),
(5, 6, 48, 'point_won', 3, 'Lob winner');

-- BADMINTON MATCH 7 (match_id=7): Shuttle Kings 2-0 Smash Warriors (sets)
INSERT INTO match_events (match_id, team_id, player_id, event_type, set_number, detail) VALUES
(7, 7, 51, 'set_won',   1, 'Won set 21-17'),
(7, 7, 51, 'set_won',   2, 'Won set 21-15'),
(7, 7, 51, 'match_won', 2, 'Won the match 2-0 in sets'),
(7, 7, 51, 'point_won', 1, 'Smash winner'),
(7, 7, 51, 'point_won', 1, 'Net drop winner'),
(7, 8, 55, 'point_won', 1, 'Cross-court smash'),
(7, 7, 51, 'point_won', 2, 'Deceptive drop shot'),
(7, 8, 55, 'point_won', 2, 'Drive winner'),
(7, 7, 51, 'point_won', 2, 'Jump smash winner');

-- ============================================================
-- PLAYER_MATCH_STATS (stats for completed matches)
-- ============================================================

-- Cricket Match 1 — Royal Strikers batters
INSERT INTO player_match_stats (player_id, match_id, runs_scored, balls_faced, wickets_taken, rating, notes) VALUES
(1,  1, 72,  48, 0, 8.5, 'Excellent batting display'),
(2,  1, 45,  32, 0, 7.0, 'Good start but got out'),
(3,  1, 28,  22, 0, 6.5, 'Useful contribution'),
(4,  1, 22,  15, 0, 7.5, 'Quick-fire cameo'),
(5,  1, 18,  14, 0, 6.0, 'Steady innings')
ON CONFLICT(player_id, match_id) DO UPDATE SET runs_scored=excluded.runs_scored, balls_faced=excluded.balls_faced, wickets_taken=excluded.wickets_taken, rating=excluded.rating, notes=excluded.notes;

-- Cricket Match 1 — Royal Strikers bowlers
INSERT INTO player_match_stats (player_id, match_id, wickets_taken, runs_conceded, overs_bowled, rating, notes) VALUES
(6,  1, 3, 28, 4.0, 9.0, 'Outstanding bowling spell'),
(7,  1, 2, 34, 4.0, 7.5, 'Good support bowling'),
(9,  1, 1, 30, 4.0, 6.5, 'Economical spell')
ON CONFLICT(player_id, match_id) DO UPDATE SET wickets_taken=excluded.wickets_taken, runs_conceded=excluded.runs_conceded, overs_bowled=excluded.overs_bowled, rating=excluded.rating, notes=excluded.notes;

-- Cricket Match 1 — Thunder Lions batters
INSERT INTO player_match_stats (player_id, match_id, runs_scored, balls_faced, wickets_taken, rating, notes) VALUES
(12, 1, 55, 40, 0, 8.0, 'Top scorer for the team'),
(13, 1, 38, 28, 0, 7.0, 'Aggressive batting'),
(14, 1, 22, 20, 0, 5.5, 'Struggled at times'),
(15, 1, 18, 16, 0, 6.0, 'Brief but useful')
ON CONFLICT(player_id, match_id) DO UPDATE SET runs_scored=excluded.runs_scored, balls_faced=excluded.balls_faced, wickets_taken=excluded.wickets_taken, rating=excluded.rating, notes=excluded.notes;

-- Cricket Match 1 — Thunder Lions bowlers
INSERT INTO player_match_stats (player_id, match_id, wickets_taken, runs_conceded, overs_bowled, rating, notes) VALUES
(16, 1, 1, 32, 4.0, 6.0, 'Decent bowling'),
(17, 1, 2, 38, 4.0, 7.0, 'Key wickets at crucial times'),
(20, 1, 0, 42, 4.0, 4.5, 'Expensive outing')
ON CONFLICT(player_id, match_id) DO UPDATE SET wickets_taken=excluded.wickets_taken, runs_conceded=excluded.runs_conceded, overs_bowled=excluded.overs_bowled, rating=excluded.rating, notes=excluded.notes;

-- Football Match 3 — Phoenix FC
INSERT INTO player_match_stats (player_id, match_id, goals_scored, assists, yellow_cards, minutes_played, rating, notes) VALUES
(30, 3, 1, 1, 0, 90, 8.5, 'Goal and assist, excellent performance'),
(29, 3, 1, 0, 1, 90, 7.5, 'Goal and a booking'),
(31, 3, 1, 0, 0, 90, 8.0, 'Stunning long-range goal'),
(28, 3, 0, 1, 0, 80, 7.0, 'Creative passing throughout')
ON CONFLICT(player_id, match_id) DO UPDATE SET goals_scored=excluded.goals_scored, assists=excluded.assists, yellow_cards=excluded.yellow_cards, minutes_played=excluded.minutes_played, rating=excluded.rating, notes=excluded.notes;

-- Football Match 3 — Storm United
INSERT INTO player_match_stats (player_id, match_id, goals_scored, assists, yellow_cards, minutes_played, rating, notes) VALUES
(41, 3, 1, 0, 0, 90, 7.0, 'Converted the penalty'),
(39, 3, 0, 1, 0, 90, 6.5, 'Set up the penalty'),
(35, 3, 0, 0, 1, 90, 5.5, 'Booked for a foul')
ON CONFLICT(player_id, match_id) DO UPDATE SET goals_scored=excluded.goals_scored, assists=excluded.assists, yellow_cards=excluded.yellow_cards, minutes_played=excluded.minutes_played, rating=excluded.rating, notes=excluded.notes;

-- Tennis Match 5 — Players
INSERT INTO player_match_stats (player_id, match_id, points_won, sets_won, games_won, rating, notes) VALUES
(45, 5, 95,  2, 18, 8.5, 'Strong serving and baseline play'),
(48, 5, 82,  1, 16, 7.5, 'Fought well in second set tiebreak')
ON CONFLICT(player_id, match_id) DO UPDATE SET points_won=excluded.points_won, sets_won=excluded.sets_won, games_won=excluded.games_won, rating=excluded.rating, notes=excluded.notes;

-- Badminton Match 7 — Players
INSERT INTO player_match_stats (player_id, match_id, points_won, sets_won, rating, notes) VALUES
(51, 7, 42, 2, 9.0, 'Dominant smashing and net play'),
(55, 7, 32, 0, 6.0, 'Unable to handle the pace')
ON CONFLICT(player_id, match_id) DO UPDATE SET points_won=excluded.points_won, sets_won=excluded.sets_won, rating=excluded.rating, notes=excluded.notes;

-- ============================================================
-- MATCH_ROSTERS (Lineup for completed cricket match)
-- ============================================================

-- Royal Strikers lineup for Match 1
INSERT INTO match_rosters (match_id, player_id, team_id, lineup_position, is_starting) VALUES
(1, 1,  1, 1,  1),   -- Virat Sharma - Opening batsman
(1, 2,  1, 2,  1),   -- Rohit Patel - Opening batsman
(1, 3,  1, 3,  1),   -- Shubman Gill
(1, 4,  1, 4,  1),   -- Hardik Pandya
(1, 5,  1, 5,  1),   -- Ravindra Jadeja
(1, 8,  1, 6,  1),   -- Rishabh Iyer (WK)
(1, 10, 1, 7,  1),   -- Axar Singh
(1, 11, 1, 8,  1),   -- Shreyas Kumar
(1, 6,  1, 9,  1),   -- Jasprit Bumrah
(1, 7,  1, 10, 1),   -- Mohammed Shami
(1, 9,  1, 11, 1);   -- Kuldeep Yadav

-- Thunder Lions lineup for Match 1
INSERT INTO match_rosters (match_id, player_id, team_id, lineup_position, is_starting) VALUES
(1, 12, 2, 1,  1),   -- KL Rahul - Opening
(1, 13, 2, 2,  1),   -- Suryakumar Yadav - Opening
(1, 14, 2, 3,  1),   -- Ishan Kishan (WK)
(1, 15, 2, 4,  1),   -- Shardul Thakur
(1, 18, 2, 5,  1),   -- Dinesh Karthik
(1, 19, 2, 6,  1),   -- Washington Sundar
(1, 21, 2, 7,  1),   -- Prithvi Shaw
(1, 16, 2, 8,  1),   -- Yuzvendra Chahal
(1, 17, 2, 9,  1),   -- Bhuvneshwar Kumar
(1, 20, 2, 10, 1),   -- Deepak Chahar
(1, 22, 2, 11, 1);   -- Navdeep Saini
