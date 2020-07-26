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


plot(
  ElectricPowerConsumption$Global_active_power ~ ElectricPowerConsumption$Datetime,
  type = "l",
  ylab = "Global Active Power (kilowatts)",
  xlab = ""
)