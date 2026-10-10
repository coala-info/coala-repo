cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacache
  - query
label: metacache_query
doc: "Classify reads (short reads, long reads, genome fragments, ...) with a MetaCache database.\n\nTool homepage: https://github.com/muellan/metacache"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.database_files)
inputs:
  - id: database
    type: string
    doc: "Database name (all parts <database>.cache# are loaded when the name has no .cache# extension)"
    inputBinding:
      position: 1
  - id: database_files
    type:
      type: array
      items: File
    doc: "Database files (<database>.meta and <database>.cache0, .cache1, ...) staged in the working directory"
  - id: sequences
    type:
      type: array
      items:
        - File
        - Directory
    doc: "FASTA or FASTQ files, or directories, with the reads to classify"
    inputBinding:
      position: 2
  - id: out
    type: 
      - 'null'
      - string
    doc: "Redirect output to file <file>. If not specified, output will be written to stdout. If more than one input file was given all output will be concatenated into one file."
    inputBinding:
      position: 100
      prefix: -out
  - id: split_out
    type: 
      - 'null'
      - string
    doc: "Generate output and statistics for each input file separately. For each input file <in> an output file with name <file>_<in> will be written."
    inputBinding:
      position: 101
      prefix: -split-out
  - id: pairfiles
    type: 
      - 'null'
      - boolean
    doc: "Interleave paired-end reads from two consecutive files, so that the nth read from file m and the nth read from file m+1 will be treated as a pair. If more than two files are provided, their names will be sorted before processing. Thus, the order defined by the filenames determines the pairing not th"
    inputBinding:
      position: 102
      prefix: -pairfiles
  - id: pairseq
    type: 
      - 'null'
      - boolean
    doc: "Two consecutive sequences (1+2, 3+4, ...) from each file will be treated as paired-end reads."
    inputBinding:
      position: 103
      prefix: -pairseq
  - id: insertsize
    type: 
      - 'null'
      - int
    doc: "Maximum insert size to consider. default: sum of lengths of the individual reads"
    inputBinding:
      position: 104
      prefix: -insertsize
  - id: min_readlen
    type: 
      - 'null'
      - int
    doc: "Minimum length of reads (in bp). Reads shorter than the given number will not be classified. default: no limit"
    inputBinding:
      position: 105
      prefix: -min-readlen
  - id: max_readlen
    type: 
      - 'null'
      - int
    doc: "Maximum length of reads (in bp). Reads longer than the given number will not be classified. default: no limit"
    inputBinding:
      position: 106
      prefix: -max-readlen
  - id: lowest
    type: 
      - 'null'
      - string
    doc: "Do not classify on ranks below <rank> (Valid values: sequence, form, variety, subspecies, species, subgenus, genus, subtribe, tribe, subfamily, family, suborder, order, subclass, class, subphylum, phylum, subkingdom, kingdom, domain) default: sequence"
    inputBinding:
      position: 107
      prefix: -lowest
  - id: highest
    type: 
      - 'null'
      - string
    doc: "Do not classify on ranks above <rank> (Valid values: sequence, form, variety, subspecies, species, subgenus, genus, subtribe, tribe, subfamily, family, suborder, order, subclass, class, subphylum, phylum, subkingdom, kingdom, domain) default: domain"
    inputBinding:
      position: 108
      prefix: -highest
  - id: hitmin
    type: 
      - 'null'
      - int
    doc: "Sets classification threshhold to <t>. A read will not be classified if less than t features from the database match. Higher values will increase precision at the expense of sensitivity. default: 0"
    inputBinding:
      position: 109
      prefix: -hitmin
  - id: hitdiff
    type: 
      - 'null'
      - float
    doc: "Sets candidate LCA threshhold to <d> percent. Influences if only candidate with the most hits will be used as classification result or if taxa of other candidates will be considered. All candidate (taxa) will be included that have at least d% as many hits above the hit-min threshold as the candidate"
    inputBinding:
      position: 110
      prefix: -hitdiff
  - id: maxcand
    type: 
      - 'null'
      - int
    doc: "maximum number of reference taxon candidates to consider for each query; A large value can significantly decrease the querying speed!. default: 2"
    inputBinding:
      position: 111
      prefix: -maxcand
  - id: cov_percentile
    type: 
      - 'null'
      - float
    doc: "Remove the p-th percentile of hit reference sequences with the lowest coverage. Classification is done using only the remaining reference sequences. This can help to reduce false positives, especially when your input data has a high sequencing coverage. This feature decreases the querying speed! def"
    inputBinding:
      position: 112
      prefix: -cov-percentile
  - id: no_summary
    type: 
      - 'null'
      - boolean
    doc: "Dont't show result summary & mapping statistics at the end of the mapping output default: off"
    inputBinding:
      position: 113
      prefix: -no-summary
  - id: no_query_params
    type: 
      - 'null'
      - boolean
    doc: "Don't show query settings at the beginning of the mapping output default: off"
    inputBinding:
      position: 114
      prefix: -no-query-params
  - id: no_err
    type: 
      - 'null'
      - boolean
    doc: "Suppress all error messages. default: off"
    inputBinding:
      position: 115
      prefix: -no-err
  - id: no_map
    type: 
      - 'null'
      - boolean
    doc: "Don't report classification for each individual query sequence; show summaries only (useful for quick tests). default: off"
    inputBinding:
      position: 116
      prefix: -no-map
  - id: mapped_only
    type: 
      - 'null'
      - boolean
    doc: "Don't list unclassified reads/read pairs. default: off"
    inputBinding:
      position: 117
      prefix: -mapped-only
  - id: taxids
    type: 
      - 'null'
      - boolean
    doc: "Print taxon ids in addition to taxon names. default: off"
    inputBinding:
      position: 118
      prefix: -taxids
  - id: taxids_only
    type: 
      - 'null'
      - boolean
    doc: "Print taxon ids instead of taxon names. default: off"
    inputBinding:
      position: 119
      prefix: -taxids-only
  - id: omit_ranks
    type: 
      - 'null'
      - boolean
    doc: "Do not print taxon rank names. default: off"
    inputBinding:
      position: 120
      prefix: -omit-ranks
  - id: separate_cols
    type: 
      - 'null'
      - boolean
    doc: "Prints *all* mapping information (rank, taxon name, taxon ids) in separate columns (see option '-separator'). default: off"
    inputBinding:
      position: 121
      prefix: -separate-cols
  - id: separator
    type: 
      - 'null'
      - string
    doc: "Sets string that separates output columns. default: '\\t|\\t'"
    inputBinding:
      position: 122
      prefix: -separator
  - id: comment
    type: 
      - 'null'
      - string
    doc: "Sets string that precedes comment (non-mapping) lines. default: '# '"
    inputBinding:
      position: 123
      prefix: -comment
  - id: queryids
    type: 
      - 'null'
      - boolean
    doc: "Show a unique id for each query. Note that in paired-end mode a query is a pair of two read sequences. This option will always be activated if option '-hits-per-ref' is given. default: off"
    inputBinding:
      position: 124
      prefix: -queryids
  - id: lineage
    type: 
      - 'null'
      - boolean
    doc: "Report complete lineage for per-read classification starting with the lowest rank found/allowed and ending with the highest rank allowed. See also options '-lowest' and '-highest'. default: off"
    inputBinding:
      position: 125
      prefix: -lineage
  - id: abundances
    type: 
      - 'null'
      - string
    doc: "Show absolute and relative abundance of each taxon. If a valid filename is given, the list will be written to this file. default: off"
    inputBinding:
      position: 126
      prefix: -abundances
  - id: abundance_per
    type: 
      - 'null'
      - string
    doc: "Show absolute and relative abundances for each taxon on one specific rank. Classifications on higher ranks will be estimated by distributing them down according to the relative abundances of classifications on or below the given rank. (Valid values: sequence, form, variety, subspecies, species, subg"
    inputBinding:
      position: 127
      prefix: -abundance-per
  - id: tophits
    type: 
      - 'null'
      - boolean
    doc: "For each query, print top feature hits in database. default: off"
    inputBinding:
      position: 128
      prefix: -tophits
  - id: allhits
    type: 
      - 'null'
      - boolean
    doc: "For each query, print all feature hits in database. default: off"
    inputBinding:
      position: 129
      prefix: -allhits
  - id: locations
    type: 
      - 'null'
      - boolean
    doc: "Show locations in candidate reference sequences. Activates option '-tophits'. default: off"
    inputBinding:
      position: 130
      prefix: -locations
  - id: hits_per_ref
    type: 
      - 'null'
      - string
    doc: "Shows a list of all hits for each reference sequence. If this condensed list is all you need, you should deactive the per-read mapping output with '-no-map'. If a valid filename is given after '-hits-per-ref', the list will be written to a separate file. Option '-queryids' will be activated and the "
    inputBinding:
      position: 131
      prefix: -hits-per-ref
  - id: align
    type: 
      - 'null'
      - boolean
    doc: "Show semi-global alignment to best candidate reference sequence. Original files of reference sequences must be available. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 132
      prefix: -align
  - id: ground_truth
    type: 
      - 'null'
      - boolean
    doc: "Report correct query taxa if known. Queries need to have either a 'taxid|<number>' entry in their header or a sequence id that is also present in the database. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 133
      prefix: -ground-truth
  - id: precision
    type: 
      - 'null'
      - boolean
    doc: "Report precision & sensitivity by comparing query taxa (ground truth) and mapped taxa. Queries need to have either a 'taxid|<number>' entry in their header or a sequence id that is also found in the database. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 134
      prefix: -precision
  - id: taxon_coverage
    type: 
      - 'null'
      - boolean
    doc: "Report true/false positives and true/false negatives.This option turns on '-precision', so ground truth data needs to be available. This feature decreases the querying speed! default: off"
    inputBinding:
      position: 135
      prefix: -taxon-coverage
  - id: kmerlen
    type: 
      - 'null'
      - int
    doc: "number of nucleotides/characters in a k-mer default: determined by database"
    inputBinding:
      position: 136
      prefix: -kmerlen
  - id: sketchlen
    type: 
      - 'null'
      - int
    doc: "number of features (k-mer hashes) per sampling window default: determined by database"
    inputBinding:
      position: 137
      prefix: -sketchlen
  - id: winlen
    type: 
      - 'null'
      - int
    doc: "number of letters in each sampling window default: determined by database"
    inputBinding:
      position: 138
      prefix: -winlen
  - id: winstride
    type: 
      - 'null'
      - int
    doc: "distance between window starting positions default: determined by database"
    inputBinding:
      position: 139
      prefix: -winstride
  - id: max_locations_per_feature
    type: 
      - 'null'
      - int
    doc: "maximum number of reference sequence locations to be stored per feature; If the value is too high it will significantly impact querying speed. Note that an upper hard limit is always imposed by the data type used for the hash table bucket size (set with compilation macro '-DMC_LOCATION_LIST_SIZE_TYP"
    inputBinding:
      position: 140
      prefix: -max-locations-per-feature
  - id: remove_overpopulated_features
    type: 
      - 'null'
      - boolean
    doc: "Removes all features that have reached the maximum allowed amount of locations per feature. This can improve querying speed and can be used to remove non-discriminative features. default: off Not available in the GPU version."
    inputBinding:
      position: 141
      prefix: -remove-overpopulated-features
  - id: remove_ambig_features
    type: 
      - 'null'
      - string
    doc: "Removes all features that have more distinct reference sequence on the given taxonomic rank than set by '-max-ambig-per-feature'. This can decrease the database size significantly at the expense of sensitivity. Note that the lower the given taxonomic rank is, the more pronounced the effect will be. "
    inputBinding:
      position: 142
      prefix: -remove-ambig-features
  - id: max_ambig_per_feature
    type: 
      - 'null'
      - int
    doc: "Maximum number of allowed different reference sequence taxa per feature if option '-remove-ambig-features' is used. Not available in the GPU version."
    inputBinding:
      position: 143
      prefix: -max-ambig-per-feature
  - id: max_load_fac
    type: 
      - 'null'
      - float
    doc: "maximum hash table load factor; This can be used to trade off larger memory consumption for speed and vice versa. A lower load factor will improve speed, a larger one will improve memory efficiency. default: 0.800000 Not available in the GPU version."
    inputBinding:
      position: 144
      prefix: -max-load-fac
  - id: threads
    type: 
      - 'null'
      - int
    doc: "Sets the maximum number of parallel threads to use.default (on this machine): 20"
    inputBinding:
      position: 145
      prefix: -threads
  - id: batch_size
    type: 
      - 'null'
      - int
    doc: "Process <#> many queries (reads or read pairs) per thread at once. default (on this machine): 4096"
    inputBinding:
      position: 146
      prefix: -batch-size
  - id: query_limit
    type: 
      - 'null'
      - int
    doc: "Classify at max. <#> queries (reads or read pairs) per input file. default: no limit"
    inputBinding:
      position: 147
      prefix: -query-limit
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: log
    type: stderr
    doc: Standard error (progress and summary messages)
  - id: out_files
    type: File[]
    doc: "Result file(s) written with -out or -split-out"
    outputBinding:
      glob: |
        ${ var l = []; if (inputs.out) { l.push(inputs.out); } if (inputs.split_out) { l.push(inputs.split_out + '*'); } return l; }
  - id: abundances_file
    type: ['null', File]
    doc: "Abundance table written with -abundances"
    outputBinding:
      glob: $(inputs.abundances)
  - id: hits_per_ref_file
    type: ['null', File]
    doc: "Hits per reference table written with -hits-per-ref"
    outputBinding:
      glob: $(inputs.hits_per_ref)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacache:2.6.0--h077b44d_0
stdout: metacache_query.out
