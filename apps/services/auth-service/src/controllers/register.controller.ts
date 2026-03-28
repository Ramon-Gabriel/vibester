import { FastifyReply, FastifyRequest } from "fastify";
import { RegisterService } from "../services/register.service";
import { RegisterInputInterface } from "../types/register.types";

export class RegisterController {
    private readonly registerService = new RegisterService();

    async register(
        request: FastifyRequest<{ Body: RegisterInputInterface }>,
        reply: FastifyReply
    ) {
        const { name, username, email, password, bornAt } = request.body;

        const account = await this.registerService.register({
            name,
            username,
            email,
            password,
            bornAt: new Date(bornAt),
        });

        return reply.status(201).send(account);
    }
}