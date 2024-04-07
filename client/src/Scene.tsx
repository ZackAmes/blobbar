import {FC} from "react";
import {Canvas, useThree} from "@react-three/fiber";
import {Box, Plane, OrbitControls} from "@react-three/drei";
import * as THREE from "three";

interface SceneProps {

}

const Scene: FC<SceneProps> = () => {

    return (
        <Canvas style={{height:800, width:800}}camera={{rotation: new THREE.Euler(Math.PI/3,0,0), position:[0,-8,4] }}>
            <mesh >
                <boxGeometry args={[20,20,.1]}/>
                <meshBasicMaterial color="black"/>
            </mesh>
            <mesh position = {[0, 5, .1]}>
                <boxGeometry args={[5,.1,1]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
        </Canvas>
    )
}


export default Scene;