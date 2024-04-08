import { FC } from "react";
import Button from "./Button";
import { Direction } from "../utils";
import * as THREE from "three";

interface ControlsProps {
    position: [number, number, number],
    blobert_x: number
    move: any
    account: any
    cur_drink: string
}

const Controls: FC<ControlsProps> = ({position, blobert_x, move, account, cur_drink}) => {

    const get_ingredient = (x: number) => {
        if (x == 1) {return "grog"};
        if (x == 2) {return "mead"};
        if (x == 3) {return "whiskey"};
        if (x == 4) {return "soda"};
        if (x == 5) {return "juice"};

    }
    return (
        <group position = {position}>
            <Button rotation = {new THREE.Euler(Math.PI/2,0,0)} position={[-10,0,0]} label= {blobert_x == 1 ? "Trash" : "Left"} onClick={() => move(account.account, Direction.Left)}/>
            <Button rotation = {new THREE.Euler(Math.PI/2,0,0)} position={[-3,0,0]} label= {"Add " + get_ingredient(blobert_x)} onClick={() => move(account.account, Direction.Up)}/>
            <Button rotation = {new THREE.Euler(Math.PI/2,0,0)} position={[3,0,0]} label= {"Serve" +  cur_drink} onClick={() => move(account.account, Direction.Down)}/>
            <Button rotation = {new THREE.Euler(Math.PI/2,0,0)} position={[10,0,0]} label= {blobert_x == 5 ? "Trash" : "Right"} onClick={() => move(account.account, Direction.Right)}/>

        </group>
    )
}

export default Controls;