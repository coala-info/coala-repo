cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtToMaf
label: ucsc-axttomaf
doc: "Convert from axt to maf format. axtToMaf combines axt alignment files with sequence\
  \ size information to produce MAF (Multiple Alignment Format) files.\n\nTool homepage:\
  \ https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: axt_file
    type: File
    doc: Input axt file (sorted by target when -tSplit is used)
    inputBinding:
      position: 11
  - id: t_size_file
    type: File
    doc: 'Target sequence size file (two-column file: name and size)'
    inputBinding:
      position: 12
  - id: q_size_file
    type: File
    doc: 'Query sequence size file (two-column file: name and size)'
    inputBinding:
      position: 13
  - id: output_maf_path
    type: string
    doc: Name of the output maf file (a directory when -tSplit is used)
    inputBinding:
      position: 14
  - id: q_prefix
    type:
      - 'null'
      - string
    doc: Add this prefix (for example XX.) to the start of the query sequence name
      in the maf
    inputBinding:
      position: 1
      prefix: -qPrefix=
      separate: false
  - id: t_prefix
    type:
      - 'null'
      - string
    doc: Add this prefix (for example YY.) to the start of the target sequence name
      in the maf
    inputBinding:
      position: 2
      prefix: -tPrefix=
      separate: false
  - id: t_split
    type:
      - 'null'
      - boolean
    doc: Create a separate maf file for each target sequence. The output is then a
      directory, and the input axt must be sorted by target.
    inputBinding:
      position: 3
      prefix: -tSplit
  - id: score
    type:
      - 'null'
      - boolean
    doc: Recalculate score
    inputBinding:
      position: 4
      prefix: -score
  - id: score_zero
    type:
      - 'null'
      - boolean
    doc: Recalculate score if zero
    inputBinding:
      position: 5
      prefix: -scoreZero
outputs:
  - id: maf_file
    type:
      - 'null'
      - File
    doc: Output maf file
    outputBinding:
      glob: "$(inputs.t_split ? [] : inputs.output_maf_path)"
  - id: maf_dir
    type:
      - 'null'
      - Directory
    doc: Output directory with one maf file per target sequence (with -tSplit)
    outputBinding:
      glob: "$(inputs.t_split ? inputs.output_maf_path : [])"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttomaf:482--h0b57e2e_0
