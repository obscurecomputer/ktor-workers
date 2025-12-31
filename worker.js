import {Container, getRandom} from "@cloudflare/containers";

export class ApplicationContainer extends Container {
    defaultPort = 8080;
    sleepAfter = "10s";
}

/**
 * @type {ExportedHandler<Env>}
 */
export default {
    async fetch(request, env, ctx) {
        const containerInstance = await getRandom(env.APPLICATION_CONTAINER, 1);
        return containerInstance.fetch(request);
    }
}