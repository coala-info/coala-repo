# magcluster CWL Generation Report

## magcluster_prokka

### Tool Description
Prokka: rapid prokaryotic genome annotation

### Metadata
- **Docker Image**: quay.io/biocontainers/magcluster:0.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/runjiaji/magcluster
- **Package**: https://anaconda.org/channels/bioconda/packages/magcluster/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/magcluster/overview
- **Total Downloads**: 12.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/runjiaji/magcluster
- **Stars**: N/A
### Original Help Text
```text
usage: magcluster [options] prokka [-h] [--quiet] [--debug] [--outdir OUTDIR]
                                   [--prefix PREFIX] [--force] [--addgenes]
                                   [--addmrna] [--locustag LOCUSTAG]
                                   [--increment INCREMENT] [--gffver GFFVER]
                                   [--compliant] [--centre CENTRE]
                                   [--accver ACCVER] [--genus GENUS]
                                   [--species SPECIES] [--strain STRAIN]
                                   [--plasmid PLASMID] [--kingdom KINGDOM]
                                   [--gcode GCODE] [--gram GRAM] [--usegenus]
                                   [--proteins PROTEINS] [--hmms HMMS]
                                   [--metagenome] [--rawproduct]
                                   [--cdsrnaolap] [--cpus CPUS] [--fast]
                                   [--noanno] [--mincontiglen MINCONTIGLEN]
                                   [--evalue EVALUE] [--rfam] [--norrna]
                                   [--notrna] [--rnammer]
                                   fafile [fafile ...]

positional arguments:
  fafile                Genome files need to be annotated

optional arguments:
  -h, --help            show this help message and exit

General:
  --quiet               No screen output (default OFF)
  --debug               Debug mode: keep all temporary files (default OFF)

Outputs:
  --outdir OUTDIR       Output folder [auto] (default 'XXX_annotation')
  --prefix PREFIX       Filename output prefix [auto] (default "XXX_")
  --force               Force overwriting existing output folder (default OFF)
  --addgenes            Add 'gene' features for each 'CDS' feature (default
                        OFF)
  --addmrna             Add 'mRNA' features for each 'CDS' feature (default
                        OFF)
  --locustag LOCUSTAG   Locus tag prefix (default 'PROKKA')
  --increment INCREMENT
                        Locus tag counter increment (default '1')
  --gffver GFFVER       GFF version (default '3')
  --compliant           Force Genbank/ENA/DDJB compliance: --genes
                        --mincontiglen 200 --centre XXX (default OFF)

XXX (default OFF):
  --centre CENTRE       Sequencing centre ID. (default '')
  --accver ACCVER       Version to put in Genbank file (default '1')

Organism details:
  --genus GENUS         Genus name (default 'Genus')
  --species SPECIES     Species name (default 'species')
  --strain STRAIN       Strain name (default 'strain')
  --plasmid PLASMID     Plasmid name or identifier (default '')

Annotations:
  --kingdom KINGDOM     Annotation mode: Archaea|Bacteria|Viruses (default
                        'Bacteria')
  --gcode GCODE         Genetic code / Translation table (set if --kingdom is
                        set) (default '0')
  --gram GRAM           Gram: -/neg +/pos (default '')
  --usegenus            Use genus-specific BLAST databases (needs --genus)
                        (default OFF)
  --proteins PROTEINS   Fasta file of trusted proteins to first annotate from
                        (default "Magnetosome_protein_data.fasta")
  --hmms HMMS           Trusted HMM to first annotate from (default '')
  --metagenome          Improve gene predictions for highly fragmented genomes
                        (default OFF)
  --rawproduct          Do not clean up /product annotation (default OFF)
  --cdsrnaolap          Allow [tr]RNA to overlap CDS (default OFF)

Computation:
  --cpus CPUS           Number of CPUs to use [0=all] (default '8')
  --fast                Fast mode - skip CDS /product searching (default OFF)
  --noanno              For CDS just set /product="unannotated protein"
                        (default OFF)
  --mincontiglen MINCONTIGLEN
                        Minimum contig size [NCBI needs 200] (default '1')
  --evalue EVALUE       Similarity e-value cut-off (default '1e-06')
  --rfam                Enable searching for ncRNAs with Infernal+Rfam (SLOW!)
                        (default '0')
  --norrna              Don't run rRNA search (default OFF)
  --notrna              Don't run tRNA search (default OFF)
  --rnammer             Prefer RNAmmer over Barrnap for rRNA prediction
                        (default OFF)
```


## magcluster_mgc_screen

### Tool Description
Analyzes .gbk/.gbf files to identify potential MGCs based on magnetosome gene content within specified windows.

### Metadata
- **Docker Image**: quay.io/biocontainers/magcluster:0.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/runjiaji/magcluster
- **Package**: https://anaconda.org/channels/bioconda/packages/magcluster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magcluster [options] mgc_screen [-h] [-l CONTIGLENGTH] [-w WINDOWSIZE]
                                       [-th THRESHOLD] [-o OUTDIR]
                                       gbkfile [gbkfile ...]

positional arguments:
  gbkfile               .gbk/.gbf files to be analyzed. Multiple files or
                        files-containing folder is acceptable.

optional arguments:
  -h, --help            show this help message and exit
  -l CONTIGLENGTH, --contiglength CONTIGLENGTH
                        The minimum length of contigs to be considered
                        (default '2,000 bp')
  -w WINDOWSIZE, --windowsize WINDOWSIZE
                        The length of MGCs screening window (default '10,000
                        bp')
  -th THRESHOLD, --threshold THRESHOLD
                        The minimum number of magnetosome genes in a given
                        contig and a given length of screening window (default
                        '3')
  -o OUTDIR, --outdir OUTDIR
                        Output folder (default 'mgc_screen')
```


## magcluster_clinker

### Tool Description
magcluster clinker

### Metadata
- **Docker Image**: quay.io/biocontainers/magcluster:0.2.5--pyhdfd78af_0
- **Homepage**: https://github.com/runjiaji/magcluster
- **Package**: https://anaconda.org/channels/bioconda/packages/magcluster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: magcluster [options] clinker [-h] [-r RANGES [RANGES ...]] [-na]
                                    [-i IDENTITY] [-j JOBS] [-s SESSION]
                                    [-ji JSON_INDENT] [-f] [-o OUTPUT]
                                    [-p [PLOT]] [-dl DELIMITER] [-dc DECIMALS]
                                    [-hl] [-ha] [-ufo]
                                    [gbkfiles [gbkfiles ...]]

optional arguments:
  -h, --help            show this help message and exit

Input options:
  gbkfiles              Gene cluster GenBank files
  -r RANGES [RANGES ...], --ranges RANGES [RANGES ...]
                        Scaffold extraction ranges. If a range is specified,
                        only features within the range will be extracted from
                        the scaffold. Ranges should be formatted like:
                        scaffold:start-end (e.g. scaffold_1:15000-40000)

Alignment options:
  -na, --no_align       Do not align clusters
  -i IDENTITY, --identity IDENTITY
                        Minimum alignment sequence identity [default: 0.3]
  -j JOBS, --jobs JOBS  Number of alignments to run in parallel (0 to use the
                        number of CPUs) [default: 0]

Output options:
  -s SESSION, --session SESSION
                        Path to clinker session
  -ji JSON_INDENT, --json_indent JSON_INDENT
                        Number of spaces to indent JSON [default: none]
  -f, --force           Overwrite previous output file
  -o OUTPUT, --output OUTPUT
                        Save alignments to file
  -p [PLOT], --plot [PLOT]
                        Plot cluster alignments using clustermap.js. If a path
                        is given, clinker will generate a portable HTML file
                        at that path. Otherwise, the plot will be served
                        dynamically using Python's HTTP server.
  -dl DELIMITER, --delimiter DELIMITER
                        Character to delimit output by [default: human
                        readable]
  -dc DECIMALS, --decimals DECIMALS
                        Number of decimal places in output [default: 2]
  -hl, --hide_link_headers
                        Hide alignment column headers
  -ha, --hide_aln_headers
                        Hide alignment cluster name headers

Visualisation options:
  -ufo, --use_file_order
                        Display clusters in order of input files
```

