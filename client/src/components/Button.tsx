import { FC } from "react"
import { Text, Box } from "@react-three/drei"


interface ButtonProps {
    label: string,
    onClick: any,
    position: [number, number, number]
}

const Button: FC<ButtonProps> = ({label, onClick, position}) => {

    return (
        <group onClick= {onClick} position = {position}>
            <Box args = {[3, .1, 1]}>
                <meshBasicMaterial color="black" />
            </Box>
            <Text position = {[position[0], position[1]+.1, position[2]]}>
                <meshBasicMaterial color = "white"/>
                {label}
            </Text>
        </group>
    )
}

export default Button;