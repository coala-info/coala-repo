cwlVersion: v1.2
class: CommandLineTool
baseCommand: domainator_deduplicate_genbank.py
label: domainator_deduplicate_genbank.py
doc: "Remove redundant sequences from a genbank file\n\nRuns a clustering algorithm,
  such as cdhit or usearch on sequences from a genbank (or fasta) file to reduce redundancy.\n\
  The \"hash\" algorithm is a faster way to deduplicate exact duplicates, by hashing
  the sequences and eliminating hash duplicates.\n\nTool homepage: https://github.com/nebiolabs/domainator"
inputs:
  - id: algorithm
    type:
      - 'null'
      - string
    doc: Which clustering algorithm to use.
    default: cd-hit
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: bin_path
    type:
      - 'null'
      - string
    doc: If the executable for the algorithm you're using isn't in the system 
      path, you can provide the full path to the executable here.
    default: None
    inputBinding:
      position: 101
      prefix: --bin_path
  - id: both_strands
    type:
      - 'null'
      - boolean
    doc: When set for nucleotide inputs, consider both strands for 
      clustering/hash deduplication.
    default: false
    inputBinding:
      position: 101
      prefix: --both_strands
  - id: cluster_sep
    type:
      - 'null'
      - string
    doc: "Separator to separate individual contig names in the second column of the
      cluster table. Default: ' ; '"
    default: ' ; '
    inputBinding:
      position: 101
      prefix: --cluster_sep
  - id: cluster_table
    type:
      - 'null'
      - File
    doc: 'If supplied, then write a tab separated table with columns: representative,
      contigs.'
    default: None
    inputBinding:
      position: 101
      prefix: --cluster_table
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a configuration file.
    default: None
    inputBinding:
      position: 101
      prefix: --config
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'The number of threads to use for deduplication [default: use all available
      cores]'
    default: 0
    inputBinding:
      position: 101
      prefix: --cpu
  - id: fasta_out
    type:
      - 'null'
      - boolean
    doc: makes output a fasta file when activated
    default: false
    inputBinding:
      position: 101
      prefix: --fasta_out
  - id: fasta_type
    type:
      - 'null'
      - string
    doc: Whether the sequences in fasta files are protein or nucleotide 
      sequences.
    default: protein
    inputBinding:
      position: 101
      prefix: --fasta_type
  - id: id
    type:
      - 'null'
      - float
    doc: Identity threshold (between 0 and 1), passed to cd-hit as the -c 
      parameter or to usearach as the -id parameter.
    default: None
    inputBinding:
      position: 101
      prefix: --id
  - id: input
    type:
      - 'null'
      - type: array
        items: File
    doc: Genbank or fasta filenames.
    default: None
    inputBinding:
      position: 101
      prefix: --input
  - id: log
    type:
      - 'null'
      - File
    doc: The name of the log file. If not supplied, writes to stderr.
    default: None
    inputBinding:
      position: 101
      prefix: --log
  - id: params
    type:
      - 'null'
      - string
    doc: "string of parameters to pass to the clustering algorithm, in the form of
      a json dict in single quotes. example: '\"-s\":0.9'"
    default: None
    inputBinding:
      position: 101
      prefix: --params
  - id: prefix_count
    type:
      - 'null'
      - boolean
    doc: In the output genbank file, will prepend X- to the names of contigs, 
      where X is the number of contigs from the original file collapsed into 
      this centroid.
    default: false
    inputBinding:
      position: 101
      prefix: --prefix_count
  - id: print_config
    type:
      - 'null'
      - boolean
    doc: 'Print the configuration after applying all other arguments and exit. The
      optional flags customizes the output and are one or more keywords separated
      by comma. The supported flags are: comments, skip_default, skip_null.'
    inputBinding:
      position: 101
      prefix: --print_config
  - id: suffix_count
    type:
      - 'null'
      - boolean
    doc: In the output genbank file, will append -X to the names of contigs, 
      where X is the number of contigs from the original file collapsed into 
      this centroid.
    default: false
    inputBinding:
      position: 101
      prefix: --suffix_count
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: The name of the output file. If not supplied, writes to stdout.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/domainator:0.8.1--pyhdfd78af_0
