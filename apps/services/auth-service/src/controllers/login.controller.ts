import { FastifyReply, FastifyRequest } from "fastify";
import { LoginInputInterface } from "../types/register.types";
import { LoginService } from "../services/login.service";
import z from "zod";

export class LoginController {
    private readonly loginService = new LoginService();

    async login(
        request: FastifyRequest<{ Body: LoginInputInterface }>,
        reply: FastifyReply
    ) {

        const schema = z.object({
            email: z.string().email().optional(),
            username: z.string().optional(),
            password: z.string().min(6),
        }).refine((data) => data.email || data.username, {
            message: "Email ou username é obrigatório",
        });
        
        const parseResult = schema.safeParse(request.body);

        if (!parseResult.success) {
            return reply.status(400).send({ error: parseResult.error.message });
        }

        const { email, username, password } = parseResult.data;

        const account = await this.loginService.login({
            email,
            username,
            password,
        });

        return reply.status(200).send(account);
    }
}