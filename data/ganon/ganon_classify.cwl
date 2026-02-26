cwlVersion: v1.2
class: CommandLineTool
baseCommand: ganon classify
label: ganon_classify
doc: "Classify reads against a database.\n\nTool homepage: https://github.com/pirovc/ganon"
inputs:
  - id: binning
    type:
      - 'null'
      - boolean
    doc: Optimized parameters for binning (--rel-cutoff 0.25 --rel-filter 0 
      --min-count 0 --report-type reads). Will report sequence abundances (.tre)
      instead of tax. abundance.
    default: false
    inputBinding:
      position: 101
      prefix: --binning
  - id: db_prefix
    type:
      type: array
      items: string
    doc: Database input prefix[es]
    default: None
    inputBinding:
      position: 101
      prefix: --db-prefix
  - id: fpr_query
    type:
      - 'null'
      - type: array
        items: float
    doc: Max. false positive of a query to accept a match. Applied after 
      --rel-cutoff and --rel-filter. Generally used to remove false positives 
      matches querying a database build with large --max-fp. Single value or one
      per hierarchy (e.g. 0.1 0). 1 for no filter
    default:
      - 1e-05
    inputBinding:
      position: 101
      prefix: --fpr-query
  - id: hierarchy_labels
    type:
      - 'null'
      - type: array
        items: string
    doc: Hierarchy definition of --db-prefix files to be classified. Can also be
      a string, but input will be sorted to define order (e.g. 1 1 2 3). The 
      default value reported without hierarchy is 'H1'
    default: None
    inputBinding:
      position: 101
      prefix: --hierarchy-labels
  - id: min_count
    type:
      - 'null'
      - float
    doc: Minimum percentage/counts to report an taxa (.tre) [use values between 
      0-1 for percentage, >1 for counts]
    default: 5e-05
    inputBinding:
      position: 101
      prefix: --min-count
  - id: multiple_matches
    type:
      - 'null'
      - string
    doc: Method to solve reads with multiple matches [em, lca, skip]. em -> 
      expectation maximization algorithm based on unique matches. lca -> lowest 
      common ancestor based on taxonomy. The EM algorithm can be executed later 
      with 'ganon reassign' using the .all file (--output-all).
    default: em
    inputBinding:
      position: 101
      prefix: --multiple-matches
  - id: output_all
    type:
      - 'null'
      - boolean
    doc: Output a file with all unique and multiple matches (.all)
    default: false
    inputBinding:
      position: 101
      prefix: --output-all
  - id: output_one
    type:
      - 'null'
      - boolean
    doc: Output a file with one match for each read (.one) either an unique 
      match or a result from the EM or a LCA algorithm (--multiple-matches)
    default: false
    inputBinding:
      position: 101
      prefix: --output-one
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix for output (.rep) and tree-like report (.tre). Empty to 
      output to STDOUT (only .rep)
    default: None
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: output_single
    type:
      - 'null'
      - boolean
    doc: When using multiple hierarchical levels, output everything in one file 
      instead of one per hierarchy
    default: false
    inputBinding:
      position: 101
      prefix: --output-single
  - id: output_unclassified
    type:
      - 'null'
      - boolean
    doc: Output a file with unclassified read headers (.unc)
    default: false
    inputBinding:
      position: 101
      prefix: --output-unclassified
  - id: paired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Multi-fastq[.gz] pairs of file[s] to classify
    default: None
    inputBinding:
      position: 101
      prefix: --paired-reads
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet output mode
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: Ranks to report taxonomic abundances (.tre). empty will report default 
      ranks [domain phylum class order family genus species assembly].
    default: []
    inputBinding:
      position: 101
      prefix: --ranks
  - id: rel_cutoff
    type:
      - 'null'
      - type: array
        items: float
    doc: Min. percentage of a read (set of k-mers) shared with a reference 
      necessary to consider a match. Generally used to remove low similarity 
      matches. Single value or one per database (e.g. 0.7 1 0.25). 0 for no 
      cutoff
    default:
      - 0.75
    inputBinding:
      position: 101
      prefix: --rel-cutoff
  - id: rel_filter
    type:
      - 'null'
      - type: array
        items: float
    doc: Additional relative percentage of matches (relative to the best match) 
      to keep. Generally used to keep top matches above cutoff. Single value or 
      one per hierarchy (e.g. 0.1 0). 1 for no filter
    default:
      - 0.1
    inputBinding:
      position: 101
      prefix: --rel-filter
  - id: report_type
    type:
      - 'null'
      - string
    doc: Type of report (.tre) [abundance, reads, matches, dist, corr]. More 
      info in 'ganon report'.
    default: abundance
    inputBinding:
      position: 101
      prefix: --report-type
  - id: single_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: Multi-fastq[.gz] file[s] to classify
    default: None
    inputBinding:
      position: 101
      prefix: --single-reads
  - id: skip_report
    type:
      - 'null'
      - boolean
    doc: Disable tree-like report (.tre) at the end of classification. Can be 
      done later with 'ganon report'.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-report
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of sub-processes/threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output mode
    default: false
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ganon:2.2.0--py312hfc6b275_0
stdout: ganon_classify.out
