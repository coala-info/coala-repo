# Code example from 'RAREsim_Vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RAREsim")

## -----------------------------------------------------------------------------
library(RAREsim)
library(ggplot2)

## -----------------------------------------------------------------------------
# load the target data
data("nvariant_afr")
print(nvariant_afr, row.names  =  FALSE)

## -----------------------------------------------------------------------------
nvar <- fit_nvariant(nvariant_afr)
nvar

## -----------------------------------------------------------------------------
plot(nvariant_afr$n, nvariant_afr$per_kb,
     xlab = 'Sample Size', ylab = 'Variants per Kb')
lines(nvariant_afr$n, (nvar$phi*(nvariant_afr$n^nvar$omega)))


## -----------------------------------------------------------------------------
nvariant(phi = nvar$phi, omega = nvar$omega, N = 8128)

## -----------------------------------------------------------------------------
nvariant(N=8128, pop = 'AFR') 

## -----------------------------------------------------------------------------
nvariant(phi = 0.1638108, omega = 0.6248848, N = 8128)

## -----------------------------------------------------------------------------
19.029*nvariant(nvar$phi, omega = nvar$omega, N = 8128)

## -----------------------------------------------------------------------------
# load the data
data("afs_afr")
print(afs_afr)

## -----------------------------------------------------------------------------
af <- fit_afs(Observed_bin_props = afs_afr)
print(af)

## -----------------------------------------------------------------------------
# Label the target and  fitted data
afs_afr$Data <- 'Target Data'
af$Fitted_results$Data <- 'Fitted Function'

# Combine into one data frame
af_all<-rbind(afs_afr, af$Fitted_results)
af_all$Data <- as.factor(af_all$Data)

#plot
ggplot(data = af_all)+
  geom_point( mapping = aes(x= Lower, y= Prop, col = Data))+
  labs(x = 'Lower Limit of MAC Bin',
             y = 'Propoortion of Variants')


## -----------------------------------------------------------------------------
mac <- afs_afr[,c(1:2)]

## -----------------------------------------------------------------------------
afs(mac_bins = mac, pop = 'AFR')

## -----------------------------------------------------------------------------
afs(alpha = 1.594622, beta =  -0.2846474, b  = 0.297495, mac_bins = mac)

## -----------------------------------------------------------------------------
bin_estimates <- expected_variants(Total_num_var = 865.0634, mac_bin_prop = af$Fitted_results)
print(bin_estimates)

## -----------------------------------------------------------------------------
bin_estimates <- expected_variants(Total_num_var =
                                     19.029*nvariant(phi = 0.1638108,
                                                     omega = 0.6248848, N = 8128),
                                   mac_bin_prop = afs(mac_bins = mac, pop = 'AFR'))
print(bin_estimates)

## -----------------------------------------------------------------------------
sessionInfo()

