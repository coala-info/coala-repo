# harpy CWL Generation Report

## harpy_align

### Tool Description
Align sequences to a reference genome. Provide an additional subcommand bwa or strobe to get more information on using those aligners. Both have comparable performance, but strobe is typically faster. The aligners are not linked-read aware, but the workflows ensure linked-read information is carried over to the alignment records.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Total Downloads**: 1.9M
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/pdimens/harpy
- **Stars**: N/A
### Original Help Text
```text
Usage: harpy align [OPTIONS] COMMAND [ARGS]...                                  
                                                                                
Align sequences to a reference genome                                           
Provide an additional subcommand bwa or strobe to get more information on using 
those aligners. Both have comparable performance, but strobe is typically       
faster. The aligners are not linked-read aware, but the workflows ensure        
linked-read information is carried over to the alignment records.               
                                                                                
Commands:                                                                       
  bwa     Align sequences to reference genome using BWA MEM2                    
  strobe  Align sequences to reference genome using strobealign
```


## harpy_assembly

### Tool Description
Assemble linked reads into a genome. The linked-read barcodes must be in BX:Z or BC:Z FASTQ header tags. It is strongly recommended to first deconvolve the input FASTQ files with harpy deconvolve.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy assembly [OPTIONS] FASTQ_R1 FASTQ_R2                               
                                                                                
Assemble linked reads into a genome                                             
The linked-read barcodes must be in BX:Z or BC:Z FASTQ header tags. If provided,
values for -k must be separated by commas and without spaces (e.g. -k 15,23,51).
It is strongly recommended to first deconvolve the input FASTQ files with harpy 
deconvolve.                                                                     
                                                                                
Assembly Parameters:                                                            
  --kmer-length    -k  K values to use for assembly (odd and <128)              
                       [default=auto]                                           
  --max-memory     -r  Maximum memory for spades to use, in megabytes           
                       [default=10000]                                          
  --extra-params   -x  Additional spades parameters, in quotes                  
  --organism-type  -u  Organism type for assembly report                        
                       [eukaryote,prokaryote,fungus]                            
                       [default=eukaryote]                                      
                                                                                
Scaffolding Parameters:                                                         
  --arcs-extra         -y  Additional ARCS parameters, in quotes (option=arg    
                           format)                                              
  --contig-length      -c  Minimum contig length                                
                           [default=500]                                        
  --links              -n  Minimum number of links to compute scaffold          
                           [default=5]                                          
  --min-aligned        -a  Minimum aligned read pairs per barcode               
                           [default=5]                                          
  --min-quality        -q  Minimum mapping quality                              
                           [default=0]                                          
  --mismatch           -m  Maximum number of mismatches                         
                           [default=5]                                          
  --molecule-distance  -d  Distance cutoff to split molecules (bp)              
                           [default=50000]                                      
  --molecule-length    -l  Minimum molecule length (bp)                         
                           [default=2000]                                       
  --seq-identity       -i  Minimum sequence identity                            
                           [default=98]                                         
  --span               -s  Minimum number of spanning molecules to be           
                           considered assembled                                 
                           [default=20]                                         
                                                                                
Workflow Options:                                                               
  --output-dir    -o  Output directory name                                     
                      [default=Assembly]                                        
  --threads       -t  Number of threads to use                                  
                      [default=4]                                               
  --container         Use a container instead of conda                          
  --hpc               HPC submission YAML configuration file                    
  --quiet             0 all output, 1 progress bar, 2 no output                 
  --skip-reports      Don't generate HTML reports                               
  --snakemake         Additional Snakemake parameters, in quotes                
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/assembly
```


## harpy_demultiplex

### Tool Description
Demultiplex haplotagged FASTQ files. Check that you are using the correct haplotagging method/technology, since the different barcoding approaches have very different demultiplexing strategies.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy demultiplex COMMAND [ARGS]...                                      
                                                                                
Demultiplex haplotagged FASTQ files                                             
Check that you are using the correct haplotagging method/technology, since the  
different barcoding approaches have very different demultiplexing strategies.   
                                                                                
Haplotagging Technologies                                                       
                                                                                
 • meier2021: the original haplotagging barcode strategy                        
    • Meier et al. (2021) doi: 10.1073/pnas.2015005118                          
                                                                                
Commands:                                                                       
  meier2021  Demultiplex FASTQ files haplotagged with the Meier et al. 2021     
             protocol
```


## harpy_impute

### Tool Description
Impute variant genotypes from alignments. Provide the parameter file followed by the input VCF and the input alignment files/directories (.bam) at the end of the command.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy impute [OPTIONS] PARAMETERS VCF INPUTS...                          
                                                                                
Impute variant genotypes from alignments                                        
Provide the parameter file followed by the input VCF and the input alignment    
files/directories (.bam) at the end of the command as individual files/folders, 
using shell wildcards (e.g. data/drosophila*.bam), or both.                     
                                                                                
Use harpy template to generate one and adjust it for your study. Set a          
--grid-size (in base pairs) to significantly reduce computation time and memory 
usage at the cost of minor accuracy loss. The --vcf-samples option considers    
only the samples present in your input VCF file rather than all the samples     
identified in INPUTS. Use --region to only impute a specific genomic region,    
given as contig:start-end-buffer, otherwise all contigs will be imputed. If     
providing additional STITCH arguments, they must be in quotes and in the        
--option=value format, without spaces (e.g. "--switchModelIteration=39").       
                                                                                
Parameters:                                                                     
  --extra-params  -x  Additional STITCH parameters, in quotes                   
  --region        -r  Specific region to impute                                 
  --grid-size     -g  Perform imputation in windows of a specific size, instead 
                      of per-SNP (default)                                      
                      [default=1]                                               
  --vcf-samples       Use samples present in vcf file for imputation rather     
                      than those found in the inputs                            
                                                                                
Workflow Options:                                                               
  --output-dir    -o  Output directory name                                     
                      [default=Impute]                                          
  --threads       -t  Number of threads to use                                  
                      [default=4]                                               
  --container         Use a container instead of conda                          
  --hpc               HPC submission YAML configuration file                    
  --quiet             0 all output, 1 progress bar, 2 no output                 
  --skip-reports      Don't generate HTML reports                               
  --snakemake         Additional Snakemake parameters, in quotes                
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/impute/
```


## harpy_metassembly

### Tool Description
Assemble linked reads into a metagenome. The linked-read barcodes must be in BX:Z or BC:Z FASTQ header tags. It is strongly recommended to first deconvolve the input FASTQ files with harpy deconvolve.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy metassembly [OPTIONS] FASTQ_R1 FASTQ_R2                            
                                                                                
Assemble linked reads into a metagenome                                         
The linked-read barcodes must be in BX:Z or BC:Z FASTQ header tags. If provided,
values for -k must be separated by commas and without spaces (e.g. -k 15,23,51).
It is strongly recommended to first deconvolve the input FASTQ files with harpy 
deconvolve.                                                                     
                                                                                
Metassembly Parameters:                                                         
  --bx-tag         -b  The header tag with the barcode (BX or BC)               
                       [default=BX]                                             
  --extra-params   -x  Additional spades parameters, in quotes                  
  --kmer-length    -k  K values to use for assembly (odd and <128)              
                       [default=auto]                                           
  --max-memory     -r  Maximum memory for spades to use, in megabytes           
                       [default=10000]                                          
  --unlinked       -U  Treat input data as not linked reads                     
  --organism-type  -u  Organism type for assembly report                        
                       [eukaryote,prokaryote,fungus]                            
                       [default=eukaryote]                                      
                                                                                
Workflow Options:                                                               
  --output-dir    -o  Output directory name                                     
                      [default=Metassembly]                                     
  --threads       -t  Number of threads to use                                  
                      [default=4]                                               
  --container         Use a container instead of conda                          
  --hpc               HPC submission YAML configuration file                    
  --quiet             0 all output, 1 progress bar, 2 no output                 
  --skip-reports      Don't generate HTML reports                               
  --snakemake         Additional Snakemake parameters, in quotes                
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/metassembly
```


## harpy_phase

### Tool Description
Phase SNPs into haplotypes. Provide the vcf file followed by the input alignment (.bam) files and/or directories.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy phase [OPTIONS] VCF INPUTS...                                      
                                                                                
Phase SNPs into haplotypes                                                      
Provide the vcf file followed by the input alignment (.bam) files and/or        
directories at the end of the command as individual files/folders, using shell  
wildcards (e.g. data/myotis*.bam), or both.                                     
                                                                                
Presence and type of linked-read data is auto-detected, but you may choose to   
omit barcode information with -U. Use --vcf-samples to phase only the samples   
present in your input VCF file rather than all the samples present in the INPUT 
alignments.                                                                     
                                                                                
Parameters:                                                                     
  --extra-params       -x  Additional HapCut2 parameters, in quotes             
  --reference          -r  Path to reference genome if wanting to also extract  
                           reads spanning indels                                
  --min-map-quality    -q  Minimum mapping quality for phasing                  
                           [default=20]                                         
  --min-base-quality   -m  Minimum base quality for phasing                     
                           [default=13]                                         
  --molecule-distance  -d  Distance cutoff to split molecules (bp)              
                           [default=100000]                                     
  --prune-threshold    -p  PHRED-scale threshold (%) for pruning low-confidence 
                           SNPs (larger prunes more.)                           
                           [default=30]                                         
  --unlinked           -U  Treat input data as not linked reads                 
  --vcf-samples            Use samples present in vcf file for phasing rather   
                           than those found in the inputs                       
                                                                                
Workflow Options:                                                               
  --output-dir    -o  Output directory name                                     
                      [default=Phase]                                           
  --threads       -t  Number of threads to use                                  
                      [default=4]                                               
  --container         Use a container instead of conda                          
  --contigs           File or list of contigs to plot                           
  --hpc               HPC submission YAML configuration file                    
  --quiet             0 all output, 1 progress bar, 2 no output                 
  --skip-reports      Don't generate HTML reports                               
  --snakemake         Additional Snakemake parameters, in quotes                
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/phase
```


## harpy_qc

### Tool Description
FASTQ adapter removal, quality filtering, etc. Linked-read presence and type is auto-detected.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy qc [OPTIONS] INPUTS...                                             
                                                                                
FASTQ adapter removal, quality filtering, etc.                                  
Provide the input fastq files and/or directories at the end of the command as   
individual files/folders, using shell wildcards (e.g. data/acronotus*.fq), or   
both. Linked-read presence and type is auto-detected, but you may use -U to     
disable the parts of the workflow specific to linked-read data.                 
                                                                                
Standard trimming                                                               
                                                                                
 • a sliding window from front to tail                                          
 • poly-G tail removal                                                          
                                                                                
Optional quality checks                                                         
                                                                                
 • -a remove adapters                                                           
    • accepts auto for automatic detection or a FASTA file of adapters to remove
 • -d removes optical PCR duplicates                                            
    • recommended to skip at this step in favor of barcode-assisted             
      deduplication after alignment                                             
                                                                                
Parameters:                                                                     
  --deduplicate    -d  Identify and remove PCR duplicates                       
  --extra-params   -x  Additional Fastp parameters, in quotes                   
  --max-length     -M  Maximum length to trim sequences down to                 
                       [default=150]                                            
  --min-length     -m  Discard reads shorter than this length                   
                       [default=30]                                             
  --trim-adapters  -a  Detect and trim adapters                                 
  --unlinked       -U  Treat input data as not linked reads                     
                                                                                
Workflow Options:                                                               
  --output-dir    -o  Output directory name                                     
                      [default=QC]                                              
  --threads       -t  Number of threads to use                                  
                      [default=4]                                               
  --container         Use a container instead of conda                          
  --hpc               HPC submission YAML configuration file                    
  --quiet             0 all output, 1 progress bar, 2 no output                 
  --skip-reports      Don't generate HTML reports                               
  --snakemake         Additional Snakemake parameters, in quotes                
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/qc
```


## harpy_simulate

### Tool Description
Simulate genomic variants. The variant simulator (simuG) can only simulate one type of variant at a time, so you may need to run it a few times if you want multiple variant types.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy simulate COMMAND [ARGS]...                                         
                                                                                
Simulate genomic variants                                                       
To simulate genomic variants, provide an additional subcommand                  
{snpindel,inversion,cnv,translocation} to get more information about that       
workflow. The variant simulator (simuG) can only simulate one type of variant at
a time, so you may need to run it a few times if you want multiple variant      
types.                                                                          
                                                                                
Linked Read Sequences:                                                          
  linkedreads  Create linked reads using genome haplotypes                      
               [deprecated]                                                     
                                                                                
Genomic Variants:                                                               
  cnv            Introduce copy number variants into a genome                   
  inversion      Introduce inversions into a genome                             
  snpindel       Introduce snps and/or indels into a genome                     
  translocation  Introduce translocations into a genome
```


## harpy_snp

### Tool Description
Call SNPs and small indels from alignments. Provide an additional subcommand mpileup or freebayes to get more information on using those variant callers. They are both robust variant callers, but freebayes is recommended when ploidy is greater than 2.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy snp COMMAND [ARGS]...                                              
                                                                                
Call SNPs and small indels from alignments                                      
Provide an additional subcommand mpileup or freebayes to get more information on
using those variant callers. They are both robust variant callers, but freebayes
is recommended when ploidy is greater than 2.                                   
                                                                                
Commands:                                                                       
  freebayes  Call variants using freebayes                                      
  mpileup    Call variants from using bcftools mpileup
```


## harpy_sv

### Tool Description
Call inversions, deletions, and duplications from alignments using LEVIATHAN or NAIBR.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy sv [OPTIONS] COMMAND [ARGS]...                                     
                                                                                
Call inversions, deletions, and duplications from alignments                    
                                                                                
                                                                                
 caller     inversions  duplications  deletions  breakends                      
 ─────────────────────────────────────────────────────────                      
 leviathan      ✔            ✔            ✔          ✔                          
 naibr          ✔            ✔            ✔          🗙                          
                                                                                
                                                                                
Provide the subcommand leviathan or naibr to get more information on using those
variant callers. NAIBR tends to call variants better, but requires more user    
preprocessing.                                                                  
                                                                                
Commands:                                                                       
  leviathan  Call structural variants using LEVIATHAN                           
  naibr      Call structural variants using NAIBR
```


## harpy_convert

### Tool Description
Convert data formats using the harpy toolset

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: harpy convert [OPTIONS] COMMAND [ARGS]...                                
                                                                                
╭─ Usage Error ────────────────────────────────────────────────────────────────╮
│ No such option: -h                                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## harpy_deconvolve

### Tool Description
Resolve barcode sharing in unrelated molecules. Provide the input fastq files and/or directories at the end of the command.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy deconvolve [OPTIONS] INPUTS...                                     
                                                                                
Resolve barcode sharing in unrelated molecules                                  
Provide the input fastq files and/or directories at the end of the command as   
individual files/folders, using shell wildcards (e.g. data/acronotus*.fq), or   
both.                                                                           
                                                                                
The term "cloud" refers to the collection of all sequences that feature the same
barcode. By default, dropout is set to 0, meaning it will consider all barcodes,
even clouds with singleton.                                                     
                                                                                
Parameters:                                                                     
  --kmer-length  -k  Size of kmers                                              
                     [default=21]                                               
  --window-size  -w  Size of window guaranteed to contain at least one kmer     
                     [default=40]                                               
  --density      -d  On average, 1/2^d kmers are indexed                        
                     [default=3]                                                
  --dropout      -a  Minimum cloud size to deconvolve                           
                     [default=0]                                                
                                                                                
Workflow Options:                                                               
  --threads     -t  Number of threads to use                                    
                    [default=4]                                                 
  --output-dir  -o  Output directory name                                       
                    [default=Deconvolve]                                        
  --container       Use a container instead of conda                            
  --hpc             HPC submission YAML configuration file                      
  --quiet           0 all output, 1 progress bar, 2 no output                   
  --snakemake       Additional Snakemake parameters, in quotes                  
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/deconvolve
```


## harpy_downsample

### Tool Description
Downsample data using the harpy tool suite.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: harpy downsample [OPTIONS]                                               
                                                                                
╭─ Usage Error ────────────────────────────────────────────────────────────────╮
│ No such option: -h                                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## harpy_template

### Tool Description
Create files and HPC configs for workflows. All commands write to stdout.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy template [OPTIONS] COMMAND [ARGS]...                               
                                                                                
Create files and HPC configs for workflows                                      
All commands write to stdout. Use hpc-* and impute without arguments.           
                                                                                
Input Files:                                                                    
  groupings  Create a template sample-grouping file                             
  impute     Create a template imputation parameter file                        
                                                                                
HPC Configurations:                                                             
  hpc-generic      Create a template config for a generic scheduler             
  hpc-googlebatch  Create a template config for Google Batch                    
  hpc-lsf          Create a template config for LSF                             
  hpc-slurm        Create a template config for SLURM
```


## harpy_deps

### Tool Description
Locally install workflow dependencies. These commands are intended only for situations on HPCs where conda cannot be installed or the worker nodes do not have internet access to download conda/apptainer workflow dependencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy deps COMMAND [ARGS]...                                             
                                                                                
Locally install workflow dependencies                                           
These commands are intended only for situations on HPCs where conda cannot be   
installed or the worker nodes do not have internet access to download           
conda/apptainer workflow dependencies.                                          
                                                                                
Commands:                                                                       
  conda      Install workflow dependencies via conda                            
  container  Install workflow dependency container
```


## harpy_diagnose

### Tool Description
Diagnose issues within a harpy directory

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Using cached SIF image
Usage: harpy diagnose [OPTIONS] DIRECTORY                                       
                                                                                
╭─ Usage Error ────────────────────────────────────────────────────────────────╮
│ No such option: -h                                                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## harpy_resume

### Tool Description
Continue an incomplete Harpy workflow. Bypasses preprocessing steps and executes the Snakemake command present in the directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy resume [OPTIONS] DIRECTORY                                         
                                                                                
Continue an incomplete Harpy workflow                                           
In the event you need to run the Snakemake workflow present in a Harpy output   
directory (e.g. Align/bwa) without Harpy redoing validations and rewriting any  
of the configuration files, this command bypasses all the preprocessing steps of
Harpy workflows and executes the Snakemake command present in                   
directory/workflow/workflow.yaml. It will reuse an existing workflow/envs/      
folder to validate software dependencies, otherwise use --conda to create a     
populated one.                                                                  
                                                                                
The only requirements are:                                                      
                                                                                
 • the target directory has workflow/config.yaml present in it                  
 • the targest directory has workflow/envs/*.yaml present in it                 
                                                                                
Options:                                                                        
  --conda     -c  Recreate the conda environments                               
  --absolute  -a  Call Snakemake with absolute paths                            
  --threads   -t  Change the number of threads (>1)                             
  --quiet         0 all output, 1 progress bar, 2 no output                     
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/other
```


## harpy_validate

### Tool Description
File format checks for linked-read data. This is useful to make sure your input files are formatted correctly for the processing pipeline before you are surprised by errors hours into an analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy validate COMMAND [ARGS]...                                         
                                                                                
File format checks for linked-read data                                         
This is useful to make sure your input files are formatted correctly for the    
processing pipeline before you are surprised by errors hours into an analysis.  
Provide an additional command fastq or bam to see more information and options. 
                                                                                
Commands:                                                                       
  bam    Validate linked-read BAM file format                                   
  fastq  Validate linked-read FASTQ file format
```


## harpy_view

### Tool Description
View a workflow's components. These convenient commands let you view/edit the latest workflow log file, snakefile, snakemake parameter file, workflow config file in a directory that was used for the output of a Harpy run.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.1--pyhdfd78af_2
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy view COMMAND [ARGS]...                                             
                                                                                
View a workflow's components                                                    
These convenient commands let you view/edit the latest workflow log file,       
snakefile, snakemake parameter file, workflow config file in a directory that   
was used for the output of a Harpy run.                                         
                                                                                
Options:                                                                        
  --help  -h  Show this message and exit.                                       
                                                                                
Commands:                                                                       
  config        View/edit a workflow's config file                              
  environments  View the Snakemake-managed conda environments                   
  log           View a workflow's last log file                                 
  snakefile     View/edit a workflow's snakefile                                
  snakeparams   View/edit a workflow's snakemake configurations
```


## Metadata
- **Skill**: generated
