# taxonkit CWL Generation Report

## taxonkit_cami-filter

### Tool Description
Remove taxa of given TaxIds and their descendants in CAMI metagenomic profile

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Total Downloads**: 137.0K
- **Last updated**: 2025-12-20
- **GitHub**: https://github.com/shenwei356/taxonkit
- **Stars**: N/A
### Original Help Text
```text
Remove taxa of given TaxIds and their descendants in CAMI metagenomic profile

Input format: 
  The CAMI (Taxonomic) Profiling Output Format    
  - https://github.com/CAMI-challenge/contest_information/blob/master/file_formats/CAMI_TP_specification.mkd
  - One file with mutiple samples is also supported.

How to:
  - No extra taxonomy data needed, so the original taxonomic information are
    used and not changed.
  - A mini taxonomic tree is built from records with abundance greater than
    zero, and only leaves are retained for later use. The rank of leaves may
    be "strain", "species", or "no rank".
  - Relative abundances (in percentage) are recomputed for all leaves
    (reference genome).
  - A new taxonomic tree is built from these leaves, and abundances are 
    cumulatively added up from leaves to the root.

Examples:
  1. Remove Archaea, Bacteria, and EukaryoteS, only keep Viruses:
      taxonkit cami-filter -t 2,2157,2759 test.profile -o test.filter.profile
  2. Remove Viruses:
      taxonkit cami-filter -t 10239 test.profile -o test.filter.profile

Usage:
  taxonkit cami-filter [flags] 

Flags:
      --field-percentage int   field index of PERCENTAGE (default 5)
      --field-rank int         field index of taxid (default 2)
      --field-taxid int        field index of taxid (default 1)
      --field-taxpath int      field index of TAXPATH (default 3)
      --field-taxpathsn int    field index of TAXPATHSN (default 4)
  -h, --help                   help for cami-filter
      --leaf-ranks strings     only consider leaves at these ranks (default [species,strain,no rank])
      --show-rank strings      only show TaxIds and names of these ranks (default
                               [superkingdom,phylum,class,order,family,genus,species,strain])
      --taxid-sep string       separator of taxid in TAXPATH and TAXPATHSN (default "|")
  -t, --taxids strings         the parent taxid(s) to filter out
  -f, --taxids-file strings    file(s) for the parent taxid(s) to filter out, one taxid per line

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_create-taxdump

### Tool Description
Create NCBI-style taxdump files for custom taxonomy, e.g., GTDB and ICTV

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Create NCBI-style taxdump files for custom taxonomy, e.g., GTDB and ICTV

Input format: 
  0. For GTDB taxonomy file, just use --gtdb.
     We use the numeric assembly accession as the taxon at subspecies rank.
     (without the prefix GCA_ and GCF_, and version number).
  1. The input file should be tab-delimited, at least one column is needed.
  2. Ranks can be given either via the first row or the flag --rank-names.
  3. The column containing the genome/assembly accession is recommended to
     generate TaxId mapping file (taxid.map, id -> taxid).
       -A/--field-accession,    field contaning genome/assembly accession      
       --field-accession-re,    regular expression to extract the accession
     Note that mutiple TaxIds pointing to the same accession are listed as
     comma-seperated integers. 

Attention:
  1. Duplicated taxon names wit different ranks are allowed since v0.16.0, since
     the rank and taxon name are contatenated for generating the TaxId.
  2. The generated TaxIds are not consecutive numbers, however some tools like MMSeqs2
     required this, you can use the script below for convertion:
     
     https://github.com/apcamargo/ictv-mmseqs2-protein-database/blob/master/scripts/fix_taxdump.py

  3. We only check and eliminate taxid collision within a single version of taxonomy data.
     Therefore, if you create taxid-changelog with "taxid-changelog", different taxons
     in multiple versions might have the same TaxIds and some change events might be wrong.

     So a single version of taxonomic data created by "taxonkit create-taxdump" has no problem,
     it's just the changelog might not be perfect.

Usage:
  taxonkit create-taxdump [flags] 

Flags:
  -A, --field-accession int             field index of assembly accession (genome ID), for outputting
                                        taxid.map
  -S, --field-accession-as-subspecies   treate the accession as subspecies rank
      --field-accession-re string       regular expression to extract assembly accession (default "^(.+)$")
      --force                           overwrite existing output directory
      --gtdb                            input files are GTDB taxonomy file
      --gtdb-re-subs string             regular expression to extract assembly accession as the
                                        subspecies (default "^\\w\\w_GC[AF]_(.+)\\.\\d+$")
  -h, --help                            help for create-taxdump
      --line-chunk-size int             number of lines to process for each thread, and 4 threads is
                                        fast enough. (default 5000)
      --null strings                    null value of taxa (default [,NULL,NA])
  -x, --old-taxdump-dir string          taxdump directory of the previous version, for generating
                                        merged.dmp and delnodes.dmp
  -O, --out-dir string                  output directory
  -R, --rank-names strings              names of all ranks, leave it empty to use the (lowercase) first
                                        row of input as rank names

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_filter

### Tool Description
Filter TaxIds by taxonomic rank range

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Filter TaxIds by taxonomic rank range

Attention:

  1. Flag -L/--lower-than and -H/--higher-than are exclusive, and can be
     used along with -E/--equal-to which values can be different.
  2. A list of pre-ordered ranks is in ~/.taxonkit/ranks.txt, you can use
     your list by -r/--rank-file, the format specification is below.
  3. All ranks in taxonomy database should be defined in rank file.
  4. Ranks can be removed with black list via -B/--black-list.

  5. TaxIDs with no rank (those starting with ! in the rank file) are kept
     by default! They can be optionally discarded by -N/--discard-noranks.

     One exception: -N/--discard-noranks is switched on automatically
     when only -E/--equal-to is given and the value is not one of ranks
     without order ("no rank", "clade").

  6. [Recommended] When filtering with -L/--lower-than, you can use
    -n/--save-predictable-norank to save some special ranks without order,
    where rank of the closest higher node is still lower than rank cutoff.

Rank file:

  1. Blank lines or lines starting with "#" are ignored.
  2. Ranks are in decending order and case ignored.
  3. Ranks with same order should be in one line separated with comma (",", no space).
  4. Ranks without order should be assigned a prefix symbol "!" for each rank.

Usage:
  taxonkit filter [flags] 

Flags:
  -B, --black-list strings        black list of ranks to discard, e.g., '-B "no rank" -B "clade"
  -N, --discard-noranks           discard all ranks without order, type "taxonkit filter --help" for details
  -R, --discard-root              discard root taxid, defined by --root-taxid
  -E, --equal-to strings          output TaxIds with rank equal to some ranks, multiple values can be
                                  separated with comma "," (e.g., -E "genus,species"), or give multiple
                                  times (e.g., -E genus -E species)
  -h, --help                      help for filter
  -H, --higher-than string        output TaxIds with rank higher than a rank, exclusive with --lower-than
      --list-order                list user defined ranks in order, from "$HOME/.taxonkit/ranks.txt"
      --list-ranks                list ordered ranks in taxonomy database, sorted in user defined order
  -L, --lower-than string         output TaxIds with rank lower than a rank, exclusive with --higher-than
  -r, --rank-file string          user-defined ordered taxonomic ranks, type "taxonkit filter --help"
                                  for details
      --root-taxid uint32         root taxid (default 1)
  -n, --save-predictable-norank   do not discard some special ranks without order when using -L, where
                                  rank of the closest higher node is still lower than rank cutoff
  -i, --taxid-field int           field index of taxid. input data should be tab-separated (default 1)

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_genautocomplete

### Tool Description
generate shell autocompletion script

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
generate shell autocompletion script

Supported shell: bash|zsh|fish|powershell

Bash:

    # generate completion shell
    taxonkit genautocomplete --shell bash

    # configure if never did.
    # install bash-completion if the "complete" command is not found.
    echo "for bcfile in ~/.bash_completion.d/* ; do source \$bcfile; done" >> ~/.bash_completion
    echo "source ~/.bash_completion" >> ~/.bashrc

Zsh:

    # generate completion shell
    taxonkit genautocomplete --shell zsh --file ~/.zfunc/_taxonkit

    # configure if never did
    echo 'fpath=( ~/.zfunc "${fpath[@]}" )' >> ~/.zshrc
    echo "autoload -U compinit; compinit" >> ~/.zshrc

fish:

    taxonkit genautocomplete --shell fish --file ~/.config/fish/completions/taxonkit.fish

Usage:
  taxonkit genautocomplete [flags] 

Flags:
      --file string    autocompletion file (default "/root/.bash_completion.d/taxonkit.sh")
  -h, --help           help for genautocomplete
      --shell string   autocompletion type (bash|zsh|fish|powershell) (default "bash")

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_lca

### Tool Description
Compute lowest common ancestor (LCA) for TaxIds

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Compute lowest common ancestor (LCA) for TaxIds

Attention:

  1. This command computes LCA TaxId for a list of TaxIds 
     in a field ("-i/--taxids-field) of tab-delimited file or STDIN.
  2. TaxIDs should have the same separator ("-s/--separator"),
     single charactor separator is prefered.
  3. Empty lines or lines without valid TaxIds in the field are omitted.
  4. If some TaxIds are not found in database, it returns 0.
  
Examples:

    $ echo 239934, 239935, 349741 | taxonkit lca  -s ", "
    239934, 239935, 349741  239934

    $ time echo 239934  239935  349741 9606  | taxonkit lca
    239934 239935 349741 9606       131567

Usage:
  taxonkit lca [flags] 

Flags:
  -b, --buffer-size string   size of line buffer, supported unit: K, M, G. You need to increase the
                             value when "bufio.Scanner: token too long" error occured (default "1M")
  -h, --help                 help for lca
  -K, --keep-invalid         print the query even if no single valid taxid left
      --separater string     separater for TaxIds. This flag is same to --separator. (default " ")
  -s, --separator string     separator for TaxIds (default " ")
  -D, --skip-deleted         skip deleted TaxIds and compute with left ones
  -U, --skip-unfound         skip unfound TaxIds and compute with left ones
  -i, --taxids-field int     field index of TaxIds. Input data should be tab-separated (default 1)

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_lineage

### Tool Description
Query taxonomic lineage of given TaxIds

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Query taxonomic lineage of given TaxIds

Input:

  - List of TaxIds, one TaxId per line.
  - Or tab-delimited format, please specify TaxId field 
    with flag -i/--taxid-field (default 1).
  - Supporting (gzipped) file or STDIN.

Output:

  1. Input line data.
  2. (Optional) Status code (-c/--show-status-code), values:
     - "-1" for queries not found in whole database.
     - "0" for deleted TaxIds, provided by "delnodes.dmp".
     - New TaxIds for merged TaxIds, provided by "merged.dmp".
     - Taxids for these found in "nodes.dmp".
  3. Lineage, delimiter can be changed with flag -d/--delimiter.
  4. (Optional) TaxIds taxons in the lineage (-t/--show-lineage-taxids)
  5. (Optional) Name (-n/--show-name)
  6. (Optional) Rank (-r/--show-rank)

Filter out invalid and deleted taxids, and replace merged 
taxids with new ones:
    
    # input is one-column-taxid
    $ taxonkit lineage -c taxids.txt \
        | awk '$2>0' \
        | cut -f 2-
        
    # taxids are in 3rd field in a 4-columns tab-delimited file,
    # for $5, where 5 = 4 + 1.
    $ cat input.txt \
        | taxonkit lineage -c -i 3 \
        | csvtk filter2 -H -t -f '$5>0' \
        | csvtk -H -t cut -f -3

Usage:
  taxonkit lineage [flags] 

Flags:
  -d, --delimiter string      field delimiter in lineage (default ";")
  -h, --help                  help for lineage
  -L, --no-lineage            do not show lineage, when user just want names or/and ranks
  -R, --show-lineage-ranks    appending ranks of all levels
  -t, --show-lineage-taxids   appending lineage consisting of taxids
  -n, --show-name             appending scientific name
  -r, --show-rank             appending rank of taxids
  -c, --show-status-code      show status code before lineage
  -i, --taxid-field int       field index of taxid. input data should be tab-separated (default 1)

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_list

### Tool Description
List taxonomic subtrees of given TaxIds

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
List taxonomic subtrees of given TaxIds

Attention:
  1. When multiple taxids are given, the output may contain duplicated records
     if some taxids are descendants of others.

Examples:

    $ taxonkit list --ids 9606 -n -r --indent "    "
    9606 [species] Homo sapiens
        63221 [subspecies] Homo sapiens neanderthalensis
        741158 [subspecies] Homo sapiens subsp. 'Denisova'

    $ taxonkit list --ids 9606 --indent ""
    9606
    63221
    741158

    # from stdin
    echo 9606 | taxonkit list

    # from file
    taxonkit list <(echo 9606)

Usage:
  taxonkit list [flags] 

Flags:
  -h, --help            help for list
  -i, --ids string      TaxId(s), multiple values should be separated by comma
  -I, --indent string   indent (default "  ")
  -J, --json            output in JSON format. you can save the result in file with suffix ".json" and
                        open with modern text editor
  -n, --show-name       output scientific name
  -r, --show-rank       output rank

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_name2taxid

### Tool Description
Convert taxon names to TaxIds

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Convert taxon names to TaxIds

Attention:

  1. Some TaxIds share the same names, e.g, Drosophila.
     These input lines are duplicated with multiple TaxIds.

    $ echo Drosophila | taxonkit name2taxid | taxonkit lineage -i 2 -r -L
    Drosophila      7215    genus
    Drosophila      32281   subgenus
    Drosophila      2081351 genus

Usage:
  taxonkit name2taxid [flags] 

Flags:
  -f, --fuzzy             allow fuzzy match
  -n, --fuzzy-top-n int   choose top n matches in fuzzy search (default 1)
  -h, --help              help for name2taxid
  -i, --name-field int    field index of name. data should be tab-separated (default 1)
  -s, --sci-name          only searching scientific names
  -r, --show-rank         show rank

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_profile2cami

### Tool Description
Convert metagenomic profile table to CAMI format

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Convert metagenomic profile table to CAMI format

Input format: 
  1. The input file should be tab-delimited
  2. At least two columns needed:
     a) TaxId of a taxon.
     b) Abundance (could be percentage, automatically detected or use -p/--percentage).

Attention:
  0. If some TaxIds are parents of others, please switch on -S/--no-sum-up to disable
     summing up abundances.
  1. Some TaxIds may be merged to another ones in current taxonomy version,
     the abundances will be summed up.
  2. Some TaxIds may be deleted in current taxonomy version,
     the abundances can be optionally recomputed with the flag -R/--recompute-abd.

Usage:
  taxonkit profile2cami [flags] 

Flags:
  -a, --abundance-field int   field index of abundance. input data should be tab-separated (default 2)
  -h, --help                  help for profile2cami
  -0, --keep-zero             keep taxons with abundance of zero
  -S, --no-sum-up             do not sum up abundance from child to parent TaxIds
  -p, --percentage            abundance is in percentage
  -R, --recompute-abd         recompute abundance if some TaxIds are deleted in current taxonomy version
  -s, --sample-id string      sample ID in result file
  -r, --show-rank strings     only show TaxIds and names of these ranks (default
                              [superkingdom,phylum,class,order,family,genus,species,strain])
  -i, --taxid-field int       field index of taxid. input data should be tab-separated (default 1)
  -t, --taxonomy-id string    taxonomy ID in result file

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_reformat

### Tool Description
Reformat lineage in canonical ranks

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Reformat lineage in canonical ranks

Warning:

  - 'taxonkit reformat2' is recommended since Match 2025 when NCBI made
    big changes to ranks.
    See more: https://ncbiinsights.ncbi.nlm.nih.gov/2025/02/27/new-ranks-ncbi-taxonomy/

Input:

  - List of TaxIds or lineages, one record per line.
    The lineage can be a complete lineage or only one taxonomy name.
  - Or tab-delimited format.
    Plese specify the lineage field with flag -i/--lineage-field (default 2).
    Or specify the TaxId field with flag -I/--taxid-field (default 0),
    which overrides -i/--lineage-field.
  - Supporting (gzipped) file or STDIN.

Output:

  1. Input line data.
  2. Reformated lineage.
  3. (Optional) TaxIds taxons in the lineage (-t/--show-lineage-taxids)
  
Ambiguous names:

  - Some TaxIds have the same complete lineage, empty result is returned 
    by default. You can use the flag -a/--output-ambiguous-result to
    return one possible result

Output format can be formated by flag --format, available placeholders:

    {C}: cellular root
    {a}: acellular root
    {r}: realm
    {d}: domain
    {k}: superkingdom
    {K}: kingdom
    {p}: phylum
    {c}: class
    {o}: order
    {f}: family
    {g}: genus
    {s}: species
    {t}: subspecies/strain
    
    {S}: subspecies
    {T}: strain

When these're no nodes of rank "subspecies" nor "strain",
you can switch on -S/--pseudo-strain to use the node with lowest rank
as subspecies/strain name, if which rank is lower than "species". 
This flag affects {t}, {S}, {T}.
    
Output format can contains some escape charactors like "\t".

Usage:
  taxonkit reformat [flags] 

Flags:
  -P, --add-prefix                     add prefixes for all ranks, single prefix for a rank is defined
                                       by flag --prefix-X
  -d, --delimiter string               field delimiter in input lineage (default ";")
  -F, --fill-miss-rank                 fill missing rank with lineage information of the next higher rank
  -f, --format string                  output format, placeholders of rank are needed (default
                                       "{k};{p};{c};{o};{f};{g};{s}")
  -h, --help                           help for reformat
  -i, --lineage-field int              field index of lineage. data should be tab-separated (default 2)
  -r, --miss-rank-repl string          replacement string for missing rank
  -p, --miss-rank-repl-prefix string   prefix for estimated taxon names (default "unclassified ")
  -s, --miss-rank-repl-suffix string   suffix for estimated taxon names. "rank" for rank name, "" for no
                                       suffix (default "rank")
  -R, --miss-taxid-repl string         replacement string for missing taxid
  -a, --output-ambiguous-result        output one of the ambigous result
      --prefix-C string                prefix for cellular root, used along with flag -P/--add-prefix
                                       (default "d__")
      --prefix-K string                prefix for kingdom, used along with flag -P/--add-prefix (default
                                       "K__")
      --prefix-S string                prefix for subspecies, used along with flag -P/--add-prefix
                                       (default "S__")
      --prefix-T string                prefix for strain, used along with flag -P/--add-prefix (default
                                       "T__")
      --prefix-a string                prefix for acellular root, used along with flag -P/--add-prefix
                                       (default "d__")
      --prefix-c string                prefix for class, used along with flag -P/--add-prefix (default "c__")
      --prefix-d string                prefix for domain, used along with flag -P/--add-prefix (default
                                       "d__")
      --prefix-f string                prefix for family, used along with flag -P/--add-prefix (default
                                       "f__")
      --prefix-g string                prefix for genus, used along with flag -P/--add-prefix (default "g__")
      --prefix-k string                prefix for superkingdom, used along with flag -P/--add-prefix
                                       (default "k__")
      --prefix-o string                prefix for order, used along with flag -P/--add-prefix (default "o__")
      --prefix-p string                prefix for phylum, used along with flag -P/--add-prefix (default
                                       "p__")
      --prefix-r string                prefix for realm, used along with flag -P/--add-prefix (default "r__")
      --prefix-s string                prefix for species, used along with flag -P/--add-prefix (default
                                       "s__")
      --prefix-t string                prefix for subspecies/strain, used along with flag
                                       -P/--add-prefix (default "t__")
  -S, --pseudo-strain                  use the node with lowest rank as strain name, only if which rank
                                       is lower than "species" and not "subpecies" nor "strain". It
                                       affects {t}, {S}, {T}. This flag needs flag -F
  -t, --show-lineage-taxids            show corresponding taxids of reformated lineage
  -I, --taxid-field int                field index of taxid. input data should be tab-separated. it
                                       overrides -i/--lineage-field
  -T, --trim                           do not fill or add prefix for missing rank lower than current rank

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_reformat2

### Tool Description
Reformat lineage in chosen ranks, allowing more ranks than 'reformat'

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Reformat lineage in chosen ranks, allowing more ranks than 'reformat'

Input:

  - List of TaxIds, one record per line.
  - Or tab-delimited format.
    Please specify the TaxId field with flag -I/--taxid-field (default 1)
  - Supporting (gzipped) file or STDIN.

Output:

  1. Input line data.
  2. Reformated lineage.
  3. (Optional) TaxIds taxons in the lineage (-t/--show-lineage-taxids)

Output format:

  1. It can contain some escape characters like "\t".
  2. You can use "|" to set multiple ranks, and the first valid one will be outputted.

     This is useful for a rank with different rank names, especially since NCBI
     made big changes to some ranks in March 2025:
        - "Domain" replaces "superkingdom" for Archaea, Bacteria, and Eukaryota
        - "Acellular root" replaces "superkingdom" for Viruses
        - Six viral groups are designated with the new rank "realm", the equivalent of "domain"
     So, we can use "{domain|acellular root|superkingdom}" to handle all these cases
     and keep compatible with old taxonomy data.

       $ echo -ne "Eukaryota\nBacteria\nViruses\n" \
           | taxonkit name2taxid -s -r \
           | taxonkit reformat2 -I 2 -f "{domain|acellular root|superkingdom}" \
           | csvtk add-header -Ht -n name,taxid,rank,kingdom/domain \
           | csvtk pretty -t

       name        taxid   rank             kingdom/domain
       ---------   -----   --------------   --------------
       Eukaryota   2759    domain           Eukaryota
       Bacteria    2       domain           Bacteria
       Viruses     10239   acellular root   Viruses

     Another example is for subspecies nodes, the rank might be "subpecies", "strain", or "no rank".
     For example,

       $ echo -ne "562\n83333\n2697049\n" \
          | taxonkit lineage -L -r \
          | taxonkit reformat2 -f "{species};{strain|subspecies|no rank}"

       562     species Escherichia coli;
       83333   strain  Escherichia coli;Escherichia coli K-12
       2697049 no rank Severe acute respiratory syndrome-related coronavirus;Severe acute respiratory syndrome coronavirus 2

Differences from 'taxonkit reformat':

  - [input] only accept TaxIDs
  - [format] accept more rank place holders, not just the seven canonical ones.
  - [format] use the full name of ranks, such as "{species}", rather than "{s}"
  - [format] support multiple ranks in one place holder, such as "{subspecies|strain}"
  - do not automatically add prefixes, but you can simply set them in the format

Usage:
  taxonkit reformat2 [flags] 

Flags:
  -f, --format string            output format, placeholders of rank are needed (default
                                 "{domain|acellular
                                 root|superkingdom};{phylum};{class};{order};{family};{genus};{species}")
  -h, --help                     help for reformat2
  -r, --miss-rank-repl string    replacement string for missing rank
  -R, --miss-taxid-repl string   replacement string for missing taxid
  -B, --no-ranks strings         rank names of no-rank. A lineage might have many "no rank" ranks, we
                                 only keep the last one below known ranks (default [no rank,clade])
  -t, --show-lineage-taxids      show corresponding taxids of reformated lineage
  -I, --taxid-field int          field index of taxid. input data should be tab-separated. it overrides
                                 -i/--lineage-field (default 1)
  -T, --trim                     do not replace missing ranks lower than the rank of the current node

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_taxid-changelog

### Tool Description
Create TaxId changelog from dump archives

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Create TaxId changelog from dump archives

Attention:
  1. This command was originally designed for NCBI taxonomy, where the the TaxIds are stable.
  2. For other taxonomic data created by "taxonkit create-taxdump", e.g., GTDB-taxdump,
    some change events might be wrong, because
     a) There would be dramatic changes between the two versions.
     b) Different taxons in multiple versions might have the same TaxIds, because we only
        check and eliminate taxid collision within a single version.
     So a single version of taxonomic data created by "taxonkit create-taxdump" has no problem,
     it's just the changelog might not be perfect.

Steps:

    # dependencies:
    #   rush - https://github.com/shenwei356/rush/

    mkdir -p archive; cd archive;

    # --------- download ---------

    # option 1
    # for fast network connection
    wget ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump_archive/taxdmp*.zip

    # option 2
    # for slow network connection
    url=https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdump_archive/
    wget $url -O - -o /dev/null \
        | grep taxdmp | perl -ne '/(taxdmp_.+?.zip)/; print "$1\n";' \
        | rush -j 2 -v url=$url 'axel -n 5 {url}/{}' \
            --immediate-output  -c -C download.rush

    # --------- unzip ---------

    ls taxdmp*.zip | rush -j 1 'unzip {} names.dmp nodes.dmp merged.dmp delnodes.dmp -d {@_(.+)\.}'

    # optionally compress .dmp files with pigz, for saving disk space
    fd .dmp$ | rush -j 4 'pigz {}'

    # --------- create log ---------

    cd ..
    taxonkit taxid-changelog -i archive -o taxid-changelog.csv.gz --verbose

Output format (CSV):

    # fields        comments
    taxid           # taxid
    version         # version / time of archive, e.g, 2019-07-01
    change          # change, values:
                    #   NEW             newly added
                    #   REUSE_DEL       deleted taxids being reused
                    #   REUSE_MER       merged taxids being reused
                    #   DELETE          deleted
                    #   MERGE           merged into another taxid
                    #   ABSORB          other taxids merged into this one
                    #   CHANGE_NAME     scientific name changed
                    #   CHANGE_RANK     rank changed
                    #   CHANGE_LIN_LIN  lineage taxids remain but lineage changed
                    #   CHANGE_LIN_TAX  lineage taxids changed
                    #   CHANGE_LIN_LEN  lineage length changed
    change-value    # variable values for changes: 
                    #   1) new taxid for MERGE
                    #   2) merged taxids for ABSORB
                    #   3) empty for others
    name            # scientific name
    rank            # rank
    lineage         # full lineage of the taxid
    lineage-taxids  # taxids of the lineage

    # you can use csvtk to investigate them. e.g.,
    csvtk grep -f taxid -p 1390515 taxid-changelog.csv.gz

Usage:
  taxonkit taxid-changelog [flags] 

Flags:
  -i, --archive string   directory containing uncompressed dumped archives
  -h, --help             help for taxid-changelog

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information
```


## taxonkit_version

### Tool Description
Prints the version of taxonkit

### Metadata
- **Docker Image**: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
- **Homepage**: https://github.com/shenwei356/taxonkit
- **Package**: https://anaconda.org/channels/bioconda/packages/taxonkit/overview
- **Validation**: PASS

### Original Help Text
```text
Error: unknown shorthand flag: 'e' in -elp
Usage:
  taxonkit version [flags] 

Flags:
  -u, --check-update   check update
  -h, --help           help for version

Global Flags:
      --data-dir string   directory containing nodes.dmp and names.dmp (default "/root/.taxonkit")
      --line-buffered     use line buffering on output, i.e., immediately writing to stdin/file for
                          every line of output
  -o, --out-file string   out file ("-" for stdout, suffix .gz for gzipped out) (default "-")
  -j, --threads int       number of CPUs. 4 is enough (default 4)
      --verbose           print verbose information

unknown shorthand flag: 'e' in -elp
```

