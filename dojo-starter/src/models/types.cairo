
#[derive(Serde, Copy, Drop)]
enum TileType {
    None,
    Ground,
    Trash,
    Bar,
    Ingredient: DrinkType,

}

#[derive(Serde, Copy, Drop, Introspect, PartialEq)]
enum Level {
    None,
    One,
    Two,
    Three,
    Endless
}

#[derive(Serde, Copy, Drop, Introspect)]
enum DrinkType {
    None,
    Grog,
    Rum, 
    Vodka,
    Soda,
    Juice,
    Syrup
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
