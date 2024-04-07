import { AccountInterface } from "starknet";
import { Entity, getComponentValue } from "@dojoengine/recs";
import { uuid } from "@latticexyz/utils";
import { ClientComponents } from "./createClientComponents";
import { Direction, updatePositionWithDirection } from "../utils";
import {
    getEntityIdFromKeys,
    getEvents,
    setComponentsFromEvents,
} from "@dojoengine/utils";
import { ContractComponents } from "./generated/contractComponents";
import type { IWorld } from "./generated/generated";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
    { client }: { client: IWorld },
    contractComponents: ContractComponents,
    { Blobtender }: ClientComponents
) {
    const spawn = async (account: AccountInterface) => {
        const entityId = getEntityIdFromKeys([
            BigInt(account.address),
        ]) as Entity;

        try {
            const { transaction_hash } = await client.actions.spawn({
                account,
            });

            console.log(
                await account.waitForTransaction(transaction_hash, {
                    retryInterval: 100,
                })
            );

            setComponentsFromEvents(
                contractComponents,
                getEvents(
                    await account.waitForTransaction(transaction_hash, {
                        retryInterval: 100,
                    })
                )
            );
        } catch (e) {
            console.log(e);
        } 
    };

    const blobert = async () => {
        try {
            const res = await client.actions.get_random_blobert();
            console.log(res);
        }catch(e) {
            console.log(e)
        }
    }
    const move = async (account: AccountInterface, direction: Direction) => {
        const entityId = getEntityIdFromKeys([
            BigInt(account.address),
        ]) as Entity;


        try {
            const { transaction_hash } = await client.actions.move({
                account,
                direction,
            });

            setComponentsFromEvents(
                contractComponents,
                getEvents(
                    await account.waitForTransaction(transaction_hash, {
                        retryInterval: 100,
                    })
                )
            );
        } catch (e) {
            console.log(e);
        } 
    };

    return {
        spawn,
        move,
        blobert
    };
}
