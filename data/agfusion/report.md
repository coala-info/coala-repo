# agfusion CWL Generation Report

## agfusion_annotate

### Tool Description
Annotate and visualize gene fusion events using the AGFusion database.

### Metadata
- **Docker Image**: quay.io/biocontainers/agfusion:1.252--py_0
- **Homepage**: https://github.com/murphycj/AGFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/agfusion/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/agfusion/overview
- **Total Downloads**: 28.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/murphycj/AGFusion
- **Stars**: N/A
### Original Help Text
```text
usage: agfusion annotate [-h] -g5 GENE5PRIME -g3 GENE3PRIME -j5 JUNCTION5PRIME
                         -j3 JUNCTION3PRIME -db DATABASE -o OUT [-nc]
                         [--protein_databases PROTEIN_DATABASES [PROTEIN_DATABASES ...]]
                         [--recolor RECOLOR] [--rename RENAME]
                         [--exclude_domain EXCLUDE_DOMAIN [EXCLUDE_DOMAIN ...]]
                         [--type TYPE] [-w WIDTH] [-ht HEIGHT] [--dpi DPI]
                         [--fontsize FONTSIZE] [--WT] [-ms] [-ndl] [--debug]
                         [--scale SCALE]

optional arguments:
  -h, --help            show this help message and exit
  -g5 GENE5PRIME, --gene5prime GENE5PRIME
                        5' gene partner
  -g3 GENE3PRIME, --gene3prime GENE3PRIME
                        3' gene partner
  -j5 JUNCTION5PRIME, --junction5prime JUNCTION5PRIME
                        Genomic location of predicted fuins for the 5' gene
                        partner. The 1-based position that is the last
                        nucleotide included in the fusion before the junction.
  -j3 JUNCTION3PRIME, --junction3prime JUNCTION3PRIME
                        Genomic location of predicted fuins for the 3' gene
                        partner. The 1-based position that is the first
                        nucleotide included in the fusion after the junction.
  -db DATABASE, --database DATABASE
                        Path to the AGFusion database (e.g. --db
                        /path/to/agfusion.homo_sapiens.87.db)
  -o OUT, --out OUT     Directory to save results
  -nc, --noncanonical   (Optional) Include non-canonical gene transcripts in
                        the analysis (default False).
  --protein_databases PROTEIN_DATABASES [PROTEIN_DATABASES ...]
                        (Optional) Space-delimited list of one or more protein
                        feature databases to include when visualizing
                        proteins. Options are: pfam, smart, superfamily,
                        tigrfam, pfscan (Prosite_profiles), tmhmm (i.e.
                        transmembrane), seg (low_complexity regions), ncoils
                        (coiled coil regions), prints, pirsf, and signalp
                        (signal peptide regions) (default: --protein_databases
                        pfam and tmhmm).
  --recolor RECOLOR     (Optional) Re-color a domain. Provide the original
                        name of the domain then your color (semi-colon
                        delimited, all in quotes). Can specify --recolor
                        multiples for each domain. (e.g. --color
                        "Pkinase_Tyr;blue" --color "I-set;#006600").
  --rename RENAME       (Optional) Rename a domain. Provide the original name
                        of the domain then your new name (semi-colon
                        delimited, all in quotes). Can specify --rename
                        multiples for each domain. (e.g. --rename
                        "Pkinase_Tyr;Kinase").
  --exclude_domain EXCLUDE_DOMAIN [EXCLUDE_DOMAIN ...]
                        (Optional) Exclude a certain domain(s) from plotting
                        by providing a space-separated list of domain names.
  --type TYPE           (Optional) Image file type (png, jpeg, pdf). Default:
                        png
  -w WIDTH, --width WIDTH
                        (Optional) Image width in inches (default 10).
  -ht HEIGHT, --height HEIGHT
                        (Optional) Image file height in inches (default 3).
  --dpi DPI             (Optional) Dots per inch.
  --fontsize FONTSIZE   (Optional) Fontsize (default 12).
  --WT                  (Optional) Include this to plot wild-type
                        architechtures of the 5' and 3' genes
  -ms, --middlestar     (Optional) Insert a * at the junction position for the
                        cdna, cds, and protein sequences (default False).
  -ndl, --no_domain_labels
                        (Optional) Do not label domains.
  --debug               (Optional) Enable debugging logging.
  --scale SCALE         (Optional) Set maximum width (in amino acids) of the
                        figure to rescale the fusion (default: max length of
                        fusion product)
```


## agfusion_batch

### Tool Description
AGFusion batch processing for fusion-finding algorithm outputs to visualize and analyze gene fusions.

### Metadata
- **Docker Image**: quay.io/biocontainers/agfusion:1.252--py_0
- **Homepage**: https://github.com/murphycj/AGFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/agfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: agfusion batch [-h] -f FILE -a ALGORITHM -db DATABASE -o OUT [-nc]
                      [--protein_databases PROTEIN_DATABASES [PROTEIN_DATABASES ...]]
                      [--recolor RECOLOR] [--rename RENAME]
                      [--exclude_domain EXCLUDE_DOMAIN [EXCLUDE_DOMAIN ...]]
                      [--type TYPE] [-w WIDTH] [-ht HEIGHT] [--dpi DPI]
                      [--fontsize FONTSIZE] [--WT] [-ms] [-ndl] [--debug]

optional arguments:
  -h, --help            show this help message and exit
  -f FILE, --file FILE  Output file from fusion-finding algorithm.
  -a ALGORITHM, --algorithm ALGORITHM
                        The fusion-finding algorithm. Can be one of the
                        following: bellerophontes, breakfusion, chimerascan,
                        chimerscope, defuse, ericscript, fusioncatcher,
                        fusionhunter, fusionmap, fusioninspector, infusion,
                        jaffa, mapsplice, starfusion, tophatfusion.
  -db DATABASE, --database DATABASE
                        Path to the AGFusion database (e.g. --db
                        /path/to/agfusion.homo_sapiens.87.db)
  -o OUT, --out OUT     Directory to save results
  -nc, --noncanonical   (Optional) Include non-canonical gene transcripts in
                        the analysis (default False).
  --protein_databases PROTEIN_DATABASES [PROTEIN_DATABASES ...]
                        (Optional) Space-delimited list of one or more protein
                        feature databases to include when visualizing
                        proteins. Options are: pfam, smart, superfamily,
                        tigrfam, pfscan (Prosite_profiles), tmhmm (i.e.
                        transmembrane), seg (low_complexity regions), ncoils
                        (coiled coil regions), prints, pirsf, and signalp
                        (signal peptide regions) (default: --protein_databases
                        pfam and tmhmm).
  --recolor RECOLOR     (Optional) Re-color a domain. Provide the original
                        name of the domain then your color (semi-colon
                        delimited, all in quotes). Can specify --recolor
                        multiples for each domain. (e.g. --color
                        "Pkinase_Tyr;blue" --color "I-set;#006600").
  --rename RENAME       (Optional) Rename a domain. Provide the original name
                        of the domain then your new name (semi-colon
                        delimited, all in quotes). Can specify --rename
                        multiples for each domain. (e.g. --rename
                        "Pkinase_Tyr;Kinase").
  --exclude_domain EXCLUDE_DOMAIN [EXCLUDE_DOMAIN ...]
                        (Optional) Exclude a certain domain(s) from plotting
                        by providing a space-separated list of domain names.
  --type TYPE           (Optional) Image file type (png, jpeg, pdf). Default:
                        png
  -w WIDTH, --width WIDTH
                        (Optional) Image width in inches (default 10).
  -ht HEIGHT, --height HEIGHT
                        (Optional) Image file height in inches (default 3).
  --dpi DPI             (Optional) Dots per inch.
  --fontsize FONTSIZE   (Optional) Fontsize (default 12).
  --WT                  (Optional) Include this to plot wild-type
                        architechtures of the 5' and 3' genes
  -ms, --middlestar     (Optional) Insert a * at the junction position for the
                        cdna, cds, and protein sequences (default False).
  -ndl, --no_domain_labels
                        (Optional) Do not label domains.
  --debug               (Optional) Enable debugging logging.
```


## agfusion_download

### Tool Description
Download the AGFusion database for specific genomes, species, and releases.

### Metadata
- **Docker Image**: quay.io/biocontainers/agfusion:1.252--py_0
- **Homepage**: https://github.com/murphycj/AGFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/agfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: agfusion download [-h] [-d DIR] [-g GENOME] [-s SPECIES] [-r RELEASE]
                         [-a]

optional arguments:
  -h, --help            show this help message and exit
  -d DIR, --dir DIR     (Optional) Directory to the database will be
                        downloaded to (defaults to current working directory).
  -g GENOME, --genome GENOME
                        Specify the genome shortcut (e.g. hg19). To see
                        allavailable shortcuts run 'agfusion download -a'.
                        Either specify this or --species and --release.
  -s SPECIES, --species SPECIES
                        The species (e.g. homo_sapiens).
  -r RELEASE, --release RELEASE
                        The ensembl release (e.g. 87).
  -a, --available       List available species and ensembl releases.
```


## agfusion_build

### Tool Description
Build the AGFusion database for a specific species and Ensembl release.

### Metadata
- **Docker Image**: quay.io/biocontainers/agfusion:1.252--py_0
- **Homepage**: https://github.com/murphycj/AGFusion
- **Package**: https://anaconda.org/channels/bioconda/packages/agfusion/overview
- **Validation**: PASS

### Original Help Text
```text
usage: agfusion build [-h] -d DIR -s SPECIES -r RELEASE --pfam PFAM
                      [--server SERVER]

optional arguments:
  -h, --help            show this help message and exit
  -d DIR, --dir DIR     Directory to write database file to.
  -s SPECIES, --species SPECIES
                        The species (e.g. homo_sapiens).
  -r RELEASE, --release RELEASE
                        The ensembl release (e.g. 87).
  --pfam PFAM           File containing PFAM ID mappings.
  --server SERVER       (optional) Ensembl server (default
                        ensembldb.ensembl.org)
```

