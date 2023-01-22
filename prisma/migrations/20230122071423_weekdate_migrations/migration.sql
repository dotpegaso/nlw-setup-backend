/*
  Warnings:

  - You are about to drop the `DayHabits` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Habits` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `WeekDaysHabits` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "DayHabits";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Habits";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "WeekDaysHabits";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Habit" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "DayHabit" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "day_id" TEXT NOT NULL,
    "habit_id" TEXT NOT NULL,
    CONSTRAINT "DayHabit_day_id_fkey" FOREIGN KEY ("day_id") REFERENCES "Day" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "DayHabit_habit_id_fkey" FOREIGN KEY ("habit_id") REFERENCES "Habit" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "WeekDayHabit" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "habit_id" TEXT NOT NULL,
    "week_day" INTEGER NOT NULL,
    CONSTRAINT "WeekDayHabit_habit_id_fkey" FOREIGN KEY ("habit_id") REFERENCES "Habit" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "DayHabit_day_id_habit_id_key" ON "DayHabit"("day_id", "habit_id");

-- CreateIndex
CREATE UNIQUE INDEX "WeekDayHabit_habit_id_week_day_key" ON "WeekDayHabit"("habit_id", "week_day");
