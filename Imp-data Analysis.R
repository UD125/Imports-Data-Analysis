#----------------Sql in R using Package sqldf------------------------

#--------------------Country wise India's Imports Data by Principal Commodity during 2011-12 & 2012-13.

getwd()
Impdata <- read.csv("datafile.csv")
summary(Impdata)
View(Impdata)
dim(Impdata)
library(Hmisc)
describe(Impdata)
attach(Impdata)
mean(Quantity...2011.12)
mean(Quantity...2012.13)

as.data.frame(colSums(is.na(Impdata)))

#Installing Sqldf package-------------------------------------
install.packages("sqldf",dependencies = TRUE)
library(sqldf)
#Selecting All Variables---------------------------------------
S1 <- sqldf("select *
            from Impdata") # * - Refers to all variables in the dataset.
S1

colnames(Impdata)[which(names(Impdata)=="Principal.Commodity")] = "PrincipalCommodity"
colnames(Impdata)[which(names(Impdata)=="Country.exporting.to.India")] = "CountryExpIndia"
#Renaming is done because of dots in between the variable name which shows while running an sql query

#Selecting Variables based on Name----------------------
S2 <- sqldf("select PrincipalCommodity, CountryExpIndia
            from Impdata")
S2

colnames(Impdata)[which(names(Impdata)=="Quantity...2011.12")] = "Qty2011-12" 

#Selecting Variables based on condition------------------
S3 <- sqldf('select *
            from Impdata
            where "Qty2011-12" > 8000000')
S3

S4 <- sqldf('select "PrincipalCommodity","Unit", "CountryExpIndia", "Qty2011-12","ValueINR2011-12"
            from Impdata
            where "Qty2011-12" > 8000000')
S4

colnames(Impdata)[which(names(Impdata)=="Value..INR....2011.12")] = "ValueINR2011-12" 

max(`Qty2011-12`)

#Here after knowing maximum Qty2011-12, I ran this query to know which commodity is imported in maximum quantity from which country in 2011-12.
S5 <- sqldf('select "PrincipalCommodity","Unit", "CountryExpIndia", "Qty2011-12","ValueINR2011-12"
            from Impdata
            where "Qty2011-12" == 55260271')
S5 #Commodity - Coal, Coke & Briquittes ETC. , Country - Indonesia in 2011-12.

colnames(Impdata)[which(names(Impdata)=="Value..INR....2012.13")] = "ValueINR2012-13" 
colnames(Impdata)[which(names(Impdata)=="Value..INR....2011.12")] = "ValueINR2011-12" 
colnames(Impdata)[which(names(Impdata)=="Quantity...2012.13")] = "Qty2012-13" 

attach(Impdata)
max(`Qty2012-13`)

S6 <- sqldf('select "PrincipalCommodity","Unit", "CountryExpIndia", "Qty2012-13","ValueINR2012-13"
            from Impdata
            where "Qty2012-13" == 77493363')
S6 #Commodity - Coal, Coke & Briquittes ETC. , Country - Indonesia in 2012-13

S7 <- sqldf('select "PrincipalCommodity","Unit", "CountryExpIndia", "Qty2012-13","ValueINR2012-13"
            from Impdata
            where "Qty2012-13" > 8000000')
S7

S8 <- sqldf('select "PrincipalCommodity","CountryExpIndia","ValueINR2012-13"
            from Impdata
            where "ValueINR2012-13" > 1000000000000 ')
S8

# Run this query to find out Highest Value Imports from  different Countries---------
S9 <- sqldf('select *
            from Impdata
            where "ValueINR2011-12" > 1000000000000 AND "ValueINR2012-13" > 1000000000000 ')
S9 #Highest Value Imports from two countries - Saudi Arab and Switzerland
# Commodity - Petroleum, Crude & Products - Saudi Arab
# Commodity - Gold                        - Switzerland

