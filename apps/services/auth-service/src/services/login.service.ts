import prismaClient from "../prisma";
import { LoginInputInterface, LoginOutputInterface } from "../types/register.types";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { env } from "../config/env";


export class LoginService {
    async login(input: LoginInputInterface): Promise<LoginOutputInterface> {
        console.log("Realizando login de usuário");

        const user = await prismaClient.access.findFirst({
            where: {
                OR: [
                    { email: input.email },
                    { username: input.username }
                ],
            }
        });

        if (!user) {
            throw new Error("Usuário ou senha inválidos");
        }

        const passwordMatch = await bcrypt.compare(input.password, user.passwordHash);

        if (!passwordMatch) {
            throw new Error("Usuário ou senha inválidos");
        }

        const token = jwt.sign(
            { userId: user.id },
            env.jwtSecret,
            { expiresIn: env.jwtExpiresIn as jwt.SignOptions["expiresIn"] }
        );

        return {
            id: user.id,
            token,
            accountId: user.accountId,
        };
    }
}