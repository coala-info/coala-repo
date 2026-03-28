# votuderep CWL Generation Report

## votuderep_derep

### Tool Description
Dereplicate vOTUs using BLAST and ANI clustering.
This command: 1. Creates a BLAST database from input sequences 2. Performs
all-vs-all BLAST comparison 3. Calculates ANI and coverage for sequence pairs
4. Clusters sequences by ANI using greedy algorithm 5. Outputs cluster
representatives (longest sequences)
The algorithm selects the longest sequence from each cluster as the
representative, effectively removing shorter redundant sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/votuderep
- **Package**: https://anaconda.org/channels/bioconda/packages/votuderep/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/votuderep/overview
- **Total Downloads**: 235
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/quadram-institute-bioscience/votuderep
- **Stars**: N/A
### Original Help Text
```text
Usage: votuderep derep [OPTIONS]                                               
                                                                                
 Dereplicate vOTUs using BLAST and ANI clustering.                              
 This command: 1. Creates a BLAST database from input sequences 2. Performs     
 all-vs-all BLAST comparison 3. Calculates ANI and coverage for sequence pairs  
 4. Clusters sequences by ANI using greedy algorithm 5. Outputs cluster         
 representatives (longest sequences)                                            
 The algorithm selects the longest sequence from each cluster as the            
 representative, effectively removing shorter redundant sequences.              
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --input     -i  FILE     Input FASTA file containing vOTUs [required]     │
│    --output    -o  FILE     Output FASTA file with dereplicated vOTUs        │
│    --threads   -t  INTEGER  Number of threads for BLAST                      │
│    --tmp           TEXT     Directory for temporary files (default: $TEMP or │
│                             /tmp or ./)                                      │
│    --min-ani       FLOAT    Minimum ANI to consider two vOTUs as the same    │
│    --min-tcov      FLOAT    Minimum target coverage to consider two vOTUs as │
│                             the same                                         │
│    --keep                   Keep the temporary directory after completion    │
│    --help      -h           Show this message and exit.                      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## votuderep_filter

### Tool Description
Filter FASTA file using CheckV quality metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/votuderep
- **Package**: https://anaconda.org/channels/bioconda/packages/votuderep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: votuderep filter [OPTIONS] FASTA CHECKV_OUT                             
                                                                                
 Filter FASTA file using CheckV quality metrics.                                
 FASTA: Input FASTA file with viral contigs                                     
 CHECKV_OUT: TSV output file from CheckV                                        
                                                                                
                                                                                
 This command filters viral contigs based on various quality metrics from       
 CheckV, including sequence length, completeness, contamination, and quality    
 classification.                                                                
 Quality levels (hierarchical):                                                 
 • Complete: Highest quality, complete genomes                                  
 • High-quality: High confidence viral sequences                                
 • Medium-quality: Moderate confidence sequences                                
 • Low-quality: Lower confidence but valid sequences                            
 • Not-determined: Quality could not be determined                              
                                                                                
                                                                                
 The --min-quality option filters inclusively:                                  
 • low: Keeps Low-quality and above (default)                                   
 • medium: Keeps Medium-quality and above                                       
 • high: Keeps High-quality and above (including Complete)                      
                                                                                
                                                                                
 Not-determined sequences are included by default unless --exclude-undetermined 
 is used.                                                                       
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  FASTA                       FILE               [required]                 │
│ *  CHECKV_OUT                  FILE               [required]                 │
│    --output                -o  FILE               Output FASTA file          │
│                                                   (default: STDOUT)          │
│    --min-len               -m  INTEGER            Minimum contig length      │
│    --max-len                   INTEGER            Maximum contig length (0 = │
│                                                   unlimited)                 │
│    --provirus                                     Only select proviruses     │
│                                                   (provirus == 'Yes')        │
│    --min-completeness      -c  FLOAT              Minimum completeness       │
│                                                   percentage                 │
│    --max-contam                FLOAT              Maximum contamination      │
│                                                   percentage                 │
│    --no-warnings                                  Only keep contigs with no  │
│                                                   warnings                   │
│    --exclude-undetermined                         Exclude contigs with       │
│                                                   checkv_quality ==          │
│                                                   'Not-determined'           │
│    --complete                                     Only keep contigs with     │
│                                                   checkv_quality ==          │
│                                                   'Complete'                 │
│    --min-quality               [low|medium|high]  Minimum quality level: low │
│                                                   (includes                  │
│                                                   Low/Medium/High/Complete), │
│                                                   medium                     │
│                                                   (Medium/High/Complete), or │
│                                                   high (High/Complete)       │
│    --help                  -h                     Show this message and      │
│                                                   exit.                      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## votuderep_getdbs

### Tool Description
Download geNomad, CheckV, and PHROGs databases.
Downloads and extracts viral classification and quality control databases
required for viral metagenomics analysis.
The command is resumable: if interrupted, it will skip already downloaded and
extracted files when re-run.

### Metadata
- **Docker Image**: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/votuderep
- **Package**: https://anaconda.org/channels/bioconda/packages/votuderep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: votuderep getdbs [OPTIONS]                                              
                                                                                
 Download geNomad, CheckV, and PHROGs databases.                                
 Downloads and extracts viral classification and quality control databases      
 required for viral metagenomics analysis.                                      
 The command is resumable: if interrupted, it will skip already downloaded and  
 extracted files when re-run.                                                   
 Available databases:                                                           
   genomad_1.9  - geNomad viral identification database                         
   checkv_1.5   - CheckV viral quality control database                         
   phrogs_4     - PHROGs viral protein families database                        
   all          - Download all databases (default)                              
                                                                                
                                                                                
 Examples:                                                                      
   votuderep getdbs --outdir ~/databases                                        
   votuderep getdbs -o ./db --db genomad_1.9 --db checkv_1.5                    
   votuderep getdbs -o ./db --db genomad_1.9,checkv_1.5                         
   votuderep getdbs -o ./db --db all                                            
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --outdir  -o  PATH  Directory where to download and extract databases     │
│                        [required]                                            │
│    --force             Allow using a non-empty output directory              │
│    --db          TEXT  Database(s) to download: genomad_1.9, checkv_1.5,     │
│                        phrogs_4, or all (default: all). Can be repeated or   │
│                        comma-separated.                                      │
│    --help    -h        Show this message and exit.                           │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## votuderep_splitcoverm

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/votuderep
- **Package**: https://anaconda.org/channels/bioconda/packages/votuderep/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: votuderep splitcoverm [OPTIONS]                                         
                                                                                
 Try running the '--help' flag for more information.                            
╭─ Error ──────────────────────────────────────────────────────────────────────╮
│ No such option: --h Did you mean --help?                                     │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## votuderep_tabulate

### Tool Description
Generate CSV file from a directory containing sequencing reads. Scans INPUT_DIR for paired-end sequencing reads and generates a CSV table mapping sample names to their R1 and R2 file paths. The command identifies read pairs by looking for forward/reverse tags in filenames, extracts sample names, and outputs a table suitable for downstream analysis tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/votuderep
- **Package**: https://anaconda.org/channels/bioconda/packages/votuderep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: votuderep tabulate [OPTIONS] INPUT_DIR                                  
                                                                                
 Generate CSV file from a directory containing sequencing reads.                
 Scans INPUT_DIR for paired-end sequencing reads and generates a CSV table      
 mapping sample names to their R1 and R2 file paths.                            
 The command identifies read pairs by looking for forward/reverse tags in       
 filenames, extracts sample names, and outputs a table suitable for downstream  
 analysis tools.                                                                
 Example:                                                                       
   votuderep tabulate reads/ -o samples.csv                                     
   votuderep tabulate reads/ --for-tag _1 --rev-tag _2 --extension .fq.gz       
   votuderep tabulate reads/ --strip "Sample_" --strip ".filtered" -a           
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  INPUT_DIR        DIRECTORY  [required]                                    │
│    --output     -o  FILE       Output CSV file (default: STDOUT)             │
│    --delimiter  -d  TEXT       Field separator [default: ,]                  │
│    --for-tag    -1  TEXT       Identifier for forward reads [default: _R1]   │
│    --rev-tag    -2  TEXT       Identifier for reverse reads [default: _R2]   │
│    --strip      -s  TEXT       Remove this string from sample names (can be  │
│                                used multiple times)                          │
│    --extension  -e  TEXT       Only process files ending with this extension │
│    --absolute   -a             Use absolute paths in output                  │
│    --help       -h             Show this message and exit.                   │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## votuderep_trainingdata

### Tool Description
Download training dataset from the internet. Uses a registry (DATASETS) of named datasets, each containing a set of {url, path} items. Adds new datasets by extending the DATASETS dict.

### Metadata
- **Docker Image**: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
- **Homepage**: https://github.com/quadram-institute-bioscience/votuderep
- **Package**: https://anaconda.org/channels/bioconda/packages/votuderep/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: votuderep trainingdata [OPTIONS]                                        
                                                                                
 Download training dataset from the internet.                                   
 Uses a registry (DATASETS) of named datasets, each containing a set of {url,   
 path} items. Adds new datasets by extending the DATASETS dict.                 
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --outdir  -o  TEXT  Where to put the output files [default: ./ebame-virome/] │
│ --name    -n  TEXT  Dataset name to download (registered in DATASETS)        │
│                     [default: virome]                                        │
│ --help    -h        Show this message and exit.                              │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
