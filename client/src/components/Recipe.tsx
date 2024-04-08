import { FC } from "react";
import { Text } from "@react-three/drei";
interface RecipeProps {
    position: [number, number, number]
    recipe: [string, string, string]
}

const Recipe: FC<RecipeProps> = ({position, recipe}) => {
    return (
        <group  position={position}>
            <Text color="black"> {recipe[1] == "" ? recipe[0] : recipe[0] + " + "} </Text>
            <Text color="black" position={[0,-1,0]}> {recipe[1] == "" ? "" : recipe[1] + " = "} </Text>
            <Text color="black" position={[0,-2,0]}> {recipe[2] == "" ? "" : recipe[2] } </Text>
        </group>
    )
}

export default Recipe;