---
name: bioconductor-tronco
description: "TRONCO infers cancer progression models from genomic data using Suppes-Bayes Causal Networks. Use when user asks to import MAF or GISTIC data, visualize genomic alterations with oncoprints, manipulate cancer datasets, or infer progression models using algorithms like CAPRI and CAPRESE."
homepage: https://bioconductor.org/packages/release/bioc/html/TRONCO.html
---


# bioconductor-tronco

name: bioconductor-tronco
description: Inference of cancer progression models from heterogeneous genomic data (mutations, CNAs) using Suppes-Bayes Causal Networks. Use for importing MAF/GISTIC/Boolean data, data manipulation, oncoprint visualization, and running inference algorithms like CAPRI, CAPRESE, and MST-based methods (Edmonds, Gabow, Chow-Liu, Prim).

# bioconductor-tronco

## Overview
The **TRONCO** (TRanslational ONCOlogy) package implements algorithms to infer cancer progression models from cross-sectional (ensemble-level) or multi-region/single-cell (individual-level) genomic data. It represents progression as a Suppes-Bayes Causal Network (SBCN) where nodes are genomic alterations and edges represent selective advantage relations.

## Core Workflow

### 1. Data Import
TRONCO uses a specific object structure. Import data from common formats:

```r
library(TRONCO)

# From MAF (Mutation Annotation Format)
# merge.mutation.types = TRUE combines different mutations in the same gene into one 'Mutation' event
dataset_maf = import.MAF(maf_dataframe, merge.mutation.types = TRUE)

# From GISTIC (Copy Number Alterations)
# 1: low-level gain, 2: high-level gain, -1: het loss, -2: hom loss
dataset_gistic = import.GISTIC(gistic_matrix)

# From custom Boolean Matrix (Samples x Events)
dataset_custom = import.genotypes(boolean_matrix, event.type = 'variant')

# Annotate dataset description
dataset = annotate.description(dataset_maf, 'My Cancer Study')
```

### 2. Data Visualization & Inspection
Use "as" functions to view internal data and `oncoprint` for heatmaps.

```r
# Summary view
view(dataset)

# Access components
genotypes = as.genotypes(dataset)
events = as.events(dataset)
genes = as.genes(dataset)

# Oncoprint visualization
# Automatically sorts to highlight mutual exclusivity
oncoprint(dataset, title = 'Study Oncoprint')

# Grouped by clinical stage (if annotated)
dataset = annotate.stages(dataset, stages_matrix)
oncoprint(dataset, group.samples = as.stages(dataset))
```

### 3. Data Manipulation
Filter and consolidate data before inference.

```r
# Filter by frequency (e.g., genes mutated in > 5% of samples)
dataset_filtered = events.selection(dataset, filter.freq = 0.05)

# Force inclusion/exclusion
dataset_filtered = events.selection(dataset, 
                                    filter.in.names = c('TP53', 'KRAS'),
                                    filter.out.names = 'TTN')

# Join events (e.g., treat different mutation types as one)
dataset_joined = join.types(dataset, 'Missense_Mutation', 'Nonsense_Mutation')

# Check for zeroes, ones, or indistinguishable events (required before inference)
consolidate.data(dataset_filtered)
```

### 4. Model Inference
Choose an algorithm based on data type (Ensemble vs. Individual).

#### CAPRI (Ensemble-level)
Supports complex hypotheses (logical formulas).
```r
# Add a XOR hypothesis: either KRAS or NRAS mutation
dataset_hypo = hypothesis.add(dataset_filtered, 'RAS_xor', XOR('KRAS', 'NRAS'))

# Run CAPRI
model_capri = tronco.capri(dataset_hypo, nboot = 100, boot.seed = 123)
```

#### Individual-level Algorithms (Single-cell/Multi-region)
```r
# CAPRESE: Quick, returns a forest of trees
model_caprese = tronco.caprese(dataset_filtered)

# MST-based methods (Edmonds, Gabow, Chow-Liu, Prim)
model_edmonds = tronco.edmonds(dataset_filtered, nboot = 100)
```

## Tips for Success
- **Compliance**: Use `is.compliant(dataset)` to ensure the TRONCO object is valid after manual edits.
- **Hypotheses**: CAPRI is unique in its ability to test if a group of genes (e.g., in a pathway) collectively acts as a "cause" for a downstream event using `hypothesis.add.group`.
- **Homologous Events**: Use `hypothesis.add.homologous(dataset)` to automatically create OR/XOR patterns for different types of alterations affecting the same gene.

## Reference documentation
- [An introduction to the TRONCO R package](./references/f1_introduction.md)
- [Loading data](./references/f2_loading_data.md)
- [Data visualization](./references/f3_data_visualization.md)
- [Data manipulation](./references/f4_data_manipulation.md)
- [Model inference](./references/f5_model_inference.md)
- [Post reconstruction](./references/f6_post_reconstruction.md)
- [Import and export to other tools](./references/f7_import_export.md)