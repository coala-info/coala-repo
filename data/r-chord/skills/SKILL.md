---
name: r-chord
description: R package chord (documentation from project home).
homepage: https://cran.r-project.org/web/packages/chord/index.html
---

# r-chord

name: r-chord
description: Predict Homologous Recombination Deficiency (HRD) from somatic mutation contexts using the CHORD random forest model. Use this skill when you need to extract mutation signatures (SNVs, indels, SVs) and classify samples as HR-deficient (BRCA1-type or BRCA2-type) or HR-proficient.

# r-chord

## Overview
CHORD (Classifier of HOmologous Recombination Deficiency) is an R package that uses relative counts of somatic mutation contexts—specifically deletions with flanking microhomology and 1-100kb structural duplications—to predict HRD status. It distinguishes between BRCA1-type and BRCA2-type deficiency across pan-cancer datasets.

## Installation
CHORD requires `mutSigExtractor` and `randomForest`.

```R
# Install dependencies
install.packages('randomForest')
install.packages('devtools')
install.packages('BiocManager')
BiocManager::install('BSgenome')
BiocManager::install('BSgenome.Hsapiens.UCSC.hg19') # Default genome

# Install CHORD and mutSigExtractor from GitHub
devtools::install_github('UMCUGenetics/mutSigExtractor')
devtools::install_github('UMCUGenetics/CHORD')
```

## Workflow: Predicting HRD

### 1. Extract Mutation Contexts
Use `extractSigsChord()` to generate the feature matrix required for prediction. You can provide VCF paths or R dataframes.

**Using VCF files:**
```R
library(CHORD)

contexts <- extractSigsChord(
  vcf.snv = 'path/to/snv_and_indels.vcf.gz',
  vcf.sv = 'path/to/svs.vcf.gz',
  sv.caller = 'manta', # 'manta' or 'gridss'
  sample.name = 'Sample_01'
)
```

**Using Dataframes:**
If using custom parsers, provide dataframes with specific column orders:
- **SNV/Indel:** `chrom`, `pos`, `ref`, `alt`
- **SV:** `sv_type` (DEL, DUP, INV, TRA), `sv_len`

```R
contexts <- extractSigsChord(
  df.snv = my_snv_df,
  df.sv = my_sv_df,
  sample.name = 'Sample_01'
)
```

### 2. Run Prediction
Pass the extracted contexts to `chordPredict()`.

```R
# Basic prediction
predictions <- chordPredict(contexts)

# Prediction with bootstrapping for stability (recommended for low mutational load)
predictions <- chordPredict(contexts, do.bootstrap = TRUE)
```

## Interpreting Results
The output dataframe contains:
- `p_hrd`: Probability of HR deficiency.
- `p_BRCA1` / `p_BRCA2`: Probabilities of specific HRD types.
- `hr_status`: 'HR_deficient' if `p_hrd` >= 0.5.
- `hrd_type`: 'BRCA1_type' or 'BRCA2_type'.

### Quality Control Requirements
- **Indels:** Requires >= 50 indels for accurate HRD status.
- **SVs:** Requires >= 30 SVs for accurate HRD subtyping (if HRD).
- **MSI:** CHORD cannot be applied to Microsatellite Instable (MSI) samples (>14,000 indels).

## Tips
- **Reference Genomes:** The default is `BSgenome.Hsapiens.UCSC.hg19`. For hg38, load the library and set `ref.genome = BSgenome.Hsapiens.UCSC.hg38`.
- **Filtering:** Ensure input variants are filtered for "PASS". Use the `vcf.filters` argument if your VCFs are unfiltered.
- **Batch Processing:** For multiple samples, extract contexts individually, `rbind` them into a single matrix, and run `chordPredict` once on the merged matrix.

## Reference documentation
- [CHORD: Classifier of HOmologous Recombination Deficiency](./references/README.md)
- [GitHub Articles](./references/articles.md)
- [CHORD Home Page](./references/home_page.md)