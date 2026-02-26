cwlVersion: v1.2
class: CommandLineTool
baseCommand: superfocus
label: super-focus_superfocus
doc: "SUPER-FOCUS: A tool for agile functional analysis of shotgun metagenomic data.\n\
  \nTool homepage: https://edwards.sdsu.edu/SUPERFOCUS"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: "aligner choice (rapsearch, diamond, blast, or mmseqs2;\ndefault rapsearch)."
    default: rapsearch
    inputBinding:
      position: 101
      prefix: --aligner
  - id: alternate_directory
    type:
      - 'null'
      - Directory
    doc: Alternate directory for your databases.
    inputBinding:
      position: 101
      prefix: --alternate_directory
  - id: amino_acid
    type:
      - 'null'
      - boolean
    doc: "amino acid input; 0 nucleotides; 1 amino acids\n                       \
      \ (default 0)."
    default: false
    inputBinding:
      position: 101
      prefix: --amino_acid
  - id: database
    type:
      - 'null'
      - string
    doc: "database (DB_90, DB_95, DB_98, or DB_100; default\n                    \
      \    DB_90)"
    default: DB_90
    inputBinding:
      position: 101
      prefix: --database
  - id: delete_alignments
    type:
      - 'null'
      - boolean
    doc: Delete alignments
    inputBinding:
      position: 101
      prefix: --delete_alignments
  - id: evalue
    type:
      - 'null'
      - float
    doc: e-value (default 0.00001).
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --evalue
  - id: fast
    type:
      - 'null'
      - boolean
    doc: "runs RAPSearch2 or DIAMOND on fast mode - 0 (False) /\n                \
      \        1 (True) (default: 1)."
    default: true
    inputBinding:
      position: 101
      prefix: --fast
  - id: focus
    type:
      - 'null'
      - boolean
    doc: 'runs FOCUS; 1 does run; 0 does not run: default 0.'
    default: false
    inputBinding:
      position: 101
      prefix: --focus
  - id: latency_wait
    type:
      - 'null'
      - int
    doc: "Add a delay (in seconds) between writing the file and\n                \
      \        reading it"
    inputBinding:
      position: 101
      prefix: --latency_wait
  - id: log
    type:
      - 'null'
      - File
    doc: 'Path to log file (Default: STDOUT).'
    default: STDOUT
    inputBinding:
      position: 101
      prefix: --log
  - id: minimum_alignment
    type:
      - 'null'
      - int
    doc: 'minimum alignment (amino acids) (default: 15).'
    default: 15
    inputBinding:
      position: 101
      prefix: --minimum_alignment
  - id: minimum_identity
    type:
      - 'null'
      - float
    doc: minimum identity (default 60 perc).
    default: 60.0
    inputBinding:
      position: 101
      prefix: --minimum_identity
  - id: normalise_output
    type:
      - 'null'
      - boolean
    doc: "normalises each query counts based on number of hits;\n                \
      \        0 doesn't normalize; 1 normalizes (default: 1)."
    default: true
    inputBinding:
      position: 101
      prefix: --normalise_output
  - id: output_directory
    type: Directory
    doc: Path to output files
    inputBinding:
      position: 101
      prefix: --output_directory
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: 'Output prefix (Default: output).'
    default: output
    inputBinding:
      position: 101
      prefix: --output_prefix
  - id: query
    type: File
    doc: Path to FAST(A/Q) file or directory with these files.
    inputBinding:
      position: 101
      prefix: --query
  - id: subsample
    type:
      - 'null'
      - string
    doc: "subsample the sequences to reduce memory demand and\n                  \
      \      speed up analysis"
    inputBinding:
      position: 101
      prefix: --subsample
  - id: temp_directory
    type:
      - 'null'
      - Directory
    doc: specify an alternate temporary directory to use
    inputBinding:
      position: 101
      prefix: --temp_directory
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number Threads used in the k-mer counting (Default:\n                  \
      \      4)."
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/super-focus:1.6--pyhdfd78af_1
stdout: super-focus_superfocus.out
