# suvtk CWL Generation Report

## suvtk_download-database

### Tool Description
Download and extract the TAR archive from the fixed Zenodo DOI.

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Total Downloads**: 517
- **Last updated**: 2025-09-13
- **GitHub**: https://github.com/LanderDC/suvtk
- **Stars**: N/A
### Original Help Text
```text
Usage: suvtk download-database [OPTIONS]

  Download and extract the TAR archive from the fixed Zenodo DOI.

Options:
  -o, --output-dir PATH  Directory to extract the archive into (defaults to
                         archive name)
  -h, --help             Show this message and exit.
```


## suvtk_taxonomy

### Tool Description
This command uses MMseqs2 to assign taxonomy to sequences using protein sequences from ICTV taxa in the nr database.

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: suvtk taxonomy [OPTIONS]

  This command uses MMseqs2 to assign taxonomy to sequences using protein
  sequences from ICTV taxa in the nr database.

Options:
  -i, --input PATH       Input fasta file  [required]
  -o, --output PATH      Output directory  [required]
  -d, --database PATH    Path to the suvtk database folder.  [required]
  -s, --identity FLOAT   Minimum sequence identity for hits to be considered
                         [default: 0.7]
  -t, --threads INTEGER  Number of threads to use  [default: 20]
  -h, --help             Show this message and exit.
```


## suvtk_features

### Tool Description
Create feature tables for sequences from an input fasta file.

  This command processes the input sequences to predict open reading frames
  (ORFs), aligns the predicted protein sequences against a specified database
  with proteins and their function, and generates feature tables for
  submission to GenBank.

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: suvtk features [OPTIONS]

  Create feature tables for sequences from an input fasta file.

  This command processes the input sequences to predict open reading frames
  (ORFs), aligns the predicted protein sequences against a specified database
  with proteins and their function, and generates feature tables for
  submission to GenBank.

Options:
  -i, --input PATH          Input fasta file  [required]
  -o, --output PATH         Output directory  [required]
  -d, --database PATH       Path to the suvtk database folder.  [required]
  -g, --translation-table   Translation table to use. Only genetic codes from h
                            ttps://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintg
                            c.cgi are allowed (1-6, 9-16, 21-31).  [default:
                            1]
  --coding-complete         Do not predict incomplete genes (no stop codon)
                            and only keep genomes that are 'coding complete'
                            (>50% coding capacity). [This can not be turned
                            off for now]
  --taxonomy PATH           Taxonomy file to adjust sequence orientation
                            (ssRNA- sequences will get 3' -> 5' orientation,
                            all others 5' -> 3').
  --separate-files          Save feature tables into separate files
  -t, --threads             Number of threads to use  [default: 20]
  -h, --help                Show this message and exit.
```


## suvtk_virus-info

### Tool Description
This command provides info on potentially segmented viruses based on the taxonomy and also outputs a file with the genome type and genome structure for the MIUVIG structured comment.

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: suvtk virus-info [OPTIONS]

  This command provides info on potentially segmented viruses based on the
  taxonomy and also outputs a file with the genome type and genome structure
  for the MIUVIG structured comment.

Options:
  --taxonomy PATH      Taxonomy file.  [required]
  -d, --database PATH  The suvtk database path.  [required]
  -o, --output PATH    Output directory  [required]
  -h, --help           Show this message and exit.
```


## suvtk_their

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Usage: suvtk [OPTIONS] COMMAND [ARGS]...
Try 'suvtk -h' for help.

Error: No such command 'their'.
```


## suvtk_co-occurrence

### Tool Description
Identify co-occurring sequences in an abundance table based on specified
  thresholds.

  This function reads an abundance table, filters contigs based on prevalence,
  and calculates correlation matrices to identify co-occurring sequences. It
  supports optional segment-specific analysis and contig length correction.

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: suvtk co-occurrence [OPTIONS]

  Identify co-occurring sequences in an abundance table based on specified
  thresholds.

  This function reads an abundance table, filters contigs based on prevalence,
  and calculates correlation matrices to identify co-occurring sequences. It
  supports optional segment-specific analysis and contig length correction.

Options:
  -i, --input FILE         Abundance table file (tsv).  [required]
  -o, --output OUTPUT      Prefix for the output name.  [required]
  -s, --segments FILE      File with a list of contigs of interest (often RdRP
                           segments), each on a new line.
  -l, --lengths FILE       File with the lengths of each contig.
  -p, --prevalence FLOAT   Minimum percentage of samples for correlation
                           analysis.  [default: 0.1]
  -c, --correlation FLOAT  Minimum correlation to keep pairs.  [default: 0.5]
  --strict                 The correlation threshold should be met for all
                           provided segments.
  -h, --help               Show this message and exit.
```


## suvtk_gbk2tbl

### Tool Description
This script converts a GenBank file (.gbk or .gb) into a Sequin feature table (.tbl), which is an input file of table2asn used for creating an ASN.1 file (.sqn).

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: suvtk gbk2tbl [OPTIONS]

  This script converts a GenBank file (.gbk or .gb) into a Sequin feature
  table (.tbl), which is an input file of table2asn used for creating an ASN.1
  file (.sqn).

Options:
  -i, --input PATH             Input genbank file  [required]
  -m, --mincontigsize INTEGER  The minimum contig length  [default: 0]
  -p, --prefix TEXT            The prefix of output filenames  [default: seq]
  -h, --help                   Show this message and exit.
```


## suvtk_comments

### Tool Description
Generate a structured comment file based on MIUVIG standards.

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: suvtk comments [OPTIONS]

  Generate a structured comment file based on MIUVIG standards.

Options:
  -t, --taxonomy PATH  MIUVIG TSV file generated by the `taxonomy` or
                       `segment-info` subcommand.  [required]
  -f, --features PATH  MIUVIG TSV file generated by the `features` subcommand.
                       [required]
  -m, --miuvig PATH    TSV file with MIUVIG information.  [required]
  -a, --assembly PATH  TSV file with Genbank Assembly information.  [required]
  -c, --checkv PATH    CheckV's quality_summary.tsv file.
  -o, --output PATH    Output filename.  [required]
  -h, --help           Show this message and exit.
```


## suvtk_table2asn

### Tool Description
This command generates a .sqn file that you can send to gb-sub@ncbi.nlm.nih.gov

### Metadata
- **Docker Image**: quay.io/biocontainers/suvtk:0.1.6--pyh64700be_0
- **Homepage**: https://github.com/LanderDC/suvtk
- **Package**: https://anaconda.org/channels/bioconda/packages/suvtk/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: suvtk table2asn [OPTIONS]

  This command generates a .sqn file that you can send to gb-
  sub@ncbi.nlm.nih.gov

Options:
  -i, --input PATH     Input fasta file  [required]
  -o, --output PATH    Output prefix  [required]
  -s, --src-file PATH  File with Source modifiers (.src).  [required]
  -f, --features PATH  Feature table file (.tbl).  [required]
  -t, --template PATH  Template file with author information (.sbt). See https
                       ://submit.ncbi.nlm.nih.gov/genbank/template/submission/
                       [required]
  -c, --comments PATH  Structured comment file (.cmt) with MIUVIG information.
                       [required]
  -h, --help           Show this message and exit.
```


## Metadata
- **Skill**: not generated
