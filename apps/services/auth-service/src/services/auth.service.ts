/*
import { AppError } from "../middlewares/error.middleware";
import { userRepository } from "../repositories/user.repository";
import { hashUtil } from "../utils/hash.util";
import { jwtUtil } from "../utils/jwt.util";
import { profileUtil } from "../utils/profile.util";
import { LoginDTO, RegisterDTO } from "../dtos/auth.dto";

export const authService = {

    async login(data: LoginDTO) {
        const user = await userRepository.findByEmail(data.email);
        if (!user) {
            throw new AppError("Email ou senha inválidos", 401);
        }

        const validPassword = await hashUtil.compare(data.password, user.password)
        if (!validPassword) {
            throw new AppError("Email ou senha inválidos", 401);
        }

        const accessToken = jwtUtil.generateAccess(user.id);
        const refreshToken = jwtUtil.generateRefresh(user.id);

        const profile = await profileUtil.getByUserId(user.id);

        return { accessToken, refreshToken, profile };
    },

    async refreshToken(refreshToken: string) {
        try {
            const { userId } = jwtUtil.verify(refreshToken);
            const accessToken = jwtUtil.generateAccess(userId);
            return { accessToken };
        } catch (err) {
            throw new AppError("Token de atualização inválido", 401);
        }
    },

    async logout(userId: string) {
        // Aqui você pode implementar a lógica para invalidar o token de atualização, 
        // como armazenar os tokens em um banco de dados e marcá-los como inválidos.
        return { message: "Logout realizado com sucesso" };
    }

}
*/