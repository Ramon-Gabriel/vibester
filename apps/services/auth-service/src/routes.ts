import { FastifyInstance, FastifyPluginOptions, FastifyReply, FastifyRequest } from "fastify";
import { LoginInputInterface, RegisterInputInterface } from "./types/register.types";
import { RegisterController } from "./controllers/register.controller";
import { LoginController } from "./controllers/login.controller";

export async function authRoutes(instance: FastifyInstance, options: FastifyPluginOptions) {
    
    instance.post("/register", async(
        request: FastifyRequest<{ Body: RegisterInputInterface }>,
        reply: FastifyReply) => {
            return new RegisterController().register(request, reply);
        }
    );

    instance.post("/login", async(
        request: FastifyRequest<{ Body: LoginInputInterface }>,
        reply: FastifyReply) => {
            return new LoginController().login(request, reply);
        }
    );
}