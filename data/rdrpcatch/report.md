# rdrpcatch CWL Generation Report

## rdrpcatch_databases

### Tool Description
Download & update RdRpCATCH databases. If databases are already installed in the specified directory, it will check for updates and download the latest version if available.

### Metadata
- **Docker Image**: quay.io/biocontainers/rdrpcatch:1.0.1.post1--pyhdfd78af_0
- **Homepage**: https://github.com/dimitris-karapliafis/RdRpCATCH
- **Package**: https://anaconda.org/channels/bioconda/packages/rdrpcatch/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rdrpcatch/overview
- **Total Downloads**: 2.0K
- **Last updated**: 2026-02-16
- **GitHub**: https://github.com/dimitris-karapliafis/RdRpCATCH
- **Stars**: N/A
### Original Help Text
```text
Usage: rdrpcatch databases [OPTIONS]                                           
                                                                                
 Download &  update RdRpCATCH databases. If databases are already installed in  
 the specified directory, it will check for updates and download the latest     
 version if available.                                                          
                                                                                
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ *  --destination-dir  -dest  DIRECTORY  Path to directory to download        │
│                                         databases                            │
│                                         [required]                           │
│    --concept-doi             TEXT       Zenodo Concept DOI for database      │
│                                         repository                           │
│    --add-custom-db    -cdb   PATH       Path to a custom, pressed pHMM       │
│                                         database directory. This only        │
│                                         worksif the supported  databases     │
│                                         have already been downloaded. Please │
│                                         point to the directory the databases │
│                                         are stored ('rdrpcatch_dbs')         │
│                                         usingthe '--destination-dir' flag.   │
│    --help                               Show this message and exit.          │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## rdrpcatch_scan

### Tool Description
Scan sequences for RdRps.

### Metadata
- **Docker Image**: quay.io/biocontainers/rdrpcatch:1.0.1.post1--pyhdfd78af_0
- **Homepage**: https://github.com/dimitris-karapliafis/RdRpCATCH
- **Package**: https://anaconda.org/channels/bioconda/packages/rdrpcatch/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: rdrpcatch scan [OPTIONS]                                                
                                                                                
 Scan sequences for RdRps.                                                      
                                                                                
╭─ Input & output options ─────────────────────────────────────────────────────╮
│ *  --input            -i           FILE        Path to the input FASTA file. │
│                                                [required]                    │
│ *  --output           -o           DIRECTORY   Path to the output directory. │
│                                                [required]                    │
│ *  --db-dir           -db-dir      PATH        Path to the directory         │
│                                                containing RdRpCATCH          │
│                                                databases.                    │
│                                                [required]                    │
│    --seq-type         -seq-type    [prot|nuc]  Type of sequence to search    │
│                                                against: (prot,nuc). If       │
│                                                omitted, type will be         │
│                                                auto-detected.                │
│    --gen-code         -gen-code    INTEGER     Genetic code to use for       │
│                                                translation. (default: 1)     │
│                                                Possible genetic codes        │
│                                                (supported by seqkit          │
│                                                translate) : 1: The Standard  │
│                                                Code, 2: The Vertebrate       │
│                                                Mitochondrial Code, 3: The    │
│                                                Yeast Mitochondrial Code, 4:  │
│                                                The Mold, Protozoan, and      │
│                                                Coelenterate Mitochondrial    │
│                                                Code and the                  │
│                                                Mycoplasma/Spiroplasma Code,  │
│                                                5: The Invertebrate           │
│                                                Mitochondrial Code, 6: The    │
│                                                Ciliate, Dasycladacean and    │
│                                                Hexamita Nuclear Code, 9: The │
│                                                Echinoderm and Flatworm       │
│                                                Mitochondrial Code, 10: The   │
│                                                Euplotid Nuclear Code, 11:    │
│                                                The Bacterial, Archaeal and   │
│                                                Plant Plastid Code, 12: The   │
│                                                Alternative Yeast Nuclear     │
│                                                Code, 13: The Ascidian        │
│                                                Mitochondrial Code, 14: The   │
│                                                Alternative Flatworm          │
│                                                Mitochondrial Code, 16:       │
│                                                Chlorophycean Mitochondrial   │
│                                                Code, 21: Trematode           │
│                                                Mitochondrial Code, 22:       │
│                                                Scenedesmus obliquus          │
│                                                Mitochondrial Code, 23:       │
│                                                Thraustochytrium              │
│                                                Mitochondrial Code, 24:       │
│                                                Pterobranchia Mitochondrial   │
│                                                Code, 25: Candidate Division  │
│                                                SR1 and Gracilibacteria Code, │
│                                                26: Pachysolen tannophilus    │
│                                                Nuclear Code, 27: Karyorelict │
│                                                Nuclear, 28: Condylostoma     │
│                                                Nuclear, 29: Mesodinium       │
│                                                Nuclear, 30: Peritrich        │
│                                                Nuclear, 31: Blastocrithidia  │
│                                                Nuclear,                      │
│    --length-thr       -length-thr  INTEGER     Minimum length threshold for  │
│                                                seqkit seq(default: 400).     │
│                                                ONLY used for nucleotide      │
│                                                sequences.                    │
│    --extended-output                           Keep additional HMM score     │
│                                                columns                       │
│                                                (norm_bitscore_profile,       │
│                                                norm_bitscore_sequence,       │
│                                                ID_score) in the output.      │
│                                                (default: False)              │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Database options ───────────────────────────────────────────────────────────╮
│ --db-options         -dbs      TEXT  Comma-separated list of databases to    │
│                                      search against. Valid options: RVMT,    │
│                                      NeoRdRp, NeoRdRp.2.1, Olendraite_fam,   │
│                                      Olendraite_gen, RDRP-scan,Lucaprot_HMM, │
│                                      Zayed_HMM, all, none.                   │
│ --custom-dbs                   TEXT  Comma-separated custom database names   │
│                                      (already prepared in custom_dbs dir     │
│                                      under db-dir).                          │
│ --alt-mmseqs-tax-db  -altmmdb  TEXT  Optional alternative MMseqs2            │
│                                      seqTaxDB-formatted MMseqs2 database to  │
│                                      use. Can be a database name under       │
│                                      'mmseqs_dbs'or a path to a              │
│                                      seqTaxDB-formatted MMseqs2 database     │
│                                      (path/to/base/filename). If omitted,    │
│                                      the default                             │
│                                      'mmseqs_refseq_riboviria_20250211' is   │
│                                      used.                                   │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ HMMsearch threshold options ────────────────────────────────────────────────╮
│ --evalue                    -e        FLOAT    E-value threshold for         │
│                                                HMMsearch. (default: 1e-5).   │
│ --incevalue                 -incE     FLOAT    Inclusion E-value threshold   │
│                                                for HMMsearch. (default:      │
│                                                1e-5).                        │
│ --domevalue                 -domE     FLOAT    Domain E-value threshold for  │
│                                                HMMsearch. (default: 1e-5).   │
│ --incdomevalue              -incdomE  FLOAT    Inclusion domain E-value      │
│                                                threshold for HMMsearch.      │
│                                                (default: 1e-5).              │
│ --zvalue                    -z        INTEGER  Number of sequences to search │
│                                                against. (default: 1000000)   │
│ --default-hmmsearch-params                     Use HMMER default hmmsearch   │
│                                                thresholds (E=10.0,           │
│                                                domE=10.0, incE=0.01,         │
│                                                incdomE=0.01, automatic Z).   │
│                                                Overrides                     │
│                                                --evalue/--incevalue/--domev… │
│                                                and ignores --zvalue.         │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Runtime & housekeeping options ─────────────────────────────────────────────╮
│ --cpus       -cpus       INTEGER  Number of CPUs to use for HMMsearch.       │
│                                   (default: 1)                               │
│ --bundle     -bundle              Bundle the output files into a single      │
│                                   archive. (default: False)                  │
│ --keep-tmp   -keep-tmp            Keep temporary files (Expert users)        │
│                                   (default: False)                           │
│ --overwrite  -overwrite           Force overwrite of existing output         │
│                                   directory. (default: False)                │
│ --verbose    -v                   Print verbose output.                      │
╰──────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────╮
│ --help      Show this message and exit.                                      │
╰──────────────────────────────────────────────────────────────────────────────╯
```


## Metadata
- **Skill**: generated
