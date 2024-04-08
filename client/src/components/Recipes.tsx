import { FC, useState } from "react";
import Recipe from "./Recipe";
import Button from "./Button";
import { recipes } from "../utils";
import { Text } from "@react-three/drei";
import * as THREE from "three";
interface RecipesProps {
    position: [number, number, number]
}

const Recipes: FC<RecipesProps> = ({position}) => {
    
    let [cur_recipe, set_recipe] = useState(0);
    
    
    return (
        <group rotation = {new THREE.Euler(Math.PI/4,0,0)} position = {position}>
            {cur_recipe > 0 && <Button rotation = {new THREE.Euler(Math.PI/2,0,0)} label="<" position = {[-4,0,1.5]} onClick = { () => set_recipe(cur_recipe-1)}/>}
            <Text color= "black" position={[0,0,1.5]}> Recipes </Text>
            {cur_recipe < 16 && <Button rotation = {new THREE.Euler(Math.PI/2,0,0)} label=">" position = {[4,0,1.5]} onClick = { () => set_recipe(cur_recipe+1)}/>}
            <Recipe position={[1,0,-1]} recipe = {recipes[cur_recipe]}/>

        
        </group>
    )
}

export default Recipes;