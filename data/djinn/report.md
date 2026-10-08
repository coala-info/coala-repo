# djinn CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| djinn_fastq_convert | PASS |  |
| djinn_fastq_extract | PASS |  |
| djinn_fastq_filter_invalid | PASS |  |
| djinn_fastq_filter_singletons | PASS |  |
| djinn_fastq_ncbi | PASS |  |
| djinn_fastq_sample | PASS |  |
| djinn_fastq_sort | Failed | tool bug: with paired-end input R2 is written to a file literally named '{prefix}.R2.fq.gz' (missing f-string in sort.py), so the R2 output is lost |
| djinn_fastq_spoof_hic | PASS |  |
| djinn_fastq_standardize | PASS |  |
| djinn_sam_assign_mi | PASS |  |
| djinn_sam_concat | PASS |  |
| djinn_sam_extract | PASS |  |
| djinn_sam_filter_invalid | PASS |  |
| djinn_sam_filter_singletons | PASS |  |
| djinn_sam_ncbi | PASS |  |
| djinn_sam_sample | PASS |  |
| djinn_sam_sort | PASS |  |
| djinn_sam_standardize | PASS |  |

## djinn_fastq_convert

### Tool Description
Convert between linked-read formats

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq convert [OPTIONS] PREFIX TARGET INPUT                        
                                                                                
Convert between linked-read formats                                             
Auto-detects the input data format and takes the positional argument TARGET     
specifying the target data format. 10X data as input requires a --barcodes file 
(often called a barcode whitelist) so djinn can identify the inline barcodes. In
all cases, a file will be created with the barcode conversion map.              
                                                                                
                                                                                
 from/to       barcode format                         example                   
 ────────────────────────────────────────────────────────────────────────────── 
 10x           the first N base pairs of R1, given                              
               --barcodes                                                       
 haplotagging  a BX:Z:ACBD SAM tag in the sequence    @SEQID BX:Z:A01C93B56D11  
               header                                                           
 stlfr         #1_2_3 format appended to the          @SEQID#1_2_3              
               sequence ID                                                      
 tellseq       :ATCG format appended to the sequence  @SEQID:GGCAAATATCGAGAAGTC 
               ID                                                               
                                                                                
                                                                                
Options:                                                                        
  --barcodes  -b  barcodes file [10x input only]                                
  --threads   -t  Number of compression threads to use for output files         
                  [default=4]                                                   
                                                                                
Documentation: https://pdimens.github.io/djinn/convert/
```


## djinn_fastq_extract

### Tool Description
Extract all barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq extract [OPTIONS] INPUT...                                   
                                                                                
Extract all barcodes                                                            
Inputs must be one or two FASTQ files (R1 and optional R2, can be gzipped).     
Input expect barcodes to follow the standard haplotagging (BX tag), stlfr       
(@seq_id#barcode), or tellseq (@seq_id:barcode) formats. Writes to stdout.      
                                                                                
Documentation: https://pdimens.github.io/djinn/extract
```


## djinn_fastq_filter_invalid

### Tool Description
Retain only valid-barcoded reads

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq filter-invalid [OPTIONS] PREFIX INPUT...                     
                                                                                
Retain only valid-barcoded reads                                                
Use --invalid to separately output reads with invalid barcodes. Barcodes can be 
in haplotagging, stlfr, or tellseq formats.                                     
                                                                                
Options:                                                                        
  --invalid  -i  Separately output records with invalid barcodes                
  --threads  -t  Number of compression threads to use for output files          
                 [default=4]                                                    
                                                                                
Documentation: https://pdimens.github.io/djinn/filter/
```


## djinn_fastq_filter_singletons

### Tool Description
Retain reads with non-singleton barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq filter-singletons [OPTIONS] PREFIX INPUT...                  
                                                                                
Retain reads with non-singleton barcodes                                        
Use --singletons to output reads with singleton barcodes into a separate        
file(s). This method also filters out invalid barcodes, since they are not      
considered linked. Expects barcode to be in haplotagging, stlfr, or tellseq     
formats. Specify --threads if pigz is available in your PATH (the value will be 
divided between the number of input files). Interleaved FASTQ files are not     
supported for paired-end data due to the way barcodes are counted.              
                                                                                
Options:                                                                        
  --singletons  -s  Separately output records with valid singleton barcodes     
  --threads     -t  Number of compression threads to use for output files       
                    [default=4]                                                 
                                                                                
Documentation: https://pdimens.github.io/djinn/filter/
```


## djinn_fastq_ncbi

### Tool Description
FASTQ → BAM conversion for NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq ncbi [OPTIONS] INPUT...                                      
                                                                                
FASTQ → BAM conversion for NCBI                                                 
The input FASTQ file(s) must have their barcode in an auxilary tag (e.g. BX:Z:),
otherwise you run the risk of NCBI removing any barcode information stored in   
the sequence header. If the barcodes are in default tellseq/stlfr format, use   
djinn fastq standardize to move the barcode into the BX tag. Writes to stdout.  
                                                                                
Options:                                                                        
  --threads  -t  Number of threads to use                                       
                 [default=4]                                                    
                                                                                
Documentation: https://pdimens.github.io/djinn/ncbi/
```


## djinn_fastq_sample

### Tool Description
Downsample data by barcode

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq sample [OPTIONS] PREFIX INPUT...                             
                                                                                
Downsample data by barcode                                                      
Downsamples a FASTQ file or file pair by barcode to keep all records containing 
-d randomly sampled barcodes. If d >= 1, the downsampling is a fixed number of  
barcodes, whereas d < 1 would indicate a fraction of the total number of        
barcodes (e.g. -d 0.5retains 50% of all barcodes). Use--invalid/-i` to specify  
if invalid barcodes should be included in downsampling. Inputs can be single-end
or paired-end reads and must be in haplotagging, stlfr, or tellseq formats.     
                                                                                
                                                                                
 --invalid  effect                                                              
 ──────────────────────────────────────────────────────────────                 
     0      removes all invalid barcodes from the sampling pool                 
     1      adds all invalid barcodes to the sampling pool                      
   0<i<1    keeps i proprotion of invalids in the sampling pool                 
                                                                                
                                                                                
Options:                                                                        
  --downsample   -d  Number/fraction of barcodes to retain                      
  --invalid      -i  Proportion of invalid barcodes to sample                   
                     [default=1]                                                
  --threads      -t  Number of compression threads to use for output files      
                     [default=4]                                                
  --random-seed      Random seed for sampling                                   
                                                                                
Documentation: https://pdimens.github.io/djinn/downsample
```


## djinn_fastq_sort

### Tool Description
Sort by barcode

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq sort [OPTIONS] SAM_tag output_prefix INPUT...                
                                                                                
Sort by barcode                                                                 
The barcode must be in a SAM tag (e.g. BX, BC) whether in FASTQ or SAM/BAM      
format.                                                                         
                                                                                
Options:                                                                        
  --threads  -t  Number of threads to use                                       
                 [default=10]                                                   
                                                                                
Documentation: https://pdimens.github.io/djinn/sort/
```


## djinn_fastq_spoof_hic

### Tool Description
Convert linked-reads into fake HI-C data

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq spoof-hic [OPTIONS] PREFIX INPUTS...                         
                                                                                
Convert linked-reads into fake HI-C data                                        
Reads with the same barcode will have their forward reads paired with up to -m  
random reverse reads to mimic the long-range data captured with HI-C. A large -m
value may significantly increase output file size. The resulting fastq files    
will be in TELLseq-ish format (original barcode appended to sequence ID). See   
the documentation for more details.                                             
                                                                                
Input FASTQ pair must be sorted by barcode and properly paired                  
                                                                                
Options:                                                                        
  --invalid     -i  Include invalid barcodes in the output                      
  --singletons  -s  Include singleton barcodes in the output                    
  --max-pairs   -m  Maximum number of R2 reads per R1 per barcode               
                    [default=1]                                                 
  --threads     -t  Number of compression threads to use for output files       
                    [default=4]                                                 
  --help            Show this message and exit.                                 
                                                                                
Documentation: https://pdimens.github.io/djinn/ncbi/
```


## djinn_fastq_standardize

### Tool Description
Move barcodes to BX+VX sequence header tags

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn fastq standardize [OPTIONS] output_prefix INPUT...                 
                                                                                
Move barcodes to BX+VX sequence header tags                                     
This conversion moves the barcode to the BX:Z tag in fastq records, maintaining 
the same barcode type by default (auto-detected). See the documentation for a   
deeper look into the location and format expectations for different linked-read 
technologies. Also writes a VX:i tag to describe barcode validation 0 (invalid) 
or 1 (valid). Use djinn fastq convert if your fastq data is in 10X format, as   
this command will not work on 10X format (i.e. barcode is the first 16 bases of 
read 1). Use --style to also convert the barcode to a different style           
(haplotagging, stlfr, tellseq, 10X).                                            
                                                                                
                                                                                
 Option        Style                                                            
 ──────────────────────────────────────────────────────────                     
 haplotagging  AxxCxxBxxDxx                                                     
 stlfr         1_2_3                                                            
 tellseq       18-base nucleotide (e.g. AGCCATGTACGTATGGTA)                     
 10X           16-base nucleotide (e.g. GGCTGAACACGTGCAG)                       
                                                                                
                                                                                
Options:                                                                        
  --style    -s  Change the barcode style                                       
  --threads  -t  Number of compression threads to use for output files          
                 [default=4]                                                    
                                                                                
Documentation: https://pdimens.github.io/djinn/standardize/#fastq
```


## djinn_sam_assign_mi

### Tool Description
Assign an MI:i (Molecular Identifier) tags

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam assign-mi [OPTIONS] INPUT                                      
                                                                                
Assign an MI:i (Molecular Identifier) tags                                      
Using a distance cutoff, assign barcoded alignments to unique molecules (default
= 0). Unmapped records are discarded in the output unless --keep-unmapped is    
used. Records without a BX:Z tag or with an invalid barcode (based on VX tag)   
are preserved but are not assigned an MI:i tag. Input file must be in standard  
format (BX and VX tags) and must be coordinate sorted (such as with samtools    
sort).                                                                          
                                                                                
Options:                                                                        
  --cutoff         -c  Distance in base pairs at which alignments with the same 
                       barcode should be considered different molecules. If 0,  
                       then alignment distance is ignored.                      
                       [default=0]                                              
  --keep-unmapped  -u  Keep unmapped records                                    
  --sam            -S  Output as SAM instead of BAM                             
                                                                                
Documentation: https://pdimens.github.io/djinn/assign_mi
```


## djinn_sam_concat

### Tool Description
Molecule-aware file concatenation

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam concat [OPTIONS] INPUT...                                      
                                                                                
Molecule-aware file concatenation                                               
Concatenate records from linked-read SAM/BAM files while making sure molecule   
identification tags (MI or BX) remain unique for every sample. This is a means  
of accomplishing the same as 'samtools cat', except all MI/BX tags are updated  
so individuals don't have overlapping tags (which would mess up all the         
linked-read info). The default ignores existing MI tags and writes new ones that
correspond to unique BX tags. Using --mi is the opposite, where it ignores      
existing BX tags and writes new ones that correspond with the MI tags in the    
barcode style of your choice.                                                   
                                                                                
Options:                                                                        
  --mi       MI tag is the primary molecule identifier and write new barcodes   
             in this format [haplotagging, stlfr, tellseq]                      
  --sam  -S  Output as SAM instead of BAM                                       
                                                                                
Documentation: https://pdimens.github.io/djinn/concat
```


## djinn_sam_extract

### Tool Description
Extract all barcodes

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam extract [OPTIONS] INPUT                                        
                                                                                
Extract all barcodes                                                            
Inputs must be one SAM/BAM file or two FASTQ files (R1 and R2, can be gzipped). 
Both FASTQ and SAM/BAM inputs expect barcodes to follow the standard            
haplotagging (BX tag), stlfr (@seq_id#barcode), or tellseq (@seq_id:barcode)    
formats.  Writes to stdout.                                                     
                                                                                
Documentation: https://pdimens.github.io/djinn/extract
```


## djinn_sam_filter_invalid

### Tool Description
Retain only valid-barcoded reads

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam filter-invalid [OPTIONS] INPUT                                 
                                                                                
Retain only valid-barcoded reads                                                
Use --invalid to separately output reads with invalid barcodes. Barcode must be 
in BX:Z SAM tag. Writes to stdout.                                              
                                                                                
Options:                                                                        
  --invalid  -i  Output records with invalid barcodes to this file              
  --sam      -S  Output as SAM instead of BAM                                   
  --threads  -t  Number of threads to use                                       
                 [default=4]                                                    
                                                                                
Documentation: https://pdimens.github.io/djinn/filter/
```


## djinn_sam_filter_singletons

### Tool Description
Retain only non-singleton reads

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam filter-singletons [OPTIONS] INPUT                              
                                                                                
Retain only non-singleton reads                                                 
This method also filters out invalid barcodes, since they are not considered    
linked. Barcode must be in BX:Z SAM tag. Use --singletons to optionally output  
reads with singleton barcodes into a separate BAM file whose name is provided   
for this option. Writes to stdout.                                              
                                                                                
Options:                                                                        
  --singletons  -s  Print valid singleton records to this file                  
  --sam         -S  Output as SAM instead of BAM                                
                                                                                
Documentation: https://pdimens.github.io/djinn/filter/
```


## djinn_sam_ncbi

### Tool Description
BAM → FASTQ conversion from NCBI

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam ncbi [OPTIONS] PREFIX INPUT                                    
                                                                                
BAM → FASTQ conversion from NCBI                                                
Converts an unmapped SAM/BAM file to FASTQ sequences, losslessly, preserving    
barcode tags.                                                                   
                                                                                
Options:                                                                        
  --threads  -t  Number of threads to use                                       
                 [default=10]                                                   
                                                                                
Documentation: https://pdimens.github.io/djinn/ncbi/
```


## djinn_sam_sample

### Tool Description
Downsample data by barcode

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam sample [OPTIONS] INPUT                                         
                                                                                
Downsample data by barcode                                                      
Downsamples a SAM/BAM file by barcode to keep all records containing -d randomly
sampled barcodes. If d >= 1, the downsampling is a fixed number of barcodes,    
whereas d < 1 would indicate a fraction of the total number of barcodes (e.g. -d
0.5retains 50% of all barcodes). Use--invalid/-ito specify if invalid barcodes  
should be included in downsampling. Barcode must be inBX:Z` SAM tag. Writes to  
stdout.                                                                         
                                                                                
                                                                                
 --invalid  effect                                                              
 ──────────────────────────────────────────────────────────────                 
     0      removes all invalid barcodes from the sampling pool                 
     1      adds all invalid barcodes to the sampling pool                      
   0<i<1    keeps i proprotion of invalids in the sampling pool                 
                                                                                
                                                                                
Options:                                                                        
  --downsample   -d  Number/fraction of barcodes to retain                      
  --invalid      -i  Proportion of invalid barcodes to sample                   
                     [default=0]                                                
  --random-seed      Random seed for sampling                                   
  --sam          -S  Output as SAM instead of BAM                               
  --threads      -t  Number of threads to use                                   
                     [default=10]                                               
                                                                                
Documentation: https://pdimens.github.io/djinn/downsample
```


## djinn_sam_sort

### Tool Description
Sort by barcode

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam sort [OPTIONS] SAM_tag INPUT                                   
                                                                                
Sort by barcode                                                                 
The barcode must be in a SAM tag (e.g. BX, BC).                                 
                                                                                
Options:                                                                        
  --threads  -t  Number of threads to use                                       
                 [default=10]                                                   
  --sam      -S  Output as SAM instead of BAM                                   
                                                                                
Documentation: https://pdimens.github.io/djinn/sort/
```


## djinn_sam_standardize

### Tool Description
Move barcodes to BX+VX sequence header tags

### Metadata
- **Docker Image**: quay.io/biocontainers/djinn:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/pdimens/djinn
- **Package**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Validation**: PASS
- **Conda**: https://anaconda.org/channels/bioconda/packages/djinn/overview
- **Total Downloads**: 282
- **Last updated**: 2026-02-19
- **GitHub**: https://github.com/pdimens/djinn
- **Stars**: N/A

### Original Help Text
```text
Usage: djinn sam standardize [OPTIONS] INPUT                                    
                                                                                
Move barcodes to BX+VX sequence header tags                                     
This conversion moves the barcode to the BX:Z tag in sam/bam records,           
maintaining the same barcode type by default (auto-detected). See the           
documentation for a deeper look into the location and format expectations for   
different linked-read technologies. Also writes a VX:i tag to describe barcode  
validation 0 (invalid) or 1 (valid). Use --style to also convert the barcode to 
a different style (haplotagging, stlfr, tellseq, 10X).                          
                                                                                
                                                                                
 Option        Style                                                            
 ──────────────────────────────────────────────────────────                     
 haplotagging  AxxCxxBxxDxx                                                     
 stlfr         1_2_3                                                            
 tellseq       18-base nucleotide (e.g. AGCCATGTACGTATGGTA)                     
 10X           16-base nucleotide (e.g. GGCTGAACACGTGCAG)                       
                                                                                
                                                                                
Options:                                                                        
  --style  -s  Change the barcode style                                         
  --sam    -S  Output as SAM instead of BAM                                     
  --help       Show this message and exit.                                      
                                                                                
Documentation: https://pdimens.github.io/djinn/standardize/#fastq
```


## Metadata
- **Skill**: generated
