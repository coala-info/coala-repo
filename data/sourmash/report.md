# sourmash CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| sourmash_compare | PASS |  |
| sourmash_compute | PASS |  |
| sourmash_gather | PASS |  |
| sourmash_index | PASS |  |
| sourmash_lca_classify | PASS |  |
| sourmash_lca_compare_csv | PASS |  |
| sourmash_lca_index | PASS |  |
| sourmash_lca_rankinfo | PASS |  |
| sourmash_lca_summarize | PASS |  |
| sourmash_plot | PASS |  |
| sourmash_prefetch | PASS |  |
| sourmash_search | PASS |  |
| sourmash_sig_cat | PASS |  |
| sourmash_sig_check | PASS |  |
| sourmash_sig_collect | PASS |  |
| sourmash_sig_describe | PASS |  |
| sourmash_sig_downsample | PASS |  |
| sourmash_sig_export | PASS |  |
| sourmash_sig_extract | PASS |  |
| sourmash_sig_fileinfo | PASS |  |
| sourmash_sig_filter | PASS |  |
| sourmash_sig_flatten | PASS |  |
| sourmash_sig_grep | PASS | ran on real data; the --csv option crashes in sourmash 4.9.4 (KeyError), main mode works |
| sourmash_sig_inflate | PASS |  |
| sourmash_sig_ingest | PASS |  |
| sourmash_sig_intersect | PASS |  |
| sourmash_sig_kmers | PASS |  |
| sourmash_sig_manifest | PASS |  |
| sourmash_sig_merge | PASS |  |
| sourmash_sig_overlap | PASS |  |
| sourmash_sig_rename | PASS |  |
| sourmash_sig_split | PASS |  |
| sourmash_sig_subtract | PASS |  |
| sourmash_sketch_dna | PASS |  |
| sourmash_sketch_fromfile | PASS |  |
| sourmash_sketch_protein | PASS |  |
| sourmash_sketch_translate | PASS |  |
| sourmash_storage_convert | PASS |  |
| sourmash_tax_annotate | PASS |  |
| sourmash_tax_genome | PASS |  |
| sourmash_tax_grep | PASS |  |
| sourmash_tax_metagenome | PASS |  |
| sourmash_tax_prepare | PASS |  |
| sourmash_tax_summarize | PASS |  |

## sourmash_compare

### Tool Description
Compares one or more signatures (created with `sketch`) using estimated Jaccard index [1] or (if signatures are created with `-p abund`) the angular similarity [2]).

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

The `compare` subcommand compares one or more signatures (created with
`sketch`) using estimated Jaccard index [1] or (if signatures are
created with `-p abund`) the angular similarity [2]).

The default output is a text display of a similarity matrix where each
entry `[i, j]` contains the estimated Jaccard index between input
signature `i` and input signature `j`.  The output matrix can be saved
to a file with `--output <outfile.mat>` and used with the `sourmash
plot` subcommand (or loaded with `numpy.load(...)`.  Using `--csv
<outfile.csv>` will output a CSV file that can be loaded into other
languages than Python, such as R.

Command line usage:
```
sourmash compare file1.sig [ file2.sig ... ]
```

**Note:** compare by default produces a symmetric similarity matrix that can be used as an input to clustering. With `--containment`, however, this matrix is no longer symmetric and cannot formally be used for clustering.

[1] https://en.wikipedia.org/wiki/Jaccard_index
[2] https://en.wikipedia.org/wiki/Cosine_similarity#Angular_distance_and_similarity

---

create a similarity matrix comparing many samples

positional arguments:
  signatures            list of signatures to compare

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output F        file to which output will be written; default is
                        terminal (standard output)
  --ignore-abundance    do NOT use k-mer abundances even if present
  --containment         calculate containment instead of similarity
  --max-containment     calculate max containment instead of similarity
  --avg-containment, --average-containment
                        calculate average containment instead of similarity
  --estimate-ani, --ANI, --ani
                        return ANI estimated from jaccard, containment,
                        average containment, or max containment; see
                        https://doi.org/10.1101/2022.01.11.475870
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -f, --force           continue past errors in file loading
  --csv F               write matrix to specified file in CSV format (with
                        column headers)
  --labels-to, --labels-save LABELS_TO
                        a CSV file containing label information
  -p, --processes N     Number of processes to use to calculate similarity
  --distance-matrix     output a distance matrix, instead of a similarity
                        matrix
  --similarity-matrix   output a similarity matrix; this is the default
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --scaled FLOAT        downsample to this scaled; value should be between 100
                        and 1e6
```

## sourmash_compute

### Tool Description
Create MinHash sketches at k-mer sizes of 21, 31 and 51, for all FASTA and FASTQ files in the current directory, and save them in signature files ending in '.sig'. You can rapidly compare these files with `compare` and query them with `search`, among other operations; see the full documentation at http://sourmash.rtfd.io/. The key options for compute are:

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

** WARNING: the sourmash compute command is DEPRECATED as of 4.0 and
** will be removed in 5.0. Please see the 'sourmash sketch' command instead.

   sourmash compute -k 21,31,51 *.fa *.fq

Create MinHash sketches at k-mer sizes of 21, 31 and 51, for
all FASTA and FASTQ files in the current directory, and save them in
signature files ending in '.sig'. You can rapidly compare these files
with `compare` and query them with `search`, among other operations;
see the full documentation at http://sourmash.rtfd.io/.

The key options for compute are:

 * `-k/--ksize <int>[, <int>]: k-mer size(s) to use, e.g. -k 21,31,51
 * `-n/--num <int>` or `--scaled <int>`: set size or resolution of sketches
 * `--track-abundance`: track abundances of hashes (default False)
 * `--dna or --protein`: nucleotide and/or protein signatures (default `--dna`)
 * `--merge <name>`: compute a merged signature across all inputs.
 * `--singleton`: compute individual signatures for each sequence.
 * `--name-from-first`: set name of signature from first sequence in file.
 * `-o/--output`: save all computed signatures to this file.

Please see -h for all of the options as well as more detailed help.

---

compute sequence signatures for inputs

Required arguments:
  filenames             file(s) of sequences

Miscellaneous options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  --check-sequence      complain if input sequence is invalid
  --license LICENSE     signature license. Currently only CC0 is supported.

Sketching options:
  -k, --ksizes KSIZES   comma-separated list of k-mer sizes; default=21,31,51
  --track-abundance     track k-mer abundances in the generated signature
  --scaled SCALED       choose number of hashes as 1 in FRACTION of input
                        k-mers
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --input-is-protein    Consume protein sequences - no translation needed.
  --seed SEED           seed used by MurmurHash; default=42
  -n, --num-hashes, --num N
                        num value should be between 50 and 50000

File handling options:
  -f, --force           recompute signatures even if the file exists
  -o, --output OUTPUT   output computed signatures to this file
  --output-dir, --outdir OUTPUT_DIR
                        output computed signatures to this directory
  --singleton           compute a signature for each sequence record
                        individually
  --merge, --name FILE  merge all input files into one signature file with the
                        specified name
  --name-from-first     name the signature generated from each file after the
                        first record in the file
  --randomize           shuffle the list of input filenames randomly
```

## sourmash_gather

### Tool Description
Selects the best reference genomes to use for a metagenome analysis, by finding the smallest set of non-overlapping matches to the query in a database. This is specifically meant for metagenome and genome bin analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

The `gather` subcommand selects the best reference genomes to use for
a metagenome analysis, by finding the smallest set of non-overlapping
matches to the query in a database.  This is specifically meant for
metagenome and genome bin analysis.  (See "Classifying Signatures" [1]
in the command line documentation for more information on the
different approaches that can be used here.)

If the input signature was created with `-p abund`, output
will be abundance weighted (unless `--ignore-abundances` is
specified).  `-o/--output` will create a CSV file containing the
matches.

`gather`, like `search`, will load all of provided signatures into
memory.  You can use `sourmash index` to create a Sequence Bloom Tree
(SBT) that can be quickly searched on disk; this is the same format in
which we provide GenBank and other databases.

Command line usage:
```
sourmash gather query.sig [ list of signatures or SBTs ]
```

Example output for an unweighted/noabund query:
```
overlap     p_query p_match
---------   ------- --------
1.4 Mbp      11.0%  58.0%     JANA01000001.1 Fusobacterium sp. OBRC...
1.0 Mbp       7.7%  25.9%     CP001957.1 Haloferax volcanii DS2 pla...
0.9 Mbp       7.4%  11.8%     BA000019.2 Nostoc sp. PCC 7120 DNA, c...
0.7 Mbp       5.9%  23.0%     FOVK01000036.1 Proteiniclasticum rumi...
0.7 Mbp       5.3%  17.6%     AE017285.1 Desulfovibrio vulgaris sub...
```

Example output for a weighted query:
```
overlap     p_query p_match avg_abund
---------   ------- ------- ---------
9.3 Mbp        0.8%   97.5%       6.7    NC_007951.1 Burkholderia xenovorans ...
7.3 Mbp        2.3%   99.9%      23.9    NC_003272.1 Nostoc sp. PCC 7120 DNA,...
7.0 Mbp        8.9%  100.0%      94.5    BX119912.1 Rhodopirellula baltica SH...
6.6 Mbp        1.4%  100.0%      16.3    NC_009972.1 Herpetosiphon aurantiacu...
...
```

The command line option `--threshold-bp` sets the threshold below
which matches are no longer reported; by default, this is set to
50kb. see the Appendix in Classifying Signatures [1] for details.

Note:

Use `sourmash gather` to classify a metagenome against a collection of
genomes with no (or incomplete) taxonomic information.  Use `sourmash
lca summarize` to classify a metagenome using a collection of genomes
with taxonomic information.

[1] https://sourmash.readthedocs.io/en/latest/classifying-signatures.html

---

search a metagenome signature against dbs

positional arguments:
  query                 query signature
  databases             signatures/SBTs to search

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug
  -n, --num-results N   number of results to report (default: terminate at
                        --threshold-bp)
  -o, --output FILE     output CSV containing matches to this file
  --save-matches FILE   save gather matched signatures from the database to
                        the specified file
  --save-prefetch FILE  save all prefetch-matched signatures from the
                        databases to the specified file or directory
  --save-prefetch-csv FILE
                        save a csv with information from all prefetch-matched
                        signatures to the specified file
  --threshold-bp REAL   reporting threshold (in bp) for estimated overlap with
                        remaining query (default=50kb)
  --output-unassigned FILE
                        output unassigned portions of the query as a signature
                        to the specified file
  --ignore-abundance    do NOT use k-mer abundances if present
  --md5 MD5             select the signature with this md5 as query
  --cache-size N        number of internal SBT nodes to cache in memory
                        (default: 0, cache all nodes)
  --linear              force a low-memory but maybe slower database search
  --no-linear
  --no-prefetch         do not use prefetch before gather; see documentation
  --prefetch            use prefetch before gather; see documentation
  --estimate-ani-ci     also output confidence intervals for ANI estimates
  --fail-on-empty-database
                        stop at databases that contain no compatible
                        signatures
  --no-fail-on-empty-database
                        continue past databases that contain no compatible
                        signatures
  --create-empty-results
                        create an empty results file even if no matches.
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --scaled FLOAT        downsample to this scaled; value should be between 100
                        and 1e6
```

## sourmash_index

### Tool Description
Create an on-disk database of signatures that can be searched quickly & in low memory. All signatures must be scaled, and must be the same k-mer size and molecule type; the standard signature selectors (-k/--ksize, --scaled, --dna/--protein) choose which signatures to be added.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

   sourmash index -k 31 dbname *.sig -F dbtype

Create an on-disk database of signatures that can be searched quickly
& in low memory. All signatures must be scaled, and must be the same
k-mer size and molecule type; the standard signature selectors
(-k/--ksize, --scaled, --dna/--protein) choose which signatures to be
added.

The key options for index are:

 * `-k/--ksize <int>`: k-mer size to select
 * `--dna` or --protein`: nucleotide or protein signatures (default `--dna`)
 * `-F <dbtype>`: 'SBT' (default), 'rocksdb', or 'zip'. 'rocksdb' is recommended and will be come the default in sourmash v5.

---

index signatures for rapid search

positional arguments:
  name                  name to save index under; defaults to {name}.sbt.zip
  signatures            signatures to load into SBT

options:
  -h, --help            show this help message and exit
  -F, --index-type {SBT,rocksdb,zip}
                        type of index to build (default: SBT)
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -q, --quiet           suppress non-error output
  -d, --n_children D    number of children for internal nodes; default=2
  --append              add signatures to an existing SBT
  -x, --bf-size S       Bloom filter size used for internal nodes
  -f, --force           try loading *all* files in provided subdirectories,
                        not just .sig files"
  -s, --sparseness FLOAT
                        What percentage of internal nodes will not be saved;
                        ranges from 0.0 (save all nodes) to 1.0 (no nodes
                        saved)
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --scaled FLOAT        downsample to this scaled; value should be between 100
                        and 1e6
```

## sourmash_plot

### Tool Description
Generate plots from sourmash compare output.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  plot [-h] [--pdf] [--labels] [--no-labels] [--labeltext LABELTEXT]
             [--indices] [--no-indices] [--vmin VMIN] [--vmax VMAX]
             [--subsample N] [--subsample-seed S] [-f] [--output-dir DIR]
             [--csv F] [--labels-from LABELS_FROM]
             distances

positional arguments:
  distances             output from "sourmash compare"

options:
  -h, --help            show this help message and exit
  --pdf                 output PDF; default is PNG
  --labels              show sample labels on dendrogram/matrix
  --no-labels           do not show sample labels
  --labeltext LABELTEXT
                        filename containing list of labels (overrides
                        signature names); implies --labels
  --indices             show sample indices but not labels; overridden by
                        --labels
  --no-indices          do not show sample indices
  --vmin VMIN           lower limit of heatmap scale; default=0.000000
  --vmax VMAX           upper limit of heatmap scale; default=1.000000
  --subsample N         randomly downsample to this many samples, max
  --subsample-seed S    random seed for --subsample; default=1
  -f, --force           forcibly plot non-distance matrices
  --output-dir DIR      directory for output plots
  --csv F               write clustered matrix and labels out in CSV format
                        (with column headers) to this file
  --labels-from, --labels-load LABELS_FROM
                        a CSV file containing label information to use on
                        plot; implies --labels
```

## sourmash_prefetch

### Tool Description
Search for query signatures within specified databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  prefetch [-h] [--db-from-file DB_FROM_FILE] [--linear] [--no-linear]
                 [-q] [-d] [-o FILE] [--save-matches FILE]
                 [--threshold-bp REAL] [--save-unmatched-hashes FILE]
                 [--save-matching-hashes FILE] [--md5 MD5] [--estimate-ani-ci]
                 [-k K] [--protein] [--no-protein] [--dayhoff] [--no-dayhoff]
                 [--hp] [--no-hp] [--skipm1n3] [--no-skipm1n3] [--skipm2n3]
                 [--no-skipm2n3] [--dna] [--no-dna] [--picklist PICKLIST]
                 [--picklist-require-all]
                 [--include-db-pattern INCLUDE_DB_PATTERN]
                 [--exclude-db-pattern EXCLUDE_DB_PATTERN] [--scaled FLOAT]
                 query [databases ...]

positional arguments:
  query                 query signature
  databases             one or more databases to search

options:
  -h, --help            show this help message and exit
  --db-from-file DB_FROM_FILE
                        list of paths containing signatures to search
  --linear              force linear traversal of indexes to minimize loading
                        time and memory use
  --no-linear
  -q, --quiet           suppress non-error output
  -d, --debug
  -o, --output FILE     output CSV containing matches to this file
  --save-matches FILE   save all matching signatures from the databases to the
                        specified file or directory
  --threshold-bp REAL   reporting threshold (in bp) for estimated overlap with
                        remaining query hashes (default=50kb)
  --save-unmatched-hashes FILE
                        output unmatched query hashes as a signature to the
                        specified file
  --save-matching-hashes FILE
                        output matching query hashes as a signature to the
                        specified file
  --md5 MD5             select the signature with this md5 as query
  --estimate-ani-ci     also output confidence intervals for ANI estimates
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --scaled FLOAT        downsample to this scaled; value should be between 100
                        and 1e6
```

## sourmash_search

### Tool Description
Searches a collection of signatures or SBTs for matches to the query signature. It can search for matches with either high Jaccard similarity or containment; the default is to use Jaccard similarity, unless --containment is specified. -o/--output will create a CSV file containing the matches.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

The `search` subcommand searches a collection of signatures or SBTs
for matches to the query signature.  It can search for matches with
either high Jaccard similarity [1] or containment; the default is to
use Jaccard similarity, unless `--containment` is specified.
`-o/--output` will create a CSV file containing the matches.

`search` will load all of provided signatures into memory, which can
be slow and somewhat memory intensive for large collections.  You can
use `sourmash index` to create a Sequence Bloom Tree (SBT) that can be
quickly searched on disk; this is the same format in which we provide
GenBank and other databases.

Command line usage:
```
sourmash search query.sig [ list of signatures or SBTs ]
```

Example output:

```
49 matches; showing first 20:
similarity   match
----------   -----
 75.4%      NZ_JMGW01000001.1 Escherichia coli 1-176-05_S4_C2 e117605...
 72.2%      NZ_GG774190.1 Escherichia coli MS 196-1 Scfld2538, whole ...
 71.4%      NZ_JMGU01000001.1 Escherichia coli 2-011-08_S3_C2 e201108...
 70.1%      NZ_JHRU01000001.1 Escherichia coli strain 100854 100854_1...
 69.0%      NZ_JH659569.1 Escherichia coli M919 supercont2.1, whole g...
...  
```

[1] https://en.wikipedia.org/wiki/Jaccard_index

When `--containment` is provided, the containment of the query in each
of the search signatures or databases is reported.

---

search a signature against other signatures

positional arguments:
  query                 query signature
  databases             signatures/SBTs to search

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           output debug information
  -t, --threshold T     minimum threshold for reporting matches; default=0.08
  --save-matches FILE   output matching signatures to the specified file
  --best-only           report only the best match (with greater speed)
  -n, --num-results N   number of results to display to user; 0 to report all
  --containment         score based on containment rather than similarity
  --max-containment     score based on max containment rather than similarity
  --estimate-ani-ci     for containment searches, also output confidence
                        intervals for ANI estimates
  --ignore-abundance    do NOT use k-mer abundances if present; note: has no
                        effect if --containment or --max-containment is
                        specified
  -o, --output FILE     output CSV containing matches to this file
  --md5 MD5             select the signature with this md5 as query
  --fail-on-empty-database
                        stop at databases that contain no compatible
                        signatures
  --no-fail-on-empty-database
                        continue past databases that contain no compatible
                        signatures
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --scaled FLOAT        downsample to this scaled; value should be between 100
                        and 1e6
```

## sourmash_lca_classify

### Tool Description
Classify query signatures with lowest common ancestor (LCA) databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  classify [-h] [--db DB [DB ...]] [--query [QUERY ...]]
                 [--query-from-file QUERY_FROM_FILE] [--threshold T]
                 [--majority] [-q] [-d] [-o FILE] [--scaled SCALED]

options:
  -h, --help            show this help message and exit
  --db DB [DB ...]      databases to use to classify
  --query [QUERY ...]   query signatures to classify
  --query-from-file QUERY_FROM_FILE
                        file containing list of signature files to query
  --threshold T         minimum number of hashes needed for a taxonomic
                        classification (default: 5)
  --majority            use majority vote classification instead of lca
  -q, --quiet           suppress non-error output
  -d, --debug           output debugging output
  -o, --output FILE     output CSV to the specified file; by default output to
                        stdout
  --scaled SCALED
```

## sourmash_lca_compare_csv

### Tool Description
Compare two taxonomy spreadsheets.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  compare_csv [-h] [-q] [-d] [-C C] [--tabs] [--no-headers] [-f]
                    csv1 csv2

positional arguments:
  csv1                  taxonomy spreadsheet output by classify
  csv2                  custom taxonomy spreadsheet

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           output debugging output
  -C, --start-column C  column at which taxonomic assignments start; default=2
  --tabs                input spreadsheet is tab-delimited; default is commas
  --no-headers          no headers present in taxonomy spreadsheet
  -f, --force
```

## sourmash_lca_index

### Tool Description
Create a lowest common ancestor (LCA) database from signatures and a taxonomy spreadsheet.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  index [-h] [--from-file FROM_FILE] [--scaled S] [-q] [-d] [-C C]
              [--tabs] [--no-headers] [--split-identifiers]
              [--keep-identifier-versions] [-f] [--report REPORT]
              [--require-taxonomy] [--fail-on-missing-taxonomy]
              [-F {json,sql}] [-k K] [--protein] [--no-protein] [--dayhoff]
              [--no-dayhoff] [--hp] [--no-hp] [--skipm1n3] [--no-skipm1n3]
              [--skipm2n3] [--no-skipm2n3] [--dna] [--no-dna]
              [--picklist PICKLIST] [--picklist-require-all]
              csv lca_db_out [signatures ...]

positional arguments:
  csv                   taxonomy spreadsheet
  lca_db_out            output database name
  signatures            signatures or directory of signatures to index
                        (optional if provided via --from-file)

options:
  -h, --help            show this help message and exit
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  --scaled S
  -q, --quiet           suppress non-error output
  -d, --debug           output debugging output
  -C, --start-column C  column at which taxonomic assignments start; default=2
  --tabs                input spreadsheet is tab-delimited; default is commas
  --no-headers          no headers present in taxonomy spreadsheet
  --split-identifiers   split names in signatures on whitespace
  --keep-identifier-versions
                        do not remove accession versions
  -f, --force
  --report REPORT       output a report on anomalies, if any
  --require-taxonomy    ignore signatures with no taxonomy entry
  --fail-on-missing-taxonomy
                        fail quickly if taxonomy is not available for an
                        identifier
  -F, --database-format {json,sql}
                        format of output database; default is 'json')
  -k, --ksize K         k-mer size to select; default=31
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_lca_rankinfo

### Tool Description
Summarize the lineage diversity of k-mers in LCA databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  rankinfo [-h] [-q] [-d] [--scaled FLOAT] [--minimum-num MINIMUM_NUM]
                 db [db ...]

positional arguments:
  db

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           output debugging output
  --scaled FLOAT
  --minimum-num MINIMUM_NUM
                        Minimum number of different lineages a k-mer must be
                        in to be counted
```

## sourmash_lca_summarize

### Tool Description
Summarize the taxonomic content of query signatures with LCA databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  summarize [-h] [--db DB [DB ...]] [--query [QUERY ...]]
                  [--query-from-file QUERY_FROM_FILE] [--threshold T]
                  [-o FILE] [--scaled FLOAT] [--ignore-abundance] [-q] [-d]

options:
  -h, --help            show this help message and exit
  --db DB [DB ...]      one or more LCA databases to use
  --query [QUERY ...]   one or more signature files to use as queries
  --query-from-file QUERY_FROM_FILE
                        file containing list of signature files to query
  --threshold T         minimum number of hashes to require for a match
  -o, --output FILE     file to which CSV output will be written
  --scaled FLOAT        scaled value to downsample to
  --ignore-abundance    ignore hash abundances in query signatures do not
                        weight results
  -q, --quiet           suppress non-error output
  -d, --debug           output debugging output
```

## sourmash_sig_cat

### Tool Description
Concatenate signature files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature cat` - concatenate multiple signatures together

Concatenate signature files.

For example,

sourmash signature cat file1.sig file2.sig -o all.sig

will combine all signatures in `file1.sig` and `file2.sig` and put them
in the file `all.sig`.

concatenate signature files

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -q, --quiet           suppress non-error output
  -d, --debug           provide debugging output
  -o, --output FILE     output signature to this file (default stdout)
  -u, --unique          keep only distinct signatures, removing duplicates
                        (based on md5sum)
  -f, --force           try to load all files as signatures
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_check

### Tool Description
Check signature collections against a picklist.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sig check <filenames> --picklist ... -o miss.csv -m manifest.csv

This will check the signature contents of <filenames> against the given
picklist, optionally outputting the unmatched picklist rows to 'miss.csv'
and optionally outputting a manifest of the matched signatures to
'manifest.csv'.

By default, 'sig check' requires a pre-existing manifest for collections;
this prevents potentially slow manifest rebuilding. You
can turn this check off with '--no-require-manifest'.

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           provide debugging output
  -o, --output-missing FILE
                        output picklist with remaining unmatched entries to
                        this file
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -m, --save-manifest-matching SAVE_MANIFEST_MATCHING
                        save a manifest of the matching entries to this file.
  --fail-if-missing     exit with an error code (-1) if there are any missing
                        picklist values.
  --no-require-manifest
                        do not require a manifest; generate dynamically if
                        needed
  -F, --manifest-format {csv,sql}
                        format of manifest output file; default is 'csv')
  --abspath, --use-absolute-paths
                        convert all locations to absolute paths
  --no-abspath          do not convert all locations to absolute paths
  --relpath, --use-relative-paths
                        convert all locations to paths relative to the output
                        manifest
  --no-relpath          do not convert all locations to paths relative to the
                        output manifest
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --v4                  use sourmash v4 command-line behavior (default)
  --v5                  use sourmash v5 command-line behavior
```

## sourmash_sig_collect

### Tool Description
Collect manifest information across many files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sig collect <filenames> -o all.sqlmf

This will collect manifests from across many files and save the information
into a standalone manifest database.

By default, 'sig collect' requires a pre-existing manifest for collections;
this prevents potentially slow manifest rebuilding. You
can turn this check off with '--no-require-manifest'.

positional arguments:
  locations             locations of input signatures

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   manifest output file
  -q, --quiet           suppress non-error output
  -d, --debug           provide debugging output
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  --no-require-manifest
                        do not require a manifest; generate dynamically if
                        needed
  -F, --manifest-format {csv,sql}
                        format of manifest output file; default is 'csv')
  --merge-previous      merge new manifests into existing
  --abspath, --use-absolute-paths
                        convert all locations to absolute paths
  --no-abspath          do not convert all locations to absolute paths
  --relpath, --use-relative-paths
                        convert all locations to paths relative to the output
                        manifest
  --no-relpath          do not convert all locations to paths relative to the
                        output manifest
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --v4                  use sourmash v4 command-line behavior (default)
  --v5                  use sourmash v5 command-line behavior
```

## sourmash_sig_describe

### Tool Description
Show details of signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature describe` - display detailed information about signatures

Display signature details.

For example,

sourmash sig describe tests/test-data/47.fa.sig

will display:

signature filename: tests/test-data/47.fa.sig
signature: NC_009665.1 Shewanella baltica OS185, complete genome
source file: 47.fa
md5: 09a08691ce52952152f0e866a59f6261
k=31 molecule=DNA num=0 scaled=1000 seed=42 track_abundance=0
size: 5177
signature license: CC0

show details of signature

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           provide debugging output
  --csv FILE            output information to a CSV file
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
```

## sourmash_sig_downsample

### Tool Description
Downsample one or more signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature downsample` - decrease the size of a signature

Downsample one or more signatures.

With `downsample`, you can --

* increase the `scaled` value for a signature created with `-p scaled=SCALED`, shrinking it in size;
* decrease the `num` value for a traditional num MinHash, shrinking it in size;
* try to convert a `scaled` signature to a `num` signature;
* try to convert a `num` signature to a `scaled` signature.

For example,

sourmash signature downsample file1.sig file2.sig --scaled 100000 -o downsampled.sig

will output each signature, downsampled to a scaled value of 100000, to
`downsampled.sig`; and

sourmash signature downsample --num 500 scaled_file.sig -o downsampled.sig

will try to convert a scaled MinHash to a num MinHash.

downsample one or more signatures

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  --scaled SCALED       scaled value to downsample to
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  -f, --force           try to load all files as signatures
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  -n, --num-hashes, --num N
                        num value should be between 50 and 50000
```

## sourmash_sig_export

### Tool Description
Export a signature, for example to mash.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature export` - export signatures to mash.

Export signatures from sourmash format. Currently only supports
mash dump format.

For example,

sourmash signature export filename.sig -o filename.sig.msh.json

export a signature, e.g. to mash

positional arguments:
  filename

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  --md5 MD5             select the signature with this md5 as query
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
```

## sourmash_sig_extract

### Tool Description
Extract one or more signatures from a collection.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature extract` - extract signatures from a collection

Extract the specified signature(s) from a collection of signatures.

For example,

sourmash signature extract *.sig -k 21 --dna -o extracted.sig

will extract all nucleotide signatures calculated at k=21 from all
.sig files in the current directory.

There are currently two other useful selectors for `extract`: you can specify
(part of) an md5sum, as output in the CSVs produced by `search` and `gather`;
and you can specify (part of) a name.

For example,

sourmash signature extract tests/test-data/*.fa.sig --md5 09a0869

will extract the signature from `47.fa.sig` which has an md5sum of
`09a08691ce52952152f0e866a59f6261`; and 

sourmash signature extract tests/test-data/*.fa.sig --name NC_009665

will extract the same signature, which has an accession number of
`NC_009665.1`.

#### Using picklists with `sourmash sig extract`

As of sourmash 4.2.0, `extract` also supports picklists, a feature by
which you can select signatures based on values in a CSV file. See
[the command line docs](https://sourmash.readthedocs.io/en/latest/command-line.html) for more information.

extract one or more signatures

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  --md5 MD5             select signatures whose md5 contains this substring
  --name NAME           select signatures whose name contains this substring
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_fileinfo

### Tool Description
Provide summary information on the given file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sig fileinfo <filename>

This will provide a summary of the sketch contents in the given file.

JSON output can be generated in place of the normal human-readable output
with '--json-out'.

'sig summarize' and 'sig fileinfo' are aliases for the same command.

positional arguments:
  path

options:
  -h, --help          show this help message and exit
  -q, --quiet         suppress non-error output
  -d, --debug         output debug information
  -f, --force         try to load all files as signatures
  --rebuild-manifest  forcibly rebuild the manifest
  --json-out          output information in JSON format only
```

## sourmash_sig_filter

### Tool Description
Filter k-mers (hashes) on abundance.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature filter` - remove hashes based on abundance

Filter the hashes in the specified signature(s) by abundance, by either
`-m/--min-abundance` or `-M/--max-abundance` or both. Abundance selection is
inclusive, so `-m 2 -M 5` will select hashes with abundance greater than
or equal to 2, and less than or equal to 5.

For example,

sourmash signature -m 2 *.sig

will output new signatures containing only hashes that occur two or
more times in each signature.

The `filter` command accepts the same selectors as `extract`.

filter k-mers on abundance

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  --md5 MD5             select signatures whose md5 contains this substring
  --name NAME           select signatures whose name contains this substring
  -m, --min-abundance MIN_ABUNDANCE
                        keep hashes >= this minimum abundance
  -M, --max-abundance MAX_ABUNDANCE
                        keep hashes <= this maximum abundance
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
```

## sourmash_sig_flatten

### Tool Description
Remove abundances from signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature flatten` - remove abundance information from signatures

Flatten the specified signature(s), removing abundances and setting
track_abundance to False.

For example,

sourmash signature flatten *.sig -o flattened.sig

will remove all abundances from all of the .sig files in the current
directory.

The `flatten` command accepts the same selectors as `extract`.

remove abundances

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  --md5 MD5             select signatures whose md5 contains this substring
  --name NAME           select signatures whose name contains this substring
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_grep

### Tool Description
Extract signatures by substring or regular expression match.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
    sourmash sig grep <pattern> <filename> [... <filenames>]

This will search for the provided pattern in the files or databases,
using the signature metadata, and output matching signatures.
Currently 'grep' searches the 'name', 'filename', and 'md5' fields as
displayed by `sig describe`.

'pattern' can be a string or a regular expression.

'sig grep' uses the built-in Python regexp module, 're', to implement
regexp searching. See https://docs.python.org/3/howto/regex.html and
https://docs.python.org/3/library/re.html for details.

The '-v' (exclude), '-i' (case-insensitive), and `-c` (count) options
of 'grep' are supported.

'-o/--output' can be used to output matching signatures to a specific
location.

By default, 'sig grep' requires a pre-existing manifest for collections;
this prevents potentially slow manifest rebuilding. You
can turn this check off with '--no-require-manifest'.

positional arguments:
  pattern               search pattern (string/regex)
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           output debug information
  -o, --output FILE     output matching signatures to this file (default
                        stdout)
  -f, --force           try to load all files as signatures, independent of
                        filename
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -v, --invert-match    select non-matching signatures
  -i, --ignore-case     ignore case distinctions (search lower and upper case
                        both)
  --no-require-manifest
                        do not require a manifest; generate dynamically if
                        needed
  --csv CSV             save CSV file containing signature data in manifest
                        format
  --silent, --no-signatures-output
                        do not output signatures
  -c, --count           only output a count of discovered signatures; implies
                        --silent
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_inflate

### Tool Description
Borrow abundances from one signature and add them to one or more other signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  inflate [-h] [-q] [-o FILE] [-f] [-k K] [--protein] [--no-protein]
                [--dayhoff] [--no-dayhoff] [--hp] [--no-hp] [--skipm1n3]
                [--no-skipm1n3] [--skipm2n3] [--no-skipm2n3] [--dna]
                [--no-dna] [--picklist PICKLIST] [--picklist-require-all]
                signature_from other_sigs [other_sigs ...]

positional arguments:
  signature_from
  other_sigs

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  -f, --force           try to load all files as signatures
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_ingest

### Tool Description
Import a mash or other signature.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

   sourmash sig ingest --csv <input filename> [ <more inputs> ] -o <output>

Ingest num sketches from a simple CSV format, or alternatively a JSON
formatproduced by 'mash info -d'.  The CSV file should contain one
line per sketch, with the first column containing 'murmur64', the
second being '42', the third and fourth being the k-mer size and the
name, and the remaining columns being the hashes.

positional arguments:
  filenames

options:
  -h, --help         show this help message and exit
  --csv              import in Mash CSV format
  -q, --quiet        suppress non-error output
  -o, --output FILE  output signature to this file (default stdout)
```

## sourmash_sig_intersect

### Tool Description
Intersect two or more signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature intersect` - intersect two (or more) signatures

Output the intersection of the hash values in multiple signature files.

For example,

sourmash signature intersect file1.sig file2.sig file3.sig -o intersect.sig

will output the intersection of all the hashes in those three files to
`intersect.sig`.

The `intersect` command flattens all signatures, i.e. the abundances
in any signatures will be ignored and the output signature will have
`track_abundance` turned off. See `sourmash signature flatten` for more details.

Note: `intersect` only creates one output file, with one signature in it.

intersect two or more signatures

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  -A, --abundances-from FILE
                        intersect with & take abundances from this signature
  --set-name SET_NAME   set name for output signature
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_kmers

### Tool Description
Show k-mers and sequences that match the signature hashes.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature kmers` - extract k-mers and/or sequences that match to signatures

Given one or more compatible sketches and some sequence files, extract
the k-mers and/or sequences corresponding to the hash values in the
sketch. Because the sourmash hash function is one-way, this requires
FASTA or FASTQ sequence files in addition to the sketch.

For example,

sourmash sig kmers --signatures sig1.sig --sequences seqfile.fasta     --save-sequences matches.fasta --save-kmers kmer-matches.csv

will search `seqfile.fasta` for matching sequences and k-mers,
and produce two files. The file `matches.fasta` will contain FASTA
sequences that match the hashes in the input signature, while the
file `kmer-matches.csv` provides the matching k-mers and hash values,
together with their originating filename and sequence name.

If the sketch is a protein sketch (protein, dayhoff, or hp), then
the input sequences are assumed to be protein. To search DNA sequences
for translated protein hashes, provide the `--translate` flag to `sig kmers`.

`--save-sequences` and `--save-kmers` are both optional.  If neither are
given, basic statistics on k-mer matching are given.

Please note that `--save-kmers` can be very slow on large files!

The input sketches are the source of the input hashes.  So, for example,
If `--scaled=1` sketches are provided, `sig kmers` can be used to
yield all the k-mers and their matching hashes.  Likewise, if the
sketch is built from the intersection of two other sketches, only
the k-mers and hash values present in both sketches will be used.

Likewise, the input sequences are used for matching; they do not need
to be the same sequences that were used to create the sketches.
Input sequences can be in FASTA or FASTQ format, and either flat text
or compressed with gzip or bzip2; formats are auto-detected.

By default, `sig kmers` ignores bad k-mers (e.g. non-ACGT characters
in DNA). If `--check-sequence` is provided, `sig kmers` will error
exit on the first bad k-mer.  If `--check-sequence --force` is provided,
`sig kmers` will provide error messages (and skip bad sequences), but
will continue processing input sequences.

show k-mers/sequences matching the signature hashes

options:
  -h, --help            show this help message and exit
  --signatures [SIGNATURES ...]
  -q, --quiet           suppress non-error output
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
  --sequences SEQUENCES [SEQUENCES ...]
                        FASTA/FASTQ/bz2/gz files with sequences
  --save-kmers SAVE_KMERS
                        save k-mers and hash values to a CSV file
  --save-sequences SAVE_SEQUENCES
                        save sequences with matching hashes to a FASTA file
  --translate           translate DNA k-mers into amino acids (for protein,
                        dayhoff, and hp sketches)
  --check-sequence      complain if input sequence is invalid (NOTE: only
                        checks DNA)
```

## sourmash_sig_manifest

### Tool Description
Create a manifest for a collection of signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sig manifest <filename> -o manifest.csv

This will output a sourmash manifest in CSV format. This manifest
can be used as a picklist with --picklist manifest.csv::manifest.

The manifest will be rebuilt by iterating over the signatures in the
file unless --no-rebuild-manifest is specified; for large
collections, rebuilding the manifest can take a long time!

See also the 'describe' and 'fileinfo' commands under 'sourmash sig'.

positional arguments:
  location

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           output debug information
  -o, --output, --csv FILE
                        output information to a CSV file
  -f, --force           try to load all files as signatures
  --rebuild-manifest    force rebuilding manifest if available
  --no-rebuild-manifest
                        use existing manifest if available
  -F, --manifest-format {csv,sql}
                        format of manifest output file; default is 'csv')
  --v4                  use sourmash v4 command-line behavior (default)
  --v5                  use sourmash v5 command-line behavior
```

## sourmash_sig_merge

### Tool Description
Merge one or more signatures into one.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature merge` - merge two or more signatures into one

Merge two (or more) signatures.

For example,

sourmash signature merge file1.sig file2.sig -o merged.sig

will output the union of all the hashes in `file1.sig` and `file2.sig`
to `merged.sig`.

All of the signatures passed to merge must either have been created
with `-p abund`, or not.  If they have `track_abundance` on,
then the merged signature will have the sum of all abundances across
the individual signatures.  The `--flatten` flag will override this
behavior and allow merging of mixtures by removing all abundances.

Note: `merge` only creates one output file, with one signature in it,
in the JSON `.sig` format.

merge one or more signatures

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  --flatten             remove abundances from all signatures
  --set-name, --name SET_NAME
                        rename merged signature
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_overlap

### Tool Description
See a detailed comparison of two signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature overlap` - detailed comparison of two signatures' overlap

Display a detailed comparison of two signatures. This calculates the
Jaccard similarity (as in `sourmash compare` or `sourmash search`) and
the Jaccard containment in both directions (as with `--containment`).
It also displays the number of hash values in the union and
intersection of the two signatures, as well as the number of disjoint
hash values in each signature.

This command has two uses - first, it is helpful for understanding how
similarity and containment are calculated, and second, it is useful for
analyzing signatures with very small overlaps, where the similarity
and/or containment might be very close to zero.

For example,

sourmash signature overlap file1.sig file2.sig

will display the detailed comparison of `file1.sig` and `file2.sig`.

see detailed comparison of signatures

positional arguments:
  signature1
  signature2

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
```

## sourmash_sig_rename

### Tool Description
Rename the display name of signatures.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature rename` - rename a signature

Rename the display name for one or more signatures - this is the name
output for matches in `compare`, `search`, `gather`, etc.

For example,

sourmash signature rename file1.sig "new name" -o renamed.sig

will place a renamed copy of the hashes in `file1.sig` in the file
`renamed.sig`. If you provide multiple signatures, all will be renamed
to the same name.

rename signature

positional arguments:
  signatures
  name

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -d, --debug           print debugging output
  -o, --output FILE     output renamed signature to this file (default stdout)
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --include-db-pattern INCLUDE_DB_PATTERN
                        search only signatures that match this pattern in
                        name, filename, or md5
  --exclude-db-pattern EXCLUDE_DB_PATTERN
                        search only signatures that do not match this pattern
                        in name, filename, or md5
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_split

### Tool Description
Split signature files into individual files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature split` - split signatures into individual files

Split each signature in the input file(s) into individual files, with
standardized names.

For example,

sourmash signature split tests/test-data/2.fa.sig

will create 3 files,

`f372e478.k=21.scaled=1000.DNA.dup=0.2.fa.sig`,
`f3a90d4e.k=31.scaled=1000.DNA.dup=0.2.fa.sig`, and
`43f3b48e.k=51.scaled=1000.DNA.dup=0.2.fa.sig`, representing the three
different DNA signatures at different ksizes created from the input file
`2.fa`.

The format of the names of the output files is standardized and stable
for major versions of sourmash: currently, they are period-separated
with fields:

* `md5sum` - a unique hash value based on the contents of the signature.
* `k=<ksize>` - k-mer size.
* `scaled=<scaled>` or `num=<num>` - scaled or num value for MinHash.
* `<moltype>` - the molecule type (DNA, protein, dayhoff, or hp)
* `dup=<n>` - a non-negative integer that prevents duplicate signatures from colliding.
* `basename` - basename of first input file used to create signature; if none provided, or stdin, this is `none`.

If `--outdir` is specified, all of the signatures are placed in outdir.

Note: `split` only saves files in the JSON `.sig` format.

split signature files

positional arguments:
  signatures

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  --output-dir, --outdir OUTPUT_DIR
                        output signatures to this directory
  -f, --force           try to load all files as signatures
  --from-file FROM_FILE
                        a text file containing a list of files to load
                        signatures from
  -E, --extension EXTENSION
                        write files with this extension ('.sig' by default)
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
  --picklist PICKLIST   select signatures based on a picklist, i.e.
                        'file.csv:colname:coltype'
  --picklist-require-all
                        require that all picklist values be found or else fail
```

## sourmash_sig_subtract

### Tool Description
Subtract other signatures from a signature.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

### `sourmash signature subtract` - subtract other signatures from a signature

Subtract all of the hash values from one signature that are in one or more
of the others.

For example,

sourmash signature subtract file1.sig file2.sig file3.sig -o subtracted.sig

will subtract all of the hashes in `file2.sig` and `file3.sig` from
`file1.sig`, and save the new signature to `subtracted.sig`.

To use `subtract` on signatures calculated with
`-p abund`, you must specify `--flatten`.

Note: `subtract` only creates one output file, with one signature in it.

subtract one or more signatures

positional arguments:
  signature_from
  subtraction_sigs

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output FILE     output signature to this file (default stdout)
  --flatten             remove abundance from signatures before subtracting
  -A, --abundances-from FILE
                        intersect with & take abundances from this signature
  --set-name SET_NAME   set name for output signature
  -k, --ksize K         k-mer size to select; no default.
  --protein             choose a protein signature; by default, a nucleotide
                        signature is used
  --no-protein          do not choose a protein signature
  --dayhoff             choose Dayhoff-encoded amino acid signatures
  --no-dayhoff          do not choose Dayhoff-encoded amino acid signatures
  --hp, --hydrophobic-polar
                        choose hydrophobic-polar-encoded amino acid signatures
  --no-hp, --no-hydrophobic-polar
                        do not choose hydrophobic-polar-encoded amino acid
                        signatures
  --skipm1n3, --skipmer-m1n3
                        choose skipmer (m1n3) signatures
  --no-skipm1n3, --no-skipmer-m1n3
                        do not choose skipmer (m1n3) signatures
  --skipm2n3, --skipmer-m2n3
                        choose skipmer (m2n3) signatures
  --no-skipm2n3, --no-skipmer-m2n3
                        do not choose skipmer (m2n3) signatures
  --dna, --rna, --nucleotide
                        choose a nucleotide signature (default: True)
  --no-dna, --no-rna, --no-nucleotide
                        do not choose a nucleotide signature
```

## sourmash_sketch_dna

### Tool Description
Create DNA sketches from nucleotide sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sketch dna data/*.fna.gz

The 'sketch dna' command reads in DNA sequences and outputs DNA
sketches.

By default, 'sketch dna' uses the parameter string 'k=31,scaled=1000,noabund'.

This creates sketches with a k-mer size of 31, a scaled factor of
1000, and no abundance tracking of k-mers.  You can specify one or
more parameter strings of your own with -p, e.g.  'sourmash sketch dna
-p k=31,noabund -p k=21,scaled=100,abund'. Note that a single `-p` parameter string can contain multiple ksize values, but only a single scaled value or abundance value, e.g. -p k=21,k=31,abund

'sourmash sketch' takes input sequences in FASTA and FASTQ,
uncompressed or gz/bz2 compressed.

Please see the 'sketch' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/sourmash-sketch.html

positional arguments:
  filenames             file(s) of sequences

options:
  -h, --help            show this help message and exit
  --license LICENSE     signature license. Currently only CC0 is supported.
  --check-sequence      complain if input sequence is invalid DNA
  -p, --param-string PARAM_STRING
                        signature parameters to use.
  --from-file FROM_FILE
                        a text file containing a list of sequence files to
                        load

File handling options:
  -f, --force           recompute signatures even if the file exists
  -o, --output OUTPUT   output computed signatures to this file
  --set-name, --name, --merge FILE
                        name the output sketch as specified; note, merges all
                        input files while sketching
  --output-dir, --outdir OUTPUT_DIR
                        output computed signatures to this directory
  --singleton           compute a signature for each sequence record
                        individually
  --name-from-first     name the signature generated from each file after the
                        first record in the file
  --randomize           shuffle the list of input filenames randomly
```

## sourmash_sketch_fromfile

### Tool Description
Create sketches in batch from a CSV file of names and sequence files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sketch fromfile <csv file> --output-signatures <location> -p <...>

The 'sketch fromfile' command takes in a CSV file with list of names
and filenames to be used for building signatures. It is intended for
batch use, when building large collections of signatures.

One or more parameter strings must be specified with '-p'.

One or more existing collections of signatures can be provided via
'--already-done' and already-existing signatures (based on name and
sketch type) will not be recalculated or output.

If a location is provided via '--output-signatures', signatures will be saved
to that location.

Please see the 'sketch' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/sourmash-sketch.html

positional arguments:
  csvs                  input CSVs providing 'name', 'genome_filename', and
                        'protein_filename'

options:
  -h, --help            show this help message and exit
  -p, --param-string PARAM_STRING
                        signature parameters to use.
  --already-done ALREADY_DONE [ALREADY_DONE ...]
                        one or more collections of existing signatures to
                        avoid recalculating
  --license LICENSE     signature license. Currently only CC0 is supported.
  --check-sequence      complain if input sequence is invalid (NOTE: only
                        checks DNA)

File handling options:
  -o, --output-signatures OUTPUT_SIGNATURES
                        output computed signatures to this file
  --force-output-already-exists
                        overwrite/append to --output-signatures location
  --ignore-missing      proceed with building possible signatures, even if
                        some input files are missing
  --output-csv-info OUTPUT_CSV_INFO
                        output information about what signatures need to be
                        generated
  --output-manifest-matching OUTPUT_MANIFEST_MATCHING
                        output a manifest file of already-existing signatures
  --report-duplicated   report duplicated names
```

## sourmash_sketch_protein

### Tool Description
Create protein sketches from protein sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sketch protein data/*.fna.gz

The 'sketch protein' command reads in protein sequences and outputs protein
sketches.

By default, 'sketch protein' uses the parameter string
'k=10,scaled=200,noabund'.

This corresponds to an amino-acid k-mer size of 10, a scaled factor
of 200, and no abundance tracking of k-mers. You can specify one or
more parameter strings of your own with -p, e.g. 'sourmash sketch
protein -p k=11,noabund -p k=12,scaled=100,abund'. Note that a single `-p` parameter string can contain multiple ksize values, but only a single scaled value or abundance value e.g. -p k=11,k=12,scaled=100,abund.

'sourmash sketch' takes input sequences in FASTA and FASTQ,
uncompressed or gz/bz2 compressed.

Please see the 'sketch' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/sourmash-sketch.html

positional arguments:
  filenames             file(s) of sequences

options:
  -h, --help            show this help message and exit
  --license LICENSE     signature license. Currently only CC0 is supported.
  -p, --param-string PARAM_STRING
                        signature parameters to use.
  --from-file FROM_FILE
                        a text file containing a list of sequence files to
                        load

File handling options:
  -f, --force           recompute signatures even if the file exists
  -o, --output OUTPUT   output computed signatures to this file
  --set-name, --name, --merge FILE
                        name the output sketch as specified; note, merges all
                        input files while sketching
  --output-dir, --outdir OUTPUT_DIR
                        output computed signatures to this directory
  --singleton           compute a signature for each sequence record
                        individually
  --name-from-first     name the signature generated from each file after the
                        first record in the file
  --randomize           shuffle the list of input filenames randomly
  --dayhoff             compute sketches using the dayhoff alphabet instead
  --hp                  compute sketches using the dayhoff alphabet instead
```

## sourmash_sketch_translate

### Tool Description
Translate DNA sequences and create protein sketches.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash sketch translate data/*.fna.gz

The 'sketch translate' command reads in DNA sequences and outputs protein
sketches.

By default, 'sketch translate' uses the parameter string
'k=10,scaled=200,noabund'.

This corresponds to a DNA k-mer size of 30 (and an amino-acid k-mer size
of 10), a scaled factor of 200, and no abundance tracking of
k-mers. You can specify one or more parameter strings of your own with
-p, e.g. 'sourmash sketch translate -p k=11,noabund -p
k=12,scaled=100,abund'.

'sourmash sketch' takes input sequences in FASTA and FASTQ,
uncompressed or gz/bz2 compressed.

Please see the 'sketch' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/sourmash-sketch.html

positional arguments:
  filenames             file(s) of sequences

options:
  -h, --help            show this help message and exit
  --license LICENSE     signature license. Currently only CC0 is supported.
  --check-sequence      complain if input sequence is invalid DNA
  -p, --param-string PARAM_STRING
                        signature parameters to use.
  --from-file FROM_FILE
                        a text file containing a list of sequence files to
                        load

File handling options:
  -f, --force           recompute signatures even if the file exists
  -o, --output OUTPUT   output computed signatures to this file
  --set-name, --name, --merge FILE
                        name the output sketch as specified; note, merges all
                        input files while sketching
  --output-dir, --outdir OUTPUT_DIR
                        output computed signatures to this directory
  --singleton           compute a signature for each sequence record
                        individually
  --name-from-first     name the signature generated from each file after the
                        first record in the file
  --randomize           shuffle the list of input filenames randomly
  --dayhoff             compute sketches using the dayhoff alphabet instead
  --hp                  compute sketches using the dayhoff alphabet instead
```

## sourmash_storage_convert

### Tool Description
Convert a sequence bloom tree (SBT) index to another storage backend.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage:  convert [-h] [-b BACKEND] sbt

positional arguments:
  sbt                   name to save SBT into

options:
  -h, --help            show this help message and exit
  -b, --backend BACKEND
                        Backend to convert to
```

## sourmash_tax_annotate

### Tool Description
Annotate gather results with taxonomy.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash tax annotate --gather-csv <gather_csv> [ ... ] --taxonomy-csv <taxonomy_csv> [ ... ]

The 'tax annotate' command reads in gather results CSVs and annotates them
 with taxonomic information.

By default, 'tax annotate' produces a gather CSV with an additional 'lineage'
 column containing the taxonomic information for each database match.

Please see the 'tax annotate' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-tax-annotate-annotates-gather-output-with-taxonomy

options:
  -h, --help            show this help message and exit
  -g, --gather-csv [GATHER_CSV ...]
                        CSV output files from sourmash gather
  --from-file FILE      input many gather results as a text file, with one
                        gather CSV per line
  -q, --quiet           suppress non-error output
  -t, --taxonomy-csv, --taxonomy [FILE ...]
                        database lineages CSV
  -o, --output-dir OUTPUT_DIR
                        directory for output files
  --keep-full-identifiers
                        do not split identifiers on whitespace
  --keep-identifier-versions
                        after splitting identifiers, do not remove accession
                        versions
  --fail-on-missing-taxonomy
                        fail quickly if taxonomy is not available for an
                        identifier
  -f, --force           continue past errors in file and taxonomy loading
  --lins, --lin-taxonomy
                        use LIN taxonomy in place of standard taxonomic ranks.
                        Note that the taxonomy CSV must contain LIN lineage
                        information.
  --ictv, --ictv-taxonomy
                        use ICTV taxonomy in place of standard taxonomic
                        ranks. Note that the taxonomy CSV must contain ICTV
                        ranks.
```

## sourmash_tax_genome

### Tool Description
Classify a genome using gather results.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash tax genome --gather-csv <gather_csv> [ ... ] --taxonomy-csv <taxonomy-csv> [ ... ]

The 'tax genome' command reads in genome gather result CSVs and reports likely
classification for each query genome.

By default, classification uses a containment threshold of 0.1,
meaning at least 10 percent of the query was covered by matches with
the reported taxonomic rank and lineage.  You can specify an alternate
classification threshold or force classification by taxonomic rank
instead, e.g. at species or genus-level.

The default output format consists of five columns,
 'query_name,status,rank,fraction,lineage', where 'fraction' is the fraction
 of the query matched to the reported rank and lineage. The 'status' column
 provides additional information on the classification, and can be:
  - 'match' - this query was classified
  - 'nomatch'- this query could not be classified
  - 'below_threshold' - this query was classified at the specified rank,
     but the query fraction matched was below the containment threshold

Use '-F human' to display human-readable output instead.

Optionally, you can report classifications in 'krona' format, but note
that this forces classification by rank, rather than containment threshold.

Please see the 'tax genome' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-tax-genome-classify-a-genome-using-gather-results

options:
  -h, --help            show this help message and exit
  -g, --gather-csv [GATHER_CSV ...]
                        CSVs output by sourmash gather for this sample
  --from-file FILE      input many gather results as a text file, with one
                        gather CSV per line
  -q, --quiet           suppress non-error output
  -t, --taxonomy-csv, --taxonomy [FILE ...]
                        database lineages CSV
  -o, --output-base OUTPUT_BASE
                        base filepath for output file(s) (default stdout)
  --output-dir OUTPUT_DIR
                        directory for output files
  --keep-full-identifiers
                        do not split identifiers on whitespace
  --keep-identifier-versions
                        after splitting identifiers, do not remove accession
                        versions
  --fail-on-missing-taxonomy
                        fail quickly if taxonomy is not available for an
                        identifier
  -F, --output-format [{csv_summary,krona,human,lineage_csv} ...]
                        choose output format(s)
  -f, --force           continue past survivable errors in loading taxonomy
                        database or gather results
  --lins, --lin-taxonomy
                        use LIN taxonomy in place of standard taxonomic ranks.
                        Note that the taxonomy CSV must contain 'lin' lineage
                        information.
  --lingroup, --lingroups FILE
                        CSV containing 'name', 'lin' columns, where 'lin' is
                        the lingroup prefix. Will restrict classification to
                        these groups.
  --ictv, --ictv-taxonomy
                        use ICTV taxonomy in place of standard taxonomic
                        ranks. Note that the taxonomy CSV must contain ICTV
                        ranks.
  --containment-threshold CONTAINMENT_THRESHOLD
                        minimum containment threshold for classification;
                        default=0.1
  --ani-threshold, --aai-threshold ANI_THRESHOLD
                        minimum ANI threshold (nucleotide gather) or AAI
                        threshold (protein gather) for classification;
                        default=None
  -r, --rank, --position, --lin-position RANK
                        For non-default output formats. Classify to this rank
                        (tax genome) or summarize taxonomy at this rank and
                        above (tax metagenome). Note that the taxonomy CSV
                        must contain lineage information at this rank, and
                        that LIN positions start at 0. Choices: 'strain',
                        'species', 'genus', 'family', 'order', 'class',
                        'phylum', 'superkingdom' or an integer LIN position
  --v4                  use sourmash v4 command-line behavior (default)
  --v5                  use sourmash v5 command-line behavior
```

## sourmash_tax_grep

### Tool Description
Search taxonomies for matching strings and create picklists.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash tax grep <term> --taxonomy-csv <taxonomy_file> [ ... ]

`sourmash tax grep` searches taxonomies for matching strings,
optionally restricting the string search to a specific taxonomic rank.
It creates new files containing matching taxonomic entries; these new
files can serve as taxonomies and can also be used as picklists.

`tax grep` only searches taxonomic ranks, not identifier strings.
Use `sig grep` to search for identifiers in sketch collections.

Please see the 'tax grep' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-tax-grep-subset-taxonomies-and-create-picklists-based-on-taxonomy-string-matches

positional arguments:
  pattern

options:
  -h, --help            show this help message and exit
  -r, --rank {superkingdom,phylum,class,order,family,genus,species}
                        search only this rank
  -v, --invert-match    select non-matching lineages
  -i, --ignore-case     ignore case distinctions (search lower and upper case
                        both)
  --silent, --no-picklist-output
                        do not output picklist
  -c, --count           only output a count of discovered lineages; implies
                        --silent
  -q, --quiet           suppress non-error output
  -t, --taxonomy-csv, --taxonomy FILE [FILE ...]
                        database lineages
  -o, --output OUTPUT   output file (defaults to stdout)
  -f, --force           continue past errors in file and taxonomy loading
```

## sourmash_tax_metagenome

### Tool Description
Summarize metagenome content from gather results.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash tax metagenome --gather-csv <gather_csv> [ ... ] --taxonomy-csv <taxonomy-csv> [ ... ]

The 'tax metagenome' command reads in metagenome gather result CSVs and
summarizes by taxonomic lineage.

The default output format consists of four columns,
 'query_name,rank,fraction,lineage', where 'fraction' is the fraction
 of the query matched to that reported rank and lineage. The summarization
 is reported for each taxonomic rank.

Alternatively, you can output results at a specific rank (e.g. species)
in 'krona', 'lineage_summary', and 'human' formats.

Use '-F human' to display human-readable output.

Please see the 'tax metagenome' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-tax-metagenome-summarize-metagenome-content-from-gather-results

options:
  -h, --help            show this help message and exit
  -g, --gather-csv [GATHER_CSV ...]
                        CSVs from sourmash gather
  --from-file FILE      input many gather results as a text file, with one
                        gather CSV per line
  -q, --quiet           suppress non-error output
  -o, --output-base OUTPUT_BASE
                        base filepath for output file(s) (default stdout)
  --output-dir OUTPUT_DIR
                        directory for output files
  -t, --taxonomy-csv, --taxonomy FILE [FILE ...]
                        database lineages CSV
  --keep-full-identifiers
                        do not split identifiers on whitespace
  --keep-identifier-versions
                        after splitting identifiers, do not remove accession
                        versions
  --fail-on-missing-taxonomy
                        fail quickly if taxonomy is not available for an
                        identifier
  -F, --output-format [{human,csv_summary,krona,lineage_summary,kreport,lingroup,bioboxes} ...]
                        choose output format(s)
  -f, --force           continue past errors in taxonomy database loading
  --lins, --lin-taxonomy
                        use LIN taxonomy in place of standard taxonomic ranks.
                        Note that the taxonomy CSV must contain 'lin' lineage
                        information.
  --lingroup, --lingroups FILE
                        CSV containing 'name', 'lin' columns, where 'lin' is
                        the lingroup prefix. For 'tax metagenome' runs with a
                        single 'gather' file (single query), providing this
                        file will allow us to output a 'lingroup' report
                        containing taxonomic summarization for each group. For
                        multiple queries, we recommend the 'csv_summary'
                        output format.
  --ictv, --ictv-taxonomy
                        use ICTV taxonomy in place of standard taxonomic
                        ranks. Note that the taxonomy CSV must contain ICTV
                        ranks.
  -r, --rank, --position, --lin-position RANK
                        For non-default output formats. Classify to this rank
                        (tax genome) or summarize taxonomy at this rank and
                        above (tax metagenome). Note that the taxonomy CSV
                        must contain lineage information at this rank, and
                        that LIN positions start at 0. Choices: 'strain',
                        'species', 'genus', 'family', 'order', 'class',
                        'phylum', 'superkingdom' or an integer LIN position
  --use-abundances      use abundances from sketches if available (for krona
                        and lineage_summary)
  --ignore-abundances, --no-abundances
                        ignore abundances from sketches even if available
  --v4                  use sourmash v4 command-line behavior (default)
  --v5                  use sourmash v5 command-line behavior
```

## sourmash_tax_prepare

### Tool Description
Prepare and combine taxonomy files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash tax prepare --taxonomy-csv <taxonomy_file> [ ... ] -o <output>

The 'tax prepare' command reads in one or more taxonomy databases
and saves them into a new database. It can be used to combine databases
in the desired order, as well as output different database formats.

Please see the 'tax prepare' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/command-line.html#sourmash-tax-prepare-prepare-and-or-combine-taxonomy-files

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -t, --taxonomy-csv, --taxonomy FILE [FILE ...]
                        database lineages
  -o, --output OUTPUT   output file
  -F, --database-format {csv,sql}
                        format of output file; default is 'sql')
  --keep-full-identifiers
                        do not split identifiers on whitespace
  --keep-identifier-versions
                        after splitting identifiers, do not remove accession
                        versions
  --fail-on-missing-taxonomy
                        fail quickly if taxonomy is not available for an
                        identifier
  -f, --force           continue past errors in file and taxonomy loading
```

## sourmash_tax_summarize

### Tool Description
Print summary information for lineage spreadsheets or taxonomy databases.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 

    sourmash tax summarize <taxonomy_file> [ <more files> ... ]

The 'tax summarize' command reads in one or more taxonomy databases
or lineage files (produced by 'tax annotate'), combines them,
and produces a human readable summary.

Please see the 'tax summarize' documentation for more details:
  https://sourmash.readthedocs.io/en/latest/command-line.html#command-line.html#sourmash-tax-summarize-print-summary-information-for-lineage-spreadsheets-or-taxonomy-databases

positional arguments:
  FILE                  database lineages

options:
  -h, --help            show this help message and exit
  -q, --quiet           suppress non-error output
  -o, --output-lineage-information OUTPUT_LINEAGE_INFORMATION
                        output a CSV file containing individual lineage counts
  --keep-full-identifiers
                        do not split identifiers on whitespace
  --keep-identifier-versions
                        after splitting identifiers, do not remove accession
                        versions
  -f, --force           continue past errors in file and taxonomy loading
  --lins, --lin-taxonomy
                        use LIN taxonomy in place of standard taxonomic ranks.
  --ictv, --ictv-taxonomy
                        use ICTV taxonomy in place of standard taxonomic
                        ranks. Note that the taxonomy CSV must contain ICTV
                        ranks.
```

## Metadata
- **Skill**: generated
