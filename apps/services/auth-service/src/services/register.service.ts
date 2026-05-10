import prismaClient from "../prisma/index";
import { RegisterInputInterface, RegisterOutputInterface } from "../types/register.types";
import { hash } from "bcryptjs";
import { randomUUID } from "node:crypto";

export class RegisterService {
    async register(input: RegisterInputInterface): Promise<RegisterOutputInterface> {
        console.log("Criando cadastro de usuário");

        const passwordHash = await hash(input.password, 10);

        const account = await prismaClient.access.create({
            data: {
                accountId: randomUUID(),
                username: input.username,
                email: input.email,
                passwordHash,
            }
        });

        try {
            await fetch('http://localhost:3002/api/users/profile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    userID: account.accountId,
                })
            });
        } catch (err) {
            console.error('Failed to create profile in user-service', err);
        }
        
        return {
            id: account.id,
            // token
            username: account.username,
            name: input.name,
            email: account.email,
            createdAt: account.createdAt,
            updatedAt: account.updatedAt,
            bornAt: input.bornAt,
        };
    }
}
