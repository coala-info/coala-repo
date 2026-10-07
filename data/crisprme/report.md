# crisprme CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crisprme_complete-search | Failed | image problem: the pipeline calls pr (GNU coreutils), which is missing from the image, so a 1000G variant search on a 30 kb hg38 region stops at the targets join; reference-only runs also fail because busybox realpath errors on the '_' placeholder. |
| crisprme_generate-personal-card | Not completed | needs a finished variant-aware complete-search result folder, which cannot be produced with this image. |
| crisprme_gnomAD-converter | PASS |  |
| crisprme_targets-integration | Not completed | needs the final integrated results file from complete-search, which cannot be produced with this image. |

## crisprme_complete-search

### Tool Description
End-to-end off-target search on reference and variant genomes, with CFD and CRISTA scoring, annotation and target selection.

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
- **Homepage**: https://github.com/samuelecancellieri/CRISPRme
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Total Downloads**: 459.2K
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/samuelecancellieri/CRISPRme
- **Stars**: N/A

### Original Help Text
```text
The complete-search functionality is an end-to-end automated pipeline that takes raw input files and performs the full workflow up to post-analysis. Starting from the user-provided genome, variants, guides, PAM and annotation files, it identifies potential CRISPR off-targets incorporating variant and haplotype information, and scores each candidate guide. The pipeline performs genome-wide searches, integrates annotation data, and generates comprehensive reports.Options:
	--genome, specify the reference genome folder [REQUIRED]
	--vcf, specify a file listing VCF folders (one per line) [OPTIONAL]
	--guide, specify a file containing guide RNAs [REQUIRED if --sequence not provided]
	--sequence, specify a file with DNA sequences or BED coordinates to extract guides [REQUIRED if --guide not provided]
	--pam, specify a file containing the PAM sequence [REQUIRED]
	--be-window, specify the window to search for base editor susceptibility (e.g., --be-window 4,8) [OPTIONAL]
	--be-base, the base(s) for the chosen base editor (e.g., --be-base A,C) [OPTIONAL]
	--annotation, specify BED files with genome annotations (e.g., regulatory elements, enhancers). The fourth column must contain the annotation name. The input BED files must be compressed using bgzip [OPTIONAL]
	--personal_annotation, specify BED files with personal genomic annotations. The fourth column must contain the annotation name. The input BED files must be compressed using bgzip [OPTIONAL]
	--samplesID, specify a file listing sample files (one per line) present in samplesIDs folder [OPTIONAL]
	--gene_annotation, specify gene annotation (e.g., GENCODE) to find nearest gene for each target (must be bgzip-compressed) [OPTIONAL]
	--mm, number of mismatches allowed in the search [REQUIRED]
	--bDNA, number of DNA bulges allowed in the search [OPTIONAL]
	--bRNA, number of RNA bulges allowed in the search [OPTIONAL]
	--merge, window size (nucleotides) to merge candidate off-targets using the highest scoring as pivot [default: 3]
	--sorting-criteria-scoring, comma-separated list to sort targets by scoring criteria: 'mm', 'bulges', or 'mm+bulges' [default: 'mm+bulges']
	--sorting-criteria, comma-separated list to sort targets by 'mm', 'bulges', or 'mm+bulges' [default: 'mm+bulges,mm']
	--output, specify the output folder name; results will be saved in Results/<name> [REQUIRED]
	--thread, set number of threads to use [default: 8]
```

## crisprme_targets-integration

### Tool Description
Integrates in-silico targets with empirical data to generate a usable panel.

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
- **Homepage**: https://github.com/samuelecancellieri/CRISPRme
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Total Downloads**: 459.2K
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/samuelecancellieri/CRISPRme
- **Stars**: N/A

### Original Help Text
```text
This is the automated integration process that process the final result file to generate a usable target panel.
These are the flags that must be used in order to run this function:
	--targets, used to specify the final result file to use in the panel creation process
	--empirical_data, used to specify the file that contains empirical data provided by the user to assess in-silico targets
	--output, used to specify the output folder for the results
```

## crisprme_gnomAD-converter

### Tool Description
Converts gnomAD VCF files into CRISPRme compatible VCFs (supports gnomAD >= v3.1).

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
- **Homepage**: https://github.com/samuelecancellieri/CRISPRme
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Total Downloads**: 459.2K
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/samuelecancellieri/CRISPRme
- **Stars**: N/A

### Original Help Text
```text
The gnomAD converter functionality simplifies the conversion process of gnomAD VCFs (versions 3.1 and 4.0) into VCFs supported by CRISPRme. It ensures a seamless transition while maintaining compatibility with CRISPRme's requirements, focusing on the structure and content of precomputed sample IDs file 

Options:
	--gnomAD_VCFdir, specifies the directory containing gnomAD VCFs. Files must have the BGZ extension
	--samplesID, specifies the precomputed sample IDs file necessary for incorporating population-specific information into the output VCFs
	--joint, optional flag to specify the input GnomAD VCF contain joint allele frequencies
	--keep, optional flag to retain all variants, regardless of their filter flag. By default, variants with a filter flag different from PASS are discarded
	--multiallelic, optional flag to merge variants mapped to the same position, creating multiallelic sites in the output VCFs. By default, each site remains biallelic
	--thread, used to set the number of thread used in the conversion process [default 8]
```

## crisprme_generate-personal-card

### Tool Description
Generates a personal card for specific samples by extracting all private targets.

### Metadata
- **Docker Image**: quay.io/biocontainers/crisprme:2.1.9--py38hdfd78af_0
- **Homepage**: https://github.com/samuelecancellieri/CRISPRme
- **Package**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crisprme/overview
- **Total Downloads**: 459.2K
- **Last updated**: 2026-01-17
- **GitHub**: https://github.com/samuelecancellieri/CRISPRme
- **Stars**: N/A

### Original Help Text
```text
This is the personal card generator that creates a files with all the private targets for the input sample
These are the flags that must be used in order to run this function:
	--result_dir, directory containing the result from which extract the targets to generate the card
	--guide_seq, sequence of the guide to use in order to exctract the targets
	--sample_id, ID of the sample to use in order to generate the card
```
