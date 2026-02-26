---
name: angsd
description: ANGSD is a software suite for analyzing next-generation sequencing data using genotype likelihoods to account for uncertainty. Use when user asks to estimate allele frequencies, call SNPs, calculate the site frequency spectrum, or perform population genetics analyses such as Fst and neutrality tests.
homepage: http://www.popgen.dk/angsd/index.php/ANGSD
---


# angsd

## Overview
ANGSD is a specialized suite for analyzing NGS data that accounts for genotype uncertainty. Unlike traditional tools that rely on hard-called genotypes—which can be biased in low-coverage data—ANGSD works with genotype likelihoods. It is the primary tool for population genomics workflows involving site frequency spectrum (SFS) estimation, association mapping, and relatedness testing in non-model organisms or low-depth human sequencing.

## Core Command Patterns

### Basic Input and Global Filters
Most ANGSD commands require defining the input type and basic quality filters.
- **Input List**: Use `-bam file.list` where the list contains paths to BAM/CRAM files.
- **Genotype Likelihoods**: `-GL 1` (SAMtools), `-GL 2` (GATK).
- **Filters**: Always apply basic filters to avoid artifacts:
  - `-uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -baq 1 -C 50`
  - `-minMapQ 30 -minQ 20`

### Allele Frequency and SNP Calling
To estimate Major/Minor alleles and frequencies:
```bash
angsd -bam bam.filelist -out outFileName \
    -doMajorMinor 1 -doMaf 1 -GL 1 \
    -doPost 1 -doGeno 32
```
- `-doMajorMinor 1`: Infer major and minor from GL.
- `-doMaf 1`: Estimate allele frequencies.
- `-SNP_pval 1e-6`: Only output sites with a p-value below this threshold (SNP calling).

### Population Genetics (Thetas and SFS)
Calculating Tajima's D and other neutrality tests is a two-step process using `realSFS`.

1. **Generate Site Allele Frequency (SAF)**:
   ```bash
   angsd -bam bam.filelist -doSaf 1 -out outFileName -anc reference.fa -GL 1
   ```
2. **Estimate SFS**:
   ```bash
   realSFS outFileName.saf.idx > outFileName.sfs
   ```
3. **Calculate Thetas**:
   ```bash
   angsd -bam bam.filelist -out outFileName -doThetas 1 -doSaf 1 -pest outFileName.sfs -anc reference.fa -GL 1
   thetaStat do_stat outFileName.thetas.idx
   ```

### Population Structure and Fst
For Fst between two populations:
1. Generate `.saf.idx` for both populations.
2. Calculate the 2D-SFS:
   ```bash
   realSFS pop1.saf.idx pop2.saf.idx > pop1.pop2.ml
   ```
3. Calculate Fst:
   ```bash
   realSFS fst index pop1.saf.idx pop2.saf.idx -sfs pop1.pop2.ml -fstout out.fst
   realSFS fst print out.fst.idx
   ```

## Expert Tips
- **Memory Management**: Use `-nThreads <int>` to speed up calculations, but be aware that memory usage scales with the number of sites and individuals.
- **Ancestral State**: Many population genetic statistics require an ancestral state (`-anc`). If unknown, the reference genome is often used as a proxy, though this can introduce bias.
- **Beagle Output**: For imputation or downstream PCA/Admixture tools, use `-doGlf 2` to output in Beagle format.
- **Depth Filters**: In low-coverage data, use `-setMinDepth` and `-setMaxDepth` to exclude regions with extreme coverage that might represent repeats or paralogs.

## Reference documentation
- [ANGSD Overview](./references/www_popgen_dk_angsd_index.php_ANGSD.md)