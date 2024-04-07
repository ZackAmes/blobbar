import {FC, useState, useEffect} from "react";
import {Canvas, useThree} from "@react-three/fiber";
import {Box, Plane, OrbitControls} from "@react-three/drei";
import * as THREE from "three";
import Blobert from "./Blobert";

interface BarProps {
    get_blobert: () => Promise<string>
}

const Bar: FC<BarProps> = ({get_blobert}) => {

    

    return (
        <group rotation = {new THREE.Euler(Math.PI/9,0,0)}>
            <Blobert get_blobert={get_blobert} />
            
            <mesh position={[0,5,-1]}>
                <boxGeometry args={[20,20,.1]}/>
                <meshBasicMaterial color="black"/>
            </mesh>
            <mesh position = {[0, 5, .1]}>
                <boxGeometry args={[10,.5,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
            <mesh position = {[0, 12, .1]}>
                <boxGeometry args={[10,2,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
            <mesh position = {[4, 9, .1]}>
                <boxGeometry args={[2,7.5,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>

            <mesh position = {[-4, 9, .1]}>
                <boxGeometry args={[2,7.5,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
    
        </group>
    )
}


export default Bar;