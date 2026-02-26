# blobtools CWL Generation Report

## blobtools_create

### Tool Description
Create a BlobDB from FASTA and associated data files.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Total Downloads**: 12.7K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: blobtools create     -i FASTA [-y FASTATYPE] [-o PREFIX] [--title TITLE]
                              [-b BAM...] [-C] [-a CAS...] [-c COV...]
                              [--nodes <NODES>] [--names <NAMES>] [--db <NODESDB>]
                              [-t HITS...] [-x TAXRULE...] [-m FLOAT] [-d FLOAT] [--tax_collision_random]
                              [-h|--help]

    Options:
        -h --help                       show this
        -i, --infile FASTA              FASTA file of assembly. Headers are split at whitespaces.
        -y, --type FASTATYPE            Assembly program used to create FASTA. If specified,
                                        coverage will be parsed from FASTA header.
                                        (Parsing supported for 'spades', 'velvet', 'platanus')
        -t, --hitsfile HITS...          Hits file in format (qseqid\ttaxid\tbitscore)
                                        (e.g. BLAST output "--outfmt '6 qseqid staxids bitscore'")
                                        Can be specified multiple times
        -x, --taxrule <TAXRULE>...      Taxrule determines how taxonomy of blobs
                                        is computed (by default both are calculated)
                                        "bestsum"       : sum bitscore across all
                                                          hits for each taxonomic rank
                                        "bestsumorder"  : sum bitscore across all
                                                          hits for each taxonomic rank.
                                                  - If first <TAX> file supplies hits, bestsum is calculated.
                                                  - If no hit is found, the next <TAX> file is used.
        -m, --min_score <FLOAT>         Minimal score necessary to be considered for taxonomy calculaton, otherwise set to 'no-hit'
                                        [default: 0.0]
        -d, --min_diff <FLOAT>          Minimal score difference between highest scoring
                                        taxonomies (otherwise "unresolved") [default: 0.0]
        --tax_collision_random          Random allocation of taxonomy if highest scoring
                                        taxonomies have equal scores (otherwise "unresolved") [default: False]
        --nodes <NODES>                 NCBI nodes.dmp file. Not required if '--db'
        --names <NAMES>                 NCBI names.dmp file. Not required if '--db'
        --db <NODESDB>                  NodesDB file (default: $BLOBTOOLS/data/nodesDB.txt).  If --nodes, --names and --db
                                        are all given and NODESDB does not exist, create it from NODES and NAMES.
        -b, --bam <BAM>...              BAM file(s), can be specified multiple times
        -a, --cas <CAS>...              CAS file(s) (requires clc_mapping_info in $PATH), can be specified multiple times
        -c, --cov <COV>...              COV file(s), can be specified multiple times
        -C, --calculate_cov             Legacy coverage when getting coverage from BAM (does not apply to COV parsing). 
                                            New default is to estimate coverages which is faster,
        -o, --out <PREFIX>              BlobDB output prefix
        --title TITLE                   Title of BlobDB [default: output prefix)
```


## blobtools_view

### Tool Description
View and filter a BlobDB database.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools view    -i <BLOBDB> [-x <TAXRULE>] [--rank <TAXRANK>...] [--hits]
                            [--list <LIST>] [--out <OUT>] [--notable]
                            [--concoct] [--cov] [--experimental <META>]
                            [--h|--help]

    Options:
        --h --help                  show this
        -i, --input <BLOBDB>        BlobDB file (created with "blobtools create")
        -o, --out <OUT>             Output prefix
        -l, --list <LIST>           List of sequence names (file).
        -x, --taxrule <TAXRULE>     Taxrule used for computing taxonomy
                                    (supported: "bestsum", "bestsumorder")
                                    [default: bestsum]
        -r, --rank <TAXRANK>...     Taxonomic rank(s) at which output will be written.
                                    (supported: 'species', 'genus', 'family', 'order',
                                    'phylum', 'superkingdom', 'all') [default: phylum]
        -b, --hits                  Displays taxonomic hits from tax files
                                    that contributed to the taxonomy.
        --concoct                   Generate concoct files [default: False]
        --cov                       Generate cov files [default: False]
        --experimental <META>       Experimental output [default: False]
        -n, --notable               Do not generate table view [default: False]
```


## blobtools_plot

### Tool Description
Plotting tool for BlobDB files.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools plot -i <BLOBDB>
                                [-p INT] [-l INT] [--cindex] [-n] [-s]
                                [-r RANK] [-x TAXRULE] [--label GROUPS...]
                                [--lib COVLIB] [-o PREFIX] [-m]
                                [--sort ORDER] [--sort_first LABELS] [--hist HIST] [--notitle] [--filelabel]
                                [--colours FILE] [--exclude FILE]
                                [--refcov FILE] [--catcolour FILE]
                                [--format FORMAT] [--noblobs] [--noreads] [--legend]
                                [--cumulative] [--multiplot]
                                [-h|--help]

    Options:
        -h --help                   show this
        -i, --infile BLOBDB         BlobDB file (created with "blobtools create")
        --lib COVLIB                Plot only certain covlib(s). Separated by ","
        --notitle                   Do not add filename as title to plot
        --filelabel                 Label axis based on filenames
        -p, --plotgroups INT        Number of (taxonomic) groups to plot, remaining
                                     groups are placed in 'other' [default: 8]
        -l, --length INT            Minimum sequence length considered for plotting [default: 100]
        --cindex                    Colour blobs by 'c index' [default: False]
        -n, --nohit                 Hide sequences without taxonomic annotation [default: False]
        -s, --noscale               Do not scale sequences by length [default: False]
        --legend                    Plot legend of blobplot in separate figure
        -m, --multiplot             Multi-plot. Print blobplot for each (taxonomic) group separately
        --cumulative                Print plot after addition of each (taxonomic) group
        --sort <ORDER>              Sort order for plotting [default: span]
                                     span  : plot with decreasing span
                                     count : plot with decreasing count
        --sort_first <L1,L2,...>    Labels that should always be plotted first, regardless of sort order
                                     ("no-hit,other,undef" is often a useful setting)
        --hist <HIST>               Data for histograms [default: span]
                                     span  : span-weighted histograms
                                     count : count histograms
        -r, --rank <RANK>           Taxonomic rank used for colouring of blobs [default: phylum]
                                     (Supported: species, genus, family, order,
                                        phylum, superkingdom)
        -x, --taxrule <TAXRULE>     Taxrule which has been used for computing taxonomy
                                     (Supported: bestsum, bestsumorder) [default: bestsum]
        --format FORMAT             Figure format for plot (png, pdf, eps, jpeg,
                                        ps, svg, svgz, tiff) [default: png]
        --noblobs                   Omit blobplot [default: False]
        --noreads                   Omit plot of reads mapping [default: False]

        -o, --out PREFIX            Output prefix

        --label GROUPS...           Relabel (taxonomic) groups, can be used several times.
                                     e.g. "A=Actinobacteria,Proteobacteria"
        --colours COLOURFILE        File containing colours for (taxonomic) groups. This allows having more than 9 colours.
        --exclude GROUPS            Exclude these (taxonomic) groups (also works for 'other')
                                     e.g. "Actinobacteria,Proteobacteria,other"
        --refcov <FILE>               File containing number of "total" and "mapped" reads
                                     per coverage file. (e.g.: bam0,900,100). If provided, info
                                     will be used in read coverage plot(s).
        --catcolour <FILE>            Colour plot based on categories from FILE
                                     (format : "seq	category").
```


## blobtools_covplot

### Tool Description
Create coverage plots from BlobDB and coverage files.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools covplot  -i BLOBDB -c COV [--max FLOAT]
                                [--xlabel XLABEL] [--ylabel YLABEL]
                                [--lib COVLIB] [-o PREFIX] [-m]
                                [-p INT] [-l INT] [--cindex] [-n] [-s]
                                [-r RANK] [-x TAXRULE] [--label GROUPS...]
                                [--sort ORDER] [--sort_first LABELS]
                                [--hist HIST] [--notitle]
                                [--colours FILE] [--exclude FILE]
                                [--refcov FILE] [--catcolour FILE]
                                [--format FORMAT] [--noblobs] [--noreads] [--legend]
                                [--cumulative]
                                [-h|--help]

    Options:
        -h --help                   show this
        -i, --infile BLOBDB         BlobDB file
        -c, --cov COV               COV file to be used in y-axis

        --xlabel XLABEL             Label for x-axis
        --ylabel YLABEL             Label for y-axis
        --max FLOAT                 Maximum values for x/y-axis [default: 1e10]

        --lib COVLIB                Plot only certain covlib(s). Separated by ","
        --notitle                   Do not add filename as title to plot
        -p, --plotgroups INT        Number of (taxonomic) groups to plot, remaining
                                     groups are placed in 'other' [default: 7]
        -l, --length INT            Minimum sequence length considered for plotting [default: 100]
        --cindex                    Colour blobs by 'c index' [default: False]
        -n, --nohit                 Hide sequences without taxonomic annotation [default: False]
        -s, --noscale               Do not scale sequences by length [default: False]
        --legend                    Plot legend of blobplot in separate figure
        -m, --multiplot             Multi-plot. Print blobplot for each (taxonomic) group separately
        --cumulative                Print plot after addition of each (taxonomic) group
        --sort <ORDER>              Sort order for plotting [default: span]
                                     span  : plot with decreasing span
                                     count : plot with decreasing count
        --sort_first <L1,L2,...>    Labels that should always be plotted first, regardless of sort order
                                     ("no-hit,other,undef" is often a useful setting)
        --hist <HIST>               Data for histograms [default: span]
                                     span  : span-weighted histograms
                                     count : count histograms
        -r, --rank <RANK>           Taxonomic rank used for colouring of blobs [default: phylum]
                                     (Supported: species, genus, family, order,
                                        phylum, superkingdom)
        -x, --taxrule <TAXRULE>     Taxrule which has been used for computing taxonomy
                                     (Supported: bestsum, bestsumorder) [default: bestsum]
        --format FORMAT             Figure format for plot (png, pdf, eps, jpeg,
                                        ps, svg, svgz, tiff) [default: png]
        --noblobs                   Omit blobplot [default: False]
        --noreads                   Omit plot of reads mapping [default: False]
        -o, --out PREFIX            Output prefix
        --label GROUPS...           Relabel (taxonomic) groups, can be used several times.
                                     e.g. "A=Actinobacteria,Proteobacteria"
        --colours COLOURFILE        File containing colours for (taxonomic) groups
        --exclude GROUPS            Exclude these (taxonomic) groups (also works for 'other')
                                     e.g. "Actinobacteria,Proteobacteria,other"
        --refcov <FILE>               File containing number of "total" and "mapped" reads
                                     per coverage file. (e.g.: bam0,900,100). If provided, info
                                     will be used in read coverage plot(s).
        --catcolour <FILE>            Colour plot based on categories from FILE
                                     (format : "seq,category").
```


## blobtools_map2cov

### Tool Description
Map BAM/CAS files to a FASTA assembly to calculate coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools map2cov         -i FASTA [-b BAM...] [-a CAS...]
                                    [-o PREFIX] [-c]
                                    [-h|--help]

    Options:
        -h --help                   show this
        -i, --infile FASTA          FASTA file of assembly. Headers are split at whitespaces.
        -b, --bam <BAM>...          BAM file (requires pysam)
        -a, --cas <CAS>...          CAS file (requires clc_mapping_info in $PATH)
        -o, --output <PREFIX>       Output prefix
        -c, --calculate_cov         Legacy coverage, slower. New default is to estimate coverages 
                                        based on read lengths of first 10K reads.
```


## blobtools_taxify

### Tool Description
Assigns taxonomic IDs to sequences based on similarity search results and a taxid mapping file.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools taxify          -f FILE [-a INT] [-b INT] [-c INT]
                                    [-m FILE] [-s INT] [-t INT]
                                    [-i FILE] [-x INT] [-v FLOAT]
                                    [-o PREFIX] [-h|--help]

    Options:
        -h --help                           show this

    Options for similarity search input
        -f, --hit_file <FILE>               BLAST/Diamond similarity search result (TSV format).
                                                Defaults assume "-outfmt '6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore'"
        -a, --hit_column_qseqid <INT>       Zero-based column of qseqid in similarity search result [default: 0]
                                                Change if different format than (-outfmt '6')
        -b, --hit_column_sseqid <INT>       Zero-based column of sseqid in similarity search result [default: 1]
                                                Change if different format than (-outfmt '6')
        -c, --hit_column_score <INT>        Zero-based column of (bit)score in similarity search result [default: 11]
                                                Change if different format than (-outfmt '6')
    Options for TaxID mapping file
        -m, --taxid_mapping_file <FILE>     TaxID mapping file (contains seqid and taxid)
        -s, --map_col_sseqid <INT>          Zero-based column of sseqid in TaxID mapping file (it will search for sseqid in this column)
        -t, --map_col_taxid <INT>           Zero-based Column of taxid in TaxID mapping file (it will extract for taxid from this column)

    Options for custom input
        -i, --custom <FILE>                 File containing list of sequence IDs
        -x, --custom_taxid <INT>            TaxID to assign to all sequence IDs in list
        -v, --custom_score <FLOAT>          Score to assign to all sequence IDs in list

    General
        -o, --out <PREFIX>                  Output prefix
```


## blobtools_bamfilter

### Tool Description
Filter BAM files based on contig inclusion/exclusion lists and mapping status.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools bamfilter  -b FILE [-i FILE] [-e FILE] [-U] [-n] [-o PREFIX] [-f FORMAT]
                                [-h|--help]

    Options:
        -h --help                   show this
        -b, --bam FILE              BAM file (sorted by name)
        -i, --include FILE          List of contigs whose reads are included
                                    - writes FASTAs of pairs where at least
                                        one read maps sequences in list
                                        (InUn.fq, InIn.fq, ExIn.fq)
        -e, --exclude FILE          List of contigs whose reads are excluded (outputs reads that do not map to sequences in list)
                                    - writes FASTAs of pairs where at least
                                        one read does not maps to sequences in list
                                        (InUn.fq, InIn.fq, ExIn.fq)
        -U, --exclude_unmapped      Include pairs where both reads are unmapped
        -n, --noninterleaved        Use if fw and rev reads should be in separate files  
        -f, --read_format FORMAT    FASTQ = fq, FASTA = fa [default: fa]      
        -o, --out PREFIX            Output prefix
```


## blobtools_seqfilter

### Tool Description
Filter sequences from a FASTA file based on a list of headers.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools seqfilter       -i FASTA -l LIST [-o PREFIX] [-v]
                                    [-h|--help]

    Options:
        -h --help                   show this

        -i, --infile <FASTA>        FASTA file of sequences (Headers are split at whitespaces)
        -l, --list <LIST>           TXT file containing headers of sequences to keep
        -o, --out <PREFIX>          Output prefix
        -v, --invert                Invert filtering (Sequences w/ headers NOT in list)
```


## blobtools_nodesdb

### Tool Description
NCBI nodes.dmp and names.dmp files are required to build the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/blobtools:1.1.1--py_1
- **Homepage**: https://blobtools.readme.io/docs/what-is-blobtools
- **Package**: https://anaconda.org/channels/bioconda/packages/blobtools/overview
- **Validation**: PASS

### Original Help Text
```text
usage: blobtools nodesdb             --nodes <NODES> --names <NAMES>
                                        [-h|--help]

    Options:
        -h --help                       show this
        --nodes <NODES>                 NCBI nodes.dmp file.
        --names <NAMES>                 NCBI names.dmp file.
```

