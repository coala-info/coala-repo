# Code example from 'pedigree_object' vignette. See references/ for full tutorial.

## ----column_renaming------------------------------------------------------------------------------
rel_df <- data.frame(
    indId1 = c("110", "204"),
    indId2 = c("112", "205"),
    code = c(1, 2),
    family = c("1", "2")
)
cols_ren_rel <- list(
    id1 = "indId1",
    id2 = "indId2",
    famid = "family"
)

## Rename columns rel
old_cols <- as.vector(unlist(cols_ren_rel))
new_cols <- names(cols_ren_rel)
cols_to_ren <- match(old_cols, names(rel_df))
names(rel_df)[cols_to_ren[!is.na(cols_to_ren)]] <-
    new_cols[!is.na(cols_to_ren)]
print(rel_df)

## ----normalisation--------------------------------------------------------------------------------
library(Pedixplorer)
data("sampleped")
cols <- c("sex", "id", "avail")
summary(sampleped[cols])
pedi <- Pedigree(sampleped)
summary(as.data.frame(ped(pedi))[cols])

## ----rel_df_errors--------------------------------------------------------------------------------
rel_wrong <- rel_df
rel_wrong$code[2] <- "A"
df <- Pedigree(sampleped, rel_wrong)
print(df)

## ----mcols----------------------------------------------------------------------------------------
pedi <- Pedigree(sampleped)
mcols(pedi)
## Add new columns as a threshold if identifiers of individuals superior
## to a given threshold for example
mcols(pedi)$idth <- ifelse(as.numeric(
    stringr::str_split_i(id(ped(pedi)), "_", 2)
) < 200, "A", "B")
mcols(pedi)$idth

## ----pedigree_methods, fig.alt = "Pedigree plot", fig.align = 'center'----------------------------
## We can change the family name based on an other column
pedi <- upd_famid(pedi, mcols(pedi)$idth)

## We can substract a given family
ped_a <- pedi[famid(ped(pedi)) == "A"]

## Plot it
plot(ped_a, cex = 0.5)

## Do a summary
summary(ped_a)

## Coerce it to a list
as.list(ped_a)[[1]][1:3]

## Shrink it to keep only the necessary information
lst1_s <- shrink(ped_a, max_bits = 10)
plot(lst1_s$pedObj, cex = 0.5)

## Compute the kinship individuals matrix
adopted(ped(ped_a)) <- FALSE # Set adopted to FALSE
kinship(ped_a)[1:10, 1:10]

## Get the useful individuals
ped_a <- is_informative(ped_a, informative = "AvAf", col_aff = "affection")
ped_a <- useful_inds(ped_a)
as.data.frame(ped(ped_a))["useful"][1:10, ]

## -------------------------------------------------------------------------------------------------
sessionInfo()

