# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', warnings=FALSE, messages=FALSE----
# <style>
# body {
# text-align: justify}
# </style>
BiocStyle::markdown()

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE #,
    # comment = "#>"
)
options(width=120)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
library("DNABarcodeCompatibility")

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# This function is created for the purpose of the documentation 
export_dataset_to_file = 
    function(dataset = DNABarcodeCompatibility::IlluminaIndexesRaw) {
        if ("data.frame" %in% is(dataset)) {
            write.table(dataset,
                        textfile <- tempfile(),
                        row.names = FALSE, col.names = FALSE, quote=FALSE)
            return(textfile)
        } else print(paste("The input dataset isn't a data.frame:",
                            "NOT exported into file"))
    }

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                    sample_number=12,
                    mplex_level=3,
                    platform=4)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                    sample_number=12,
                    mplex_level=3,
                    platform=2)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                    sample_number=12,
                    mplex_level=3,
                    platform=1)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
txtfile <- export_dataset_to_file (
    dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
)
experiment_design(file1=txtfile,
                sample_number=12,
                mplex_level=3,
                platform=4,
                metric = "hamming",
                d = 3)


## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Select the first half of barcodes from the dataset
txtfile1 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[1:24,]
)

# Select the second half of barcodes from the dataset
txtfile2 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[25:48,]
)

# Get compatibles combinations of least redundant barcodes
experiment_design(file1=txtfile1,
                sample_number=12,
                mplex_level=3,
                platform=4,
                file2=txtfile2)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Select the first half of barcodes from the dataset
txtfile1 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[1:24,]
)

# Select the second half of barcodes from the dataset
txtfile2 <- export_dataset_to_file (
    DNABarcodeCompatibility::IlluminaIndexesRaw[25:48,]
)

# Get compatibles combinations of least redundant barcodes
experiment_design(file1=txtfile1, sample_number=12, mplex_level=3, platform=4,
                    file2=txtfile2, metric="hamming", d=3)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
file_loading_and_checking(
    file = export_dataset_to_file(
        dataset = DNABarcodeCompatibility::IlluminaIndexesRaw
    )
)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Total number of combinations
choose(48,2)

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for an exhaustive search
system.time(m <- get_all_combinations(index_df = barcodes,
                                    mplex_level = 2,
                                    platform = 4))

# Each line represents a compatible combination of barcodes
head(m)


## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Total number of combinations
choose(48,3)

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for an exhaustive search
system.time(m <- get_all_combinations(index_df = barcodes,
                                    mplex_level = 3,
                                    platform = 4))

# Each line represents a compatible combination of barcodes
head(m)


## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Total number of combinations
choose(48,3)

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for a random search
system.time(m <- get_random_combinations(index_df = barcodes,
                                        mplex_level = 2,
                                        platform = 4))

# Each line represents a compatible combination of barcodes
head(m)


## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Total number of combinations
choose(48,4)

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for a random search
system.time(m <- get_random_combinations(index_df = barcodes,
                                        mplex_level = 4,
                                        platform = 4))

# Each line represents a compatible combination of barcodes
head(m)


## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Total number of combinations
choose(48,6)

# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Time for a random search
system.time(m <- get_random_combinations(index_df = barcodes,
                                        mplex_level = 6,
                                        platform = 4))

# Each line represents a compatible combination of barcodes
head(m)


## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Load barcodes
barcodes <- DNABarcodeCompatibility::IlluminaIndexes

# Perform a random search of compatible combinations
m <- get_random_combinations(index_df = barcodes,
                            mplex_level = 3,
                            platform = 4)

# Keep barcodes that are robust against one substitution error
filtered_m <- distance_filter(index_df = barcodes,
                            combinations_m = m,
                            metric = "hamming",
                            d = 3)

# Each line represents a compatible combination of barcodes
head(filtered_m)

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Keep set of compatible barcodes that are robust against one substitution
# error
filtered_m <- distance_filter(
    index_df = DNABarcodeCompatibility::IlluminaIndexes,
    combinations_m = get_random_combinations(index_df = barcodes,
                                            mplex_level = 3,
                                            platform = 4),
    metric = "hamming", d = 3)

# Use a Shannon-entropy maximization approach to reduce barcode redundancy
df <- optimize_combinations(combination_m = filtered_m,
                            nb_lane = 12,
                            index_number = 48)

# Each line represents a compatible combination of barcodes and each row a lane
# of the flow cell
df

## ----echo=TRUE--------------------------------------------------------------------------------------------------------
# Keep set of compatible barcodes that are robust against multiple substitution
# and insertion/deletion errors
filtered_m <- distance_filter(
    index_df = DNABarcodeCompatibility::IlluminaIndexes,
    combinations_m = get_random_combinations(index_df = barcodes,
                                            mplex_level = 3,
                                            platform = 4),
    metric = "seqlev", d = 4)

# Use a Shannon-entropy maximization approach to reduce barcode redundancy
df <- optimize_combinations(combination_m = filtered_m,
                            nb_lane = 12,
                            index_number = 48)

# Each line represents a compatible combination of barcodes and each row a
# lane of the flow cell
df

