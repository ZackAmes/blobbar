import { FC } from "react";
import { Text } from "@react-three/drei";
import * as THREE from "three";
interface RecipeProps {
    position: [number, number, number]
    recipe: [string, string, string]
}

const Recipe: FC<RecipeProps> = ({position, recipe}) => {
    let x = position[0];
    let y = position[1];
    let z = position[2];
    let offset = 0;
    console.log(recipe)
    return (
        <group rotation = {new THREE.Euler(Math.PI/4,0,0)} position={position}>
            <Text color="black"> {recipe[1] == "" ? recipe[0] : recipe[0] + " + "} </Text>
            <Text color="black" position={[0,-1,0]}> {recipe[1] == "" ? "" : recipe[1] + " = "} </Text>
            <Text color="black" position={[0,-2,0]}> {recipe[2] == "" ? "" : recipe[2] } </Text>
        </group>
    )
}

export default Recipe;