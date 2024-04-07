import {FC, useState, useEffect} from "react";
import {Canvas, useThree} from "@react-three/fiber";
import {Box, Plane, OrbitControls} from "@react-three/drei";
import * as THREE from "three";
import Blobert from "./Blobert";

interface BarProps {
    blob_position: [number, number, number]
    get_blobert: () => Promise<string>
}

const Bar: FC<BarProps> = ({blob_position, get_blobert}) => {

    

    return (
        <group position = {[0, 8, .1]} rotation = {new THREE.Euler(Math.PI/9,0,0)}>
            
            <mesh position={[0,-3,-1]}>
                <boxGeometry args={[30,30,.1]}/>
                <meshBasicMaterial color="black"/>
            </mesh>
            <mesh position = {[0, -3, 0]}>
                <boxGeometry args={[19,.5,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
            <mesh position = {[0, 4, 0]}>
                <boxGeometry args={[19,2,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
            <mesh position = {[8.5, 1, 0]}>
                <boxGeometry args={[2,7.5,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>

            <mesh position = {[-8.5, 1, 0]}>
                <boxGeometry args={[2,7.5,2]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
            //tiles
            <mesh position = {[-6, 0, .000001]}>
                <boxGeometry args={[3,3,.0000001]}/>
                <meshBasicMaterial color="white"/>
            </mesh>
            <mesh position = {[0, 0, .0000001]}>
                <boxGeometry args={[3,3,.0000001]}/>
                <meshBasicMaterial color="white"/>
            </mesh>
            <mesh position = {[6, 0, .0000001]}>
                <boxGeometry args={[3,3,.0000001]}/>
                <meshBasicMaterial color="white"/>
            </mesh>
            //ingredients
            <mesh position = {[-6, 3, 3]}>
              <cylinderGeometry args={[1.5,1.5,1.5]}/>
              <meshBasicMaterial color="orange"/>
            </mesh>
            <mesh position = {[-3, 3, 3]}>
              <cylinderGeometry args={[1.5,1.5,1.5]}/>
              <meshBasicMaterial color="red"/>
            </mesh>
            <mesh position = {[0, 3, 3]}>
              <cylinderGeometry args={[1.5,1.5,1.5]}/>
              <meshBasicMaterial color="green"/>
            </mesh>
            <mesh position = {[3, 3, 3]}>
              <cylinderGeometry args={[1.5,1.5,1.5]}/>
              <meshBasicMaterial color="blue"/>
            </mesh>
            <mesh position = {[6, 3, 3]}>
              <cylinderGeometry args={[1.5,1.5,1.5]}/>
              <meshBasicMaterial color="purple"/>
            </mesh>

            <Blobert position={blob_position} get_blobert={get_blobert} />

        </group>
    )
}


export default Bar;