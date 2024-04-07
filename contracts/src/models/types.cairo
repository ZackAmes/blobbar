
#[derive(Serde, Copy, Drop)]
enum TileType {
    None,
    Ground,
    Trash,
    Bar,
    Ingredient: IngredientType,

}

#[derive(Serde, Copy, Drop, Introspect, PartialEq)]
enum Level {
    None,
    One,
    Two,
    Three,
    Endless
}

#[derive(Copy, Drop, Serde, Introspect)]
struct Vec2 {
    x: u8,
    y: u8
}

trait Vec2Trait {
    fn is_zero(self: Vec2) -> bool;
    fn is_equal(self: Vec2, b: Vec2) -> bool;
}

impl Vec2Impl of Vec2Trait {
    fn is_zero(self: Vec2) -> bool {
        if self.x - self.y == 0 {
            return true;
        }
        false
    }

    fn is_equal(self: Vec2, b: Vec2) -> bool {
        self.x == b.x && self.y == b.y
    }
}


#[derive(Serde, Copy, Drop, Introspect)]
enum Direction {
    None,
    Left,
    Right,
    Up,
    Down,
}

impl DirectionIntoFelt252 of Into<Direction, felt252> {
    fn into(self: Direction) -> felt252 {
        match self {
            Direction::None => 0,
            Direction::Left => 1,
            Direction::Right => 2,
            Direction::Up => 3,
            Direction::Down => 4,
        }
    }
}

#[derive(Serde, Copy, Drop, Introspect)]
enum DrinkType {
    None,
    Ew,
    Grog,
    Mead, 
    Whiskey,
    Soda,
    Juice,
    MeadSprtiz,
    KnightsSpritz,
    RoyalHoneyedNectar,
    NobleNectar,
    CastleCitrusFizz,
    RegalRefresher,
    MonarchsMingle,
    CourtlyCooler,
    WizardsWhirl,
    MajesticMetheglin,
    SovereignSwirl,
    ChivalrousChalice
}

impl DrinkTypeIntoFelt252 of Into<DrinkType, felt252> {
    fn into(self: DrinkType) -> felt252 {
        match self {
            DrinkType::None => 0,
            DrinkType::Ew => 1,
            DrinkType::Grog => 2,
            DrinkType::Mead => 3, 
            DrinkType::Whiskey => 4,
            DrinkType::Soda => 5,
            DrinkType::Juice => 6,
            DrinkType::MeadSprtiz => 7,
            DrinkType::KnightsSpritz => 8,
            DrinkType::RoyalHoneyedNectar => 9,
            DrinkType::NobleNectar => 10,
            DrinkType::CastleCitrusFizz => 11,
            DrinkType::RegalRefresher => 12,
            DrinkType::MonarchsMingle => 13,
            DrinkType::CourtlyCooler => 14,
            DrinkType::WizardsWhirl => 15,
            DrinkType::MajesticMetheglin => 16,
            DrinkType::SovereignSwirl => 17,
            DrinkType::ChivalrousChalice => 18,
        }
    }
}

impl U8IntoDrinkType of Into<u8, DrinkType> {
    fn into(self: u8) -> DrinkType {
        match self {
            0 => DrinkType::None,
            1 => DrinkType::Ew,
            2=> DrinkType::Grog,
            3 => DrinkType::Mead, 
            4 => DrinkType::Whiskey,
            5 => DrinkType::Soda,
            6 => DrinkType::Juice,
            7 => DrinkType::MeadSprtiz,
            8 => DrinkType::KnightsSpritz,
            9 => DrinkType::RoyalHoneyedNectar,
            10 => DrinkType::NobleNectar,
            11 => DrinkType::CastleCitrusFizz,
            12 => DrinkType::RegalRefresher,
            13 => DrinkType::MonarchsMingle,
            14 => DrinkType::CourtlyCooler,
            15 => DrinkType::WizardsWhirl,
            16 => DrinkType::MajesticMetheglin,
            17 => DrinkType::SovereignSwirl,
            18 => DrinkType::ChivalrousChalice,
            _ => DrinkType::None
        }
    }
}

#[derive(Serde, Copy, Drop, Introspect)]
enum IngredientType {
    Grog,
    Mead, 
    Whiskey,
    Soda,
    Juice
}

// chat gpt drink recipes
//Base Ingredients:

//Mead
//Whiskey
//Soda
//Juice

//Simpler Drinks:

//Mead + Soda = Medieval Mead Spritz
//Whiskey + Soda = Knight's Spritz
//Mead + Juice = Royal Honeyed Nectar
//Whiskey + Juice = Noble Nectar

//Intermediate Drinks (Require simpler drinks as ingredients):

//Medieval Mead Spritz + Juice = Castle Citrus Fizz
//Knight's Spritz + Juice = Regal Refresher
//Royal Honeyed Nectar + Soda = Monarch's Mingle
//Noble Nectar + Soda = Courtly Cooler

//Advanced Drinks (Require intermediate drinks as ingredients):

//Castle Citrus Fizz + Whiskey = Wizard's Whirl
//Regal Refresher + Mead = Majestic Metheglin
//Monarch's Mingle + Whiskey = Sovereign Swirl
//Courtly Cooler + Mead = Chivalrous Chalice

#[generate_trait]
impl DrinkTypeImpl of DrinkTypeTrait {
    
    fn combine(self: DrinkType, to_add: IngredientType) -> DrinkType {
        match self {
            DrinkType::None => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Grog
                    },
                    IngredientType::Mead => {
                        DrinkType::Mead
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Whiskey
                    },
                    IngredientType::Soda => {
                        DrinkType::Soda
                    },
                    IngredientType::Juice => {
                        DrinkType::Juice
                    }
                }
            },
            DrinkType::Ew => {
                DrinkType::Ew
            },
            DrinkType::Grog => {
                DrinkType::Ew
            },
            DrinkType::Mead => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::Mead
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Ew
                    },
                    IngredientType::Soda => {
                        DrinkType::MeadSprtiz
                    },
                    IngredientType::Juice => {
                        DrinkType::RoyalHoneyedNectar
                    }
                }
            },
            DrinkType::Whiskey => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::Ew
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Whiskey
                    },
                    IngredientType::Soda => {
                        DrinkType::KnightsSpritz
                    },
                    IngredientType::Juice => {
                        DrinkType::NobleNectar
                    }
                }
            },
            DrinkType::Soda => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::MeadSprtiz
                    },
                    IngredientType::Whiskey => {
                        DrinkType::KnightsSpritz
                    },
                    IngredientType::Soda => {
                        DrinkType::Soda
                    },
                    IngredientType::Juice => {
                        DrinkType::Ew
                    }
                }
            },
            DrinkType::Juice => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::RoyalHoneyedNectar
                    },
                    IngredientType::Whiskey => {
                        DrinkType::NobleNectar
                    },
                    IngredientType::Soda => {
                        DrinkType::Ew
                    },
                    IngredientType::Juice => {
                        DrinkType::Juice
                    }
                }
            },
            DrinkType::MeadSprtiz => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::Ew
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Ew
                    },
                    IngredientType::Soda => {
                        DrinkType::Ew
                    },
                    IngredientType::Juice => {
                        DrinkType::CastleCitrusFizz
                    }
                }
            },
            DrinkType::KnightsSpritz => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::Ew
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Ew
                    },
                    IngredientType::Soda => {
                        DrinkType::Ew
                    },
                    IngredientType::Juice => {
                        DrinkType::RegalRefresher
                    }
                }
            },
            DrinkType::RoyalHoneyedNectar=> {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::Ew
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Ew
                    },
                    IngredientType::Soda => {
                        DrinkType::MonarchsMingle
                    },
                    IngredientType::Juice => {
                        DrinkType::Ew
                    }
                }
            },
            DrinkType::NobleNectar => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::Ew
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Ew
                    },
                    IngredientType::Soda => {
                        DrinkType::CourtlyCooler
                    },
                    IngredientType::Juice => {
                        DrinkType::Ew
                    }
                }
            },
            DrinkType::CastleCitrusFizz => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::WizardsWhirl
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Ew
                    },
                    IngredientType::Soda => {
                        DrinkType::Ew
                    },
                    IngredientType::Juice => {
                        DrinkType::Ew
                    }
                }
            },
            DrinkType::RegalRefresher => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::RoyalHoneyedNectar
                    },
                    IngredientType::Whiskey => {
                        DrinkType::NobleNectar
                    },
                    IngredientType::Soda => {
                        DrinkType::Ew
                    },
                    IngredientType::Juice => {
                        DrinkType::Juice
                    }
                }
            },
            DrinkType::MonarchsMingle => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::Ew
                    },
                    IngredientType::Whiskey => {
                        DrinkType::SovereignSwirl
                    },
                    IngredientType::Soda => {
                        DrinkType::Ew
                    },
                    IngredientType::Juice => {
                        DrinkType::Ew
                    }
                }
            },
            DrinkType::CourtlyCooler => {
                match to_add {
                    IngredientType::Grog => {
                        DrinkType::Ew
                    },
                    IngredientType::Mead => {
                        DrinkType::ChivalrousChalice
                    },
                    IngredientType::Whiskey => {
                        DrinkType::Ew
                    },
                    IngredientType::Soda => {
                        DrinkType::Ew
                    },
                    IngredientType::Juice => {
                        DrinkType::Ew
                    }
                }
            },
            DrinkType::WizardsWhirl => {
                DrinkType::Ew
            },
            DrinkType::MajesticMetheglin => {
                DrinkType::Ew
            },
            DrinkType::SovereignSwirl => {
                DrinkType::Ew
            },
            DrinkType::ChivalrousChalice => {
                DrinkType::Ew
            }
        }
    }
}
