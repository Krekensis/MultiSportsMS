---
title: Multi-Sports Management System (MSMS)
emoji: 🏆
colorFrom: blue
colorTo: indigo
sdk: docker
pinned: false
---

# Multi-Sports Management System (MSMS) 🏆

The **Multi-Sports Management System (MSMS)** is a comprehensive, database-driven application designed to streamline the management of sporting events, teams, players, and performance analytics. Developed as a high-performance relational database project, it demonstrates advanced SQL techniques and modern web architecture.

## 🌟 Key Features

### 🏢 Core Management
- **Sports Support**: Native support for **Cricket, Football, Tennis, and Badminton**, each with its own rule sets and scoring metrics.
- **Venue Management**: Track locations, seating capacity, and surface types for various sporting facilities.
- **Staff & Coaching**: Manage coaching staff with specialized skill sets and experience levels.
- **Team Administration**: Organize teams by sport, with dedicated home venues and assigned coaches.
- **Player Profiles**: Comprehensive player rosters with jersey numbers, positions, and status tracking (Active/Injured/Retired).

### ⚔️ Match & Event tracking
- **Event Orchestration**: Manage Tournaments, Leagues, Friendlies, and Championships with distinct formats (Knockout/Round-robin).
- **Match Scheduling**: Plan matches with real-time status updates (Scheduled, Ongoing, Completed, Postponed).
- **Live Event Logging**: Granular tracking of match events such as **Goals, Runs, Wickets, and Points**.
- **Dynamic Rosters**: Manage per-match starting lineups and batting orders.

### 📊 Advanced Analytics (Database Views)
- **Team Standings**: Real-time league tables with Wins, Losses, Draws, and Points calculations.
- **Player Statistics**: Career-wide performance metrics (Total Runs, Goals, Wickets, Average Ratings).
- **Top Scorers**: Automatic leaderboards filtered by sport.
- **Upcoming Matches**: A chronological view of all scheduled fixtures with venue details.

---

## 🛠️ Technology Stack

- **Frontend**: [React 18](https://reactjs.org/) + [Vite](https://vitejs.dev/)
- **Styling**: [Tailwind CSS](https://tailwindcss.com/) + [shadcn/ui](https://ui.shadcn.com/)
- **Backend**: [Node.js](https://nodejs.org/) + [Express](https://expressjs.com/)
- **Database**: [sql.js](https://sql.js.org/) (SQLite via WebAssembly)
- **Architecture**: REST API + 3NF Normalized Relational Database

---

## 💾 Database Architecture

MSMS is powered by a robust 3NF relational schema consisting of **13 Tables**, **5 Views**, and **4 Triggers**.

- **Triggers**: Automated data integrity and statistics updates. For example, logging a `goal` event automatically increments the player's career goals and the team's score.
- **Views**: Complex analytical queries (like Standings and Player Stats) are offloaded to stored database views for maximum performance.
- **Normalization**: Ensures zero data redundancy and maintains referential integrity using `ON DELETE CASCADE` and `ON DELETE SET NULL` constraints.

---

## 🚀 Quick Start

### Local Setup
1. Clone the repository.
2. Run `npm install` in the root directory.
3. Build the frontend: `npm run build:frontend`.
4. Start the server: `npm start`.

For detailed instructions, see [RUN_HOWTO.md](./RUN_HOWTO.md).

### Hugging Face Deployment
This project is configured for **Hugging Face Spaces** using the Docker SDK.
1. Create a new Space on Hugging Face.
2. Select **Docker** as the SDK.
3. Push the repository to the Space.

---

## 📄 License
This project was developed for academic purposes as part of a DBMS course.
