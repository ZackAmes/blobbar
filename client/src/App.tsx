import { useComponentValue } from "@dojoengine/react";
import { Entity } from "@dojoengine/recs";
import { Suspense, useEffect, useState } from "react";
import { Direction, recipes } from "./utils";
import { getEntityIdFromKeys, hexToAscii } from "@dojoengine/utils";
import { useDojo } from "./dojo/useDojo";
import Bar from "./components/Bar";
import { Canvas } from "@react-three/fiber";
import * as THREE from "three";
import Controls from "./components/Controls";
import Button from "./components/Button";

function App() {
    const {
        setup: {
            systemCalls: { spawn, move, blobert, client_blobert, start_level },
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
    let start_time = blobtender?.start_time;

    let get_player_blobert = async () => {
        let blob_svg:Array<string> = await blobert();
        let res = "";
        blob_svg.map((hex) => {
            res += hexToAscii(hex)
        })
        return res.substring(1, res.length -1)
    }
    let blob_x = position? position.x*-3 +6 : 0
    let blob_position: [number, number, number] = [blob_x, -.75, .75]
    return (
        <>
        <Suspense>

            <Canvas style={{height:800, width:800}} camera={{ position:[0,-15,6] }}>
                <Bar blob_position = {blob_position} get_blobert={get_player_blobert}/>
                {position ? start_time == 0 ?       
                    <Button label="Start Level" rotation = {new THREE.Euler(Math.PI/2,0,0)} position = {[5,15,10]} onClick={() => start_level(account.account)}  />:

                    <Controls position={[0,15,10]} blobert_x={position.x} move={move} cur_drink="test" account={account}/> :
                    <Button label="Spawn" rotation = {new THREE.Euler(Math.PI/2,0,0)} position = {[5,15,10]} onClick={() => spawn(account.account)}  />
                    }
            </Canvas>
        </Suspense>
        </>
    );
}

export default App;
