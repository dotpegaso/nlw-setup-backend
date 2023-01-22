import { FastifyInstance } from "fastify"
import dayjs from 'dayjs'
import { z } from 'zod' 
import { prisma } from "./lib/prisma"

export async function appRoutes(app: FastifyInstance) {
  app.post('/habits', async (request) => {

    const createHabitBody = z.object({
      title: z.string(),
      weekDays: z.array(z.number().min(0).max(6)),
    })

    const { title, weekDays } = createHabitBody.parse(request.body) // request.params, request.query

    const today = dayjs().startOf('day').toDate()

    await prisma.habit.create({
      data: {
        title,
        created_at: today,
        weekDayHabit: {
          create: weekDays.map(day => ({ week_day: day }))
        }
      }
    })
  })

  app.get('/day', async (request) => {

    const getDayParams = z.object({
      date: z.coerce.date()
    })

    const { date } = getDayParams.parse(request.query)

    const parsedDate = dayjs(date).startOf('day')
    const weekDay = parsedDate.get('day')

    console.log('date/weekDay', date, weekDay)

    const availableHabits = await prisma.habit.findMany({
      where: {
        created_at: {
          lte: date,
        },
        weekDayHabit: {
          some: {
            week_day: weekDay
          }
        }
      }
    })

    const day = await prisma.day.findUnique({
      where: {
        date: parsedDate.toDate()
      },
      include: {
        dayHabits: true
      }
    })

    const completedHabits = day?.dayHabits.map(dayHabit => dayHabit.id)

    return {
      availableHabits,
      completedHabits
    }
  })
}

