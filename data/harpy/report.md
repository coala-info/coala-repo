# harpy CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| harpy_assembly | Not completed | pipeline, skipped |
| harpy_deconvolve | Not completed | pipeline, skipped |
| harpy_impute | Not completed | pipeline, skipped |
| harpy_metassembly | Not completed | pipeline, skipped |
| harpy_phase | Not completed | pipeline, skipped |
| harpy_qc | Not completed | pipeline, skipped |
| harpy_resume | Not completed | pipeline, skipped |
| harpy_template_groupings | PASS |  |
| harpy_template_hpc_generic | PASS |  |
| harpy_template_hpc_googlebatch | PASS |  |
| harpy_template_hpc_lsf | PASS |  |
| harpy_template_hpc_slurm | PASS |  |
| harpy_template_impute | PASS |  |

## harpy_assembly

### Tool Description
Assemble linked reads into a genome. The linked-read barcodes must be in BX:Z or BC:Z FASTQ header tags. It is strongly recommended to first deconvolve the input FASTQ files with harpy deconvolve.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
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

## harpy_impute

### Tool Description
Impute variant genotypes from alignments. Provide the parameter file followed by the input VCF and the input alignment files/directories (.bam) at the end of the command.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
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
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
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
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
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
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
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

## harpy_deconvolve

### Tool Description
Resolve barcode sharing in unrelated molecules. Provide the input fastq files and/or directories at the end of the command.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
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

## harpy_resume

### Tool Description
Continue an incomplete Harpy workflow by bypassing preprocessing steps and executing the Snakemake command present in the target directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
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
directory/workflow/workflow.yaml.                                               
                                                                                
The only requirements are:                                                      
                                                                                
 • the target directory has workflow/config.yaml present in it                  
 • the target directory has workflow/workflow.yaml present in it                
 • the targest directory has workflow/envs/*.yaml present in it (if using conda)
                                                                                
Options:                                                                        
  --absolute  -a  Call Snakemake with absolute paths                            
  --direct    -d  Call Snakemake directly without Harpy intervention            
  --threads   -t  Change the number of threads (>1)                             
  --quiet         0 all output, 1 progress bar, 2 no output                     
                                                                                
Documentation: https://pdimens.github.io/harpy/workflows/other
```

## harpy_template_groupings

### Tool Description
Create a template sample-grouping file from a directory of FASTQ or BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: harpy template groupings [OPTIONS] INPUTDIR

Create a template sample-grouping file
This command generates a sample grouping file, like the kind optional for
variant calling. Provide the input fastq/bam directory at the end of the
command. Writes to stdout. Note that Harpy cannot reliably infer populations
from filenames, therefore all samples will be assigned to pop1. Please modify
this file with appropriate population designations.

Documentation:
https://pdimens.github.io/harpy/workflows/snp/#sample-grouping-file
```

## harpy_template_impute

### Tool Description
Create a template STITCH imputation parameter file.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
╭─ Notice ────────────────────────────────────────────────────────────────╮
│ Modify the model parameters as needed, but do not add/remove columns.   │
╰─────────────────────────────────────────────────────────────────────────╯
name	model	usebx	bxlimit	k	s	ngen
k10_ng50	diploid	TRUE	50000	10	1	50
k1_ng30	diploid	TRUE	50000	5	1	30
high_ngen	diploid	TRUE	50000	15	1	100
```

## harpy_template_hpc_generic

### Tool Description
Create a template Snakemake profile for a generic HPC scheduler.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
╭─ Notice ────────────────────────────────────────────────────────────────╮
│ Using this scheduler requires installing a Snakemake plugin which       │
│ wasn't detected in this environment. It can be installed with:          │
│                                                                         │
│                                                                         │
│  conda install -c bioconda snakemake-executor-plugin-cluster-generic    │
│                                                                         │
╰─────────────────────────────────────────────────────────────────────────╯
__use_yte__: true
executor: cluster-generic
default-resources:
  mem_mb: attempt * 3200
```

## harpy_template_hpc_googlebatch

### Tool Description
Create a template Snakemake profile for Google Batch.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
__use_yte__: true
executor: googlebatch
jobs: 50
latency-wait: 45
retries: 1
default-resources:
## YOU MAY NOT NEED ALL OF THESE! ##
# The name of the Google Project
  googlebatch_project: Harpy

# The name of the Google Project region (e.g., 'us-central1')
  googlebatch_region: 'us-central1'
```

## harpy_template_hpc_lsf

### Tool Description
Create a template Snakemake profile for LSF.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
__use_yte__: true
executor: lsf
default-resources:
  lsf_queue:
  walltime: 60 # minutes per job
  mem_mb: attempt * 2000
  # other args to pass to bsub
  lsf_extra: VALUE
jobs: 50
latency-wait: 60
retries: 1
```

## harpy_template_hpc_slurm

### Tool Description
Create a template Snakemake profile for SLURM.

### Metadata
- **Docker Image**: quay.io/biocontainers/harpy:3.2--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/harpy/
- **Package**: https://anaconda.org/channels/bioconda/packages/harpy/overview
- **Validation**: PASS

### Original Help Text
```text
╭─ Notice ────────────────────────────────────────────────────────────────╮
│ Using this scheduler requires installing a Snakemake plugin which       │
│ wasn't detected in this environment. It can be installed with:          │
│                                                                         │
│                                                                         │
│  conda install -c bioconda snakemake-executor-plugin-slurm              │
│                                                                         │
╰─────────────────────────────────────────────────────────────────────────╯
__use_yte__: true
executor: slurm
default-resources:
  slurm_account: $USER
```

## Metadata
- **Skill**: generated
