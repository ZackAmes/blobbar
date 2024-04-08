
use blobbar::models::types::{Direction, DrinkType, Level, Vec2, Status};
use blobbar::blobert::types::seeder::Seed;
use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Blobtender {
    #[key]
    player: ContractAddress,
    level: Level,
    position: Vec2,
    serving: u8,
    clients_served: u32,
    high_score: u32,
    blobert: Seed,
    start_time: u64
}

#[derive(Model, Copy, Drop, Serde)]
struct CurrentClient {
    #[key]
    player: ContractAddress,
    index: u32,
    order: u8
}

#[derive(Model, Copy, Drop, Serde)]
struct CurrentStatus {
    #[key]
    player: ContractAddress,
    status: Status
}

#[generate_trait]
impl BlobtenderImpl of BlobtenderTrait {

    fn new(player: ContractAddress, blobert: Seed, start_time: u64) -> Blobtender {
        Blobtender {player, level:Level::None, position: Vec2 {x: 2, y:1}, serving: 0, clients_served: 0,high_score: 0, blobert, start_time}
    }

    fn game_over(ref self: Blobtender) {
        if self.clients_served > self.high_score {
            self.high_score = self.clients_served;
        }
        self.clients_served = 0;
        self.level = Level::None;
        self.position = Vec2 {x:2, y:1};
        self.serving = 0;
        self.start_time = 0;
    }

    fn level_up(ref self: Blobtender) {
        match self.level {
            Level::None => {
                self.level = Level::One;
            },
            Level::One => {
                self.level = Level::Two;
            },
            Level::Two => {
                self.level = Level::Three;
            },
            Level::Three => {
                self.level = Level::Endless;
            },
            Level::Endless => {

            }
        }
        self.start_time = 0;
        self.position = Vec2 {x: 2, y: 1}
    } 
    
}

