# bio CWL Generation Report

## bio_search

### Tool Description
Search biological databases

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Total Downloads**: 18.5K
- **Last updated**: 2025-10-19
- **GitHub**: https://github.com/ialbert/bio
- **Stars**: N/A
### Original Help Text
```text
usage: bio [-h] [-a] [-c] [-t] [-H] [-s ''] [-S symbol] [-u] [-l 5]
           [-f refseq]
           [words ...]

positional arguments:
  words

options:
  -h, --help           show this help message and exit
  -a, --all            get all possible fields
  -c, --csv            produce comma separated output
  -t, --tab            produce tab separated output
  -H, --header         show headers
  -s, --species ''     species
  -S, --scopes symbol  scopes
  -u, --update         download the latest assebmly summary
  -l, --limit 5        download limit
  -f, --fields refseq  fields
```


## bio_fetch

### Tool Description
Fetch biological data from various databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-d ''] [-t ''] [-f ''] [-l 100] [-o ''] [acc ...]

positional arguments:
  acc              accession numbers

options:
  -h, --help       show this help message and exit
  -d, --db ''      database
  -t, --type ''    get CDS/CDNA (Ensembl only)
  -f, --format ''  return format
  -l, --limit 100  limit results
  -o, --out ''     output file (used as prefix in for FASTQ)
```


## bio_fasta

### Tool Description
A tool for manipulating FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-s 1] [-e ''] [-t ''] [-i ''] [-m ''] [-g ''] [-r ''] [-p]
           [-T] [-R] [-G] [-A ''] [-o ''] [-F 1]
           [fnames ...]

positional arguments:
  fnames           input files

options:
  -h, --help       show this help message and exit
  -s, --start 1    start coordinate
  -e, --end ''     end coordinate
  -t, --type ''    filter for a feature type
  -i, --id ''      exact match on a sequence id
  -m, --match ''   regexp match on a sequence id
  -g, --gene ''    filter for a gene name
  -r, --rename ''  rename sequence ids
  -p, --protein    operate on the protein sequences
  -T, --translate  translate DNA
  -R, --revcomp    reverse complement DNA
  -G, --features   extract the fasta for the features
  -A, --trim ''    trim polyA tails (and leading/trailing Ns)
  -o, --olap ''    overlap with coordinate
  -F, --frame 1    reading frame
```


## bio_gff

### Tool Description
Parses and filters GFF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-s 1] [-e ''] [-t ''] [-i ''] [-m ''] [-g ''] [-o ''] [-r '']
           [fnames ...]

positional arguments:
  fnames           input files

options:
  -h, --help       show this help message and exit
  -s, --start 1    start coordinate
  -e, --end ''     end coordinate
  -t, --type ''    filter for a feature type
  -i, --id ''      filter for a sequence id
  -m, --match ''   regexp match on a name
  -g, --gene ''    filter for a gene name
  -o, --olap ''    overlap with coordinate
  -r, --rename ''  rename sequence ids
```


## bio_table

### Tool Description
Generates tabular output from data.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-s 1] [-e ''] [-t ''] [-i ''] [-m ''] [-g ''] [-r ''] [-o '']
           [-f id,type,size]
           [fnames ...]

Generates tabular output from data.

positional arguments:
  fnames                input files

options:
  -h, --help            show this help message and exit
  -s, --start 1         start coordinate
  -e, --end ''          end coordinate
  -t, --type ''         filter for a feature type
  -i, --id ''           exact match on a sequence id
  -m, --match ''        regexp match on a sequence id
  -g, --gene ''         filter for a gene name
  -r, --rename ''       rename sequence ids
  -o, --olap ''         overlap with coordinate
  -f, --fields id,type,size
                        table fields (default: id,size)
```


## bio_align

### Tool Description
Perform sequence alignment

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-o 11] [-x 1] [-M ''] [-L] [-G] [-m 1] [-i 2] [-S] [-V] [-T]
           [-d] [-p] [-F] [-A]
           [sequences ...]

positional arguments:
  sequences

options:
  -h, --help        show this help message and exit
  -o, --open 11     gap open penalty
  -x, --extend 1    gap extend penalty
  -M, --matrix ''   matrix default: NUC4.4. or BLOSUM62)
  -L, --local       local alignment
  -G, --global      local alignment
  -m, --match 1     alignment match (DNA only)
  -i, --mismatch 2  alignment mismatch (DNA only)
  -S, --semiglobal  local alignment
  -V, --vcf         output vcf file
  -T, --table       output in tabular format
  -d, --diff        output mutations
  -p, --pile        output pileup
  -F, --fasta       output variant columns
  -A, --all         show all alignments
```


## bio_format

### Tool Description
Parses and processes biological sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-s ''] [-e ''] [-d] [-v] [-T] [-p] [fnames ...]

positional arguments:
  fnames

options:
  -h, --help      show this help message and exit
  -s, --start ''  start coordinate
  -e, --end ''    end coordinate
  -d, --diff      output differences
  -v, --vcf       output vcf
  -T, --table     output in tabular format
  -p, --paired    fasta input is pairwise
```


## bio_taxon

### Tool Description
Taxonomic ID lookup and database management tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-L] [-b] [-a] [-K ''] [-R ''] [-f 1] [-l] [-d 0] [-p] [-i 2]
           [-s ,] [-v]
           [terms ...]

positional arguments:
  terms             taxids or search queries

options:
  -h, --help        show this help message and exit
  -L, --lineage     show the lineage for a taxon term
  -b, --build       updates and builds a local database
  -a, --accessions  Print the accessions number for each
  -K, --keep ''     clade to keep
  -R, --remove ''   clade to remove
  -f, --field 1     which column to read when filtering
  -l, --list        lists database content
  -d, --depth 0     how deep to visit a clade
  -p, --preload     loads entire database in memory
  -i, --indent 2    the indentation depth (set to zero for flat)
  -s, --sep ,       separator (default is ', ')
  -v, --verbose     verbose mode, prints more messages
```


## bio_explain

### Tool Description
Search database by ontological name or GO/SO ids.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-b] [-P] [-s] [-g] [-l] [-p ''] [-v] [query ...]

positional arguments:
  query          Search database by ontological name or GO/SO ids.

options:
  -h, --help     show this help message and exit
  -b, --build    build a database of all gene and sequence ontology terms.
  -P, --preload  loads entire database in memory
  -s, --so       Filter query for sequence ontology terms.
  -g, --go       Filter query for gene ontology terms.
  -l, --lineage  show the ontological lineage
  -p, --plot ''  Plot the network graph of the given GO term into the given
                 file name.
  -v, --verbose  verbose mode, prints more messages
```


## bio_meta

### Tool Description
A tool for biological metadata operations.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-H] [-L None] [terms ...]

positional arguments:
  terms

options:
  -h, --help        show this help message and exit
  -H, --header      print header
  -L, --limit None  download limit
```


## bio_mygene

### Tool Description
Download gene information from NCBI Gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-l 5] [-s ''] [-f ''] [-S symbol] [query ...]

positional arguments:
  query                download limit

options:
  -h, --help           show this help message and exit
  -l, --limit 5        download limit
  -s, --species ''     species
  -f, --fields ''      fields
  -S, --scopes symbol  scopes
```


## bio_gprofiler

### Tool Description
Runs the g:Profiler tool on a csv file where one column contains gene names and some column contains pvalues.

Filters the p values by a threshold, then submits the gene names to g:GOSt.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-c edger.csv] [-d mmusculus] [-n gene] [-t 0.05] [-p FDR]
           [-o gprofiler.csv]

Runs the g:Profiler tool on a csv file where one column contains gene names and some column contains pvalues.

Filters the p values by a threshold, then submits the gene names to g:GOSt.

Valid organisms: https://biit.cs.ut.ee/gprofiler/page/organism-list

options:
  -h, --help            show this help message and exit
  -c, --counts edger.csv
                        input counts
  -d, --organism mmusculus
                        input counts
  -n, --colname gene    gene id column name
  -t, --pval-cutoff 0.05
                        pvalue cutoff
  -p, --pval-column FDR
                        pvalue column name
  -o, --output gprofiler.csv
                        pvalue column name
```


## bio_enrichr

### Tool Description
Runs the enrichr tool on a csv file where one column contains gene names and some column contains pvalues.

Filters the p values by a threshold, then submits the gene names to g:GOSt.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-c edger.csv] [-d mmusculus] [-n gene] [-t 0.05] [-p FDR]
           [-o enrichr.csv]

Runs the enrichr tool on a csv file where one column contains gene names and some column contains pvalues.

Filters the p values by a threshold, then submits the gene names to g:GOSt.

Valid organisms: https://biit.cs.ut.ee/gprofiler/page/organism-list

options:
  -h, --help            show this help message and exit
  -c, --counts edger.csv
                        input counts
  -d, --organism mmusculus
                        input counts
  -n, --colname gene    gene id column name
  -t, --pval-cutoff 0.05
                        pvalue cutoff
  -p, --pval-column FDR
                        pvalue column name
  -o, --output enrichr.csv
                        pvalue column name
```


## bio_code

### Tool Description
Biostar Workflows: https://www.biostarhandbook.com/

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
# Writing: src/Test.mk
# Writing: src/data/golden_design.csv
# Writing: src/data/barton_counts.csv
# Writing: src/data/README.md
# Writing: src/data/golden_counts.csv
# Writing: src/data/barton_design.csv
# Writing: src/r/plot_heatmap.r
# Writing: src/r/evaluate_results.r
# Writing: src/r/deseq2.r
# Writing: src/r/create_tx2gene.r
# Writing: src/r/format_featurecounts.r
# Writing: src/r/combine_salmon.r
# Writing: src/r/edger.r
# Writing: src/r/plot_pca.r
# Writing: src/r/simulate_null.r
# Writing: src/r/simulate_counts.r
# Writing: src/recipes/download-data.mk
# Writing: src/recipes/rnaseq-with-salmon.mk
# Writing: src/recipes/genome-assembly.mk
# Writing: src/recipes/cancer-study-snpcall.mk
# Writing: src/recipes/cancer-study-snpeval.mk
# Writing: src/recipes/short-read-alignments.mk
# Writing: src/recipes/variant-calling.mk
# Writing: src/recipes/rnaseq-with-hisat.mk
# Writing: src/run/bioproject.mk
# Writing: src/run/deepvariant.mk
# Writing: src/run/ivar.mk
# Writing: src/run/gatk.mk
# Writing: src/run/refgenie.mk
# Writing: src/run/genbank.mk
# Writing: src/run/bwa.mk
# Writing: src/run/minimap2.mk
# Writing: src/run/curl.mk
# Writing: src/run/time.sh
# Writing: src/run/bcftools.mk
# Writing: src/run/tester.mk
# Writing: src/run/splitchrom.mk
# Writing: src/run/aria.mk
# Writing: src/run/freebayes.mk
# Writing: src/run/wiggle.mk
# Writing: src/run/rsync.mk
# Writing: src/run/snpeff.mk
# Writing: src/run/salmon.mk
# Writing: src/run/bgzip.mk
# Writing: src/run/coverage.mk
# Writing: src/run/bowtie2.mk
# Writing: src/run/vep.mk
# Writing: src/run/star.mk
# Writing: src/run/sra.mk
# Writing: src/run/datasets.mk
# Writing: src/run/fastp.mk
# Writing: src/run/bcftools_parallel.mk
# Writing: src/run/hisat2.mk
# Writing: src/setup/doctor.r
# Writing: src/setup/init-rstudio.r
# Writing: src/setup/README.md
# Writing: src/setup/init-stats.sh
# Writing: src/workflows/airway.mk
# Writing: src/workflows/presenilin.mk
# Writing: src/workflows/benchmark.mk
# Writing: src/workflows/snpcall.mk
# Writing: src/workflows/snpeval.mk
# Writing: src/elixir/HG008-call.mk
# Writing: src/elixir/ebola-snpcall.mk
# Writing: src/elixir/HG008-compare.mk
# Writing: src/elixir/denisovan-snp.mk
# Writing: src/elixir/HG008-data.mk
# Writing: src/elixir/README.md
# Writing: src/elixir/airway-rnaseq.mk
# Created 69 files.
# Biostar Workflows: https://www.biostarhandbook.com/
```


## bio_comm

### Tool Description
A better 'comm' command. Prints elements common from columns from two files.

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-1] [-2] [-3] [-t] [-x 1] [-y 1] file1 file2

A better 'comm' command. Prints elements common from columns from two files.

positional arguments:
  file1         input file 1
  file2         input file 2

options:
  -h, --help    show this help message and exit
  -1, --uniq1   prints elements unique to file 1
  -2, --uniq2   prints elements unique to file 2
  -3, --union   prints elements present in both files
  -t, --tab     tab delimited (default is csv)
  -x, --col1 1  column index for file 1 [default=1]
  -y, --col2 1  column index for file 2 [default=1]
```


## bio_uniq

### Tool Description
N/A

### Metadata
- **Docker Image**: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
- **Homepage**: https://github.com/ialbert/bio
- **Package**: https://anaconda.org/channels/bioconda/packages/bio/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bio [-h] [-f 1] [-c] [-t] [fnames ...]

positional arguments:
  fnames         file names

options:
  -h, --help     show this help message and exit
  -f, --field 1  field index (1 by default)
  -c, --count    produce counts
  -t, --tab      tab delimited (default is csv)
```

