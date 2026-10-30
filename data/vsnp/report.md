# vsnp CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| vsnp_vSNP_step1.py | PASS |  |
| vsnp_vSNP_step2.py | Failed | image problem: the image bundles no reference option directory (Mycobacterium_AF2122 is missing), so step 2 crashes with AttributeError 'Ref_Options' has no attribute 'gbk'; base command also fixed |
| vsnp_vsnp_alignment_vcf.py | PASS | real SARS-CoV-2 test reads and reference (paired and single-end runs) |
| vsnp_vsnp_best_reference.py | PASS | synthetic data: reads built from the tool's own M. bovis oligos give TB group, Mycobacterium_AF2122 |
| vsnp_vsnp_bruc_mlst.py | PASS | synthetic data: reads tiled from the tool's ST1 reference give MLST type 01 |
| vsnp_vsnp_chromosome_reference.py | PASS | real M. bovis VCF gives Mycobacterium_AF2122 |
| vsnp_vsnp_excel_merge_files.py | Failed | image problem: pandas 1.2.3 with xlrd 2.0.1 cannot read .xlsx files (openpyxl missing) |
| vsnp_vsnp_fasta_gbk_gff_by_acc.py | PASS | downloaded phage lambda NC_001416 FASTA, GenBank and GFF (48,502 bp) |
| vsnp_vsnp_fasta_to_snps_table.py | PASS | synthetic data: SNPs planted into the real M. bovis reference; tree groups the planted clades |
| vsnp_vsnp_fastq_quality.py | PASS | real SARS-CoV-2 reads; crashes on reads whose quality line contains the character ^ |
| vsnp_vsnp_file_management.py | Failed | image problem: pandas 1.2.3 with xlrd 2.0.1 cannot read the .xlsx genotype code file (openpyxl missing) |
| vsnp_vsnp_filter_finder.py | Failed | image problem: the -f Excel filter file cannot be read (xlrd 2.0.1, no openpyxl); the error is caught and printed |
| vsnp_vsnp_group_reporter.py | Failed | image problem: the image bundles no reference option directory (Mycobacterium_AF2122 missing), so it crashes with AttributeError: no attribute excel |
| vsnp_vsnp_merge_vcf_into_fasta.py | PASS | real M. bovis VCF merged into the reference; the one high-quality SNP (A to G at 1057) is applied |
| vsnp_vsnp_path_adder.py | Failed | image problem: --cwd must write /usr/local/dependencies/reference_options_paths.txt inside the image, which is read-only; base command also fixed |
| vsnp_vsnp_remove_from_analysis.py | Failed | image problem: pandas 1.2.3 with xlrd 2.0.1 cannot read the .xlsx list file (openpyxl missing) |
| vsnp_vsnp_spoligotype.py | PASS | synthetic data: reads built from the tool's spacer table give SB0001 |

## vsnp_vSNP_step1.py

### Tool Description
vSNP step 1: Preprocessing and reference selection for variant calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Total Downloads**: 11.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/USDA-VS/vSNP
- **Stars**: N/A
### Original Help Text
```text
usage: PROG [-h] [-r1 READ1] [-r2 READ2] [-r REFERENCE] [-g GBK] [-t]
            [-group GROUP] [-skip_assembly] [-v]

---------------------------------------------------------
Three Senario Options:
    Senario 1: Provide a FASTA
    vSNP_step1.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz -r *fasta
    vSNP_step1.py -r1 *fastq.gz -r *fasta

    Senario 2: Provide a Reference Option
    Run -t option to see table of reference options: vSNP_step1.py -t
    vSNP_step1.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz -r Mycobacterium_AF2122

    Senario 3: Find Best Reference.  Only for TB complex, paraTB, and Brucella.
    Run without -r option
    vSNP_step1.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz

FASTA, gbk, and gff files for multi-chromosome genomes must be concatenated to single file

Dependencies:
    - Reference options are grouped and accessed via named directories.  New directories are added using, $ path_adder.py.  In vSNP's installed package dependency paths are stored in, "dependency_paths.txt".  Directory/reference options are shown using -t option.
        Seven files can be included:
            Excel: (see template_define_filter.xlsx) with defining SNPs and filter positions.   <Required for grouping>
            Excel: metadata.xlsx  3 column file: VCF file name, updated file name, representative (optional boolean).  File name must contain "meta" somewhere in its name.  <Optional>
            Excel: remove_from_analysis.xlsx 1 column file: removes files based on name minus .vcf extension.  File name must contain "remove" somewhere in its name.  <Optional>
            FASTA (.fasta): used by vSNP_step1.py as reference.  <Required, unless explicitely given with -r option.  See senario 1>
            GBK (.gbk): used to annotate VCF files and tables.  <Optional>
            GFF (.gff): used by IGV to show annotation.  <Optional>
            IGV file: .genome IGV file mapping FASTA and GFF.  <Optional>
    - vSNP comes installed with Mycobacterium_AF2122.  For additional reference options see: https://github.com/USDA-VS/vSNP_dependencies.git

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Required: single read, R1 when Illumina read
  -r2 READ2, --read2 READ2
                        Optional: R2 Illumina read
  -r REFERENCE, --reference REFERENCE
                        Optional: Provide reference option or FASTA file. If
                        neither are given, no -r option, then a
                        TB/Brucella/paraTB best reference are searched
  -g GBK, --gbk GBK     Optional: gbk to annotate VCF file
  -t, --table           See reference options
  -group GROUP, --group GROUP
                        Optional: group output via best_reference.py, ie
                        specify TB or Bruc which initials spoligo or MLST
                        generation
  -skip_assembly, --skip_assembly
                        Optional: skip assembly of unmapped reads
  -v, --version         show program's version number and exit

---------------------------------------------------------
```


## vsnp_vSNP_step2.py

### Tool Description
Current working directory used by default, but can specify working directory with -w. Directory must contain VCF files with file extension ".vcf"

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-r REFERENCE] [-t] [-a] [-s] [-d] [-n] [-f]
            [-w WORKING_DIRECTORY] [-g GBK] [-v]

---------------------------------------------------------
Current working directory used by default, but can specify working directory with -w.
Directory must contain VCF files with file extension ".vcf"

Usage: 
    # See available reference options:
    vSNP_step2.py -t

    # Run with a specific reference option:
    vSNP_step2.py -r Brucella_suis1

    # Find reference from VCF chrom column:
    vSNP_step2.py

    # If VCF chrom does not cross-reference with reference an all_vcf is made:
    vSNP_step2.py

    # An all VCF table can also be created along with using a reference option:
    vSNP_step2.py -ar Brucella_suis1

Dependencies:
- Reference options are grouped and accessed via named directories.  New directories are added using, $ path_adder.py.  In vSNP's installed package dependency paths are stored in, "dependency_paths.txt".  Directory/reference options are shown using -t option.
    Seven files can be included:
        Excel: (see template_define_filter.xlsx) with defining SNPs and filter positions.   <Required for grouping>
        Excel: metadata.xlsx  3 column file: VCF file name, updated file name, representative (optional boolean).  File name must contain "meta" somewhere in its name.  <Optional>
        Excel: remove_from_analysis.xlsx 1 column file: removes files based on name minus .vcf extension.  File name must contain "remove" somewhere in its name.  <Optional>
        FASTA (.fasta): used by vSNP_step1.py as reference.  <Required, unless explicitely given with -r option.  See senario 1>
        GBK (.gbk): used to annotate VCF files and tables.  <Optional>
        GFF (.gff): used by IGV to show annotation.  <Optional>
        IGV file: .genome IGV file mapping FASTA and GFF.  <Optional>

    - "template.xlsx" is availabe in "dependencies" directory.
      Definition: absolute position - combination of reference and position.  This is the combination of VCF CHROM and POS, CHROM:POS. 
      There are 3 aspects to Excel file:
        1) top row: absolute position to define a group
        2) second row: group name.  First column must contain "-All" in the name, other naming restrictions: no special characters or spaces.  Dashes and underscores are allowed in group name.
        3) third row and below: positions to filter from table and trees.
            Must be in CHROM:POS format
            POS numbers are allowed to have commas: both 1000 and 1,000 are accepted
            POS number ranges can be be used.  Note: CHROM:POS number range conforms to IGV

- vSNP comes installed with Mycobacterium_AF2122.  For additional reference options see: https://github.com/USDA-VS/vSNP_dependencies.git

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -r REFERENCE, --reference REFERENCE
                        provide a valid reference, see -t output
  -t, --table           see valid reference types available
  -a, --all             create table with all isolates
  -s, --subset          create trees with a subset of sample that represent
                        the whole
  -d, --debug           turn off map.pooling of samples
  -n, --no_filters      run without applying filters
  -f, --filter_finder   write possible positions to filter to text file
  -w WORKING_DIRECTORY, --cwd WORKING_DIRECTORY
                        Optional: path to VCF files
  -g GBK, --gbk GBK     Optional: provide full path to gbk file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```


## vsnp_vsnp_path_adder.py

### Tool Description
Using no arguments or -s option show the same output.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-d DIRECTORY] [-s] [-v]

---------------------------------------------------------
Using no arguments or -s option show the same output.

optional arguments:
  -h, --help            show this help message and exit
  -d DIRECTORY, --cwd DIRECTORY
                        Absolute directory path to be added to find reference
                        option files.
  -s, --show            Show available directories.
  -v, --version         show program's version number and exit

---------------------------------------------------------
```


## vsnp_vsnp_alignment_vcf.py

### Tool Description
Align reads to a reference FASTA with BWA, call variants and write VCF, BAM and statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r1 READ1 [-r2 READ2] -r REFERENCE [-g GBK] [-skip_assembly]
            [-v]

---------------------------------------------------------

Usage:
    alignment_vcf.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz -r *fasta
    alignment_vcf.py -r1 *fastq.gz -r *fasta
    alignment_vcf.py -r1 *_R1*fastq.gz -r2 *_R2*fastq.gz -r *fasta -g *gbk

Dependencies:
    FASTA: reference
    GBK: used to annotate VCF files and tables
---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Required: single read, R1 when Illumina read
  -r2 READ2, --read2 READ2
                        Optional: R2 Illumina read
  -r REFERENCE, --reference REFERENCE
                        Optional: Provide reference option or FASTA file. If
                        neither are given, no -r option, then a
                        TB/Brucella/paraTB best reference are searched
  -g GBK, --gbk GBK     Optional: gbk to annotate VCF file
  -skip_assembly, --skip_assembly
                        skip assembly of unmapped reads
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_best_reference.py

### Tool Description
Use oligos to determine species from reads (Brucella, M. bovis or paratuberculosis).

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r1 READ1 [-r2 READ2] [-v]

---------------------------------------------------------
Use oligos to determine species.  Most often if the absents of a single oligo from a set specific for either brucella or bovis will confer species type.  Some species will the absents of more than one oligo.  Oligo findings are translated to binary patterns.

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Required: single read
  -r2 READ2, --read2 READ2
                        Optional: paired read
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_bruc_mlst.py

### Tool Description
Find the Brucella MLST type from reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r1 READ1 [-r2 READ2] [-v]

---------------------------------------------------------
Based on https://bmcmicrobiol.biomedcentral.com/articles/10.1186/1471-2180-7-34

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Required: single read
  -r2 READ2, --read2 READ2
                        Optional: paired read
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_chromosome_reference.py

### Tool Description
Read the chromosome name of the first VCF file in a folder and look up the reference type.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-w WORKING_DIRECTORY] [-v]

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -w WORKING_DIRECTORY, --cwd WORKING_DIRECTORY
                        Optional: path to VCF files
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_excel_merge_files.py

### Tool Description
Merge all Excel files in the working directory into one workbook.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
vsnp_excel_merge_files.py takes no options.
Working directory to contain Excel files to simply merge to a single file.
It reads every *.xlsx file in the current folder and writes combined_excelworksheets-<date_time>.xlsx.
```

## vsnp_vsnp_fasta_gbk_gff_by_acc.py

### Tool Description
Download a FASTA, GenBank or GFF file for a complete NCBI chromosome accession.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-a ACCESSION] [-f] [-b] [-g] [-v]

---------------------------------------------------------

Usage:
    fasta_gbk_gff_by_acc.py -a NC_002945 -f
    fasta_gbk_gff_by_acc.py -a NC_006932 -fg
    fasta_gbk_gff_by_acc.py -a NC_006933 -fbg
    fasta_gbk_gff_by_acc.py -a CP023243 -fbg
    fasta_gbk_gff_by_acc.py -a NZ_CP023243 -fbg
    **bad request: fasta_gbk_gff_by_acc.py -a NZ_AQME0000000 -fbg # must be complete chromosome

vSNP requires multi-chromosome genomes to be concatenated to single file

Search genomes: https://www.ncbi.nlm.nih.gov/genome

optional arguments:
  -h, --help            show this help message and exit
  -a ACCESSION, --accession ACCESSION
                        NCBI chromosome number
  -f, --fasta           get FASTA file
  -b, --gbk             get gbk file
  -g, --gff             get gff file
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_fasta_to_snps_table.py

### Tool Description
Build a parsimonious SNP table and tree from an aligned FASTA.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -f FASTA [-v]

---------------------------------------------------------
2019-12-12 Beta:
Provide an aligned FASTA, build a corresponding parsimonious table and tree.
Must have one FASTA header labeled as "reference_seq".  This will be used as the reference/root/outgroup. Should be the most likely index isolate/most close precursor to outbreak. 
vsnp_fasta_to_snps_table.py -f *fasta
---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -f FASTA, --fasta FASTA
                        provide an aligned fasta
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_fastq_quality.py

### Tool Description
Report read count, read length, mean quality and Q30 share for FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r1 READ1 [-r2 READ2] [-v]

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Required: single read, R1 if Illumina read
  -r2 READ2, --read2 READ2
                        Required: R2 Illumina read
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_file_management.py

### Tool Description
Rename VCF files in the working directory from an Excel genotype code file.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -g EXCEL_GENOTYPE_CODES [-e EXTENSION] [-v]

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -g EXCEL_GENOTYPE_CODES, --codes EXCEL_GENOTYPE_CODES
                        Excel file containing genotype code Column 1: to match
                        sample name minus everything left of first occurring _
                        or . Column 2: New name
  -e EXTENSION, --extension EXTENSION
                        File extension type to be renamed
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_filter_finder.py

### Tool Description
Find positions with low quality or low mapping quality across VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] [-w WORKING_DIRECTORY] [-f DEFINING_SNP_FILTER_FILE]
            [-g GROUP] [-d] [-v]

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -w WORKING_DIRECTORY, --cwd WORKING_DIRECTORY
                        Working directoy to be added as path to dependency
                        files.
  -f DEFINING_SNP_FILTER_FILE, --filters DEFINING_SNP_FILTER_FILE
                        Defining SNPs/Filter file
  -g GROUP, --group GROUP
                        Group/directory name
  -d, --debug           turn off map.pooling of samples
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_group_reporter.py

### Tool Description
Report the defining-SNP groups of a VCF file using a reference option.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -vcf VCF [-r REF_OPTION] [-v]

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -vcf VCF, --vcf VCF   Required: vcf file
  -r REF_OPTION, --ref_option REF_OPTION
                        Required: reference option
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_merge_vcf_into_fasta.py

### Tool Description
Merge VCF changes into a FASTA sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -f FASTA_FILE -v VCF_FILE [-q QUAL_THRESHOLD]
            [-m MAP_THRESHOLD] [-a]

---------------------------------------------------------
Merge VCF changes into FASTA sequence.
Usage: merge_vcf_into_fasta.py -r <fasta_file> -v <vcf_file>

optional arguments:
  -h, --help            show this help message and exit
  -f FASTA_FILE, --fasta_file FASTA_FILE
                        REQUIRED: In file to be processed
  -v VCF_FILE, --vcf_file VCF_FILE
                        REQUIRED: In file to be processed
  -q QUAL_THRESHOLD, --qual_threshold QUAL_THRESHOLD
                        OPTIONAL: QUAL values below this value will not be
                        applied.
  -m MAP_THRESHOLD, --map_threshold MAP_THRESHOLD
                        OPTIONAL: Map Quality values below this value will not
                        be applied.
  -a, --ambiguity_NOT   OPTIONAL: when -a used ambiguity will not be applied.
                        By default it will be applied.

---------------------------------------------------------
```

## vsnp_vsnp_remove_from_analysis.py

### Tool Description
Delete the VCF files listed in an Excel file from the working directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r EXCEL_REMOVE [-w WORKING_DIRECTORY] [-e EXTENSION] [-v]

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -r EXCEL_REMOVE, --codes EXCEL_REMOVE
                        Excel file containing samples to remove from analysis
                        Column 1: to match sample name minus extension. No
                        header allowed
  -w WORKING_DIRECTORY, --cwd WORKING_DIRECTORY
                        Optional: path to VCF files
  -e EXTENSION, --extension EXTENSION
                        File extension type to be renamed
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## vsnp_vsnp_spoligotype.py

### Tool Description
Find the M. bovis spoligotype from reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/vsnp:2.03--hdfd78af_2
- **Homepage**: https://github.com/USDA-VS/vSNP
- **Package**: https://anaconda.org/channels/bioconda/packages/vsnp/overview
- **Validation**: PASS

### Original Help Text
```text
usage: PROG [-h] -r1 READ1 [-r2 READ2] [-d] [-v]

---------------------------------------------------------

optional arguments:
  -h, --help            show this help message and exit
  -r1 READ1, --read1 READ1
                        Required: single read
  -r2 READ2, --read2 READ2
                        Optional: paired read
  -d, --debug           turn off map.pooling of samples
  -v, --version         show program's version number and exit

---------------------------------------------------------
```

## Metadata
- **Skill**: generated
