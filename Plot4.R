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

par(mfrow = c(2, 2))
with(ElectricPowerConsumption, {
  plot(
    Global_active_power ~ Datetime,
    type = "l",
    ylab = "Global Active Power",
    xlab = ""
  )
  plot(Voltage ~ Datetime,
       type = "l",
       ylab = "Voltage",
       xlab = "datetime")
  plot(
    Sub_metering_1 ~ Datetime,
    type = "l",
    ylab = "Energy sub metering",
    xlab = ""
  )
  lines(Sub_metering_1 ~ Datetime, col = 'Black')
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend(
    "topright",
    col = c("black", "red", "blue"),
    lwd = 1,
    bty = "n",
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  )
  plot(
    Global_reactive_power ~ Datetime,
    type = "l",
    ylab = "Global_rective_power",
    xlab = "datetime"
  )
})