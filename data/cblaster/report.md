# cblaster CWL Generation Report

## cblaster_gui

### Tool Description
A tool for finding homologous sequences in a database using BLAST.

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Total Downloads**: 17.5K
- **Last updated**: 2025-10-31
- **GitHub**: https://github.com/gamcil/cblaster
- **Stars**: N/A
### Original Help Text
```text
Importing genomicsqlite failed, falling back to SQLite3
Traceback (most recent call last):
  File "/usr/local/bin/cblaster", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.14/site-packages/cblaster/main.py", line 420, in main
    set_entrez()
    ~~~~~~~~~~^^
  File "/usr/local/lib/python3.14/site-packages/cblaster/main.py", line 42, in set_entrez
    cfg = config.get_config_parser()
  File "/usr/local/lib/python3.14/site-packages/cblaster/config.py", line 20, in get_config_parser
    raise IOError("No configuration folder detected, please run cblaster config")
OSError: No configuration folder detected, please run cblaster config
```


## cblaster_makedb

### Tool Description
Generate local databases from genome files

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cblaster makedb [-h] -n NAME [-cp CPUS] [-b BATCH] [-f]
                       paths [paths ...]

Generate local databases from genome files

positional arguments:
  paths              Path/s to genome files to use when building local
                     databases (can be gzipped). Alternatively, path to one
                     .txt file with one genome file per line.

options:
  -h, --help         show this help message and exit
  -n, --name NAME    Name to use when building sqlite3/diamond databases (with
                     extensions .sqlite3 and .dmnd, respectively)
  -cp, --cpus CPUS   Number of CPUs to use when parsing genome files. By
                     default, all available cores will be used.
  -b, --batch BATCH  Number of genome files to parse before saving them in the
                     local database. Useful when encountering memory issues
                     with large/many files. By default, all genome files will
                     be parsed at once.
  -f, --force        Overwrite pre-existing files, if any
```


## cblaster_search

### Tool Description
Remote/local cblaster searches.

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cblaster search [-h] [-qf QUERY_FILE] [-qi QUERY_IDS [QUERY_IDS ...]]
                       [-qp QUERY_PROFILES [QUERY_PROFILES ...]] [-o OUTPUT]
                       [-ohh] [-ode OUTPUT_DELIMITER] [-odc OUTPUT_DECIMALS]
                       [-osc] [-b BINARY] [-bhh] [-bde BINARY_DELIMITER]
                       [-bkey {len,max,sum}]
                       [-bat {identity,coverage,bitscore,evalue}]
                       [-bdc BINARY_DECIMALS] [-p [PLOT]]
                       [-mpc MAX_PLOT_CLUSTERS] [--blast_file BLAST_FILE]
                       [--ipg_file IPG_FILE]
                       [-m {local,remote,hmm,combi_local,combi_remote}]
                       [-db DATABASE [DATABASE ...]] [-cp CPUS]
                       [-pfam DATABASE_PFAM] [-eq ENTREZ_QUERY] [--rid RID]
                       [-s [SESSION_FILE ...]] [-rcp [RECOMPUTE]]
                       [-hs HITLIST_SIZE]
                       [-ds {fast,mid,sensitive,more,very,ultra}] [-g GAP]
                       [-u UNIQUE] [-mh MIN_HITS] [-r REQUIRE [REQUIRE ...]]
                       [-per PERCENTAGE] [-me MAX_EVALUE] [-mi MIN_IDENTITY]
                       [-mc MIN_COVERAGE] [-ig] [-md MAX_DISTANCE]
                       [-mic MAXIMUM_CLUSTERS]

Remote/local cblaster searches.

options:
  -h, --help            show this help message and exit

Input:
  -qf, --query_file QUERY_FILE
                        Path to FASTA file containing protein sequences to be
                        searched
  -qi, --query_ids QUERY_IDS [QUERY_IDS ...]
                        A collection of valid NCBI sequence identifiers to be
                        searched
  -qp, --query_profiles QUERY_PROFILES [QUERY_PROFILES ...]
                        A collection of valid Pfam profile identifiers to be
                        searched

Output:
  -o, --output OUTPUT   Write results to file
  -ohh, --output_hide_headers
                        Hide headers when printing result output.
  -ode, --output_delimiter OUTPUT_DELIMITER
                        Delimiter character to use when printing result
                        output.
  -odc, --output_decimals OUTPUT_DECIMALS
                        Total decimal places to use when printing score values
  -osc, --sort_clusters
                        Sorts the clusters of the final output on score. This
                        means that clusters of the same organism are not
                        neccesairily close together in the output.
  -b, --binary BINARY   Generate a binary table.
  -bhh, --binary_hide_headers
                        Hide headers in the binary table.
  -bde, --binary_delimiter BINARY_DELIMITER
                        Delimiter used in binary table (def. none = human
                        readable).
  -bkey, --binary_key {len,max,sum}
                        Key function used when generating binary table cell
                        values.
  -bat, --binary_attr {identity,coverage,bitscore,evalue}
                        Hit attribute used when generating binary table cell
                        values.
  -bdc, --binary_decimals BINARY_DECIMALS
                        Total decimal places to use when printing score values
  -p, --plot [PLOT]     Generate a cblaster plot. If this argument is
                        specified with no file name, the plot will be served
                        using Python's HTTP server. If a file name is
                        specified, a static HTML file will be generated at
                        that path.
  -mpc, --max_plot_clusters MAX_PLOT_CLUSTERS
                        The maximum amount of clusters included in the plot
                        when sorting clusters on score, meaning -osc has to be
                        used for this argument to take effect. (def 50)
  --blast_file BLAST_FILE
                        Save BLAST/DIAMOND hit table to file
  --ipg_file IPG_FILE   Save IPG table to file (only if --mode remote)

Searching:
  -m, --mode {local,remote,hmm,combi_local,combi_remote}
                        cblaster search mode
  -db, --database DATABASE [DATABASE ...]
                        Database to be searched. Remote search mode: NCBI
                        database name (def. 'nr'); local search mode: path to
                        DIAMOND database; HMM search mode: path to FASTA file.
                        In local/hmm/combined modes, must have cblaster
                        database in same location with same name and .sqlite3
                        extension.
  -cp, --cpus CPUS      Number of CPUs to use in local search. By default, all
                        available cores will be used.
  -pfam, --database_pfam DATABASE_PFAM
                        Path to folder containing Pfam database files
                        (Pfam-A.hmm.gz and Pfam-A.dat.gz). If not found,
                        cblaster will download the latest Pfam release to this
                        folder. This option is required when running HMM or
                        combi search modes.
  -eq, --entrez_query ENTREZ_QUERY
                        An NCBI Entrez search term for pre-search filtering of
                        an NCBI database when using command line BLASTp (i.e.
                        only used if 'remote' is passed to --mode); e.g.
                        "Aspergillus"[organism]
  --rid RID             Request Identifier (RID) for a web BLAST search. This
                        is only used if 'remote' is passed to --mode. Useful
                        if you have previously run a web BLAST search and want
                        to directly retrieve those results instead of running
                        a new search.
  -s, --session_file [SESSION_FILE ...]
                        Load session from JSON. If the specified file does not
                        exist, the results of the new search will be saved to
                        this file.
  -rcp, --recompute [RECOMPUTE]
                        Recompute previous search session using new
                        thresholds. The filtered session will be written to
                        the file specified by this argument. If this argument
                        is specified with no value, the session will be
                        filtered but not saved (e.g. for plotting purposes).
  -hs, --hitlist_size HITLIST_SIZE
                        Maximum total hits to save from a local or remote
                        BLAST search (def. 500). Setting this value too low
                        may result in missed hits/clusters.
  -ds, --dmnd_sensitivity {fast,mid,sensitive,more,very,ultra}
                        Level of sensitivity to use in local DIAMOND searches
                        (def. 'fast')

Clustering:
  -g, --gap GAP         Maximum allowed intergenic distance (bp) between
                        conserved hits to be considered in the same block
                        (def. 20000)
  -u, --unique UNIQUE   Minimum number of unique query sequences that must be
                        conserved in a hit cluster (def. 3)
  -mh, --min_hits MIN_HITS
                        Minimum number of hits in a cluster (def. 3)
  -r, --require REQUIRE [REQUIRE ...]
                        Names of query sequences that must be represented in a
                        hit cluster
  -per, --percentage PERCENTAGE
                        Percentage of query genes required to be present in
                        cluster

Filtering:
  -me, --max_evalue MAX_EVALUE
                        Maximum e-value for a BLAST hit to be saved (def.
                        0.01)
  -mi, --min_identity MIN_IDENTITY
                        Minimum percent identity for a BLAST hit to be saved
                        (def. 30)
  -mc, --min_coverage MIN_COVERAGE
                        Minimum percent query coverage for a BLAST hit to be
                        saved (def. 50)

Intermediate genes:
  -ig, --intermediate_genes
                        Show genes that in or near clusters but not part of
                        the cluster. This takes some extra computation time.
  -md, --max_distance MAX_DISTANCE
                        The maximum distance between the start/end of a
                        cluster and an intermediate gene (def. 5000)
  -mic, --maximum_clusters MAXIMUM_CLUSTERS
                        The maximum amount of clusters will get intermediate
                        genes assigned. Ordered on score (def. 100)

Example usage
-------------
Run a remote cblaster search, save the session and generate a plot:
  $ cblaster search -qf query.fa -s session.json -p

Recompute a search session with new parameters:
  $ cblaster search -s session.json -rcp new.json -u 4 -g 40000

Merge multiple search sessions:
  $ cblaster search -s one.json two.json three.json -rcp merged.json

Perform a local search:
  $ cblaster makedb $(ls folder/*.gbk) mydb
  $ cblaster search -qf query.fa -db mydb.dmnd -jdb mydb.json

Save plot as a static HTML file:
  $ cblaster search -s session.json -p gne.html

Kitchen sink example:
  $ cblaster search --query_file query.fa \ 
      --session_file session.json \ 
      --plot my_plot.html \ 
      --output summary.csv --output_decimals 2 \ 
      --binary abspres.csv --binary_delimiter "," \ 
      --entrez_query "Aspergillus"[orgn] \ 
      --max_evalue 0.05 --min_identity 50 --min_coverage 70 \ 
      --gap 50000 --unique 2 --min_hits 3 --require Gene1 Gene2

Cameron Gilchrist, 2020
```


## cblaster_gne

### Tool Description
Gene neighbourhood estimation.
Repeatedly recomputes homologue clusters with different --gap values.

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cblaster gne [-h] [--max_gap MAX_GAP] [--samples SAMPLES]
                    [--scale {linear,log}] [-o OUTPUT] [-hh] [-d DELIMITER]
                    [-e DECIMALS] [-p [PLOT]]
                    session

Gene neighbourhood estimation.
Repeatedly recomputes homologue clusters with different --gap values.

positional arguments:
  session               cblaster session file

options:
  -h, --help            show this help message and exit

Parameters:
  --max_gap MAX_GAP     Maximum intergenic distance (def. 100000)
  --samples SAMPLES     Total samples taken from max_gap (def. 100)
  --scale {linear,log}  Draw sampling values from a linear or log scale (def.
                        linear)

Output:
  -o, --output OUTPUT   Write results to file
  -hh, --hide_headers   Hide headers when printing result output.
  -d, --delimiter DELIMITER
                        Delimiter character to use when printing result
                        output.
  -e, --decimals DECIMALS
                        Total decimal places to use when printing score values
  -p, --plot [PLOT]     Specify this argument without value to dynamically
                        serve te plot. If a file location is provided the plot
                        will be saved there.

Example usage
-------------
Maximum gap value 200Kbp, with 200 evenly distributed gap values:
  $ cblaster gne session.json --max_gap 200000 --samples 200 --scale linear

Draw gap values from a log scale (gaps increase as values increase):
  $ cblaster gne session.json --scale log

Save delimited tabular output:
  $ cblaster gne session.json --output gne.csv --delimiter ","

Save plot as a static HTML file:
  $ cblaster gne session.json -p gne.html

Cameron Gilchrist, 2020
```


## cblaster_extract

### Tool Description
Extract information from session files

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cblaster extract [-h] [-q QUERIES [QUERIES ...]]
                        [-or ORGANISMS [ORGANISMS ...]]
                        [-sc SCAFFOLDS [SCAFFOLDS ...]] [-o OUTPUT] [-es]
                        [-no] [-de DELIMITER]
                        session

Extract information from session files

positional arguments:
  session               cblaster session file

options:
  -h, --help            show this help message and exit

Filters:
  -q, --queries QUERIES [QUERIES ...]
                        IDs of query sequences
  -or, --organisms ORGANISMS [ORGANISMS ...]
                        Organism names, accepts regular expressions
  -sc, --scaffolds SCAFFOLDS [SCAFFOLDS ...]
                        Scaffold names/ranges, in the form
                        scaffold_name:start-stop

Output:
  -o, --output OUTPUT   Output file name
  -es, --extract_sequences
                        Extract sequences, in FASTA format, for each extracted
                        record
  -no, --name_only      Do not save sequence descriptions (i.e. no genomic
                        coordinates)
  -de, --delimiter DELIMITER
                        Sequence description delimiter

Example usage
-------------
Extract names of sequences matching a specific query:
  $ cblaster extract session.json -q "Query1"

Extract, download from NCBI and write to file in FASTA format:
  $ cblaster extract session.json -q "Query1" -es -o output.fasta

Extract only from specific organisms (regular expressions):
  $ cblaster extract session.json -or "Aspergillus.*" "Penicillium.*"

Generate delimited table (CSV) of all hits in clusters:
  $ cblaster extract session.json -de ","

Cameron Gilchrist, 2020
```


## cblaster_extract_clusters

### Tool Description
Extract clusters from a session file

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cblaster extract_clusters [-h] [-c CLUSTERS [CLUSTERS ...]]
                                 [-st SCORE_THRESHOLD]
                                 [-or ORGANISMS [ORGANISMS ...]]
                                 [-sc SCAFFOLDS [SCAFFOLDS ...]] -o OUTPUT
                                 [-pf PREFIX] [-f {genbank,bigscape}]
                                 [-mc MAXIMUM_CLUSTERS]
                                 session

Extract clusters from a session file

positional arguments:
  session               cblaster session file

options:
  -h, --help            show this help message and exit

Filters:
  -c, --clusters CLUSTERS [CLUSTERS ...]
                        Cluster numbers/ ranges provided by the summary file
                        of the 'search' command.
  -st, --score_threshold SCORE_THRESHOLD
                        Minimum score of a cluster in order to be included
  -or, --organisms ORGANISMS [ORGANISMS ...]
                        Organism names (can be regex patterns)
  -sc, --scaffolds SCAFFOLDS [SCAFFOLDS ...]
                        Scaffold names/ranges e.g name:start-stop. Only
                        clusters fully within the range are selected.

Output options:
  -o, --output OUTPUT   Output directory for the clusters
  -pf, --prefix PREFIX  Start of the name for each cluster file, the base name
                        is 'cluster_clutser_number' e.g. cluster1
  -f, --format {genbank,bigscape}
                        The format of the resulting files. The options are
                        genbank and bigscape
  -mc, --maximum_clusters MAXIMUM_CLUSTERS
                        The maximum amount of clusters that will be extracted.
                        Ordered on score (def. 50)

Example usage
-------------
Extract all clusters (this can take a while for remote sessions):
  $ cblaster extract_clusters session.json -o example_directory

Extract clusters 1 through 10 + cluster 25 (numbers found in cblaster search output):
  $ cblaster extract_clusters session.json -c 1-10 25 -o example_directory

Extract only from specific organism/s (using regular expressions):
  $ cblaster extract_clusters session.json -or "Aspergillus.*" "Penicillium.*" -o example_directory

Extract clusters from a specific range on scaffold_123 + all clusters on scaffold_234:
  $ cblaster extract_clusters session.json -sc scaffold_123:1-80000 scaffold_234 -o example_directory

Cameron Gilchrist, 2021
```


## cblaster_plot_clusters

### Tool Description
Plot clusters using clinker

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cblaster plot_clusters [-h] [-c CLUSTERS [CLUSTERS ...]]
                              [-st SCORE_THRESHOLD]
                              [-or ORGANISMS [ORGANISMS ...]]
                              [-sc SCAFFOLDS [SCAFFOLDS ...]] [-o OUTPUT]
                              [-mc MAXIMUM_CLUSTERS]
                              session

Plot clusters using clinker

positional arguments:
  session               cblaster session file

options:
  -h, --help            show this help message and exit

Filters:
  -c, --clusters CLUSTERS [CLUSTERS ...]
                        Cluster numbers/ ranges provided by the summary file
                        of the 'search' command.
  -st, --score_threshold SCORE_THRESHOLD
                        Minimum score of a cluster to be included
  -or, --organisms ORGANISMS [ORGANISMS ...]
                        Organism names
  -sc, --scaffolds SCAFFOLDS [SCAFFOLDS ...]
                        Scaffold names/ranges

Output options:
  -o, --output OUTPUT   Location were to store the plot file.
  -mc, --maximum_clusters MAXIMUM_CLUSTERS
                        The maximum amount of clusters that will be plotted.
                        Ordered on score (def. 50)

Example usage
-------------
Plot all clusters (up to --maximum_clusters):
 $ cblaster plot_clusters session.json

Plot clusters 1 through 10 + cluster 25 (numbers found in cblaster search output):
 $ cblaster plot_clusters session.json -c 1-10 25 -o plot.html

Plot only specific organism/s (using regular expressions):
 $ cblaster plot_clusters session.json -or "Aspergillus.*" "Penicillium.*" -o plot.html

Plot clusters from a specific range on scaffold_123 + all clusters on scaffold_234:
  $ cblaster plot_clusters session.json -sc scaffold_123:1-80000 scaffold_234 -o plot.html

Cameron Gilchrist, 2020
```


## cblaster_config

### Tool Description
Configure cblaster (e.g. for setting NCBI e-mail addresses or API keys)

### Metadata
- **Docker Image**: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/gamcil/cblaster
- **Package**: https://anaconda.org/channels/bioconda/packages/cblaster/overview
- **Validation**: PASS

### Original Help Text
```text
usage: cblaster config [-h] [--email EMAIL] [--api_key API_KEY]
                       [--max_tries MAX_TRIES]

Configure cblaster (e.g. for setting NCBI e-mail addresses or API keys)

options:
  -h, --help            show this help message and exit
  --email EMAIL         Your e-mail address, required by NCBI to prevent abuse
  --api_key API_KEY     NCBI API key
  --max_tries MAX_TRIES
                        How many times failed requests are retried (def. 3)

Example usage
-------------
Set an e-mail address:
 $ cblaster config --email "foo@bar.com"
```

