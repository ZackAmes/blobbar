import {FC} from "react";
import {Canvas} from "@react-three/fiber";
import {Box} from "@react-three/drei";

interface SceneProps {

}

const Scene: FC<SceneProps> = () => {

    return (
        <Canvas>
            <Box>
                <meshBasicMaterial color="brown"/>
            </Box>

        </Canvas>
    )
}

export default Scene;