# vsnp CWL Generation Report

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


## Metadata
- **Skill**: generated
