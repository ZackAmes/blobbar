import { useState, useEffect } from "react";
import * as THREE from "three";

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
      <mesh position={[0,8,.1]}rotation = {new THREE.Euler(Math.PI/4,0,0)}>
        <planeGeometry args={[3, 3]} />
        <meshBasicMaterial map={texture} />
      </mesh>
    );
};

export default Blobert;