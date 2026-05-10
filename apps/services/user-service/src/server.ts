import Fastify from 'fastify';
import cors from '@fastify/cors';
import { env } from './config/env.js';
import { setupRoutes } from './routes.js';

const app = Fastify();
const port = env.port || 3002;

const start = async () => {
    await app.register(cors);
    await setupRoutes(app);

    try {
        await app.listen({ port: 3002 });
    } catch (err) {
        process.exit(1);
    }   
}

start();
