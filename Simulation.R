#MonteCarlo Simulation

#loading area 
library("decisionSupport")
library(readr)


input_table <- read.csv2("input_estimates.csv", header = TRUE)
input_table

#Build function###

#area distribution

area_crop <- 0.8         #area for crops

area_row <- 1-area_crop  #area of the rows of pv or forest


#income factors

income_crop <- 
  crop_yield*crop_monetary
income_pv <-
  (income_crop * area_crop * yield_loss_pv) + profit_pv * area_row + subsidies_pv
income_af <-
  ( income_crop * area_crop * yield_loss_af) 
  + (profit_af * area_row * fluctuation_af) + subsidies_af + ecosystem_service_af

#cost factors

cost_pv <- annual_cost_pv + investment_cost_pv 
cost_af <- harvesting_cost_af + annual_cost_af + investment_cost_af


  
