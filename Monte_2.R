#working directory ----

setwd(getwd())

#used packages ----

library(readr)
library(decisionSupport)
library(vctrs)
library(tidyverse)


input_estimates_two <- read.csv("input_estimates_project.csv",sep = ";", header = TRUE)

# input_estimates_two[, c(2,4)] <- sapply(input_estimates_two[, c(2,4)], as.numeric)
# varnames <- c(colnames(input_estimates_two))
# var_CV <- 1

#Build function ----

agrivp_vs_agroforestry_function_two <- function(x,varnames){
  
# ex-ante risks: impact the implementation of interventions ----
  
  # pv_int_event_no_involvement_by_population <-
  # chance_event(av_int_no_involvement_by_population, 1, 0, n = 1)
  # 
  # af_int_event_no_involvement_by_institution <-
  # chance_event(av_int_no_involvement_by_institution, 1, 0, n = 1)
  
  
#set variables with variation over a period of time with the vv_function is optional
  
#profits_both_systems

yield_crop                      <- vv(var_mean = crop_Yield, var_CV, n_years)
monetary_crop                   <- vv(var_mean = crop_monetary, var_CV, n_years)
profit_photovoltaic             <- vv(var_mean = profit_pv, var_CV, n_years)
profit_agroforestry             <- vv(var_mean = profit_af, var_CV, n_years)

#costs_photovoltaic

Investment_cost_photovoltaic    <- vv(var_mean = investment_cost_pv, var_CV, n_years)
anual_cost_photovoltaic         <- vv(var_mean = annual_cost_pv, var_CV, n_years)
yield_loss_photovoltaic         <- vv(var_mean = yield_loss_pv, var_CV, n_years)

#costs_agroforestry

investment_cost_agroforestry    <- vv(var_mean = investment_cost_af, var_CV, n_years)
anual_cost_agroforestry        <- vv(var_mean = anual_cost_af, var_CV, n_years)
yield_loss_agroforestry         <- vv(var_mean = yield_loss_af, var_CV, n_years)

# some trials wit rnorm()
  
# yield_crop <- rnorm(n_years, crop_Yield, abs(crop_Yield * var_CV / 100))
# monetary_crop <- rnorm(n_years, crop_monetary, abs(crop_monetary * var_CV / 100))
# profit_photovoltaic <- rnorm(n_years, profit_pv, abs(profit_pv * var_CV / 100))
# profit_agroforestry <- rnorm(n_years, profit_af, abs(profit_af * var_CV / 100))
# 
# #costs_photovoltaic
# Investment_cost_photovoltaic <- rnorm(n_years, investment_cost_pv, abs(investment_cost_pv * var_CV / 100))
# anual_cost_photovoltaic <- rnorm(n_years, annual_cost_pv, abs(annual_cost_pv * var_CV / 100))
# yield_loss_photovoltaic <- rnorm(n_years, yield_loss_pv, abs(yield_loss_pv * var_CV / 100))
# 
# #costs_agroforestry
# investment_cost_agroforestry <- rnorm(n_years, investment_cost_af, abs(investment_cost_af * var_CV / 100))
# anual_cost_agroforestry <- rnorm(n_years, annual_cost_af, abs(annual_cost_af * var_CV / 100))
# yield_loss_agroforestry <- rnorm(n_years, yield_loss_af, abs(yield_loss_af * var_CV / 100))

# decision conventional farm vs photovoltaic or agroforestry ---- 
  
  for (decision_af in c(FALSE, TRUE)) {
    
    if (decision_af){
      
      intervention_af_gain <- TRUE
      intervention_af_overall_costs <- TRUE
      intervention_af_risks <- TRUE 
    } else 
    {
      intervention_af_gain <- FALSE
      intervention_af_overall_costs <- FALSE
      intervention_af_risks <- FALSE  
    }
    
    # gain_af
    
    if (intervention_af_gain) {
      gain_af_intervention <- 
        subsidies_af+
        profit_af                # profit_af = wood_yield*wood_price 
    } else 
      gain_af_intervention <- 0
    
    # costs_af
    
    if (intervention_af_overall_costs) {
      costs_overall_af_intervention <-
        investment_cost_af +
        annual_cost_af 
    } else 
      costs_overall_af_intervention <- 0
  }
  
  # risks_af_(optional)
  
  
  for   (decision_pv in c(FALSE, TRUE)) {
    
    if (decision_pv){
      
      intervention_pv_gain <- TRUE
      intervention_pv_overall_costs <- TRUE
      intervention_pv_risks <- TRUE 
    } else 
    {
      intervention_pv_gain <- FALSE
      intervention_pv_overall_costs <- FALSE
      intervention_pv_risks <- FALSE  
    }
    
  }
  
  
  # calculation gain, costs, risks 
  
  # gain_pv 
  #  if (intervention_pv_gain) {
  #      gain_intervention_pv <-
  #      solar_radiaton_nrw *
  #      EEG_price
  #     } else 
  #       gain_intervention_pv <- 0 
  
  
  # gain_pv 
  if (intervention_pv_gain) {
    gain_intervention_pv <-
      profit_pv
    
  } else 
    gain_intervention_pv <- 0 
  
  # costs_pv     
  if (intervention_pv_overall_costs) {
    costs_intervention_pv_overall_costs <-
      investment_cost_pv +
      annual_cost_pv 
  } else 
    costs_intervention_pv_overall_costs <- 0

    
  
#   
#   NPV_af <- discount(gain_af_intervention, discount, calculate_NPV = TRUE)
#   NPV_af_int <- discount(costs_overall_af_intervention, discount, calculate_NPV = TRUE)
#   
#   NPV_pv <- discount(gain_intervention_pv, discount, calculate_NPV = TRUE)
#   NPV_pv_int <- discount( costs_intervention_pv_overall_costs, discount, calculate_NPV = TRUE)
#   
# return(list(af_NPV = NPV_af,
#             int_af_NPV = NPV_pv_int,
#             pv_NPV = NPV_pv,
#             int_pv_NPV = NPV_pv_int,
#             Cashflow_decision_af = gain_af_intervention -  costs_overall_af_intervention,
#             Cashflow_decision_pv = gain_intervention_pv - costs_intervention_pv_overall_costs))
  
  
  
return(list(Gain_photovoltaic = gain_intervention_pv, 
            Gain_agroforestry = gain_af_intervention,
            Cost_pv = costs_intervention_pv_overall_costs,
            Cost_af =  costs_overall_af_intervention 
            ))
    
} # Function bracket

# Monte

# Monte estimate_read_csv path 
# mcSimulation_results <- decisionSupport::mcSimulation(
#   estimate = decisionSupport::estimate_read_csv("input_estimates_project.csv"),
#   model_function = agrivp_vs_agroforestry_function_two(),
#   numberOfModelRuns = 200,
#   functionSyntax = "plainNames"
# )

# Monte with estimate() 
example_mc_simulation <- mcSimulation(estimate = as.estimate(input_estimates_two),
                                      model_function = agrivp_vs_agroforestry_function_two,
                                      numberOfModelRuns = 100,
                                      functionSyntax = "plainNames")



result <- agrivp_vs_agroforestry_function_two()

plot_distributions(mcSimulation_object = example_mc_simulation, 
                   vars = c("Gain_photovoltaic", "Gain_agroforestry", "Cost_pv", "Cost_af"),
                   method = 'smooth_simple_overlay', 
                   base_size = 7)

# Extract the components from the returned list
component_a <- result$
component_b <- result$b
component_c <- result$c

# Print the extracted components
print(component_a)
print(component_b)
print(component_c)






# test area

make_variables<-function(est,n=1)
{ x<-random(rho=est, n=n)
for(i in colnames(x)) assign(i, as.numeric(x[1,i]),envir=.GlobalEnv)}

make_variables(estimate_read_csv("input_estimates_project.csv"))

result_2 <- make_variables()
