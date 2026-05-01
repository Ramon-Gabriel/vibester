import { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { CreateProfileService } from "../services/createProfile.service.js";
import { CreateProfileInput, UpdateAvatarInput, UpdateBioInput } from "../types/profile.types.js";

const profileService = new CreateProfileService();

export async function profileRoutes(app: FastifyInstance) {
  app.post("/profile", async (request: FastifyRequest<{ Body: CreateProfileInput }>, reply: FastifyReply) => {
    try {
      const profile = await profileService.createProfile(request.body);
      return reply.status(201).send(profile);
    } catch (error) {
      request.log.error(error);
      return reply.status(500).send({ message: "Error creating profile" });
    }
  });

  app.put("/profile/bio", async (request: FastifyRequest<{ Body: UpdateBioInput }>, reply: FastifyReply) => {
    try {
      const profile = await profileService.updateBio(request.body);
      return reply.status(200).send(profile);
    } catch (error) {
      request.log.error(error);
      return reply.status(500).send({ message: "Error updating bio" });
    }
  });

  app.put("/profile/avatar", async (request: FastifyRequest<{ Body: UpdateAvatarInput }>, reply: FastifyReply) => {
    try {
      const profile = await profileService.updateAvatar(request.body);
      return reply.status(200).send(profile);
    } catch (error) {
      request.log.error(error);
      return reply.status(500).send({ message: "Error updating avatar" });
    }
  });

  app.post("/profile/followers/increase", async (request: FastifyRequest<{ Body: { userID: string } }>, reply: FastifyReply) => {
    try {
      const profile = await profileService.increaseFollower(request.body.userID);
      return reply.status(200).send(profile);
    } catch (error) {
      request.log.error(error);
      return reply.status(500).send({ message: "Error increasing followers" });
    }
  });

  app.post("/profile/followers/decrease", async (request: FastifyRequest<{ Body: { userID: string } }>, reply: FastifyReply) => {
    try {
      const profile = await profileService.decreaseFollower(request.body.userID);
      return reply.status(200).send(profile);
    } catch (error) {
      request.log.error(error);
      return reply.status(500).send({ message: "Error decreasing followers" });
    }
  });
}
