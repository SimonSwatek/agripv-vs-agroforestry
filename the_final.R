#working directory ----

setwd(getwd())

#used packages ----
library(ggplot2)
library(readr)
library(decisionSupport)
library(vctrs)
library(tidyverse)
library(dplyr)

# loading area dataframe ----

input_estimates_project <- read_delim("real_input_estimates_project.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)

climate_cka <- read.csv("weather_cka.csv")


# Build function ----

agrivp_vs_agroforestry_function_two <- function(x, varnames) {
  
  # Agroforestry = af ----
  # Photovoltaic = pv ----
  
  # ex-ante risks: impact the implementation of interventions ----
  
  
  
  intervention_No_Pop_backup_af <- chance_event(chance = 0.01, 1, 0, n = 1)
  
  intervention_No_Pop_backup_pv <- chance_event(chance = 0.1, 1, 0, n = 1)
  
  Risk_low_quality_panels       <- chance_event(chance = 0.15, 1, 0, n = 1)
  
  
  # baseline mono culture benefits ----
  
  Yield_crop = vv(var_mean = crop_Yield, var_CV, n_years) *
    vv(var_mean = crop_price, var_CV, n_years)
  
  
  
  af_area <- vv(var_mean = area_af, var_CV, n_years)   #changing all area vars into these two 
  pv_area <- vv(var_mean = area_pv, var_CV, n_years)   #baseline vv() based on pure af and pv area
  
  field_preparation_monoculture <-  field_preparation_mono
  
  No_Intervention <- Yield_crop * crop_area - field_preparation_monoculture
  # Precalc Yield wheat in intercropping systems
  
  
  af_wheat <- 
    (crop_area -
       af_area) *
    Yield_crop -
    field_preparation_monoculture
  
  
  pv_wheat <- 
    (crop_area -
       pv_area) *
    Yield_crop -
    field_preparation_monoculture
  
  
  
  # Intervention cases ---- 
  
  # Intervention agroforestry
  
  for (decision_af in c(FALSE, TRUE)) {
    
    if (decision_af) {
      intervention_af_gain <- TRUE
      intervention_af_cost <- TRUE
      intervention_af_risks <- TRUE 
    } 
    
    else {
      
      intervention_af_gain <- FALSE
      intervention_af_cost <- FALSE
      intervention_af_risks <- FALSE  
    }
    
    # Costs agroforestry
    
    if (intervention_af_cost) {
      fixed_af_costs <-                               #fix cost variable gedebuggt
        field_preparation_af   +
        planting_density_af  *
        price_cutting_af       +
        planting_density_af  *
        planting_cost_af       +
        harvesting_cost_af
    } 
    
    else {
      
      fixed_af_costs <- 0                             # <--- damit es gleich is mit dem 
    }
    
    # Gain agroforestry
    
    
    if (intervention_af_gain) {
      
      
      
      gain_af =
        af_area                                       *
        vv(var_mean = yield_wood_af, var_CV, n_years) *
        vv(var_mean = price_wood_af, var_CV, n_years)   +   #hier überall area_af mit af_area ausgetauscht
        af_area                                       *
        subsidies_af                                    +
        ecosystem_service_af                          *
        af_area
      
      
      if (intervention_No_Pop_backup_af) {
        
        af_area*0.1
      }
    }
    else {
      
      gain_af <- 0                                        #hier gain_af und oben precalc_af[...] ausgetauscht 
    }
    
    # Benefits af_intercropping
    
    
    af_benefits <- as.numeric(gain_af) + af_wheat             #hier die Kosten gedoppeltgemoppelt gewesen
  }
  
  # Intervention Photovoltaic 
  
  for (decision_pv in c(FALSE, TRUE)) {
    
    if (decision_pv) {
      intervention_pv_gain <- TRUE
      intervention_pv_costs <- TRUE
      intervention_pv_risks <- TRUE 
    } 
    
    else {
      
      intervention_pv_gain <- FALSE
      intervention_pv_costs <- FALSE
      intervention_pv_risks <- FALSE  
    }
    
    # Costs pv
    
    if (intervention_pv_costs) {
      fixed_pv_costs <- 
        annual_cost_pv  +
        investment_cost_pv
      
    } 
    
    if (intervention_No_Pop_backup_pv){
      
      pv_area*0.1
    }
    
    else {
      
      fixed_pv_costs <- 0  
    }
    
    # Gain pv
    
    
    if (intervention_pv_gain) {
      
      Anual_average_solar_radiaton <- climate_cka$`mean_Globalstrahlung..Wh.m².`*365 #adjust to colname to kWh
      panel_area <- vv(var_mean = area_pv, var_CV, n_years)/10000 # ha transformation in m^2 
      power_density <- vv(var_mean = power_density, var_CV, n_years)
      solar_panel_efficiency <- vv(var_mean = solar_panel_efficiency, var_CV, n_years)
      
      gain_pv = (Anual_average_solar_radiaton*panel_area*power_density*solar_panel_efficiency*energy_market_price)*10000 # qm in ha und
      #Performance_ratio_panels als leerer Wert hat gebuggt => ausgetauscht mit 'solar_panel_efficiency'
      
      
      
      
      if (Risk_low_quality_panels){
        
        solar_panel_efficiency*0.1
      }
    }
    
    else {
      
      gain_pv <- 0
    }
    
    # Benefits pv_intercropping
    
    pv_benefits <- as.numeric(gain_pv) + pv_wheat
    
  }
  
  
  # Net present value (NPV) calculation 
  
  if (decision_af) {
    
    net_benefits_af <- af_benefits - fixed_af_costs
    result_af_intervention <- net_benefits_af
    result_af_n_intervention <- No_Intervention
  }  
  
  if (decision_pv) {
    
    net_benefits_pv <- pv_benefits - fixed_pv_costs
    result_pv_intervention <- net_benefits_pv
    result_pv_n_intervention <- No_Intervention
    
  }
  
  
  NPV_af <- discount(result_af_intervention, discount_rate, calculate_NPV = TRUE)
  NPV_pv <- discount(result_pv_intervention, discount_rate, calculate_NPV = TRUE)
  NPV_no <- discount(No_Intervention, discount_rate, calculate_NPV = TRUE)
  
  
  return(list(
    Gain_photovoltaic = NPV_pv, 
    Gain_agroforestry = NPV_af,
    Gain_Crop_monoculture = NPV_no,
    Cashflow_decison_do_pv = result_pv_intervention, #- result_pv_n_intervention,
    Cashflow_decison_do_af = result_af_intervention, #- result_af_n_intervention,
    Cashflow_single_mono   = No_Intervention #- (result_af_intervention + result_pv_intervention)
    
  ))
  
  
} # End function 


# Monte simulation ----


example_mc_simulation <- mcSimulation(estimate = as.estimate(input_estimates_project),
                                      model_function = agrivp_vs_agroforestry_function_two,
                                      numberOfModelRuns =30002,
                                      functionSyntax = "plainNames")




# Monte plots ----


# All interventions
plot_distributions(mcSimulation_object = example_mc_simulation, 
                   vars = c("Gain_photovoltaic", "Gain_agroforestry","Gain_Crop_monoculture"),
                   method = 'smooth_simple_overlay', 
                   old_names = c("Gain_photovoltaic", "Gain_agroforestry","Gain_Crop_monoculture"),
                   new_names = c("Photovoltaic", "Agroforestry","Crop rotation"),
                   colors = c("green", "orange", "blue2"),
                   base_size = 25)+
  theme(legend.position = c(0.3,0.8))




# Baseline + agroforestry
plot_distributions(mcSimulation_object = example_mc_simulation, 
                   vars = c( "Gain_agroforestry","Gain_Crop_monoculture"),
                   method = 'smooth_simple_overlay', 
                   old_names = c("Gain_agroforestry","Gain_Crop_monoculture"),
                   new_names = c("Agroforestry","Crop rotation"),
                   colors = c("green", "orange"),
                   base_size = 25)+
  theme(legend.position = c(0.6,0.8))




# Baseline + photovoltaic 
plot_distributions(mcSimulation_object = example_mc_simulation, 
                   vars = c( "Gain_photovoltaic","Gain_Crop_monoculture"),
                   method = 'smooth_simple_overlay', 
                   old_names = c("Gain_photovoltaic","Gain_Crop_monoculture"),
                   new_names = c("Photovoltaic","Crop rotation"),
                   colors = c("orange", "blue2"),
                   base_size = 25)+
  theme(legend.position = c(0.6,0.8))





# Comparison both interventions
decisionSupport::plot_distributions(mcSimulation_object = example_mc_simulation, 
                                    vars = c("Gain_photovoltaic", "Gain_agroforestry"),
                                    method = 'boxplot_density',
                                    old_names = c("Gain_photovoltaic","Gain_agroforestry"),
                                    new_names = c("Photovoltaic","Agroforestry"),
                                    colors = c ("blue2", "green"),
                                    base_size = 25)



# Boxplot density Agroforestry

decisionSupport::plot_distributions(mcSimulation_object = example_mc_simulation, 
                                    vars = "Gain_agroforestry",
                                    method = 'boxplot_density',
                                    old_names = "Gain_agroforestry",
                                    new_names = "Agroforestry",
                                    colors = "green",
                                    base_size = 25)



decisionSupport::plot_distributions(mcSimulation_object = example_mc_simulation, 
                                    vars = "Gain_photovoltaic",
                                    method = 'boxplot_density',
                                    old_names = "Gain_photovoltaic",
                                    new_names = "Photovoltaic",
                                    colors = "blue2",
                                    base_size = 25)



#PLS Analyse 


pls_result <- plsr.mcSimulation(object = example_mc_simulation,
                                resultName = names(example_mc_simulation$y)[4], ncomp = 1)



plot_pls(pls_result, input_table = input_estimates_project, threshold = 0.1, cut_off_line = 1, base_size = 25)



#Value of Information (VoI) analysis ####


mcSimulation_table <- data.frame(example_mc_simulation$x, example_mc_simulation$y[1:3])
mcSimulation_table


#EVPI ####

evpi1 <- multi_EVPI(mc = mcSimulation_table, first_out_var = "Gain_agroforestry")
evpi2 <- multi_EVPI(mc = mcSimulation_table, first_out_var = "Gain_photovoltaic")
evpi3 <- multi_EVPI(mc = mcSimulation_table, first_out_var = "Gain_Crop_monoculture")



plot_evpi(evpi1, decision_vars = "Gain_agroforestry")
plot_evpi(evpi2, decision_vars = "Gain_photovoltaic")
plot_evpi(evpi3, decision_vars = "Gain_Crop_monoculture")



#Cashflow ####


cash <- plot_cashflow(mcSimulation_object = example_mc_simulation, 
                      cashflow_var_name =  c("Cashflow_decison_do_af", "Cashflow_decison_do_pv", "Cashflow_single_mono"),
                      facet_labels = c("Cashflow Agroforestry", "Cashflow Agrivoltaics", "Cashflow Crop Rotation"),
                      base_size= 25)
cash   + scale_y_continuous(breaks = c(30000,10000,3000,0,-10000,-20000,-30000,-35000))     



#End

