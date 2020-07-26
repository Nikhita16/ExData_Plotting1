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


ElectricPowerConsumption$Date <-
  as.Date(ElectricPowerConsumption$Date, format = "%d/%m/%Y")
datetime <-
  paste(as.Date(ElectricPowerConsumption$Date),
        ElectricPowerConsumption$Time)
ElectricPowerConsumption$Datetime <- as.POSIXct(datetime)


with(ElectricPowerConsumption, {
  plot(
    Sub_metering_1 ~ Datetime,
    type = "l",
    ylab = "Energy sub metering",
    xlab = ""
  )
})
lines(ElectricPowerConsumption$Sub_metering_1 ~ ElectricPowerConsumption$Datetime,
      col = 'Black')
lines(ElectricPowerConsumption$Sub_metering_2 ~ ElectricPowerConsumption$Datetime,
      col = 'Red')
lines(ElectricPowerConsumption$Sub_metering_3 ~ ElectricPowerConsumption$Datetime,
      col = 'Blue')
legend(
  "topright",
  col = c("black", "red", "blue"),
  lwd = 1,
  bty = "n",
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)
