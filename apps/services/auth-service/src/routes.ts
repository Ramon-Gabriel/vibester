import { FastifyInstance, FastifyPluginOptions, FastifyReply, FastifyRequest } from "fastify";
import { RegisterInputInterface } from "./types/register.types";
import { RegisterController } from "./controllers/register.controller";

export async function authRoutes(instance: FastifyInstance, options: FastifyPluginOptions) {
    instance.post("/register", async(
        request: FastifyRequest<{ Body: RegisterInputInterface }>,
        reply: FastifyReply) => {
            return new RegisterController().register(request, reply);
        });
}