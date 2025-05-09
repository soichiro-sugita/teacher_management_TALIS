# only Japan data
library(dplyr)
library(haven)
# どの変数を使うのかを整理する

###### rules of the file name ######

# First letter = 
# A:primary school, 
# B:junior high, 
# C:high school(Japan is not contained in C)

# Second letter = C:principal, T:teacher
# JPN:Japan

####################################

# sav to cav -------------------------------------------------------------------------

# principal data -------------------------------------------------------------------------
principal_a <- read_sav("./data/raw/TALIS/2018/SPSS_2018_national/ACGJPNT3.sav")
principal_b <- read_sav("./data/raw/TALIS/2018/SPSS_2018_national/BCGJPNT3.sav")

write.csv(principal_a, "./data/raw/TALIS/2018/SPSS_2018_national/ACGJPNT3.csv")
write.csv(principal_b, "./data/raw/TALIS/2018/SPSS_2018_national/BCGJPNT3.csv")


# teacher data -------------------------------------------------------------------------
teacher_a <- read_sav("./data/raw/TALIS/2018/SPSS_2018_national/ATGJPNT3.sav")
teacher_b <- read_sav("./data/raw/TALIS/2018/SPSS_2018_national/BTGJPNT3.sav")

write.csv(teacher_a, "./data/raw/TALIS/2018/SPSS_2018_national/ATGJPNT3.csv")
write.csv(teacher_b, "./data/raw/TALIS/2018/SPSS_2018_national/BTGJPNT3.csv")



# import csv data  -------------------------------------------------------------------------

# principal data
principal_a <- read.csv("./data/raw/TALIS/2018/SPSS_2018_national/ACGJPNT3.csv")
principal_b <- read.csv("./data/raw/TALIS/2018/SPSS_2018_national/BCGJPNT3.csv")

# teacher data
teacher_a <- read.csv("./data/raw/TALIS/2018/SPSS_2018_national/ATGJPNT3.csv")
teacher_b <- read.csv("./data/raw/TALIS/2018/SPSS_2018_national/BTGJPNT3.csv")

