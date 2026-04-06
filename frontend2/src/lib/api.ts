const BASE_URL = "/api";

async function fetchJSON<T>(url: string, options?: RequestInit): Promise<T> {
  const res = await fetch(`${BASE_URL}${url}`, {
    headers: { "Content-Type": "application/json" },
    ...options,
  });
  if (!res.ok) throw new Error(`API Error: ${res.status} ${res.statusText}`);
  return res.json();
}

// Dashboard
export const getDashboardOverview = () =>
  fetchJSON<{ total_players: number; total_teams: number; matches_completed: number; upcoming_matches: number }>("/dashboard/summary");

export const getTopPlayers = (limit = 5) =>
  fetchJSON<{ scorers: Array<{ player_id: number; first_name: string; last_name: string; team_name: string; sport_name: string; matches_played: number; avg_rating: number }>; grouped: Record<string, any> }>(`/dashboard/top-players?limit=${limit}`);

// Players
export const getPlayers = () =>
  fetchJSON<Array<{ player_id: number; first_name: string; last_name: string; email: string; date_of_birth: string; gender: string; team_id: number; jersey_number: number; position: string; status: string; team_name: string }>>("/players");

export const createPlayer = (data: Record<string, unknown>) =>
  fetchJSON("/players", { method: "POST", body: JSON.stringify(data) });

export const updatePlayer = (id: number, data: Record<string, unknown>) =>
  fetchJSON(`/players/${id}`, { method: "PUT", body: JSON.stringify(data) });

export const getPlayerStats = (id: number) =>
  fetchJSON<Array<Record<string, unknown>>>(`/players/${id}/stats`);

export const deletePlayer = (id: number) =>
  fetchJSON(`/players/${id}`, { method: "DELETE" });

// Teams
export const getTeams = () =>
  fetchJSON<Array<{ team_id: number; name: string; sport_id: number; coach_id: number; founded_year: number; home_venue_id: number; status: string; sport_name: string; coach_name: string; venue_name: string }>>("/teams");

export const getTeam = (id: number) =>
  fetchJSON<Record<string, unknown>>(`/teams/${id}`);

export const createTeam = (data: Record<string, unknown>) =>
  fetchJSON("/teams", { method: "POST", body: JSON.stringify(data) });

export const updateTeam = (id: number, data: Record<string, unknown>) =>
  fetchJSON(`/teams/${id}`, { method: "PUT", body: JSON.stringify(data) });

export const deleteTeam = (id: number) =>
  fetchJSON(`/teams/${id}`, { method: "DELETE" });

export const addPlayerToTeam = (teamId: number, playerId: number) =>
  fetchJSON(`/teams/${teamId}/players`, { method: "POST", body: JSON.stringify({ player_id: playerId }) });

// Matches
export const getMatches = () =>
  fetchJSON<Array<{ match_id: number; event_id: number; venue_id: number; match_date: string; status: string; result_summary: string; event_name: string; sport_id: number; sport_name: string; venue_name: string; team1_id: number; team1_name: string; team1_score: number | null; team2_id: number; team2_name: string; team2_score: number | null; winner_team_id: number | null }>>("/matches");

export const scheduleMatch = (data: Record<string, unknown>) =>
  fetchJSON("/matches", { method: "POST", body: JSON.stringify(data) });

export const logMatchScore = (id: number, teamId: number, data: { score?: number; innings_1_score?: number; innings_2_score?: number; sets_won?: number }) =>
  fetchJSON(`/matches/${id}/score`, { method: "PUT", body: JSON.stringify({ team_id: teamId, ...data }) });

export const logMatchResult = (id: number, data: { team1_id: number; team1_score: number; team2_id: number; team2_score: number; winner_team_id: number; result_summary: string }) =>
  fetchJSON(`/matches/${id}/result`, { method: "PUT", body: JSON.stringify(data) });

export const updateMatchStatus = (id: number, data: Record<string, unknown>) =>
  fetchJSON(`/matches/${id}`, { method: "PUT", body: JSON.stringify(data) });

export const deleteMatch = (id: number) =>
  fetchJSON(`/matches/${id}`, { method: "DELETE" });

// Sports
export const getSports = () =>
  fetchJSON<Array<{ sport_id: number; name: string; category: string; rules_json: unknown; min_players_per_team: number; max_players_per_team: number; description: string; scoring_unit: string }>>("/sports");

// Events
export const getEvents = () =>
  fetchJSON<Array<{ event_id: number; name: string; sport_id: number; event_type: string; format: string; start_date: string; end_date: string; status: string; description: string; sport_name: string }>>("/events");

export const createEvent = (data: Record<string, unknown>) =>
  fetchJSON("/events", { method: "POST", body: JSON.stringify(data) });

export const updateEvent = (id: number, data: Record<string, unknown>) =>
  fetchJSON(`/events/${id}`, { method: "PUT", body: JSON.stringify(data) });

export const deleteEvent = (id: number) =>
  fetchJSON(`/events/${id}`, { method: "DELETE" });

export const registerTeamToEvent = (eventId: number, teamId: number) =>
  fetchJSON(`/events/${eventId}/teams`, { method: "POST", body: JSON.stringify({ team_id: teamId }) });

// Coaches
export const getCoaches = () =>
  fetchJSON<Array<{ coach_id: number; first_name: string; last_name: string; email: string; phone: string; specialization: string; experience_years: number }>>("/coaches");
