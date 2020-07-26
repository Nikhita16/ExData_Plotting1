library(sqldf)

ElectricPowerConsumption <-
  read.csv.sql(
    "household_power_consumption.txt",
    sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
    header = TRUE,
    sep = ";",
    dbname = tempfile(),
    drv = "SQLite"
  )

ElectricPowerConsumption$Global_active_power <-
  as.numeric(ElectricPowerConsumption$Global_active_power)



hist(
  ElectricPowerConsumption$Global_active_power,
  col = "Red",
  main = "Global Active Power",
  xlab = "Global Active power (kilowatts)",
  ylab = "Frequency"
)