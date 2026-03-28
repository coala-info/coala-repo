# sourmash CWL Generation Report

## sourmash_compare

### Tool Description
Compares one or more signatures (created with `sketch`) using estimated Jaccard index [1] or (if signatures are created with `-p abund`) the angular similarity [2]).

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Total Downloads**: 278.8K
- **Last updated**: 2025-08-07
- **GitHub**: https://github.com/sourmash-bio/sourmash
- **Stars**: N/A
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
Create MinHash sketches at k-mer sizes of 21, 31 and 51, for
all FASTA and FASTQ files in the current directory, and save them in
signature files ending in '.sig'. You can rapidly compare these files
with `compare` and query them with `search`, among other operations; see the full documentation at http://sourmash.rtfd.io/.
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


## sourmash_info

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
[K
== This is sourmash version 4.9.4. ==

[K== Please cite Irber et. al (2024), doi:10.21105/joss.06830. ==


[Ksourmash version 4.9.4

[K- loaded from path: /usr/local/lib/python3.13/site-packages/sourmash/cli

[K
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


## sourmash_lca

### Tool Description
Taxonomic utilities

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
Taxonomic utilities:
  Operations
          sourmash lca classify --help      classify genomes
          sourmash lca compare_csv --help   compare spreadsheets
          sourmash lca index --help         create LCA database
          sourmash lca rankinfo --help      database rank info
          sourmash lca summarize --help     summarize mixture

Options:
  -h, --help  show this help message and exit
```


## sourmash_sig

### Tool Description
Manipulate signature files

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
Manipulate signature files:
  Operations
          sourmash sig cat --help           concatenate signature files
          sourmash sig check --help         check signature collections against a picklist
          sourmash sig collect --help       collect manifest information across many files
          sourmash sig describe --help      show details of signature
          sourmash sig downsample --help    downsample one or more signatures
          sourmash sig export --help        export a signature, e.g. to mash
          sourmash sig extract --help       extract one or more signatures
          sourmash sig fileinfo --help      provide summary information on the given file
          sourmash sig filter --help        filter k-mers on abundance
          sourmash sig flatten --help       remove abundances
          sourmash sig grep --help          extract one or more signatures by substr/regex match
          sourmash sig inflate --help       borrow abundances from one signature => one or more other signatures
          sourmash sig ingest --help        ingest/import a mash or other signature
          sourmash sig intersect --help     intersect two or more signatures
          sourmash sig kmers --help         show k-mers/sequences matching the signature hashes
          sourmash sig manifest --help      create a manifest for a collection of signatures
          sourmash sig merge --help         merge one or more signatures
          sourmash sig overlap --help       see detailed comparison of signatures
          sourmash sig rename --help        rename signature
          sourmash sig split --help         split signature files
          sourmash sig subtract --help      subtract one or more signatures

Options:
  -h, --help  show this help message and exit
```


## sourmash_signature

### Tool Description
Manipulate signature files

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
Manipulate signature files:
  Operations
          sourmash sig cat --help           concatenate signature files
          sourmash sig check --help         check signature collections against a picklist
          sourmash sig collect --help       collect manifest information across many files
          sourmash sig describe --help      show details of signature
          sourmash sig downsample --help    downsample one or more signatures
          sourmash sig export --help        export a signature, e.g. to mash
          sourmash sig extract --help       extract one or more signatures
          sourmash sig fileinfo --help      provide summary information on the given file
          sourmash sig filter --help        filter k-mers on abundance
          sourmash sig flatten --help       remove abundances
          sourmash sig grep --help          extract one or more signatures by substr/regex match
          sourmash sig inflate --help       borrow abundances from one signature => one or more other signatures
          sourmash sig ingest --help        ingest/import a mash or other signature
          sourmash sig intersect --help     intersect two or more signatures
          sourmash sig kmers --help         show k-mers/sequences matching the signature hashes
          sourmash sig manifest --help      create a manifest for a collection of signatures
          sourmash sig merge --help         merge one or more signatures
          sourmash sig overlap --help       see detailed comparison of signatures
          sourmash sig rename --help        rename signature
          sourmash sig split --help         split signature files
          sourmash sig subtract --help      subtract one or more signatures

Options:
  -h, --help  show this help message and exit
```


## sourmash_sketch

### Tool Description
Create signatures

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
Create signatures:
  Operations
          sourmash sketch dna --help        create DNA signatures
          sourmash sketch fromfile --help   create signatures from a CSV file
          sourmash sketch protein --help    create protein signatures
          sourmash sketch translate --help  create protein signature from DNA/RNA sequence

Options:
  -h, --help  show this help message and exit
```


## sourmash_storage

### Tool Description
Storage utilities

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
Storage utilities:
  Operations
          sourmash storage convert --help   'sourmash storage convert' - convert an SBT to use a different back end.

Options:
  -h, --help  show this help message and exit
```


## sourmash_tax

### Tool Description
Integrate taxonomy information based on 'gather' results

### Metadata
- **Docker Image**: quay.io/biocontainers/sourmash:4.9.4--hdfd78af_0
- **Homepage**: https://github.com/sourmash-bio/sourmash
- **Package**: https://anaconda.org/channels/bioconda/packages/sourmash/overview
- **Validation**: PASS

### Original Help Text
```text
Integrate taxonomy information based on 'gather' results:
  Operations
          sourmash tax annotate --help      annotate gather results with taxonomy information
          sourmash tax genome --help        classify genomes from gather results
          sourmash tax grep --help          search taxonomies and output picklists.
          sourmash tax metagenome --help    summarize metagenome gather results
          sourmash tax prepare --help       combine multiple taxonomy databases into one.
          sourmash tax summarize --help     summarize taxonomy/lineage information

Options:
  -h, --help  show this help message and exit
```


## Metadata
- **Skill**: generated
