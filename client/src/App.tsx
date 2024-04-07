import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { Suspense, useEffect, useState } from "react";
import { Direction } from "./utils";
import { getEntityIdFromKeys, hexToAscii } from "@dojoengine/utils";
import { useDojo } from "./dojo/useDojo";
import Bar from "./Bar";
import { Canvas } from "@react-three/fiber";
import * as THREE from "three";
import { SVGLoader } from "three/examples/jsm/loaders/SVGLoader"
import { OrbitControls } from "@react-three/drei";

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
    let position = blobtender?.position;

    let get_blobert = async () => {
        let blob_svg:Array<string> = await blobert();
        let res = "";
        blob_svg.map((hex) => {
            res += hexToAscii(hex)
        })
        return res.substring(1, res.length -1)


    }

    return (
        <>
        <Suspense>

            <Canvas style={{height:800, width:800}}camera={{ position:[0,-8,4] }}>
                <OrbitControls />

                <></>
                <Bar get_blobert={get_blobert}/>

            </Canvas>
        </Suspense>
        </>
    );
}

export default App;
