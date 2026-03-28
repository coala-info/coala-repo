# difcover CWL Generation Report

## difcover_run_difcover.sh

### Tool Description
Stage 1

### Metadata
- **Docker Image**: quay.io/biocontainers/difcover:3.0.1--h9948957_2
- **Homepage**: https://github.com/timnat/DifCover
- **Package**: https://anaconda.org/channels/bioconda/packages/difcover/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/difcover/overview
- **Total Downloads**: 1.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/timnat/DifCover
- **Stars**: N/A
### Original Help Text
```text
# Stage 1
File sample1_sample2.unionbedcv is empty, exit now
```


## difcover_from_bams_to_unionbed.sh

### Tool Description
Calculates coverage for BAM files using BEDTOOLS and SAMTOOLS. The main output reports coverage for input samples in corresponding columns for each bed interval. Additional files report coverage for each sample separately.

### Metadata
- **Docker Image**: quay.io/biocontainers/difcover:3.0.1--h9948957_2
- **Homepage**: https://github.com/timnat/DifCover
- **Package**: https://anaconda.org/channels/bioconda/packages/difcover/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: from_bams_to_unionbed.sh sample1.bam sample2.bam
 - This program requires BEDTOOLS and SAMTOOLS installed and to be in your PATH!
 - The input BAM files must be coordinate sorted alignments to the SAME reference genome. They also can be to filtered and subjected to removal of duplicates
 - The main output sample1_sample2.unionbedcv reports coverage for sample1 and sample2 in corresponding columns for each bed interval. Files *.bedcov.Vk1s_sorted report coverage for each sample separately.
 - ATTENTION, this script uses unionBedGraphs (from bedtools) that doesn't accept in contig names some symbols like '#', replace them in bedcov files and ref.length with ':'
Wrong number of arguments
Usage: from_bams_to_unionbed.sh sample1.coordinate_sorted_bam_file sample2.coordinate_sorted_bam_file
```


## difcover_from_unionbed_to_ratio_per_window_CC0

### Tool Description
Calculates the ratio of coverage per window between two samples from a unionbed file.

### Metadata
- **Docker Image**: quay.io/biocontainers/difcover:3.0.1--h9948957_2
- **Homepage**: https://github.com/timnat/DifCover
- **Package**: https://anaconda.org/channels/bioconda/packages/difcover/overview
- **Validation**: PASS

### Original Help Text
```text
Expected *.unionbed file
Usage: [-a minimum depth of coverage for sample1 [0]] [-A maximum depth of coverage for sample1 [1000000]] [-b minimum depth of coverage for sample2 [0]] [-B maximum depth of coverage for sample2 [1000000]]  [-v Target number of valid bases in the window [1000]] [-l minimum size of window to output [0]] sample1_sample2.unionbedcv
```


## difcover_from_ratio_per_window__to__DNAcopy_output.sh

### Tool Description
Converts ratio per window files to DNAcopy output format.

### Metadata
- **Docker Image**: quay.io/biocontainers/difcover:3.0.1--h9948957_2
- **Homepage**: https://github.com/timnat/DifCover
- **Package**: https://anaconda.org/channels/bioconda/packages/difcover/overview
- **Validation**: PASS

### Original Help Text
```text
Wrong number of arguments!
Usage: program *.ratio_per_windows adj_coef, where adj_coef recommended to be (modal_cov_sample2/modal_cov_sample1)
```


## difcover_from_DNAcopyout_to_p_fragments.sh

### Tool Description
Converts DNAcopy output to p fragments, filtering intervals based on enrichment scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/difcover:3.0.1--h9948957_2
- **Homepage**: https://github.com/timnat/DifCover
- **Package**: https://anaconda.org/channels/bioconda/packages/difcover/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: from_DNAcopyout_to_p_fragments.sh *.DNAcopyout p
The input file *.DNAcopyout must be in the format: scaffold fragment_start fragment_size number_of_windows_merged_into_fragment av(adj_coef*log2ratio). p - filter only intervals with |enrichment scores| > p
Wrong number of arguments
Usage: program *.DNAcopyout p
```


## Metadata
- **Skill**: generated
