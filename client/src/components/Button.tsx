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
            <Text scale={1.25} position = {[0, .5, 0]}>
                <meshBasicMaterial color = "Black"/>
                {label}
            </Text>
        </group>
    )
}

export default Button;