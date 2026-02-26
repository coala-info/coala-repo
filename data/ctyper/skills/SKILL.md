---
name: ctyper
description: ctyper performs rapid, allele-specific genotyping of complex genomic regions and high copy-number variants using a pangenome allele database. Use when user asks to genotype duplicated genes, resolve complex loci, annotate genotypes with clinical nomenclature, or generate mutation plots for visual validation.
homepage: https://github.com/ChaissonLab/Ctyper
---


# ctyper

## Overview
ctyper is a specialized bioinformatics tool designed to resolve complex genomic regions that traditional genotypers often struggle with, particularly those involving duplicated genes and high copy-number variation. By leveraging a pangenome allele database, it provides rapid, allele-specific genotyping. Beyond raw calling, the tool includes a suite of auxiliary scripts to transform results into standard formats like VCF, FASTA, or clinical nomenclatures, and can generate mutation plots for visual validation of complex loci.

## Installation and Environment
Install via Bioconda:
```bash
conda create -n ctyper_env -c conda-forge -c bioconda ctyper
conda activate ctyper_env
```

**Critical Environment Setup:**
ctyper requires HTSlib. Ensure your `LD_LIBRARY_PATH` includes your conda environment's library path to avoid execution errors:
```bash
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
```

## Core Usage Patterns

### Full Profiling Run
To genotype all genes included in the provided pangenome matrix:
```bash
ctyper -i input.cram -m HprcCpcHgsvc_cmr_matrix.txt -o ctyper.out
```

### Targeted Genotyping
To focus on specific genes (e.g., HLA) and speed up processing, use the `-g` (gene pattern) and `-B` (target regions BED) flags:
```bash
ctyper -i input.cram -m HprcCpcHgsvc_cmr_matrix.txt -g "HLA*" -B TargetRegions.bed -o hla_genotype.out
```

## Post-Analysis Workflow

### 1. Annotation
Convert the raw output into a readable, annotated table. This is a required step for most downstream visualization and conversion tools.
```bash
python tools/Annotation/SampleAnnotate.py -i ctyper.out -a PangenomeAlleles_annotationfix.tsv.gz -o genotype.txt
```

### 2. Format Conversion
*   **Nomenclature (HLA/KIR/CYP2D6):**
    ```bash
    python tools/Annotation/Nomenclature/GenotypetoNomenclature.py -i genotype.txt -a data/all_nomenclature.txt > nomenclature.txt
    ```
*   **VCF Generation:**
    ```bash
    python tools/Annotation/Nomenclature/GenotypetoVCF.py -i genotype.txt -a PangenomeAlleles_annotationfix.tsv.gz -o output.vcf
    ```
*   **FASTA Extraction:**
    ```bash
    python tools/Annotation/getFASTA/getFASTA.py -i genotype.txt -r reference.fa,Allalters.fa -a PangenomeAlleles_annotationfix.tsv.gz -o output.fa
    ```

### 3. Visualization
Generate mutation plots for specific genes (e.g., SMN1/SMN2) to visualize structural differences:
```bash
python tools/Plot/typemutant.py -i genotype.txt -a PangenomeAlleles_annotationfix.tsv.gz -g SMN -o SMN_plot.png
```

## Expert Tips
*   **Database Files:** Ensure you have the three mandatory matrix components: the matrix file (`.txt`), the index (`.index`), and the background model (`.bgd`).
*   **VCF Limitations:** While ctyper can produce VCFs, the developers recommend using the annotated text tables for association studies, as VCFs have inherent limitations in representing complex pangenome-derived genotypes.
*   **Custom Databases:** If you need to study custom loci not in the default HPRC/CPC/HGSVC matrix, use the companion toolkit **PATs**, though it is recommended to contact the Chaisson Lab before building custom pangenome databases.

## Reference documentation
- [Ctyper GitHub Repository](./references/github_com_ChaissonLab_Ctyper.md)
- [Bioconda ctyper Overview](./references/anaconda_org_channels_bioconda_packages_ctyper_overview.md)