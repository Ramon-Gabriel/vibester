import Fastify from 'fastify';
import cors from '@fastify/cors';
import { authRoutes } from './routes';
import { env } from './config/env';

const app = Fastify();
const port = env.port || 3001;

const start = async () => {
    await app.register(cors);
    await app.register(authRoutes);

    try {
        await app.listen({ port: 3001 });
    } catch (err) {
        process.exit(1);
    }

}

start();