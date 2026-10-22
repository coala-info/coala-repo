# taxtastic CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| taxtastic_taxit_check | PASS | the 16S refpkg validates with exit 0 and no message |
| taxtastic_taxit_create | PASS | refpkg built from 8 real RefSeq 16S sequences, a MAFFT alignment, a FastTree tree and the NCBI taxonomy (rppr is not in the image, so no-reroot is used) |
| taxtastic_taxit_get_descendants | PASS | descendants of Sarbecovirus and Escherichia: 5907 tax_ids including 2697049, 511145, 562 |
| taxtastic_taxit_get_lineage | PASS | lineages of 511145 and 2697049 are correct (Escherichia coli, Betacoronavirus pandemicum, Coronaviridae) |
| taxtastic_taxit_info | Failed | tool bug: the lengths option prints only the header because the file is closed before it is read; seq-names and tally work |
| taxtastic_taxit_lineage_table | PASS | csv lineage table for E. coli and SARS-CoV-2 is correct; the MOTHUR table works for E. coli but crashes (TypeError) for the virus lineage that lacks some ranks |
| taxtastic_taxit_named | Failed | tool bug: the ranked option returns only the no-rank tax_ids (inverted, it should ignore them); without it all four tax_ids are kept |
| taxtastic_taxit_new_database | PASS | real NCBI taxdump downloaded by the tool and loaded into a 1.3 GB SQLite database (2 minutes); network access added |
| taxtastic_taxit_strip | PASS | refpkg copy stripped: log gets a new Stripped entry and the files are unchanged; the folder is staged writable |
| taxtastic_taxit_taxids | Failed | tool bug: crashes with AttributeError 'Engine' object has no attribute 'execute' (taxtastic 0.12.0 with SQLAlchemy 2) |
| taxtastic_taxit_taxtable | PASS | E. coli K-12 MG1655 (511145) and SARS-CoV-2 (2697049) gave 25 lineage rows with the right ranks; also built the table for 8 16S taxa |
| taxtastic_taxit_update_taxids | PASS | obsolete 469598 replaced by 562, unknown id 999999999 dropped and written to the unknowns file |

## taxtastic_taxit_new_database

### Tool Description
Download NCBI taxonomy and create a database

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit new_database [-h] [--schema SCHEMA] [--no-clobber] [-n]
                          [-a {error,warn}] [-z FILE.zip] [-u URL] [-p PATH]
                          [--out OUT]
                          [url]

Download NCBI taxonomy and create a database

Download the current version of the NCBI taxonomy and load it into
``database_file`` as an SQLite3 database.  If ``database_file``
already exists it be will overwritten unless you specify ``--no-clobber``.
The NCBI taxonomy will be downloaded into
the same directory as ``database_file`` will be created in unless you
specify ``-p`` or ``--download-dir``.

positional arguments:
  url                   Database string URI or filename. If no database scheme
                        specified "sqlite:///" will be prepended.
                        [sqlite:///ncbi_taxonomy.db]

options:
  -h, --help            show this help message and exit
  --no-clobber          If database exists keep current data and append new
                        data. [False]
  -n, --no-load         Create schema and exit
  -a, --unknown-action {error,warn}
                        action to perform for unknown ranks [error]
  --out OUT             table sql

database options:
  --schema SCHEMA       Name of SQL schema in database to query (if database
                        flavor supports this).

download options:
  -z, --taxdump-file FILE.zip
                        Location of zipped taxdump file [taxdmp.zip]
  -u, --taxdump-url URL
                        Url to taxdump file
                        [https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdmp.zip]
  -p, --download-dir PATH
                        Name of the directory into which to download the zip
                        archive. [default is the same directory as the
                        database file]
```

## taxtastic_taxit_taxtable

### Tool Description
Create a tabular representation of taxonomic lineages

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit taxtable [-h] [--schema SCHEMA] [-t TAX_IDS [TAX_IDS ...]]
                      [-f FILE] [-i SEQ_INFO] [-a {error,warn}] [-o FILE]
                      [url]

Create a tabular representation of taxonomic lineages

Write a CSV file containing the minimal subset of the taxonomy in
``database_file`` representing all of the lineages specified by the
provided tax_ids. Duplicate tax_ids are ignored.

By default the CSV is written to ``stdout``, unless a file is
specified with ``-o/--outfile``.

positional arguments:
  url                   Database string URI or filename. If no database scheme
                        specified "sqlite:///" will be prepended.
                        [sqlite:///ncbi_taxonomy.db]

options:
  -h, --help            show this help message and exit
  -a, --unknown-action {error,warn}
                        action to perform for tax_ids not present in database
                        [error]

database options:
  --schema SCHEMA       Name of SQL schema in database to query (if database
                        flavor supports this).

input options:
  -t, --tax-ids TAX_IDS [TAX_IDS ...]
                        one or more space-delimited tax_ids (eg "-t 47770
                        33945")
  -f, --tax-id-file FILE
                        File containing a whitespace-delimited list of tax_ids
                        (ie, separated by tabs, spaces, or newlines.
  -i, --seq-info SEQ_INFO
                        Read tax_ids from sequence info file, minimally
                        containing a column named "tax_id"

Output options:
  -o, --outfile FILE    Output file containing lineages for the specified taxa
                        in csv format; writes to stdout if unspecified
```

## taxtastic_taxit_get_lineage

### Tool Description
Calculate the taxonomic lineage of a taxid

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit get_lineage [-h] [--schema SCHEMA] [-o FILE]
                         [url] tax_ids [tax_ids ...]

Calculate the taxonomic lineage of a taxid

positional arguments:
  url                 Database string URI or filename. If no database scheme
                      specified "sqlite:///" will be prepended.
                      [sqlite:///ncbi_taxonomy.db]
  tax_ids

options:
  -h, --help          show this help message and exit
  -o, --outfile FILE

database options:
  --schema SCHEMA     Name of SQL schema in database to query (if database
                      flavor supports this).
```

## taxtastic_taxit_lineage_table

### Tool Description
Create a table of lineages as taxonomic names for a collection of sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit lineage_table [-h] [--seqname-col NAME] [--tax-id-col NAME]
                           [-c FILE] [-t FILE]
                           FILE FILE

Create a table of lineages as taxonimic names for a collection of sequences

Minimal inputs are a taxtable and a file providing a mapping of
sequence names to tax_ids. Outputs are one or more of:

* a table of taxonomic lineges in csv format

* a "taxonomy" file formatted for MOTHUR
  (https://mothur.org/wiki/Taxonomy_File). Ranks are limited to the
  following, with corresponding abbreviations:

    ('species', 's'),
    ('genus', 'g'),
    ('family', 'f'),
    ('order', 'o'),
    ('class', 'c'),
    ('phylum', 'p'),
    ('domain', 'd'),

  Lineages are truncated to either the most specific defined rank or
  species, and missing tax_names at a given rank are replaced with the
  tax_name of the parent, eg

    "...;f__something;g__<None>;s__whatever"

  would become

    "...;f__something;g__something_unclassified;s__whatever"

options:
  -h, --help            show this help message and exit

input options:
  FILE                  output of "taxit taxtable" containing all tax_ids
                        represented in "seq_info"
  FILE                  csv file providing a mapping of sequence names to
                        tax_ids
  --seqname-col NAME    name of column in "seq_info" containing sequence names
  --tax-id-col NAME     name of column in "seq_info" containing tax_ids

Output options:
  -c, --csv-table FILE  Output file containing lineages for each sequence name
                        in csv format
  -t, --taxonomy-table FILE
                        "taxonomy" file formatted for MOTHUR
```

## taxtastic_taxit_taxids

### Tool Description
Convert a list of taxonomic names into a recursive list of species level tax_ids

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit taxids [-h] [--schema SCHEMA] [-f FILE | -n NAMES] [-o FILE]
                    [url]

Convert a list of taxonomic names into a recursive list of species
leve tax_ids.

``The names to convert can be specified in a text file with one name
per line (the ``-f`` or ``--name-file`` options) or on the command
line as a comma delimited list (the ``-n`` of ``--name`` options).

positional arguments:
  url                   Database string URI or filename. If no database scheme
                        specified "sqlite:///" will be prepended.
                        [sqlite:///ncbi_taxonomy.db]

options:
  -h, --help            show this help message and exit

database options:
  --schema SCHEMA       Name of SQL schema in database to query (if database
                        flavor supports this).

Input options:
  -f, --name-file FILE  file containing a list of taxonomic names, one per
                        line
  -n, --name NAMES      list of taxonomic names provided as a comma-delimited
                        list on the command line

Output options:
  -o, --out FILE        output file
```

## taxtastic_taxit_get_descendants

### Tool Description
Returns given taxids including descendant taxids

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit get_descendants [-h] [--schema SCHEMA] [--out OUT] [url] taxids

Returns given taxids including descendant taxids

positional arguments:
  url              Database string URI or filename. If no database scheme
                   specified "sqlite:///" will be prepended.
                   [sqlite:///ncbi_taxonomy.db]
  taxids           File or comma delimited list of tax_ids

options:
  -h, --help       show this help message and exit
  --out OUT

database options:
  --schema SCHEMA  Name of SQL schema in database to query (if database flavor
                   supports this).
```

## taxtastic_taxit_named

### Tool Description
Filters unclassified, unnamed taxonomy ids

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit named [-h] [--schema SCHEMA] (-t TAX_IDS [TAX_IDS ...] |
                   -f FILE | -i SEQ_INFO) [--ranked] [-o FILE]
                   [url]

Filters unclassified, unnamed taxonomy ids

positional arguments:
  url                   Database string URI or filename. If no database scheme
                        specified "sqlite:///" will be prepended.
                        [sqlite:///ncbi_taxonomy.db]

options:
  -h, --help            show this help message and exit
  -t, --tax-ids TAX_IDS [TAX_IDS ...]
                        one or more space-delimited tax_ids (eg "-t 47770
                        33945")
  -f, --tax-id-file FILE
                        File containing a whitespace-delimited list of tax_ids
                        (ie, separated by tabs, spaces, or newlines.
  -i, --seq-info SEQ_INFO
                        Read tax_ids from sequence info file, minimally
                        containing a column named "tax_id"
  --ranked              Ignore "no rank" taxonomies [False]
  -o, --outfile FILE    Output file containing named taxonomy ids;writes to
                        stdout if unspecified

database options:
  --schema SCHEMA       Name of SQL schema in database to query (if database
                        flavor supports this).
```

## taxtastic_taxit_update_taxids

### Tool Description
Update obsolete tax_ids

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit update_taxids [-h] [--schema SCHEMA] [--delimiter ]
                           [--taxid-column ] [--unknowns ]
                           [-a {drop,ignore,error}] [-o ]
                           infile [url]

Update obsolete tax_ids

Replaces tax_ids as specified in table 'merged' in the taxonomy
database. Use in preparation for ``taxit taxtable``. Takes sequence
info file as passed to ``taxit create --seq-info``

positional arguments:
  infile                Input file with taxids. Use "-" for stdin.
  url                   Database string URI or filename. If no database scheme
                        specified "sqlite:///" will be prepended.
                        [sqlite:///ncbi_taxonomy.db]

options:
  -h, --help            show this help message and exit
  --delimiter           Infile columns delimiter [,]
  --taxid-column        name of column or index if headerless containing
                        tax_ids to be replaced [tax_id]
  --unknowns            optional output file containing rows with unknown
                        tax_ids having no replacements in merged table
  -a, --unknown-action {drop,ignore,error}
                        action to perform for tax_ids with no replacement in
                        merged table [error]
  -o, --outfile         Modified version of input file [stdout]

database options:
  --schema SCHEMA       Name of SQL schema in database to query (if database
                        flavor supports this).
```

## taxtastic_taxit_create

### Tool Description
Create a reference package

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit create [-h] [-c] -P PATH -l LOCUS [-a NAME] [-d TEXT]
                    [-r VERSION] [-f FILE] [-i file] [-m FILE] [-M FILE]
                    [-p FILE] [-R FILE] [-s FILE] [-S FILE] [-t FILE]
                    [-T FILE] [--stats-type {PhyML,FastTree,RAxML}]
                    [--frequency-type {empirical,model}] [--no-reroot]
                    [--rppr RPPR]

Create a reference package

Create a new refpkg at the location specified by the argument to
``-P`` with locus name ``-l``.  All other fields are used to specify
initial metadata and files to add to the refpkg.  If there is already
a refpkg at ``refpkg``, this command will fail unless you specify
``-c`` or ``--clobber``.

options:
  -h, --help            show this help message and exit
  -c, --clobber         Delete an existing reference package.

Required arguments:
  -P, --package-name PATH
                        Name of refpkg to create
  -l, --locus LOCUS     The locus described by the reference package

Package Metadata:
  -a, --author NAME     Person who created the reference package
  -d, --description TEXT
                        An arbitrary description field
  -r, --package-version VERSION
                        Release version for the reference package

Input files:
  -f, --aln-fasta FILE  Multiple alignment in fasta format
  -i, --seq-info file   CSV format file describing the aligned reference
                        sequences, minimally containing the fields "seqname"
                        and "tax_id"
  -m, --mask FILE       Text file containing a mask
  -M, --model-file FILE
                        File containing model information usually the
                        .bestModel file
  -p, --profile FILE    Alignment profile
  -R, --readme FILE     README file describing the reference package
  -s, --tree-stats FILE
                        File containing tree statistics (for example
                        RAxML_info.whatever")
  -S, --aln-sto FILE    Multiple alignment in Stockholm format
  -t, --tree-file FILE  Phylogenetic tree in newick format
  -T, --taxonomy FILE   CSV format file defining the taxonomy. Fields include
                        "tax_id","parent_id","rank","tax_name" followed by a
                        column defining tax_id at each rank starting with root

Tree information:
  --stats-type {PhyML,FastTree,RAxML}
                        stats file type [default: attempt to guess from file
                        contents]
  --frequency-type {empirical,model}
                        Residue frequency type from the model. Required for
                        var in collection: PhyML Amino Acid alignments.

Taxonomic Rerooting:
  --no-reroot           Do not reroot the reference package using `rppr
                        reroot`. [default: reroot if `rppr` is available and a
                        taxonomy file is specified]
  --rppr RPPR           Name of the rppr executable. [default: rppr]
```

## taxtastic_taxit_info

### Tool Description
Show information about reference packages

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit info [-h] [-n] [-t] [-l] refpkg

Show information about reference packages.

positional arguments:
  refpkg           the reference package to operate on

options:
  -h, --help       show this help message and exit
  -n, --seq-names  print a list of sequence names
  -t, --tally      print a tally of sequences representing each taxon at rank
                   RANK
  -l, --lengths    print sequence lengths
```

## taxtastic_taxit_check

### Tool Description
Validate a reference package

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit check [-h] REFPKG

Validate a reference package

Checks whether ``REFPKG`` is a valid input for ``pplacer``, that is,
does it have a FASTA file of the reference sequences; a Stockholm file
of their multiple alignment; a Newick formatted tree build from the
aligned sequences; and all the necessary auxiliary information.

positional arguments:
  REFPKG      Path to Refpkg to check

options:
  -h, --help  show this help message and exit
```

## taxtastic_taxit_strip

### Tool Description
Remove rollback and rollforward information from a refpkg

### Metadata
- **Docker Image**: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
- **Homepage**: https://github.com/fhcrc/taxtastic
- **Package**: https://anaconda.org/channels/bioconda/packages/taxtastic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: taxit strip [-h] refpkg

Remove rollback and rollforward information from a refpkg

Delete everything in the refpkg not relevant to the current state,
including all files no longer referred to, as well as all rollback and
rollforward information. The log is preserved, with a new entry
entered indicating that ``refpkg`` was stripped.

positional arguments:
  refpkg      the reference package to operate on

options:
  -h, --help  show this help message and exit
```

