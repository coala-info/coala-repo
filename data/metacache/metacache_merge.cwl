cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - merge
label: metacache_merge
doc: "Merge the classification results of independent MetaCache queries.\n\nTool homepage: https://github.com/muellan/metacache"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: query_outputs
    type:
      type: array
      items:
        - File
        - Directory
    doc: "MetaCache query output files (produced with -tophits -queryids -lowest <rank>), or directories"
    inputBinding:
      position: 1
  - id: taxonomy
    type: Directory
    doc: "directory with taxonomic hierarchy data (NCBI taxonomy files)"
    inputBinding:
      position: 2
      prefix: -taxonomy
  - id: out
    type: 
      - 'null'
      - string
    doc: "Redirect output to file <file> (stdout if not given)"
    inputBinding:
      position: 3
      prefix: -out
  - id: lowest
    type: 
      - 'null'
      - string
    doc: "Do not classify on ranks below <rank> (Valid values: sequence, form, variety, subspecies, species, subgenus, genus, subtribe, tribe, subfamily, family, suborder, order, subclass, class, subphylum, phylum, subkingdom, kingdom, domain) default: sequence"
    inputBinding:
      position: 10
      prefix: -lowest
  - id: highest
    type: 
      - 'null'
      - string
    doc: "Do not classify on ranks above <rank> (Valid values: sequence, form, variety, subspecies, species, subgenus, genus, subtribe, tribe, subfamily, family, suborder, order, subclass, class, subphylum, phylum, subkingdom, kingdom, domain) default: domain"
    inputBinding:
      position: 11
      prefix: -highest
  - id: hitmin
    type: 
      - 'null'
      - int
    doc: "Sets classification threshhold to <t>. A read will not be classified if less than t features from the database match. Higher values will increase precision at the expense of sensitivity. default: 0"
    inputBinding:
      position: 12
      prefix: -hitmin
  - id: hitdiff
    type: 
      - 'null'
      - float
    doc: "Sets candidate LCA threshhold to <d> percent. Influences if only candidate with the most hits will be used as classification result or if taxa of other candidates will be considered. All candidate (taxa) will be included that have at least d% as many hits above the hit-min threshold as the candidate"
    inputBinding:
      position: 13
      prefix: -hitdiff
  - id: maxcand
    type: 
      - 'null'
      - int
    doc: "maximum number of reference taxon candidates to consider for each query; A large value can significantly decrease the querying speed!. default: 2"
    inputBinding:
      position: 14
      prefix: -maxcand
  - id: cov_percentile
    type: 
      - 'null'
      - float
    doc: "Remove the p-th percentile of hit reference sequences with the lowest coverage. Classification is done using only the remaining reference sequences. This can help to reduce false positives, especially when your input data has a high sequencing coverage. This feature decreases the querying speed! def"
    inputBinding:
      position: 15
      prefix: -cov-percentile
  - id: no_summary
    type: 
      - 'null'
      - boolean
    doc: "Dont't show result summary & mapping statistics at the end of the mapping output default: off"
    inputBinding:
      position: 16
      prefix: -no-summary
  - id: no_query_params
    type: 
      - 'null'
      - boolean
    doc: "Don't show query settings at the beginning of the mapping output default: off"
    inputBinding:
      position: 17
      prefix: -no-query-params
  - id: no_err
    type: 
      - 'null'
      - boolean
    doc: "Suppress all error messages. default: off"
    inputBinding:
      position: 18
      prefix: -no-err
  - id: no_map
    type: 
      - 'null'
      - boolean
    doc: "Don't report classification for each individual query sequence; show summaries only (useful for quick tests). default: off"
    inputBinding:
      position: 19
      prefix: -no-map
  - id: mapped_only
    type: 
      - 'null'
      - boolean
    doc: "Don't list unclassified reads/read pairs. default: off"
    inputBinding:
      position: 20
      prefix: -mapped-only
  - id: taxids
    type: 
      - 'null'
      - boolean
    doc: "Print taxon ids in addition to taxon names. default: off"
    inputBinding:
      position: 21
      prefix: -taxids
  - id: taxids_only
    type: 
      - 'null'
      - boolean
    doc: "Print taxon ids instead of taxon names. default: off"
    inputBinding:
      position: 22
      prefix: -taxids-only
  - id: omit_ranks
    type: 
      - 'null'
      - boolean
    doc: "Do not print taxon rank names. default: off"
    inputBinding:
      position: 23
      prefix: -omit-ranks
  - id: separate_cols
    type: 
      - 'null'
      - boolean
    doc: "Prints *all* mapping information (rank, taxon name, taxon ids) in separate columns (see option '-separator'). default: off"
    inputBinding:
      position: 24
      prefix: -separate-cols
  - id: separator
    type: 
      - 'null'
      - string
    doc: "Sets string that separates output columns. default: '\\t|\\t'"
    inputBinding:
      position: 25
      prefix: -separator
  - id: comment
    type: 
      - 'null'
      - string
    doc: "Sets string that precedes comment (non-mapping) lines. default: '# '"
    inputBinding:
      position: 26
      prefix: -comment
  - id: queryids
    type: 
      - 'null'
      - boolean
    doc: "Show a unique id for each query. Note that in paired-end mode a query is a pair of two read sequences. This option will always be activated if option '-hits-per-ref' is given. default: off"
    inputBinding:
      position: 27
      prefix: -queryids
  - id: lineage
    type: 
      - 'null'
      - boolean
    doc: "Report complete lineage for per-read classification starting with the lowest rank found/allowed and ending with the highest rank allowed. See also options '-lowest' and '-highest'. default: off"
    inputBinding:
      position: 28
      prefix: -lineage
  - id: abundances
    type: 
      - 'null'
      - string
    doc: "Show absolute and relative abundance of each taxon. If a valid filename is given, the list will be written to this file. default: off"
    inputBinding:
      position: 29
      prefix: -abundances
  - id: abundance_per
    type: 
      - 'null'
      - string
    doc: "Show absolute and relative abundances for each taxon on one specific rank. Classifications on higher ranks will be estimated by distributing them down according to the relative abundances of classifications on or below the given rank. (Valid values: sequence, form, variety, subspecies, species, subg"
    inputBinding:
      position: 30
      prefix: -abundance-per
  - id: tophits
    type: 
      - 'null'
      - boolean
    doc: "For each query, print top feature hits in database. default: off"
    inputBinding:
      position: 31
      prefix: -tophits
  - id: allhits
    type: 
      - 'null'
      - boolean
    doc: "For each query, print all feature hits in database. default: off"
    inputBinding:
      position: 32
      prefix: -allhits
  - id: locations
    type: 
      - 'null'
      - boolean
    doc: "Show locations in candidate reference sequences. Activates option '-tophits'. default: off"
    inputBinding:
      position: 33
      prefix: -locations
  - id: hits_per_ref
    type: 
      - 'null'
      - string
    doc: "Shows a list of all hits for each reference sequence. If this condensed list is all you need, you should deactive the per-read mapping output with '-no-map'. If a valid filename is given after '-hits-per-ref', the list will be written to a separate file. Option '-queryids' will be activated and the "
    inputBinding:
      position: 34
      prefix: -hits-per-ref
  - id: align
    type: 
      - 'null'
      - boolean
    doc: "Show semi-global alignment to best candidate reference sequence. Original files of reference sequences must be available. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 35
      prefix: -align
  - id: ground_truth
    type: 
      - 'null'
      - boolean
    doc: "Report correct query taxa if known. Queries need to have either a 'taxid|<number>' entry in their header or a sequence id that is also present in the database. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 36
      prefix: -ground-truth
  - id: precision
    type: 
      - 'null'
      - boolean
    doc: "Report precision & sensitivity by comparing query taxa (ground truth) and mapped taxa. Queries need to have either a 'taxid|<number>' entry in their header or a sequence id that is also found in the database. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 37
      prefix: -precision
  - id: taxon_coverage
    type: 
      - 'null'
      - boolean
    doc: "Report true/false positives and true/false negatives.This option turns on '-precision', so ground truth data needs to be available. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 38
      prefix: -taxon-coverage
  - id: kmerlen
    type: 
      - 'null'
      - int
    doc: "number of nucleotides/characters in a k-mer default: determined by database"
    inputBinding:
      position: 39
      prefix: -kmerlen
  - id: sketchlen
    type: 
      - 'null'
      - int
    doc: "number of features (k-mer hashes) per sampling window default: determined by database"
    inputBinding:
      position: 40
      prefix: -sketchlen
  - id: winlen
    type: 
      - 'null'
      - int
    doc: "number of letters in each sampling window default: determined by database"
    inputBinding:
      position: 41
      prefix: -winlen
  - id: winstride
    type: 
      - 'null'
      - int
    doc: "distance between window starting positions default: determined by database"
    inputBinding:
      position: 42
      prefix: -winstride
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Sets the maximum number of parallel threads to use.default (on this machine): 20"
    inputBinding:
      position: 43
      prefix: -threads
  - id: batch_size
    type: 
      - 'null'
      - int
    doc: "Process <#> many queries (reads or read pairs) per thread at once. default (on this machine): 4096"
    inputBinding:
      position: 44
      prefix: -batch-size
  - id: query_limit
    type: 
      - 'null'
      - int
    doc: "Classify at max. <#> queries (reads or read pairs) per input file. default: no limit"
    inputBinding:
      position: 45
      prefix: -query-limit
  - id: silent
    type: 
      - 'null'
      - boolean
    doc: "information level: silent => none"
    inputBinding:
      position: 150
      prefix: -silent
  - id: verbose
    type: 
      - 'null'
      - boolean
    doc: "information level: verbose => most detailed"
    inputBinding:
      position: 151
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress and summary messages)
  - id: merged
    type: ['null', File]
    doc: "Merged result written with -out"
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_merge.out
