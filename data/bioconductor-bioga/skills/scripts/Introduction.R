# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----installation , eval=FALSE------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("BioGA")

## ----installation_from_github , eval=FALSE------------------------------------
# devtools::install_github("danymukesha/BioGA")

## -----------------------------------------------------------------------------
# Load necessary packages
library(BioGA)
library(SummarizedExperiment)

# Define parameters
num_genes <- 1000
num_samples <- 10

# Define parameters for genetic algorithm
population_size <- 100
generations <- 20
mutation_rate <- 0.1

# Generate example genomic data using SummarizedExperiment
counts <- matrix(rpois(num_genes * num_samples, lambda = 10),
    nrow = num_genes
)
rownames(counts) <- paste0("Gene", 1:num_genes)
colnames(counts) <- paste0("Sample", 1:num_samples)

# Create SummarizedExperiment object
se <-
  SummarizedExperiment::SummarizedExperiment(assays = list(counts = counts))

# Convert SummarizedExperiment to matrix for compatibility with BioGA package
genomic_data <- assay(se)

## -----------------------------------------------------------------------------
head(genomic_data)

## -----------------------------------------------------------------------------
# Initialize population (select the number of canditate you wish `population`)
population <- BioGA::initialize_population_cpp(genomic_data,
    population_size = 5
)

## -----------------------------------------------------------------------------
# Initialize fitness history
fitness_history <- list()

# Initialize time progress
start_time <- Sys.time()

# Run genetic algorithm optimization
generation <- 0
while (TRUE) {
    generation <- generation + 1

    # Evaluate fitness
    fitness <- BioGA::evaluate_fitness_cpp(genomic_data, population)
    fitness_history[[generation]] <- fitness

    # Check termination condition
    if (generation == generations) { # defined number of generations
        break
    }

    # Selection
    selected_parents <- BioGA::selection_cpp(population,
        fitness,
        num_parents = 2
    )

    # Crossover and Mutation
    offspring <- BioGA::crossover_cpp(selected_parents, offspring_size = 2)
    # (no mutation in this example)
    mutated_offspring <- BioGA::mutation_cpp(offspring, mutation_rate = 0)

    # Replacement
    population <- BioGA::replacement_cpp(population, mutated_offspring,
        num_to_replace = 1
    )

    # Calculate time progress
    elapsed_time <- difftime(Sys.time(), start_time, units = "secs")

    # Print time progress
    cat(
        "\rGeneration:", generation, "- Elapsed Time:",
        format(elapsed_time, units = "secs"), "     "
    )
}

## -----------------------------------------------------------------------------
# Plot fitness change over generations
BioGA::plot_fitness_history(fitness_history)

## ----sessioninfo--------------------------------------------------------------
sessioninfo::session_info()

