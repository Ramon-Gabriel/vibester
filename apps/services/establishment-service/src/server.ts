import Fastify from "fastify";
import cors from "@fastify/cors";
import { establishmentRoutes } from "./routes";
import { env } from "./config/env";

const app = Fastify({
  logger: true,
});

app.register(cors, {
  origin: "*",
});

app.register(establishmentRoutes);

const start = async () => {
  try {
    await app.listen({ port: env.PORT, host: "0.0.0.0" });
    console.log(`Establishment service listening on http://0.0.0.0:${env.PORT}`);
  } catch (err) {
    app.log.error(err);
    process.exit(1);
  }
};

start();
