# import international data

library(dplyr)
library(haven)

# sav data -------------------------------------------------------------------------------
# principal data
principal_a_int <- read_sav("./data/raw/TALIS/2018/SPSS_2018_international/ACGINTT3.sav")
principal_b_int <- read_sav("./data/raw/TALIS/2018/SPSS_2018_international/BCGINTT3.sav")
principal_c_int <- read_sav("./data/raw/TALIS/2018/SPSS_2018_international/CCGINTT3.sav")

write.csv(principal_a_int, "./data/raw/TALIS/2018/SPSS_2018_international/ACGINTT3.csv")
write.csv(principal_b_int, "./data/raw/TALIS/2018/SPSS_2018_international/BCGINTT3.csv")
write.csv(principal_c_int, "./data/raw/TALIS/2018/SPSS_2018_international/CCGINTT3.csv")



# teacher data
teacher_a_int <- read_sav("./data/raw/TALIS/2018/SPSS_2018_international/ATGINTT3.sav")
teacher_b_int <- read_sav("./data/raw/TALIS/2018/SPSS_2018_international/BTGINTT3.sav")
teacher_c_int <- read_sav("./data/raw/TALIS/2018/SPSS_2018_international/CTGINTT3.sav")

write.csv(teacher_a_int, "./data/raw/TALIS/2018/SPSS_2018_international/ATGINTT3.csv")
write.csv(teacher_b_int, "./data/raw/TALIS/2018/SPSS_2018_international/BTGINTT3.csv")
write.csv(teacher_c_int, "./data/raw/TALIS/2018/SPSS_2018_international/CTGINTT3.csv")