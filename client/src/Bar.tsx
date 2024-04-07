import {FC, useState, useEffect} from "react";
import {Canvas, useThree} from "@react-three/fiber";
import {Box, Plane, OrbitControls} from "@react-three/drei";
import * as THREE from "three";
import { text } from "stream/consumers";

interface BlobertProps {
    get_blobert: () => Promise<string>;
}

const Blobert = ({get_blobert}: BlobertProps) => {
    const [texture, setTexture] = useState(new THREE.Texture);
  
    useEffect(() => {
      // Fetch the SVG string
      get_blobert().then(svgString => {
        // Convert SVG string to Blob URL
        const blob = new Blob([svgString], { type: 'image/svg+xml' });
        const url = URL.createObjectURL(blob);
  
        // Use TextureLoader to load the texture
        const loader = new THREE.TextureLoader();
        loader.load(url, texture => {
          setTexture(texture);
          URL.revokeObjectURL(url); // Clean up the blob URL
        });
      });
    }, []);
    console.log(texture);
    if (!texture) return null;
  
    return (
      <mesh>
        <planeGeometry args={[10, 10]} />
        <meshBasicMaterial map={texture} />
      </mesh>
    );
};

interface BarProps {
    get_blobert: () => Promise<string>
}

const Bar: FC<BarProps> = ({get_blobert}) => {

    

    return (
        <group rotation = {new THREE.Euler(Math.PI/9,0,0)}>
            <Blobert get_blobert={get_blobert} />
            {/*
            <mesh >
                <boxGeometry args={[20,20,.1]}/>
                <meshBasicMaterial color="black"/>
            </mesh>
            <mesh position = {[0, 5, .1]}>
                <boxGeometry args={[5,.1,1]}/>
                <meshBasicMaterial color="brown"/>
            </mesh>
    */}
        </group>
    )
}


export default Bar;