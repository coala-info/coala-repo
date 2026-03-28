# phu CWL Generation Report

## phu_cluster

### Tool Description
Sequence clustering wrapper around external 'vclust' with three modes.

### Metadata
- **Docker Image**: quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/camilogarciabotero/phu
- **Package**: https://anaconda.org/channels/bioconda/packages/phu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/phu/overview
- **Total Downloads**: 399
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/camilogarciabotero/phu
- **Stars**: N/A
### Original Help Text
```text
Usage: phu cluster [OPTIONS]                                                   
                                                                                
 Sequence clustering wrapper around external 'vclust' with three modes.         
                                                                                
 For advanced usage, provide custom vclust parameters as a quoted string.       
 See the vclust wiki for parameter details:                                     
 https://github.com/refresh-bio/vclust/wiki                                     
                                                                                
 Example:                                                                       
     phu cluster --mode votu --input-contigs genomes.fna                        
 --vclust-params="--min-kmers 20 --outfmt lite"                                 
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --mode                   [dereplication|votu|sp  dereplication | votu |   │
│                             ecies]                  species                  │
│                                                     [required]               │
│ *  --input-contigs          PATH                    Input FASTA [required]   │
│    --output-folder          PATH                    Output directory         │
│                                                     [default:                │
│                                                     clustered-contigs]       │
│    --threads        -t      INTEGER RANGE [x>=0]    0=all cores; otherwise N │
│                                                     threads                  │
│                                                     [default: 0]             │
│    --vclust-params          TEXT                    Custom vclust            │
│                                                     parameters: "--min-kmers │
│                                                     20 --outfmt lite --ani   │
│                                                     0.97"                    │
│    --help           -h                              Show this message and    │
│                                                     exit.                    │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## phu_simplify-taxa

### Tool Description
Simplify vContact taxonomy prediction columns into compact lineage codes.

### Metadata
- **Docker Image**: quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/camilogarciabotero/phu
- **Package**: https://anaconda.org/channels/bioconda/packages/phu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phu simplify-taxa [OPTIONS]                                             
                                                                                
 Simplify vContact taxonomy prediction columns into compact lineage codes.      
                                                                                
 Transforms verbose vContact taxonomy strings like                              
 'novel_genus_1_of_novel_family_2_of_Caudoviricetes'                            
 into compact codes like 'Caudoviricetes:NF2:NG1'.                              
                                                                                
 Example:                                                                       
     phu simplify-taxa -i final_assignments.csv -o simplified.csv --add-lineage 
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-file   -i      PATH  Input vContact final_assignments.csv         │
│                                 [required]                                   │
│ *  --output-file  -o      PATH  Output file path (.csv or .tsv) [required]   │
│    --add-lineage                Append compact_lineage column from deepest   │
│                                 simplified rank                              │
│    --lineage-col          TEXT  Name of the lineage column                   │
│                                 [default: compact_lineage]                   │
│    --sep                  TEXT  Override delimiter: ',' or '\t'.             │
│                                 Auto-detected from extension if not set      │
│    --help         -h            Show this message and exit.                  │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## phu_screen

### Tool Description
Screen contigs for protein families using HMMER on predicted CDS.

### Metadata
- **Docker Image**: quay.io/biocontainers/phu:0.4.4--pyhdfd78af_0
- **Homepage**: https://github.com/camilogarciabotero/phu
- **Package**: https://anaconda.org/channels/bioconda/packages/phu/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: phu screen [OPTIONS] HMMS...                                            
                                                                                
 Screen contigs for protein families using HMMER on predicted CDS.              
                                                                                
 Supports multiple HMM files with different combination modes:                  
 - any: Keep contigs matching any HMM (default, most permissive)                
 - all: Keep contigs matching all HMMs (most restrictive)                       
 - threshold: Keep contigs matching at least --min-hmm-hits HMMs                
                                                                                
 HMM modes:                                                                     
 - pure: Each HMM file contains one model (default, most common)                
 - mixed: HMM files contain multiple models (pressed/concatenated HMMs)         
                                                                                
 Examples:                                                                      
     phu screen -i contigs.fa *.hmm                                             
     phu screen -i contigs.fa --combine-mode all file1.hmm file2.hmm file3.hmm  
     phu screen -i contigs.fa --combine-mode threshold --min-hmm-hits 5         
 pfam_database.hmm                                                              
     phu screen -i contigs.fa --save-target-proteins *.hmm                      
                                                                                
╭─ Arguments ──────────────────────────────────────────────────────────────────╮
│ *    hmms      HMMS...  HMM files (supports wildcards like *.hmm) [required] │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input-contigs  -i                     PATH             Input contigs    │
│                                                             FASTA            │
│                                                             [required]       │
│    --output-folder  -o                     PATH             Output directory │
│                                                             [default:        │
│                                                             phu-screen]      │
│    --mode                                  TEXT             pyrodigal mode:  │
│                                                             meta|single      │
│                                                             [default: meta]  │
│    --threads        -t                     INTEGER RANGE    Threads for both │
│                                            [x>=1]           pyrodigal and    │
│                                                             hmmsearch        │
│                                                             [default: 1]     │
│    --min-bitscore                          FLOAT            Minimum bitscore │
│                                                             to keep a domain │
│                                                             hit              │
│    --max-evalue                            FLOAT            Maximum          │
│                                                             independent      │
│                                                             E-value to keep  │
│                                                             a domain hit     │
│                                                             [default: 1e-05] │
│    --top-per-cont…                         INTEGER          Keep top-N hits  │
│                                                             per contig (by   │
│                                                             bitscore)        │
│                                                             [default: 1]     │
│    --min-gene-len                          INTEGER          Minimum gene     │
│                                                             length for       │
│                                                             pyrodigal (nt)   │
│                                                             [default: 90]    │
│    --ttable                                INTEGER          NCBI translation │
│                                                             table for coding │
│                                                             sequences        │
│                                                             [default: 11]    │
│    --keep-proteins      --no-keep-prot…                     Keep the protein │
│                                                             FASTA used for   │
│                                                             searching        │
│                                                             [default:        │
│                                                             no-keep-protein… │
│    --keep-domtbl        --no-keep-domt…                     Keep raw         │
│                                                             domtblout from   │
│                                                             hmmsearch        │
│                                                             [default:        │
│                                                             keep-domtbl]     │
│    --combine-mode                          TEXT             How to combine   │
│                                                             hits from        │
│                                                             multiple HMMs:   │
│                                                             any|all|thresho… │
│                                                             [default: any]   │
│    --min-hmm-hits                          INTEGER          Minimum number   │
│                                                             of HMMs that     │
│                                                             must hit a       │
│                                                             contig (for      │
│                                                             threshold mode)  │
│                                                             [default: 1]     │
│    --save-target-…      --no-save-targ…                     Save matched     │
│                                                             proteins per HMM │
│                                                             model in         │
│                                                             target_proteins/ │
│                                                             subfolder        │
│                                                             [default:        │
│                                                             no-save-target-… │
│    --save-target-…      --no-save-targ…                     Save HMMs built  │
│                                                             from target      │
│                                                             proteins in      │
│                                                             target_hmms/     │
│                                                             subfolder        │
│                                                             [default:        │
│                                                             no-save-target-… │
│    --hmm-mode                              TEXT             HMM file type:   │
│                                                             'pure' (one      │
│                                                             model per file)  │
│                                                             or 'mixed'       │
│                                                             (pressed/concat… │
│                                                             HMMs)            │
│                                                             [default: pure]  │
│    --help           -h                                      Show this        │
│                                                             message and      │
│                                                             exit.            │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
