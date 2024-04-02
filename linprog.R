

data <- read.csv("final_dataset.csv")

# Define objective function to maximize NAVGFPS
objective_function <- function(aa, ag, ap) {
  # Calculate NAVGFPS based on the settings of AA, AG, and AP
  navgfps <- calculate_NAVGFPS(aa, ag, ap)
  return(-navgfps)  # Minimize NAVGFPS (negative of NAVGFPS to maximize)
}

# Define function to calculate NAVGFPS
calculate_NAVGFPS <- function(aa, ag, ap) {
  # Calculate NAVGFPS based on the settings of AA, AG, and AP
  # Replace this with your actual calculation based on your data
  navgfps <- aa * ag * ap  # Example calculation, replace with actual formula
  return(navgfps)
}

# Set constraints for AA, AG, and AP settings
constraints <- cbind(c(min_setting_aa, min_setting_ag, min_setting_ap),
                     c(max_setting_aa, max_setting_ag, max_setting_ap))

# Run optimization algorithm (e.g., brute-force grid search)
optim_result <- optim(c(0, 0, 0), objective_function, method = "L-BFGS-B", lower = c(1, 1, 1), upper = c(3, 3, 3))

# Extract optimal settings of AA, AG, and AP
optimal_aa <- optim_result$par[1]
optimal_ag <- optim_result$par[2]
optimal_ap <- optim_result$par[3]

# Calculate optimal NAVGFPS
optimal_navgfps <- calculate_NAVGFPS(optimal_aa, optimal_ag, optimal_ap)

# Print optimal settings and NAVGFPS
cat("Optimal AA:", optimal_aa, "\n")
cat("Optimal AG:", optimal_ag, "\n")
cat("Optimal AP:", optimal_ap, "\n")
cat("Optimal NAVGFPS:", optimal_navgfps, "\n")
