# Code example from 'immunotation_vignette' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(immunotation)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("immunotation")

## -----------------------------------------------------------------------------
get_valid_organisms()

## -----------------------------------------------------------------------------
df <- retrieve_chain_lookup_table(organism = "human")

DT::datatable(head(df, n=30))

## -----------------------------------------------------------------------------
DT::datatable(head(human_protein_complex_table, n=30))

## -----------------------------------------------------------------------------
allele_list1 <- c("A*01:01:01", "A*02:01:01",
                  "B*39:01:01", "B*07:02:01", 
                  "C*08:01:01", "C*01:02:01")
allele_list2 <- c("DPA1*01:03:01", "DPA1*01:04:01",
                  "DPB1*14:01:01", "DPB1*02:01:02",
                  "DQA1*02:01:01", "DQA1*05:03",
                  "DQB1*02:02:01", "DQB1*06:09:01",
                  "DRA*01:01", "DRB1*10:01:01", "DRB1*14:02:01")

## -----------------------------------------------------------------------------
get_serotypes(allele_list1, mhc_type = "MHC-I")

## -----------------------------------------------------------------------------
get_serotypes(allele_list2, mhc_type = "MHC-II")

## -----------------------------------------------------------------------------
get_mhcpan_input(allele_list1, mhc_class = "MHC-I")

## -----------------------------------------------------------------------------
get_mhcpan_input(allele_list2, mhc_class = "MHC-II")

## -----------------------------------------------------------------------------
get_G_group(allele_list2)

## -----------------------------------------------------------------------------
get_P_group(allele_list1)

## -----------------------------------------------------------------------------
allele_list3 <- c("A*01:01:01", "A*02:01:01", "A*03:01")
encode_MAC(allele_list3)

## -----------------------------------------------------------------------------
MAC1 <- "A*01:AYMG"
decode_MAC(MAC1)

## -----------------------------------------------------------------------------
sel1 <- query_allele_frequencies(hla_selection = "A*02:01", 
                                hla_sample_size_pattern = "bigger_than", 
                                hla_sample_size = 10000, 
                                standard="g")

DT::datatable(sel1)

## -----------------------------------------------------------------------------
sel1b <- query_allele_frequencies(hla_selection = "A*01:01", 
                                hla_ethnic = "Asian")

DT::datatable(sel1b)

## -----------------------------------------------------------------------------
hla_selection <- build_allele_group("A*01:02")

sel1 <- query_allele_frequencies(hla_selection = hla_selection, 
                                hla_sample_size_pattern = "bigger_than", 
                                hla_sample_size = 200, 
                                standard="g")

## -----------------------------------------------------------------------------
haplotype_alleles <- c("A*02:01", "B*", "C*")
df <- query_haplotype_frequencies(hla_selection = haplotype_alleles,
                            hla_region = "Europe")

DT::datatable(df)

## -----------------------------------------------------------------------------
sel2 <- query_allele_frequencies(hla_locus = "B", hla_population = 1986)

DT::datatable(sel2)

## -----------------------------------------------------------------------------
sel2a <- query_allele_frequencies(hla_locus = "B", hla_population = 3089)

DT::datatable(sel2a)

## -----------------------------------------------------------------------------
plot_allele_frequency(sel1)

## -----------------------------------------------------------------------------
sel3 <- query_population_detail(1986)

DT::datatable(sel3, options = list(scrollX = TRUE))

## -----------------------------------------------------------------------------
sel4 <- query_population_detail(as.numeric(sel1$population_id))

# only select the first 5 columns to display in table
DT::datatable(sel4[1:5], options = list(scrollX = TRUE))

## -----------------------------------------------------------------------------
sessionInfo()

