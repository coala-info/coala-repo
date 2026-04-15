---
name: bioconductor-compcoder
description: This tool benchmarks and compares differential expression methods for RNA-seq data through simulation and performance evaluation. Use when user asks to simulate synthetic RNA-seq counts, run multiple differential expression tools through a unified interface, or generate comparative performance reports using metrics like ROC and FDR.
homepage: https://bioconductor.org/packages/release/bioc/html/compcodeR.html
---

# bioconductor-compcoder

name: bioconductor-compcoder
description: Benchmarking and comparison of differential expression (DE) methods for RNA-seq data. Use when simulating synthetic RNA-seq counts (including phylogenetic/inter-species data), running multiple DE methods (edgeR, DESeq2, limma, etc.) through a unified interface, and generating comparative performance reports using metrics like ROC, AUC, FDR, and TPR.

# bioconductor-compcoder

## Overview
The `compcodeR` package provides a unified framework for simulating RNA-seq data and benchmarking differential expression (DE) methods. It allows users to generate synthetic counts with known ground truth, apply various DE tools (interfaced via Rmd templates), and produce comprehensive HTML reports comparing method performance across multiple metrics.

## Core Data Classes
- **compData**: The standard S4 class for datasets and results. Contains slots for `count.matrix`, `sample.annotations`, `info.parameters`, and `variable.annotations` (e.g., ground truth DE status).
- **phyloCompData**: An extension of `compData` for inter-species data. Includes additional slots for a phylogenetic `tree` (ape format) and a `length.matrix` for orthologous genes.

## Typical Workflow

### 1. Simulating Data
Use `generateSyntheticData` to create datasets with known DE genes.
```R
# Standard simulation
data_obj <- generateSyntheticData(dataset = "my_sim", n.vars = 12500, 
                                  samples.per.cond = 5, n.diffexp = 1250,
                                  output.file = "sim_data.rds")

# Phylogenetic simulation (requires a tree)
phylo_obj <- generateSyntheticData(dataset = "phylo_sim", tree = my_tree,
                                   id.species = species_ids, id.condition = cond_ids,
                                   output.file = "phylo_data.rds")
```
Check simulation quality with `summarizeSyntheticDataSet(data.set = "sim_data.rds")`.

### 2. Running Differential Expression Methods
Use `runDiffExp` to apply DE methods. The package uses "Rmd functions" to generate the analysis code.
```R
# List available methods
listcreateRmd()

# Run edgeR exact test
runDiffExp(data.file = "sim_data.rds", result.extent = "edgeR", 
           Rmdfunction = "edgeR.exact.createRmd", output.directory = ".")

# Run voom+limma
runDiffExp(data.file = "sim_data.rds", result.extent = "voom", 
           Rmdfunction = "voom.limma.createRmd", output.directory = ".")
```

### 3. Comparing Results
Generate a comparative report from multiple result RDS files.
```R
# Command-line comparison
file_table <- data.frame(input.files = c("sim_data_edgeR.rds", "sim_data_voom.rds"))
runComparison(file.table = file_table, parameters = list(fdr.threshold = 0.05), 
              output.directory = ".")

# Or use the GUI
runComparisonGUI(input.directories = ".", output.directory = ".")
```

## Using Custom Data
To use your own counts in the `compcodeR` framework, wrap them in a `compData` object:
```R
cpd <- compData(count.matrix = my_counts, 
                sample.annotations = data.frame(condition = my_factors),
                info.parameters = list(dataset = "my_data", uID = "unique_id_123"))
check_compData(cpd)
saveRDS(cpd, "my_data.rds")
```

## Key Evaluation Metrics
The comparison report includes:
- **ROC/AUC**: True Positive Rate vs. False Positive Rate.
- **FDR/TPR**: Observed False Discovery Rate and True Positive Rate at specified thresholds.
- **Type I Error**: Fraction of false positives among truly non-DE genes.
- **False Discovery Curves**: Cumulative false discoveries in ranked lists.
- **Sorensen Index**: Overlap between methods.
- **MA Plots**: Log-fold change vs. average expression.

## Reference documentation
- [Comparing methods for differential expression analysis of RNAseq data with the compcodeR package](./references/compcodeR.md)
- [Including inter-species measurements in differential expression analysis of RNAseq data with the compcodeR package](./references/phylocompcodeR.md)