cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_prg from_msa
label: make_prg_from_msa
doc: "Creates a PRG from a Multiple Sequence Alignment.\n\nTool homepage: https://github.com/rmcolq/make_prg"
inputs:
  - id: alignment_format
    type:
      - 'null'
      - string
    doc: "Alignment format of MSA, must be a biopython AlignIO\n                 \
      \       input alignment_format. See\n                        http://biopython.org/wiki/AlignIO.
      Default: fasta"
    default: fasta
    inputBinding:
      position: 101
      prefix: --alignment-format
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite previous output
    inputBinding:
      position: 101
      prefix: --force
  - id: input
    type: File
    doc: "Multiple sequence alignment file or a directory\n                      \
      \  containing such files"
    inputBinding:
      position: 101
      prefix: --input
  - id: log
    type:
      - 'null'
      - File
    doc: Path to write log to. Default is stderr
    default: stderr
    inputBinding:
      position: 101
      prefix: --log
  - id: max_nesting
    type:
      - 'null'
      - int
    doc: "Maximum number of levels to use for nesting. Default:\n                \
      \        5"
    default: 5
    inputBinding:
      position: 101
      prefix: --max-nesting
  - id: min_match_length
    type:
      - 'null'
      - int
    doc: "Minimum number of consecutive characters which must be\n               \
      \         identical for a match. Default: 7"
    default: 7
    inputBinding:
      position: 101
      prefix: --min-match-length
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for the output files
    inputBinding:
      position: 101
      prefix: --output-prefix
  - id: output_type
    type:
      - 'null'
      - string
    doc: "p: PRG, b: Binary, g: GFA, a: All. Combinations are\n                  \
      \      allowed i.e., gb: GFA and Binary. Default: a"
    default: a
    inputBinding:
      position: 101
      prefix: --output-type
  - id: suffix
    type:
      - 'null'
      - string
    doc: "If the input parameter (-i, --input) is a directory,\n                 \
      \       then filter for files with this suffix. If this\n                  \
      \      parameter is not given, all files in the input\n                    \
      \    directory is considered."
    inputBinding:
      position: 101
      prefix: --suffix
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. 0 will use all available. Default:\n                \
      \        1"
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase output verbosity (-v for debug, -vv for trace\n               \
      \         - trace is for developers only)"
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/make_prg:0.5.0--pyhdfd78af_0
stdout: make_prg_from_msa.out
