# gtdb_to_taxdump CWL Generation Report

## gtdb_to_taxdump_gtdb_to_taxdump.py

### Tool Description
Convert Genome Taxonomy Database (GTDB) taxonomy files to NCBI taxdump format (names.dmp & nodes.dmp).

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
- **Homepage**: https://github.com/nick-youngblut/gtdb_to_taxdump
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdb_to_taxdump/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gtdb_to_taxdump/overview
- **Total Downloads**: 822
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nick-youngblut/gtdb_to_taxdump
- **Stars**: N/A
### Original Help Text
```text
usage: gtdb_to_taxdump.py [-h] [-o OUTDIR] [-e EMBL_CODE] [-t TABLE]
                          [-c COLUMN] [--version]
                          tax_file [tax_file ...]

Convert GTDB taxonomy to NCBI taxdump format

positional arguments:
  tax_file              >=1 taxonomy file (or url)

options:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Output directory (Default: .)
  -e EMBL_CODE, --embl-code EMBL_CODE
                        embl code to use for all nodes (Default: XX)
  -t TABLE, --table TABLE
                        Table to append taxIDs to. Accessions used for table join (Default: None)
  -c COLUMN, --column COLUMN
                        Column in --table that contains genome accessions (Default: accession)
  --version             show program's version number and exit

DESCRIPTION:
Convert Genome Taxonomy Database (GTDB) taxonomy files
to NCBI taxdump format (names.dmp & nodes.dmp).

The input can be >=1 tsv file with the GTDB taxonomy
or >=1 url to the tsv file(s). Input can be uncompressed
or gzip'ed.

The input table format should be >=2 columns,
(Column1 = accession, Column2 = gtdb_taxonomy),
and no header.

The *.dmp files are written to `--outdir`.
A tab-delim table of taxID info is written to STDOUT.

If `--table` is provided, then the taxID info is appended
to the provided table file (also see `--column`). The table
must be tab-delimited.

delnodes.dmp & merged.dmp files are also written, but they
are "empty" (only include "#\n").
```


## gtdb_to_taxdump_ncbi-gtdb_map.py

### Tool Description
Map between NCBI & GTDB taxonomies

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
- **Homepage**: https://github.com/nick-youngblut/gtdb_to_taxdump
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdb_to_taxdump/overview
- **Validation**: PASS

### Original Help Text
```text
usage: ncbi-gtdb_map.py [-h] [-o OUTDIR] [-q {ncbi_taxonomy,gtdb_taxonomy}]
                        [-f FRACTION] [-m MAX_TIPS] [-c COLUMN] [-H]
                        [-P PREFIX] [-N] [--completeness COMPLETENESS]
                        [--contamination CONTAMINATION]
                        [--names-dmp NAMES_DMP] [--nodes-dmp NODES_DMP] [-r]
                        [-p PROCS] [-v] [--version]
                        tax_queries gtdb_metadata [gtdb_metadata ...]

Map between NCBI & GTDB taxonomies

positional arguments:
  tax_queries           List of taxa to query (1 per line)
  gtdb_metadata         >=1 gtdb-metadata file (or url)

options:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Output file directory (Default: ncbi-gtdb)
  -q {ncbi_taxonomy,gtdb_taxonomy}, --query-taxonomy {ncbi_taxonomy,gtdb_taxonomy}
                        Taxonomy of the query list (Default: ncbi_taxonomy)
  -f FRACTION, --fraction FRACTION
                        Homogeneity of LCA (fraction) in order to be used (Default: 0.9)
  -m MAX_TIPS, --max-tips MAX_TIPS
                        Max no. of tips used for LCA determination. If more, subsampling w/out replacement (Default: 100)
  -c COLUMN, --column COLUMN
                        Column containing the queries; assuming a tab-delim table (Default: 1)
  -H, --header          Header in table of queries (Default: False)?
  -P PREFIX, --prefix PREFIX
                        Add prefix to all queries such as "s__" (Default: )
  -N, --no-prefix       Strip off any [dpcofgs]__ taxonomic prefixes? (Default: False)
  --completeness COMPLETENESS
                        Only include GTDB genomes w/ >=X CheckM completeness (Default: 50.0)
  --contamination CONTAMINATION
                        Only include GTDB genomes w/ <X CheckM contamination (Default: 5.0)
  --names-dmp NAMES_DMP
                        NCBI names.dmp file. Only needed if providing NCBI taxids (Default: None)
  --nodes-dmp NODES_DMP
                        NCBI nodes.dmp file. Only needed if providing NCBI taxids (Default: None)
  -r, --rename          Write query file with queries renamed? (Default: False)
  -p PROCS, --procs PROCS
                        No. of parallel processes (Default: 1)
  -v, --verbose         Verbose output (Default: False)
  --version             show program's version number and exit

DESCRIPTION:
Using the GTDB metadata table (which contains both NCBI and GTDB taxonomies)
to map taxonomic classifications between the 2 taxonomies.

For example, determine GTDB equivalent of the NCBI taxonomic classifications:
* g__Bacillus
* s__Xanthomonas oryzae
* f__Burkholderiaceae
* s__Methanobrevibacter smithii

Algorithm:
* Read in GTDB metadata (bac and/or arc)
* Convert NCBI & GTDB taxonomies of each entry to a directed acyclic graph (DAG)
  * "accession" used for iips of each taxonomy tree
* Read in taxonomy queries (a file w/ 1 entry per line)
* For each query:
  * Found in reference taxonomy (hit/no-hit)?
  * If in reference taxonomy, get all tips (all accessions) for that node in the DAG
  * For all tips, get LCA in target taxonomy (if NCBI queries, then GTDB is target)
    * Only <= (--max-tips) used to save on time. Tips are subsampled randomly.
    * "fuzzy" LCAs allowed, in which only >= (--fraction) of the tips must have that LCA
  * If no match in reference taxonomy or no LCA that is >= (--fraction), then the 
    target LCA is "unclassified"

Notes:
* The input table of queries should be tab-delimited (select the column with --column).
* Query-target matching is caps-invariant (all converted to lower case for matching)!
* The table can have a header (see --header) and can be compressed via gzip or bzip2.
* See https://github.com/nick-youngblut/gtdb_to_taxdump/tree/master/tests/data/ncbi-gtdb for example queries.

Output:
* Output written to --outdir
* `taxonomy_map_summary.tsv`
  * ncbi_taxonomy
    * NCBI taxonomy name
  * gtdb_taxonomy
    * GTDB taxonomy name
  * lca_frac
    * Fraction of tips with that LCA
  * target_tax_level
    * The taxonomic level of the target (eg., genus or species)
* `queries_renamed.tsv` 
  * if --renamed
  * Note: renaming won't work if using NCBI taxids
  * the format of the output table will match the query table

Examples:

# NCBI => GTDB
python ncbi-gtdb_map.py tests/data/ncbi-gtdb/ncbi_tax_queries.txt https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/ar122_metadata_r95.tar.gz https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/bac120_metadata_r95.tar.gz

# GTDB => NCBI
python ncbi-gtdb_map.py -q gtdb_taxonomy tests/data/ncbi-gtdb/gtdb_tax_queries.txt https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/ar122_metadata_r95.tar.gz https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/bac120_metadata_r95.tar.gz

# NCBI => GTDB, using NCBI taxids
wget ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz
tar -pzxvf taxdump.tar.gz
python ncbi-gtdb_map.py --names-dmp taxdump/names.dmp --nodes-dmp taxdump/nodes.dmp tests/data/ncbi-gtdb/ncbi_taxid_queries.txt https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/ar122_metadata_r95.tar.gz https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/bac120_metadata_r95.tar.gz

# NCBI => GTDB; no lineage prefix ([dpcofgs]__)
python ncbi-gtdb_map.py -N tests/data/ncbi-gtdb/ncbi_tax_queries_noPrefix.txt https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/ar122_metadata_r95.tar.gz https://data.ace.uq.edu.au/public/gtdb/data/releases/release95/95.0/bac120_metadata_r95.tar.gz
```


## gtdb_to_taxdump_gtdb_to_diamond.py

### Tool Description
Convert GTDB taxonomy to input for "diamond makedb --taxonmap"

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
- **Homepage**: https://github.com/nick-youngblut/gtdb_to_taxdump
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdb_to_taxdump/overview
- **Validation**: PASS

### Original Help Text
```text
usage: gtdb_to_diamond.py [-h] [-o OUTDIR] [-t TMPDIR] [-g] [-k] [--version]
                          faa_tarball names_dmp nodes_dmp

Convert GTDB taxonomy to input for "diamond makedb --taxonmap"

positional arguments:
  faa_tarball           tarball of GTDB ref genome gene animo acid data files
  names_dmp             taxdump names.dmp file (eg., from gtdb_to_taxdump.py)
  nodes_dmp             taxdump nodes.dmp file (eg., from gtdb_to_taxdump.py)

options:
  -h, --help            show this help message and exit
  -o OUTDIR, --outdir OUTDIR
                        Output directory (Default: gtdb_to_diamond)
  -t TMPDIR, --tmpdir TMPDIR
                        Temporary directory (Default: gtdb_to_diamond_TMP)
  -g, --gzip            gzip output fasta? (Default: False)
  -k, --keep-temp       Keep temporary output? (Default: False)
  --version             show program's version number and exit

DESCRIPTION:
Convert Genome Taxonomy Database (GTDB) representative genome
gene amino acid sequences to the input files required for 
"diamond makedb --taxonmap", with allows for taxonomic identification
with diamond (LCA-based method).

Example of getting a GTDB faa fasta tarball:
  
  wget https://data.ace.uq.edu.au/public/gtdb/data/releases/release202/202.0/genomic_files_reps/gtdb_proteins_aa_reps_r202.tar.gz

  # also get Struo2 GTDB taxdump files
  wget http://ftp.tue.mpg.de/ebio/projects/struo2/GTDB_release202/taxdump/taxdump.tar.gz
  tar -pzxvf taxdump.tar.gz

Example extraction & formatting of faa files from tarball:

  OUTDIR=gtdb2dmnd_out
  gtdb_to_diamond.py -o $OUTDIR gtdb_proteins_aa_reps_r202.tar.gz taxdump/names.dmp taxdump/nodes.dmp

Example "diamond makedb" run with gtdb_to_diamond.py output files:

  diamond makedb --in $OUTDIR/gtdb_all.faa --db $OUTDIR/GTDB202.dmnd --taxonmap $OUTDIR/accession2taxid.tsv --taxonnodes $OUTDIR/nodes.dmp --taxonnames $OUTDIR/names.dmp
```


## gtdb_to_taxdump_acc2gtdb_tax.py

### Tool Description
Create Sequence accession to TAXID mapping file

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
- **Homepage**: https://github.com/nick-youngblut/gtdb_to_taxdump
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdb_to_taxdump/overview
- **Validation**: PASS

### Original Help Text
```text
usage: acc2gtdb_tax.py [-h] [-t THREADS] [-o OUTFILE] [--version]
                       gtdb_dir names_dmp

Create Sequence accession to TAXID mapping file

positional arguments:
  gtdb_dir              Path to GTDB genome directory
  names_dmp             GTDB names.dmp file created  with gtdb_to_taxdump.py

options:
  -h, --help            show this help message and exit
  -t THREADS, --threads THREADS
                        Number of threads to use  (Default: 2)
  -o OUTFILE, --outfile OUTFILE
                        Output acc2tax file (Default: gtdb.acc2tax.gz)
  --version             show program's version number and exit

DESCRIPTION:
Creates a compressed acc2tax mapping file to retrieve the TAXID
from a sequence accession.
```


## gtdb_to_taxdump_lineage2taxid.py

### Tool Description
Map taxonomic lineages to taxids

### Metadata
- **Docker Image**: quay.io/biocontainers/gtdb_to_taxdump:0.1.9--pyhcf36b3e_0
- **Homepage**: https://github.com/nick-youngblut/gtdb_to_taxdump
- **Package**: https://anaconda.org/channels/bioconda/packages/gtdb_to_taxdump/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lineage2taxid.py [-h] [--lineage-column LINEAGE_COLUMN]
                        [--taxid-column TAXID_COLUMN]
                        [--taxid-rank-column TAXID_RANK_COLUMN] [--version]
                        table_file names_dmp nodes_dmp

Map taxonomic lineages to taxids

positional arguments:
  table_file            Tab-delim input table containing GTDB taxonomic
                        lineages
  names_dmp             NCBI names.dmp file. Only needed if providing NCBI
                        taxids
  nodes_dmp             NCBI nodes.dmp file. Only needed if providing NCBI
                        taxids

options:
  -h, --help            show this help message and exit
  --lineage-column LINEAGE_COLUMN
                        Column name that contains the lineages (default:
                        classification)
  --taxid-column TAXID_COLUMN
                        Name of taxid column that will be appended to the
                        input table (default: taxid)
  --taxid-rank-column TAXID_RANK_COLUMN
                        Name of taxid-rank column that will be appended to the
                        input table (default: taxid_rank)
  --version             show program's version number and exit

DESCRIPTION:
If you have a set of taxonomic lineages (eg., generated from GTDB-Tk)
and need then taxids for the taxonomic lineages, then this script is for you!

Example lineages: 
* d__Bacteria;p__Firmicutes_A;c__Clostridia;o__Oscillospirales;f__Acutalibacteraceae;g__Ruminococcus_E;s__Ruminococcus_E bromii_B
* d__Bacteria;p__Bacteroidota;c__Bacteroidia;o__Bacteroidales;f__Bacteroidaceae;g__Phocaeicola;s__Phocaeicola plebeius_A

Method:
* The nodes.dmp & names.dmp files are loaded as a graph
* For each lineage in the "table_file":
  * From the finest-to-coarsest taxonomic resolution:
    * Find node in graph with that taxonomic classification 
      * Note: captilization invariant
      * If only 1 node (so no duplicate naming), then return that taxid & rank
      * If not, go to next-finest taxonomic resolution
    * If no taxonomic classification can be mapped:
      * Use "NA" and warn the user

Notes:
* The input table file can be compressed via gzip or bzip2
* The input table is assumed to be tab-delimited
* The output is writted to STDOUT
```


## Metadata
- **Skill**: generated
