cwlVersion: v1.2
class: CommandLineTool
baseCommand:
- samtools
- tview
label: samtools_tview
doc: 'Text alignment viewer


  Tool homepage: https://github.com/samtools/samtools'
requirements:
- class: InlineJavascriptRequirement
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
inputs:
- id: alignment_file
  type: File
  doc: Input sorted, indexed alignment file.
  secondaryFiles:
  - pattern: .bai
    required: false
  - pattern: .csi
    required: false
  - pattern: .crai
    required: false
  - pattern: ^.bai
    required: false
  inputBinding:
    position: 104
- id: reference_fasta
  type:
  - 'null'
  - File
  doc: Reference FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 105
- id: display
  type:
  - 'null'
  - string
  doc: Output as (H)tml or (C)urses or (T)ext; use T or H without a terminal (-d).
  inputBinding:
    position: 103
    prefix: -d
- id: custom_index
  type:
  - 'null'
  - boolean
  doc: Include customized index file.
  inputBinding:
    position: 103
    prefix: -X
- id: position
  type:
  - 'null'
  - string
  doc: Go directly to this position, chr:pos.
  inputBinding:
    position: 103
    prefix: -p
- id: sample
  type:
  - 'null'
  - string
  doc: Display only reads from this sample or group.
  inputBinding:
    position: 103
    prefix: -s
- id: display_width
  type:
  - 'null'
  - int
  doc: Display width (with -d T only).
  inputBinding:
    position: 103
    prefix: -w
- id: hide_inserts
  type:
  - 'null'
  - boolean
  doc: Hide inserts.
  inputBinding:
    position: 103
    prefix: -i
- id: input_fmt_option
  type:
  - 'null'
  - type: array
    items: string
    inputBinding:
      prefix: --input-fmt-option
  doc: Specify a single input file format option in the form OPTION or OPTION=VALUE (repeatable).
  inputBinding:
    position: 103
- id: reference
  type:
  - 'null'
  - File
  doc: Reference sequence FASTA file.
  secondaryFiles:
  - pattern: .fai
    required: false
  inputBinding:
    position: 103
    prefix: --reference
- id: verbosity
  type:
  - 'null'
  - int
  doc: Set level of verbosity.
  inputBinding:
    position: 103
    prefix: --verbosity
- id: output_filename
  type: string
  doc: Name of the file that receives the text alignment view.
  default: tview.txt
outputs:
- id: output
  type: File
  doc: Text alignment view.
  outputBinding:
    glob: $(inputs.output_filename)
stdout: $(inputs.output_filename)
