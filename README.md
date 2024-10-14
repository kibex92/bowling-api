# Bowling Game API

A simple RESTful API for managing a bowling game. It allows users to create games, manage frames, and calculate scores based on standard bowling rules.

## Features

- Create bowling games
- Add and Update Frames
- Calculate scores incrementally
- Retrieve game info with the total score and indidual frame data

## Getting Started

### Prerequisites

- Ruby (version 3.1.2)
- Rails (version 7.2.1)
- PostgreSQL

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/kibex92/bowling-api.git
   ```
2. Install the required gems:
   ```bash
   bundle install
   ```
3. Setup the Database
   ```bash
   rails db:create db:migrate
   ```
4. Start the server
   ```bash
   rails s
   ```
   
## API Endpoints

### Games

- **POST** `/api/v1/games` - Create a new game
- **GET** `/api/v1/games/:id` - Retrieve a specific game

### Frames

- **POST** `/api/v1/games/:game_id/frames/` - Add a frame to a game
- **PATCH** `/api/v1/games/:game_id/frames/:number` - Update a specific frame
  
- **Valid Params:**
    - `first_roll=integer`
    - `second_roll=integer`
    - For the 10th frame: `third_roll=integer`

## Testing

To run the test suite:

```bash
rspec
```
