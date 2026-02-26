cwlVersion: v1.2
class: CommandLineTool
baseCommand: kissplice
label: kissplice
doc: "local assembly of SNPs, indels and AS events\n\nTool homepage: http://kissplice.prabi.fr"
inputs:
  - id: counts_method
    type:
      - 'null'
      - int
    doc: '0,1 or 2 . Changes how the counts will be reported. If 0 : total counts,
      if 1: counts on junctions, if 2 (default): all counts. see User guide for more
      information'
    default: 2
    inputBinding:
      position: 101
      prefix: --counts
  - id: get_low_complexity_info
    type:
      - 'null'
      - boolean
    doc: Creates a file with informations on removed low-complexity cycles.
    inputBinding:
      position: 101
      prefix: --get-low-complexity-info
  - id: get_mapping_info
    type:
      - 'null'
      - boolean
    doc: Creates a file with the KissReads mapping information of the reads on 
      the bubbles.
    inputBinding:
      position: 101
      prefix: --get-mapping-info
  - id: get_redundance_info
    type:
      - 'null'
      - boolean
    doc: Creates files with informations on compressed redundant cycles.
    inputBinding:
      position: 101
      prefix: --get-redundance-info
  - id: graph_prefix
    type:
      - 'null'
      - string
    doc: path and prefix to pre-built de Bruijn graph (suffixed by 
      .edges/.nodes) if jointly used with -r, graph used to find bubbles and 
      reads used for quantification
    inputBinding:
      position: 101
      prefix: -g
  - id: keep_bccs
    type:
      - 'null'
      - boolean
    doc: Keep the node/edges files for all bccs.
    inputBinding:
      position: 101
      prefix: --keep-bccs
  - id: keep_counts
    type:
      - 'null'
      - boolean
    doc: Keep the .counts file after the sequencing-errors-removal step.
    inputBinding:
      position: 101
      prefix: --keep-counts
  - id: keep_low_complexity
    type:
      - 'null'
      - boolean
    doc: Keep the low-complexity Type_1 cycles in the result file.
    inputBinding:
      position: 101
      prefix: --keep-low-complexity
  - id: keep_redundancy
    type:
      - 'null'
      - boolean
    doc: Keep the Type_1 redundant cycles in the result file.
    inputBinding:
      position: 101
      prefix: --keep-redundancy
  - id: keep_unfinished_bccs
    type:
      - 'null'
      - boolean
    doc: keep the nodes/edges file for unfinished bccs
    inputBinding:
      position: 101
      prefix: -u
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: k-mer size
    default: 41
    inputBinding:
      position: 101
      prefix: -k
  - id: lc_entropy_threshold
    type:
      - 'null'
      - float
    doc: Cycles with a Shannon entropy value for their upper path below this 
      value will be removed (use --keep-low-complexity to keep them).
    inputBinding:
      position: 101
      prefix: --lc-entropy-threshold
  - id: max_branching_nodes
    type:
      - 'null'
      - int
    doc: maximum number of branching nodes
    default: 5
    inputBinding:
      position: 101
      prefix: -b
  - id: max_bubbles_enumeration
    type:
      - 'null'
      - string
    doc: maximal number of bubbles enumeration in each bcc. If exceeded, no 
      bubble is output for the bcc
    default: 100M
    inputBinding:
      position: 101
      prefix: -y
  - id: max_longest_path_length
    type:
      - 'null'
      - int
    doc: maximum length of the longest path, skipped exons longer than UL_MAX 
      are not reported
    default: 1000000
    inputBinding:
      position: 101
      prefix: -M
  - id: max_memory
    type:
      - 'null'
      - int
    doc: "If you use the experimental algorithm, you must provide the maximum size
      of the process's virtual memory (address space) in megabytes (default unlimited).
      WARNING: this option does not work on Mac operating systems."
    inputBinding:
      position: 101
      prefix: --max-memory
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximal number of substitutions authorized between a read and a 
      fragment (for quantification only), default 2. If you increase the 
      mismatch and use --counts think of increasing min_overlap too.
    default: 2
    inputBinding:
      position: 101
      prefix: --mismatches
  - id: max_mismatches_snp
    type:
      - 'null'
      - int
    doc: Maximal number of substitutions authorized between a read and a 
      fragment (for quantification only) for SNP, default 0.
    default: 0
    inputBinding:
      position: 101
      prefix: --mismatchesSNP
  - id: max_shorter_path_length
    type:
      - 'null'
      - string
    doc: maximal length of the shorter path
    inputBinding:
      position: 101
      prefix: -l
  - id: min_edit_distance
    type:
      - 'null'
      - int
    doc: edit distance threshold, if the two sequences (paths) of a bubble have 
      edit distance smaller than this threshold, the bubble is classified as an 
      inexact repeat
    default: 3
    inputBinding:
      position: 101
      prefix: -e
  - id: min_kmer_coverage
    type:
      - 'null'
      - int
    doc: an integer, k-mers present strictly less than this number of times in 
      the dataset will be discarded
    default: 2
    inputBinding:
      position: 101
      prefix: -c
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Set how many nt must overlap a junction to be counted by --counts 
      option. Default=5. see User guide for more information
    default: 5
    inputBinding:
      position: 101
      prefix: --min_overlap
  - id: min_relative_coverage
    type:
      - 'null'
      - float
    doc: a percentage from [0,1), edges with relative coverage below this number
      are removed
    default: 0.05
    inputBinding:
      position: 101
      prefix: -C
  - id: min_shorter_path_length
    type:
      - 'null'
      - string
    doc: minimum length of the shorter path
    inputBinding:
      position: 101
      prefix: -m
  - id: not_experimental
    type:
      - 'null'
      - boolean
    doc: Do not use a new experimental algorithm that searches for bubbles by 
      listing all paths.
    inputBinding:
      position: 101
      prefix: --not-experimental
  - id: num_processes
    type:
      - 'null'
      - int
    doc: number of cores (must be <= number of physical cores)
    inputBinding:
      position: 101
      prefix: -t
  - id: output_branch_count
    type:
      - 'null'
      - boolean
    doc: Will output the number of branching nodes in each path.
    inputBinding:
      position: 101
      prefix: --output-branch-count
  - id: output_context
    type:
      - 'null'
      - boolean
    doc: Will output the maximum non-ambiguous context of a bubble
    inputBinding:
      position: 101
      prefix: --output-context
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: path to store the results and the summary log file
    default: ./results
    inputBinding:
      position: 101
      prefix: -o
  - id: output_path
    type:
      - 'null'
      - boolean
    doc: Will output the id of the nodes composing the two paths of the bubbles.
    inputBinding:
      position: 101
      prefix: --output-path
  - id: output_snps
    type:
      - 'null'
      - int
    doc: '0, 1 or 2. Changes which types of SNPs will be output. If 0 (default), will
      not output SNPs. If 1, will output Type0a-SNPs. If 2, will output Type0a and
      Type0b SNPs (warning: this option may increase a lot the running time. You might
      also want to try the experimental algorithm here)'
    default: 0
    inputBinding:
      position: 101
      prefix: -s
  - id: read_files
    type:
      - 'null'
      - type: array
        items: File
    doc: input fasta/q read files or compressed (.gz) fasta/q files (mutiple, 
      such as "-r file1 -r file2...")
    inputBinding:
      position: 101
      prefix: -r
  - id: stranded
    type:
      - 'null'
      - boolean
    doc: Execute kissreads in stranded mode.
    inputBinding:
      position: 101
      prefix: --stranded
  - id: stranded_absolute_threshold
    type:
      - 'null'
      - int
    doc: Sets the minimum number of reads mapping to a path of a bubble in a 
      read set is needed to call a strand.
    inputBinding:
      position: 101
      prefix: --strandedAbsoluteThreshold
  - id: stranded_relative_threshold
    type:
      - 'null'
      - float
    doc: If a strand is called for a path of a bubble in a read set, but the 
      proportion of reads calling this strand is less than this threshold, then 
      the strand of the path is set to '?' (any strand - not enough evidence to 
      call a strand).
    inputBinding:
      position: 101
      prefix: --strandedRelativeThreshold
  - id: timeout
    type:
      - 'null'
      - int
    doc: max amount of time (in seconds) spent for enumerating bubbles in each 
      bcc. If exceeded, no bubble is output for the bcc
    default: 100000
    inputBinding:
      position: 101
      prefix: --timeout
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: specific directory (absolute path) where to build temporary files
    inputBinding:
      position: 101
      prefix: -d
  - id: type1_only
    type:
      - 'null'
      - boolean
    doc: Only quantify Type 1 bubbles (alternative splicing events, MAJOR SPEED 
      UP with -b > 10 BUT all other bubbles will not appear in the result file).
    inputBinding:
      position: 101
      prefix: --type1-only
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
stdout: kissplice.out
