# crispritz CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| crispritz_add-variants | PASS |  |
| crispritz_annotate-results | PASS |  |
| crispritz_generate-report | Failed | tool bug: radar_chart.py fills the plot with random.randint values instead of the annotation counts, so the report is wrong. |
| crispritz_index-genome | PASS |  |
| crispritz_scores | Failed | image problem: scores.py cannot import its bundled azimuth package (only a Python 2 __init__.pyc, bad magic number under Python 3.8), so no score files are written; the same breaks search -scores. |
| crispritz_search | PASS |  |

## crispritz_add-variants

### Tool Description
Function to add variants data to a FASTA genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
- **Homepage**: https://github.com/InfOmics/CRISPRitz
- **Package**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Total Downloads**: 178.9K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/InfOmics/CRISPRitz
- **Stars**: N/A

### Original Help Text
```text
WARNING: Too few arguments to function add-variants. Please provide: 
EXAMPLE CALL: crispritz.py add-variants vcfFilesDirectory/ genomeDirectory/
 

<vcfFilesDirectory> : Directory containing VCF files, need to be separated into single chromosome files (multi-sample files will be collapsed into one fake individual) 

<genomeDirectory> : Directory containing a genome in .fa or .fasta format, need to be separated into single chromosome files. 

-th <num_thread>: (Optional) Number of threads to use. Default uses 1 thread
```

## crispritz_index-genome

### Tool Description
Function to create genome index to perform fast searches with bulges.

### Metadata
- **Docker Image**: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
- **Homepage**: https://github.com/InfOmics/CRISPRitz
- **Package**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Total Downloads**: 178.9K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/InfOmics/CRISPRitz
- **Stars**: N/A

### Original Help Text
```text
WARNING: Too few arguments to function index-genome. Please provide:
 
EXAMPLE CALL: crispritz.py index-genome name_genome genomeDirectory(FASTA)/ pamFile.txt -bMax 2
 
<name_genome>: Name of the genome to create 
<genomeDirectory>: Directory containing a genome in .fa or .fasta format, need to be separated into single chromosome files. 
<pamFile>: Text file containing the PAM (including a number of Ns equal to the guide length) and a space separated number indicating the length of the PAM sequence 
-bMax <maxBulges_num>: Number of bulges allowed for the search phase 
-th <num_thread>: (Optional) Number of threads to use. Default uses 4 threads
```

## crispritz_search

### Tool Description
Function to perform searches on a genome (indexed or plain FASTA).

### Metadata
- **Docker Image**: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
- **Homepage**: https://github.com/InfOmics/CRISPRitz
- **Package**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Total Downloads**: 178.9K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/InfOmics/CRISPRitz
- **Stars**: N/A

### Original Help Text
```text
WARNING: Too few arguments to function search. Please provide:
 
EXAMPLE CALL MISMATCHES ONLY: crispritz.py search genomeDirectory/ pamFile.txt guidesFile.txt outputFile -mm 4 -th 4 -scores genomeDirectory(FASTA)/ -t
 
EXAMPLE CALL MISMATCHES + BULGES: crispritz.py search indexGenomeDirectory/ pamFile.txt guidesFile.txt outputFile -mm 4 -bDNA 1 -bRNA 2 -th 4 -scores genomeDirectory(FASTA)/ -t
 
<genomeDirectory>: Directory containing a genome in .fa or .fasta format (.bin format if bulges present), need to be separated into single chromosome files 
<pamFile>: Text file containing the PAM sequence (including a number of Ns equal to the guide length) and a space separated number indicating the length of the PAM sequence 
<guidesFile>: Text file containing one or more guides (including a number of Ns equal to the length of the PAM sequence) 
<outputFile>: Name of output file 
-mm <mm_num>: Number of allowed mismatches 
-bRNA <bRNA_num>: (Optional) Size of RNA bulges 
-bDNA <bDNA_num>: (Optional) Size of DNA bulges 
-th < num_thread >: (Optional) Number of threads to use. Default uses all of the available threads (ONE for bulge search) 
-scores <genomeDirectoryInFastaFormat>: (Optional) Directory containing the genome in .fa or .fasta format, necessary to extract sequences for Doench Score Function 
{-r,-p,-t}: Output type (-r off-targets list only, -p profile only, -t off-targets AND profile)
```

## crispritz_scores

### Tool Description
Function to calculate the CFD score for a list of targets.

### Metadata
- **Docker Image**: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
- **Homepage**: https://github.com/InfOmics/CRISPRitz
- **Package**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Total Downloads**: 178.9K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/InfOmics/CRISPRitz
- **Stars**: N/A

### Original Help Text
```text
WARNING: Too few arguments to function annotate-results. Please provide:
 
EXAMPLE CALL: crispritz.py scores resultsFile.txt pamFile.txt guideFiles.txt genomeDirectoryInFastaFormat
 
<resultsFile>: Targets file containing all genomic targets for the guides set 
<pamFile>: Text file containing the PAM sequence (including a number of Ns equal to the guide length) and a space separated number indicating the length of the PAM sequence 
<guidesFile>: Text file containing one or more guides (including a number of Ns equal to the length of the PAM sequence) 
<genomeDirectoryInFastaFormat>: Directory containing the genome in .fa or .fasta format, necessary to extract sequences for Doench Score Function
```

## crispritz_annotate-results

### Tool Description
Function to add genomic information to targets results.

### Metadata
- **Docker Image**: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
- **Homepage**: https://github.com/InfOmics/CRISPRitz
- **Package**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Total Downloads**: 178.9K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/InfOmics/CRISPRitz
- **Stars**: N/A

### Original Help Text
```text
WARNING: Too few arguments to function annotate-results. Please provide:
 
EXAMPLE CALL: crispritz.py annotate-results resultsFile.txt annotationsFile.bed outputFile
 
<resultsFile>: Targets file containing all genomic targets for the guides set 
<annotationsFile>: Text file containing the annotations in .bed format 
<outputFile>: Name of output file 
--change-ID <sampleIDfile> : (Optional) Change the samples, population and superpopulation IDs. DEFAULT: the default IDs are taken from the 1000 genome project (used for Human Genome hg19 and hg38)
```

## crispritz_generate-report

### Tool Description
Function to generate graphical report for a specific guide.

### Metadata
- **Docker Image**: quay.io/biocontainers/crispritz:2.7.0--py38h9948957_2
- **Homepage**: https://github.com/InfOmics/CRISPRitz
- **Package**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/crispritz/overview
- **Total Downloads**: 178.9K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/InfOmics/CRISPRitz
- **Stars**: N/A

### Original Help Text
```text
WARNING: Too few arguments to function generate-report. Please provide:
 
EXAMPLE CALL: crispritz.py GAGTCCGAGCAGAAGAAGAANNN -mm 4 -annotation annotationSummaryFile.txt -extprofile guideExtendedProfile.xls -gecko -sumref referenceAnnotationSummaryFile.txt
 
<guide>: (Optional) A guide present in the analyzed set 
-mm <mm_num>: Number of mismatches to analyze 
-annotation <annotationSummaryFile>: Count files for genomic annotations 
-extprofile <guideExtendedProfile>: Extended profile file 
-gecko: (Optional) Tag to activate gecko dataset comparison 
-sumref <referenceAnnotationSummaryFile>: (Optional) Create a barplot comparing reference genome results with enriched genome results. If the <guide> option is used, the barplot will take into account only the targets found with that specific guide
```
