cwlVersion: v1.2
class: CommandLineTool
baseCommand: faidx
label: python3-pyfaidx
doc: "Fetch sequences from FASTA. If no regions are specified, all entries in the
  input file are returned. Input FASTA file must be consistently line-wrapped, and
  line wrapping of output is based on input line lengths.\n\nTool homepage: https://github.com/mdshw5/pyfaidx"
inputs:
  - id: fasta_file
    type: File
    doc: FASTA file
    inputBinding:
      position: 100
  - id: regions
    type:
      - 'null'
      - type: array
        items: string
    doc: space separated regions of sequence to fetch e.g. chr1:1-1000
    inputBinding:
      position: 101
  - id: bed
    type:
      - 'null'
      - File
    doc: bed file of regions
    inputBinding:
      position: 1
      prefix: --bed
  - id: transform
    type:
      - 'null'
      - string
    doc: transform the requested regions into another format (bed, chromsizes, 
      nucleotide or transposed).
    inputBinding:
      position: 1
      prefix: --transform
  - id: complement
    type:
      - 'null'
      - boolean
    doc: complement the sequence.
    inputBinding:
      position: 1
      prefix: --complement
  - id: reverse
    type:
      - 'null'
      - boolean
    doc: reverse the sequence.
    inputBinding:
      position: 1
      prefix: --reverse
  - id: size_range
    type:
      - 'null'
      - string
    doc: 'selected sequences are in the size range [low, high]. example: 1,1000'
    inputBinding:
      position: 1
      prefix: --size-range
  - id: no_names
    type:
      - 'null'
      - boolean
    doc: omit sequence names from output.
    inputBinding:
      position: 1
      prefix: --no-names
  - id: full_names
    type:
      - 'null'
      - boolean
    doc: output full names including description.
    inputBinding:
      position: 1
      prefix: --full-names
  - id: split_files
    type:
      - 'null'
      - boolean
    doc: write each region to a separate file (names are derived from regions).
    inputBinding:
      position: 1
      prefix: --split-files
  - id: lazy
    type:
      - 'null'
      - boolean
    doc: fill in --default-seq for missing ranges.
    inputBinding:
      position: 1
      prefix: --lazy
  - id: default_seq
    type:
      - 'null'
      - string
    doc: default base for missing positions and masking.
    inputBinding:
      position: 1
      prefix: --default-seq
  - id: delimiter
    type:
      - 'null'
      - string
    doc: delimiter for splitting names to multiple values (duplicate names will 
      be discarded).
    inputBinding:
      position: 1
      prefix: --delimiter
  - id: regex
    type:
      - 'null'
      - string
    doc: selected sequences are those matching regular expression.
    inputBinding:
      position: 1
      prefix: --regex
  - id: invert_match
    type:
      - 'null'
      - boolean
    doc: selected sequences are those not matching 'regions' argument.
    inputBinding:
      position: 1
      prefix: --invert-match
  - id: mask_with_default_seq
    type:
      - 'null'
      - boolean
    doc: mask the FASTA file using --default-seq.
    inputBinding:
      position: 1
      prefix: --mask-with-default-seq
  - id: mask_by_case
    type:
      - 'null'
      - boolean
    doc: mask the FASTA file by changing to lowercase.
    inputBinding:
      position: 1
      prefix: --mask-by-case
  - id: no_rebuild
    type:
      - 'null'
      - boolean
    doc: do not rebuild the .fai index even if it is out of date.
    inputBinding:
      position: 1
      prefix: --no-rebuild
  - id: out_file_path
    type:
      - 'null'
      - string
    doc: output file name (default stdout)
    inputBinding:
      position: 1
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the fetched sequences, or the transformed regions)
  - id: out_file
    type:
      - 'null'
      - File
    doc: output file written with --out
    outputBinding:
      glob: $(inputs.out_file_path)
  - id: fasta_index
    type:
      - 'null'
      - File
    doc: FASTA index (.fai) built next to the input FASTA file
    outputBinding:
      glob: $(inputs.fasta_file.basename).fai
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-pyfaidx:v0.4.8.1-1-deb_cv1
stdout: python3-pyfaidx.out
