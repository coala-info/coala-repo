# Code example from 'MSstatsLOBD_workflow' vignette. See references/ for full tutorial.

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
library(MSstatsLOBD)
library(dplyr)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("MSstatsLOBD")

## -----------------------------------------------------------------------------
head(raw_data)

## ----tidy=FALSE, warning=FALSE------------------------------------------------
#Select variable that are need
df <- raw_data %>% select(Peptide.Sequence,Precursor.Charge, 
                          Product.Charge, Fragment.Ion,Concentration, 
                          Replicate, light.Area, heavy.Area, 
                          SampleGroup, File.Name)

#Convert factors to numeric and remove NA values:
df <- df %>% mutate(heavy.Area = as.numeric(heavy.Area)) %>% 
  filter(!is.na(heavy.Area))

#Sum area over all fragments
df2 <- df %>% group_by(Peptide.Sequence, Replicate, SampleGroup, 
                       Concentration, File.Name) %>%
  summarize(A_light = sum(light.Area), A_heavy = sum(heavy.Area))

#Convert to log scale
df2 <- df2 %>% mutate(log2light = log2(A_light), log2heavy = log2(A_heavy))

#Calculate median of heavy(reference) for a run
df3 <- df2 %>% group_by(Peptide.Sequence) %>% 
  summarize(medianlog2light = median(log2light), 
            medianlog2heavy= median(log2heavy))

#Modify light intensity so that the intensity of the heavy is constant (=median) across a run.
df4 <- left_join(df2,df3, by = "Peptide.Sequence") %>% 
  mutate(log2light_delta = medianlog2light - log2light) %>% 
  mutate(log2heavy_norm = log2heavy + log2light_delta, 
         log2light_norm = log2light + log2light_delta) %>% 
  mutate(A_heavy_norm = 2**log2heavy_norm, A_light_norm = 2**log2light_norm)

#Format the data for MSstats:
#Select the heavy area, concentration, peptide name and Replicate
df_out <- df4 %>% ungroup() %>% 
  select(A_heavy_norm, Concentration, Peptide.Sequence, Replicate)

#Change the names according to MSStats requirement:
df_out <- df_out %>% rename(INTENSITY = A_heavy_norm, 
                            CONCENTRATION = Concentration, 
                            NAME = Peptide.Sequence, REPLICATE = Replicate) 

# We choose NAME as the peptide sequence
head(df_out)

## ----warning=FALSE------------------------------------------------------------

#Select peptide of interest:  LPPGLLANFTLLR
spikeindata <- df_out %>% filter(NAME == "LPPGLLANFTLLR")

#This contains the measured intensity for the peptide of interest
head(spikeindata)

#Call MSStatsLOD function:
quant_out <- nonlinear_quantlim(spikeindata)

head(quant_out)

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
#plot results in the directory
plot_quantlim(spikeindata = spikeindata, quantlim_out = quant_out, address =  FALSE)

## ----warning=FALSE, comment=FALSE, warning=FALSE------------------------------
#Select peptide of interest:  FLNDTMAVYEAK
spikeindata2 <- df_out %>% filter(NAME == "FVGTPEVNQTTLYQR")

#This contains the measured intensity for the peptide of interest
head(spikeindata2)

## ----warning=FALSE------------------------------------------------------------
#Call MSStats function:
quant_out2 <- nonlinear_quantlim(spikeindata2)

head(quant_out2)

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
#plot results in the directory: "/Users/cyrilg/Desktop/Workflow/Results"
#Change directory appropriately for your computer
plot_quantlim(spikeindata = spikeindata2, quantlim_out  = quant_out2, 
              address = FALSE)

## ----warning=FALSE------------------------------------------------------------

#Call MSStatsLOD function:
quant_out <- linear_quantlim(spikeindata)

head(quant_out)

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
#plot results in the directory
plot_quantlim(spikeindata = spikeindata, quantlim_out = quant_out, address =  FALSE)

## ----warning=FALSE------------------------------------------------------------

#Call MSStatsLOD function:
quant_out <- linear_quantlim(spikeindata2)

head(quant_out)

## ----error=FALSE, warning=FALSE, message=FALSE--------------------------------
#plot results in the directory
plot_quantlim(spikeindata = spikeindata2, quantlim_out = quant_out, address =  FALSE)

