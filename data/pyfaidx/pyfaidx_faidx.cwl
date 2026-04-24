cwlVersion: v1.2
class: CommandLineTool
baseCommand: faidx
label: pyfaidx_faidx
doc: "Fetch sequences from FASTA. If no regions are specified, all entries in the\n\
  input file are returned. Input FASTA file must be consistently line-wrapped,\nand
  line wrapping of output is based on input line lengths.\n\nTool homepage: https://github.com/mdshw5/pyfaidx"
inputs:
  - id: fasta
    type: File
    doc: FASTA file
    inputBinding:
      position: 1
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: "space separated regions of sequence to fetch e.g.\nchr1:1-1000"
    inputBinding:
      position: 2
  - id: auto_strand
    type:
      - 'null'
      - boolean
    doc: "reverse complement the sequence when start > end\ncoordinate. default: False"
    inputBinding:
      position: 103
      prefix: --auto-strand
  - id: bed_file
    type:
      - 'null'
      - File
    doc: bed file of regions (zero-based start coordinate)
    inputBinding:
      position: 103
      prefix: --bed
  - id: complement
    type:
      - 'null'
      - boolean
    doc: 'complement the sequence. default: False'
    inputBinding:
      position: 103
      prefix: --complement
  - id: default_seq
    type:
      - 'null'
      - string
    doc: 'default base for missing positions and masking. default: None'
    inputBinding:
      position: 103
      prefix: --default-seq
  - id: delimiter
    type:
      - 'null'
      - string
    doc: "delimiter for splitting names to multiple values\n(duplicate names will
      be discarded). default: None"
    inputBinding:
      position: 103
      prefix: --delimiter
  - id: duplicates_action
    type:
      - 'null'
      - string
    doc: "entry to take when duplicate sequence names are\nencountered. default: stop"
    inputBinding:
      position: 103
      prefix: --duplicates-action
  - id: header_function
    type:
      - 'null'
      - string
    doc: 'python function to modify header lines e.g: "lambda x: x.split("|")[0]".
    inputBinding:
      position: 103
      prefix: --header-function
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: "selected sequences are those not matching 'regions'\nargument. default:
      False"
    inputBinding:
      position: 103
      prefix: --invert-match
  - id: lazy
    type:
      - 'null'
      - boolean
    doc: 'fill in --default-seq for missing ranges. default: False'
    inputBinding:
      position: 103
      prefix: --lazy
  - id: long_names
    type:
      - 'null'
      - boolean
    doc: "output full (long) names from the input fasta headers.\ndefault: headers
      are truncated after the first\nwhitespace"
    inputBinding:
      position: 103
      prefix: --long-names
  - id: mask_by_case
    type:
      - 'null'
      - boolean
    doc: 'mask the FASTA file by changing to lowercase. default: False'
    inputBinding:
      position: 103
      prefix: --mask-by-case
  - id: mask_with_default_seq
    type:
      - 'null'
      - boolean
    doc: 'mask the FASTA file using --default-seq default: False'
    inputBinding:
      position: 103
      prefix: --mask-with-default-seq
  - id: no_coords
    type:
      - 'null'
      - boolean
    doc: "omit coordinates (e.g. chr:start-end) from output\nheaders. default: False"
    inputBinding:
      position: 103
      prefix: --no-coords
  - id: no_names
    type:
      - 'null'
      - boolean
    doc: 'omit sequence names from output. default: False'
    inputBinding:
      position: 103
      prefix: --no-names
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: 'do not output any sequence. default: False'
    inputBinding:
      position: 103
      prefix: --no-output
  - id: no_rebuild
    type:
      - 'null'
      - boolean
    doc: "do not rebuild the .fai index even if it is out of\n    date. default: False"
    inputBinding:
      position: 103
      prefix: --no-rebuild
  - id: regex
    type:
      - 'null'
      - string
    doc: "selected sequences are those matching regular\nexpression. default: .*"
    inputBinding:
      position: 103
      prefix: --regex
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: 'reverse the sequence. default: False'
    inputBinding:
      position: 103
      prefix: --reverse
  - id: size_range
    type:
      - 'null'
      - string
    doc: "selected sequences are in the size range [low, high].\nexample: 1,1000 default:
      None"
    inputBinding:
      position: 103
      prefix: --size-range
  - id: split_files
    type:
      - 'null'
      - boolean
    doc: "write each region to a separate file (names are\nderived from regions)"
    inputBinding:
      position: 103
      prefix: --split-files
  - id: transform
    type:
      - 'null'
      - string
    doc: "transform the requested regions into another format.\ndefault: None"
    inputBinding:
      position: 103
      prefix: --transform
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'output file name (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfaidx:0.9.0.3--pyhdfd78af_0
