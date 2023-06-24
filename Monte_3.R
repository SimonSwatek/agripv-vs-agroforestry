#working directory ----

setwd(getwd())

#used packages ----

library(readr)
library(decisionSupport)
library(vctrs)
library(tidyverse)

input_estimates_project <- read_delim("input_estimates_project.csv", 
                                                   delim = ";", escape_double = FALSE, trim_ws = TRUE)
#View(input_estimates_project_updatedtrial)



#Build function ----

agrivp_vs_agroforestry_function_two <- function(x,varnames){
  
# ex-ante risks: impact the implementation of interventions ----
  
# intervention_NonPopInvolvEvent <-
# chance_event(intervention_NonPopInvolv, 1, 0, n = 1) 
  


# pre-calculation of common random draws for all intervention model runs ----    
  
# benefits/gain concentional monocrop system Wheat Germany 
  
No_Intervention <- 
  vv(var_mean = crop_Yield, var_CV, n_years)*
  vv(var_mean = crop_price, var_CV, n_years)*
  vv(var_mean = crop_area, var_CV, n_years)
  

# benefits photovoltaic (pv)

precalc_intervention_pv_benefits <-
    vv(var_mean = area_pv, var_CV, n_years) *
    vv(var_mean = electrical_energy_yield, var_CV, n_years)+
    vv(var_mean = subsidies_pv, var_CV, n_years)*
    vv(var_mean = area_pv, var_CV, n_years)
  
# benefits of agroforestry (af)

  precalc_intervention_af_benefits <-
    vv(var_mean = area_af, var_CV, n_years) *
    vv(var_mean = wood_energy_yield, var_CV, n_years)+
    vv(var_mean = subsidies_af, var_CV, n_years)*
    vv(var_mean = area_af, var_CV, n_years)

# benefits of wheat crops (wc)
  
  precalc_intervention_wheat_crop_benefits <-
    vv(var_mean = crop_Yield, var_CV, n_years) *
    vv(var_mean = crop_area, var_CV, n_years) *
    vv(var_mean = crop_price, var_CV, n_years)
  
  

# Intervention cases ---- 
  
# Intervention agroforestry
  
  for (decision_af in c(FALSE, TRUE)) {
    
    if (decision_af){
      
      intervention_af_gain <- TRUE
      intervention_af_cost <- TRUE
      intervention_af_risks <- TRUE 
    } else 
    {
      intervention_af_gain <- FALSE
      intervention_af_cost <- FALSE
      intervention_af_risks <- FALSE  
    }
    
# Costs agroforestry
    
if (intervention_af_cost) {
    
    fixed_af_costs <-
    investment_cost_af+
    annual_cost_af+
    harvesting_cost_af
  } else
    fixed_af_costs <- 0 
    
    
 # Benefits from cultivation of trees in an intercropping system 
  
  af_benefits <-
   as.numeric(intervention_af_gain)*precalc_intervention_af_benefits # + yield loss wheat for missing cultivation area
  }
  

# Intervention Photovoltaic 
  
  for   (decision_pv in c(FALSE, TRUE)) {
    
    if (decision_pv){
      
      intervention_pv_gain <- TRUE
      intervention_pv_costs <- TRUE
      intervention_pv_risks <- TRUE 
    } else 
    {
      intervention_pv_gain <- FALSE
      intervention_pv_costs <- FALSE
      intervention_pv_risks <- FALSE  
    }
  
 # Costs pv
    
    
    if (intervention_pv_costs) {
      
      fixed_pv_costs <-
        investment_cost_pv+
        annual_cost_pv
      # + maintenance for energy storage 
    } else
      fixed_pv_costs <- 0  
    
    
# Benefits from using photovoltaic in an intercropping system 
    
    pv_benefits <-
      as.numeric(intervention_pv_gain)*precalc_intervention_pv_benefits # + yield loss wheat for missing cultivation area
  
}
  

  
# Net present value (NPV) calculation 
  
if (decision_af){
   net_benefits_af <- af_benefits - intervention_af_cost
   result_af_intervention <- net_benefits_af
   result_af_n_intervention <- 0

}  
if (!decision_af){
  result_af_n_intervention <- No_Intervention
  
}

if (decision_pv){
  net_benefits_pv <- pv_benefits - intervention_pv_costs
  result_pv_intervention <- net_benefits_pv
  result_af_n_intervention <- 0
}
  
  if (!decision_pv){
    result_af_n_intervention <- No_Intervention
}    

discount_rate <- 5 # test value, no idea which value is good   
NPV_af <-
  discount(result_af_intervention, discount_rate, calculate_NPV = TRUE)

NPV_pv <- 
  discount(result_pv_intervention, discount_rate, calculate_NPV = TRUE)

NPV_no <-
  discount(result_af_n_intervention, discount_rate, calculate_NPV = TRUE)
  
  
return(list(Gain_photovoltaic = NPV_pv, 
            Gain_agroforestry = NPV_af,
            Gain_monoculture  = NPV_no,
            Cashflow_decison_do = NPV_pv+NPV_af - NPV_no
            ))
    
} # End function 


# Monte simulation ----

# Monte estimate_read_csv path 
# 
# mcSimulation_results <- decisionSupport::mcSimulation(
#   estimate = decisionSupport::estimate_read_csv("D:/Desktop/Decision Analysis and Forecasting R/seminar_project/Project_code_factory"),
#   model_function = agrivp_vs_agroforestry_function_two(),
#   numberOfModelRuns = 200,
#   functionSyntax = "plainNames"
# )

# Monte with estimate() 

example_mc_simulation <- mcSimulation(estimate = as.estimate(input_estimates_project),
                                      model_function = agrivp_vs_agroforestry_function_two,
                                      numberOfModelRuns = 100,
                                      functionSyntax = "plainNames")


# Monte plots ----

plot_distributions(mcSimulation_object = example_mc_simulation, 
                   vars = c("Gain_photovoltaic", "Gain_agroforestry", "Gain_monoculture", "Cashflow_decison_do"),
                   method = 'smooth_simple_overlay', 
                   base_size = 7)


#check main function 
result <- agrivp_vs_agroforestry_function_two()
