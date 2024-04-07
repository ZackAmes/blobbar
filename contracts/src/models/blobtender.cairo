
use blobbar::models::types::{Direction, DrinkType, Level, Vec2};
use blobbar::blobert::types::seeder::Seed;
use starknet::ContractAddress;

#[derive(Model, Copy, Drop, Serde)]
struct Blobtender {
    #[key]
    player: ContractAddress,
    level: Level,
    position: Vec2,
    serving: DrinkType,
    clients_served: u32,
    high_score: u32,
    blobert: Seed,
    start_time: u64
}

#[generate_trait]
impl BlobtenderImpl of BlobtenderTrait {

    fn new(player: ContractAddress, blobert: Seed, start_time: u64) -> Blobtender {
        Blobtender {player, level:Level::One, position: Vec2 {x: 2, y:1}, serving: DrinkType::None, clients_served: 0,high_score: 0, blobert, start_time}
    }

    fn serve(ref self: Blobtender) {
        self.clients_served += 1;
        self.serving = DrinkType::None;
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
    } 
    
}

