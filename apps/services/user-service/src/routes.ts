import { FastifyInstance } from "fastify";
import { profileRoutes } from "./controllers/profile.controller.js";

export async function setupRoutes(app: FastifyInstance) {
  app.register(profileRoutes, { prefix: "/api/users" });
}
