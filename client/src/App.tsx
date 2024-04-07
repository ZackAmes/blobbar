import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { Suspense, useEffect, useState } from "react";
import { Direction } from "./utils";
import { getEntityIdFromKeys, hexToAscii } from "@dojoengine/utils";
import { useDojo } from "./dojo/useDojo";
import Bar from "./components/Bar";
import { Canvas } from "@react-three/fiber";
import * as THREE from "three";

function App() {
    const {
        setup: {
            systemCalls: { spawn, move, blobert },
            clientComponents: { Blobtender },
        },
        account,
    } = useDojo();


    // entity id we are syncing
    const entityId = getEntityIdFromKeys([
        BigInt(account?.account.address),
    ]) as Entity;

    // get current component values
    const blobtender = useComponentValue(Blobtender, entityId);
    console.log(blobtender);
    let position = blobtender?.position;

    let get_blobert = async () => {
        let blob_svg:Array<string> = await blobert();
        let res = "";
        blob_svg.map((hex) => {
            res += hexToAscii(hex)
        })
        return res.substring(1, res.length -1)
    }

    let blob_position: [number, number, number] = [position? position.x: 0, -.75, .75]
    return (
        <>
        <Suspense>

            <Canvas style={{height:800, width:800}} camera={{ position:[0,-15,6] }}>
                <></>
                <Bar blob_position = {blob_position} get_blobert={get_blobert}/>

            </Canvas>
        </Suspense>
        </>
    );
}

export default App;
