import fastify from "fastify";
import cors from '@fastify/cors'
import { PrismaClient } from "@prisma/client";

const app = fastify()
const prisma = new PrismaClient()

app.register(cors)

app.get('/', async () => {
  const habits = await prisma.habits.findMany({
    where: {
      title: {
        startsWith: 'Beber'
      }
    }
  })

  return habits
})

app.listen({
  port: 3333,
}).then(() => {
  console.log('http server up!')
})