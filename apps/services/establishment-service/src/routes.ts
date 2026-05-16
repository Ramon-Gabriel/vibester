import { FastifyInstance, FastifyPluginOptions } from "fastify";
import { 
  listEstablishmentsController, 
  updateEstablishmentRatingController 
} from "./controllers/establishment.controller";

export async function establishmentRoutes(fastify: FastifyInstance, options: FastifyPluginOptions) {
  fastify.get("/establishments", listEstablishmentsController);
  fastify.patch("/establishments/:id/rating", updateEstablishmentRatingController);
}
