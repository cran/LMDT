## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 5,
  warning = FALSE,
  message = FALSE
)

## ----vignette1, eval = FALSE--------------------------------------------------
# library(LMDT)
# 
# # Simulate n = 600 S&P 500 option contracts along a parabolic smile manifold
# set.seed(42)
# n_opt <- 600
# moneyness <- runif(n_opt, 0.75, 1.25)
# maturity  <- runif(n_opt, 0.08, 2.50)
# X_options <- cbind(moneyness, maturity)
# 
# # True pricing error variance follows parabolic smile along moneyness
# vol_scale <- 0.05 + 0.45 * (moneyness - 1.0)^2
# pricing_residuals <- rnorm(n_opt, mean = 0, sd = vol_scale)
# 
# # Execute LMDT vs classical tests
# lmdt_options <- lmdt_test(x = X_options, residuals = pricing_residuals, k = 12)
# print(lmdt_options)

## ----vignette2, eval = FALSE--------------------------------------------------
# # Simulate n = 800 metropolitan housing transactions
# set.seed(101)
# n_house <- 800
# lat <- runif(n_house, 40.60, 40.85)
# lon <- runif(n_house, -74.05, -73.85)
# 
# # Non-spherical error clustering along riverfront bend
# river_dist <- abs(lat - 40.72 + 0.5 * (lon + 73.95)^2)
# cluster_sd <- 0.15 + 0.60 * exp(-river_dist / 0.02)
# fit_house_resids <- rnorm(n_house, mean = 0, sd = cluster_sd)
# 
# # Run LMDT with spatial nearest neighbors
# lmdt_house <- lmdt_test(x = cbind(lat, lon), residuals = fit_house_resids, k = 14)
# print(lmdt_house)

## ----vignette3, eval = FALSE--------------------------------------------------
# # Simulate n = 350 monthly observations of p = 120 macroeconomic indicators
# set.seed(303)
# n_macro <- 350
# p_macro <- 120
# 
# # Latent d = 3 factor manifold + isotropic Gaussian observation noise
# Z_factors <- matrix(rnorm(n_macro * 3), n_macro, 3)
# Loadings  <- matrix(rnorm(3 * p_macro), 3, p_macro)
# X_macro   <- Z_factors %*% Loadings + matrix(rnorm(n_macro * p_macro, sd = 0.5), n_macro, p_macro)
# 
# # Volatility regime shift along first principal macro factor
# macro_resids <- rnorm(n_macro, mean = 0, sd = 0.2 + 0.8 * (Z_factors[, 1] > 0.5))
# 
# # Denoised High-Dimensional LMDT
# lmdt_macro <- lmdt_test(x = X_macro, residuals = macro_resids, denoise = "pca")
# print(lmdt_macro)

## ----vignette4, eval = FALSE--------------------------------------------------
# # Simulate n = 1,200 consecutive 250ms LOB snapshots
# set.seed(404)
# n_lob <- 1200
# p_lob <- 20
# 
# # Latent 3D order flow attractor manifold
# t_seq <- seq(0, 4 * pi, length.out = n_lob)
# Z_lob <- cbind(sin(t_seq), cos(t_seq), t_seq / (4 * pi))
# Q_orth <- qr.Q(qr(matrix(rnorm(p_lob * p_lob), p_lob, p_lob)))
# X_lob <- Z_lob %*% t(Q_orth[, 1:3]) + matrix(rnorm(n_lob * p_lob, sd = 0.05), n_lob, p_lob)
# 
# # Liquidity evaporation regime spike
# lob_sd <- ifelse(t_seq > 3 * pi, 1.8, 0.4)
# lob_resids <- rnorm(n_lob, mean = 0, sd = lob_sd)
# 
# lmdt_lob <- lmdt_test(x = X_lob, residuals = lob_resids, k = 15)
# print(lmdt_lob)

## ----plot_demo, eval = FALSE--------------------------------------------------
# # Plot diagnostic panels
# plot(lmdt_options)

