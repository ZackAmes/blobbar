import { FC } from "react"
import { Text, Box } from "@react-three/drei"


interface ButtonProps {
    label: string,
    onClick: any,
    position: [number, number, number],
    rotation: any
}

const Button: FC<ButtonProps> = ({label, onClick, position, rotation}) => {

    return (
        <group rotation= {rotation} onClick= {onClick} position = {position}>
            <Box scale={1.5} args = {[1, .1, 1]}>
                <meshBasicMaterial color="black" />
            </Box>
            <Text scale={1.75} position = {[0, .5, 0]}>
                <meshBasicMaterial color = "white"/>
                {label}
            </Text>
        </group>
    )
}

export default Button;