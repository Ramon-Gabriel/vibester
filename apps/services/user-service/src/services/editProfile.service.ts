import prismaClient from "../prisma/index.js";
import { UpdateAvatarInput, UpdateBioInput } from "../types/profile.types.js";

export class EditProfileService {
    async updateBio(input: UpdateBioInput) {
        console.log("Atualizando bio do usuário", input.userID);

        const profile = await prismaClient.userProfile.update({
            where: { userID: input.userID },
            data: { bio: input.bio }
        });

        return profile;
    }

    async updateAvatar(input: UpdateAvatarInput) {
        console.log("Atualizando avatar do usuário", input.userID);

        const profile = await prismaClient.userProfile.update({
            where: { userID: input.userID },
            data: { avatarUrl: input.avatarUrl }
        });

        return profile;
    }

    async increaseFollower(userID: string) {
        const profile = await prismaClient.userProfile.update({
            where: { userID: userID },
            data: { followers: { increment: 1 } }
        });

        return profile;
    }

    async decreaseFollower(userID: string) {
        const profile = await prismaClient.userProfile.update({
            where: { userID: userID },
            data: { followers: { decrement: 1 } }
        });

        return profile;
    }
}