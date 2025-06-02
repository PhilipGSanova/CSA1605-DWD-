# Data
AvgSpeed <- c(78, 81, 82, 74, 83, 82, 77, 80, 70)
TotalTime <- c(39, 37, 36, 42, 35, 36, 40, 38, 46)

# (a) Standard Deviation
sd_AvgSpeed <- sd(AvgSpeed)
sd_TotalTime <- sd(TotalTime)

cat("Standard Deviation of AvgSpeed:", sd_AvgSpeed, "\n")
cat("Standard Deviation of TotalTime:", sd_TotalTime, "\n")

# (b) Variance
var_AvgSpeed <- var(AvgSpeed)
var_TotalTime <- var(TotalTime)

cat("Variance of AvgSpeed:", var_AvgSpeed, "\n")
cat("Variance of TotalTime:", var_TotalTime, "\n")
