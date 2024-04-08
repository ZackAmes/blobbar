export enum Direction {
    Left = 1,
    Right = 2,
    Up = 3,
    Down = 4,
}

export function updatePositionWithDirection(
    direction: Direction,
    value: { vec: { x: number; y: number } }
) {
    switch (direction) {
        case Direction.Left:
            value.vec.x--;
            break;
        case Direction.Right:
            value.vec.x++;
            break;
        case Direction.Up:
            value.vec.y--;
            break;
        case Direction.Down:
            value.vec.y++;
            break;
        default:
            throw new Error("Invalid direction provided");
    }
    return value;
}

export const get_drink = (id: number) => {
    if(id == 0) return "none"
    if(id == 1) return "EW"
    if(id == 2) return "Grog"
    if(id == 3) return "Mead"
    if(id == 4) return "Whiskey"
    if(id == 5) return "Soda"
    if(id == 6) return "Juice"
    if(id < 19) return recipes[id-2][2]
    else return "out of range" 

}

export const recipes: Array<[string,string,string]> = [
    ["Grog", "", ""],
    ["Mead", "", ""],
    ["Whiskey", "", ""],
    ["Soda", "", ""],
    ["Juice", "", ""],
    ["Mead", "Soda", "Mead Spritz"],
    ["Whiskey", "Soda", "Knight's Spritz"],
    ["Mead", "Juice", "Royal Honeyed Nectar"],
    ["Whiskey", "Juice", "Noble Nectar"],
    ["Mead Spritz", "Juice", "Castle Citrus Fizz"],
    ["Knight's Spritz", "Juice", "Regal Refresher"],
    ["Royal HoneyedNectar", "Soda", "Monarch's Mingle"],
    ["Noble Nectar", "Soda", "Courtly Cooler"],
    ["Castle Citrus Fizz", "Whiskey", "Wizard's Whirl"],
    ["Regal Refresher", "Mead", "Majestic Metheglin"],
    ["Monarch's Mingle", "Whiskey", "Sovereign Swirl"],
    ["Courtly Cooler", "Mead", "Chivalrous Chalice"],

]
