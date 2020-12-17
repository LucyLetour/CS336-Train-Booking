package db

import java.time.Duration
import java.time.LocalDateTime
import kotlin.random.Random

fun main() {
    try {

        val trainTids = listOf(
                1000,
                1089,
                1159,
                1429,
                1681,
                1734,
                1764,
                1824,
                2098,
                2159,
                2211,
                2303,
                2337,
                2464,
                2504,
                2594,
                2608,
                2648,
                2737,
                2738,
                2768,
                3039,
                3132,
                3217,
                3250,
                3287,
                3448,
                3638,
                3745,
                3866,
                3930,
                3987,
                4102,
                4147,
                4163,
                4297,
                4309,
                4403,
                4486,
                4598,
                4694,
                4749,
                4763,
                4832,
                4852,
                4892,
                5144,
                5145,
                5249,
                5314,
                5335,
                5409,
                5441,
                5693,
                5706,
                5735,
                5871,
                5984,
                6080,
                6084,
                6293,
                6318,
                6416,
                6440,
                6654,
                6683,
                6897,
                7313,
                7351,
                7367,
                7399,
                7450,
                7532,
                7542,
                7555,
                7710,
                7712,
                7771,
                7802,
                7811,
                7917,
                7933,
                7966,
                8033,
                8120,
                8125,
                8352,
                8462,
                8494,
                8790,
                8865,
                8867,
                9084,
                9138,
                9192,
                9275,
                9476,
                9612,
                9949,
                9951,
                9999
        )

        val insertStmnt =
                "INSERT INTO train_schedule " +
                "VALUES (?1, ?2, '?3', ?4);"

        val insertStops =
                "INSERT INTO stops_at " +
                "VALUES (?1, ?2, STR_TO_DATE('?3', '%Y-%m-%dT%H:%i:%s'), STR_TO_DATE('?4', '%Y-%m-%dT%H:%i:%s'), ?5, ?6);"



        for(i in trainTids) {
            var insertStmt1 = insertStmnt

            var travelTime: Int
            var trainLine = ""
            val fare = Random.nextInt(30, 90)

            var startTime = LocalDateTime.now()
            startTime = startTime.plusDays(Random.nextLong(-2, 7))
            startTime = startTime.plusHours(Random.nextLong(0, 22))
            startTime = startTime.plusMinutes(Random.nextLong(0, 52))


            val map2 = mapOf(
                    1 to listOf(16, 11, 7, 6, 1),
                    2 to listOf(17, 7, 3, 2),
                    3 to listOf(3, 7, 6),
                    4 to listOf(13, 8, 22),
                    5 to listOf(13, 8, 18),
                    6 to listOf(21, 19, 20),
                    7 to listOf(9, 14),
                    8 to listOf(4, 15, 10, 5),
                    9 to listOf(10, 12),
            )

            val stops = map2[i / 1000] ?: error("")

            when (i / 1000) {
                1 -> {
                    trainLine = "Main Line"
                }
                2 -> {
                    trainLine = "Northeast Corridor"
                }
                3 -> {
                    trainLine = "Grand Coast"
                }
                4 -> {
                    trainLine = "SpaceX Line"
                }
                5 -> {
                    trainLine = "South Line"
                }
                6 -> {
                    trainLine = "NJ Coastline"
                }
                7 -> {
                    trainLine = "Tiny Coast"
                }
                8 -> {
                    trainLine = "Chernobyl"
                }
                9 -> {
                    trainLine = "Southwest Corridor"
                }
            }

            var lastTime = startTime

            val stopsAndTimes = mutableListOf<Pair<Int, LocalDateTime>>()

            if(Random.nextBoolean()) {
                for(s in stops.indices) {
                    stopsAndTimes.add(Pair(stops[s], lastTime))
                    lastTime = lastTime.plusMinutes(Random.nextLong(20, 120))
                }
            } else {
                for(s in stops.lastIndex downTo 0) {
                    stopsAndTimes.add(Pair(stops[s], lastTime))
                    lastTime = lastTime.plusMinutes(Random.nextLong(20, 120))
                }
            }

            val duration = Duration.between(stopsAndTimes.first().second, stopsAndTimes.last().second)
            travelTime = duration.toMinutes().toInt()


            insertStmt1 = insertStmt1.replace("?1", i.toString(), true)
            insertStmt1 = insertStmt1.replace("?2", travelTime.toString(), true)
            insertStmt1 = insertStmt1.replace("?3", trainLine, true)
            insertStmt1 = insertStmt1.replace("?4", fare.toString(), true)
            println(insertStmt1)

            for(j in stopsAndTimes.indices) {
                var insertStops1 = insertStops
                insertStops1 = insertStops1.replace("?1", i.toString())
                insertStops1 = insertStops1.replace("?2", stopsAndTimes[j].first.toString())
                if(j != 0) {
                    insertStops1 = insertStops1.replace("?3", stopsAndTimes[j].second.toString().substringBefore('.'))
                    insertStops1 = insertStops1.replace("?5", "0")
                } else {
                    insertStops1 = insertStops1.replace("STR_TO_DATE('?3', '%Y-%m-%dT%H:%i:%s')", "null")
                    insertStops1 = insertStops1.replace("?5", "1")
                }

                if(j != stopsAndTimes.lastIndex) {
                    insertStops1 = insertStops1.replace("?4", stopsAndTimes[j].second.plusMinutes(Random.nextLong(1, 4)).toString().substringBefore('.'))
                    insertStops1 = insertStops1.replace("?6", "0")
                } else {
                    insertStops1 = insertStops1.replace("STR_TO_DATE('?4', '%Y-%m-%dT%H:%i:%s')", "null")
                    insertStops1 = insertStops1.replace("?6", "1")
                }
                println(insertStops1)
            }
        }
    } catch (e: Exception) {
        e.printStackTrace()
    }
}