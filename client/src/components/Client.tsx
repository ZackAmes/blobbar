import { FC } from "react";
import Blobert from "./Blobert";
import { Text } from "@react-three/drei";
import * as THREE from "three";

interface ClientProps {
    position: [number, number, number]
    order: string
    get_blobert: any
}

const Client: FC<ClientProps> = ({position, order, get_blobert}) => {
    return (
        <group position={position }rotation = {new THREE.Euler(Math.PI/9,0,0)}>
            <Blobert position= {[0,-3,1]} get_blobert={get_blobert} /> 
            <Text scale={1.5} position={[4,0,0]} color="blue"> {order} </Text>   

        </group>
    )
}

export default Client;