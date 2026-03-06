cwlVersion: v1.2
class: CommandLineTool
label: samtools_tview
doc: "Text alignment viewer\n\nTool homepage: https://github.com/samtools/samtools"
requirements:
- class: InitialWorkDirRequirement
  listing:
  - entry: $(inputs.reference_fasta)
    entryname: $(inputs.reference_fasta.basename)
- class: InlineJavascriptRequirement
baseCommand:
- samtools
- tview
arguments:
- position: 103
  prefix: -d
  valueFrom: T
inputs:
- id: alignment_bam
  type: File
  doc: Input alignment BAM file
  secondaryFiles:
  - .bai
  inputBinding:
    position: 1
- id: reference_fasta
  type: File
  doc: Reference sequence FASTA file
  inputBinding:
    position: 2
    valueFrom: $(self.basename)
- id: custom_index
  type: boolean?
  doc: include customized index file
  inputBinding:
    position: 103
    prefix: -X
- id: display_type
  type: string?
  doc: output as (H)tml or (C)urses or (T)ext
  inputBinding:
    position: 103
    prefix: -d
- id: display_width
  type: int?
  doc: display width (with -d T only)
  inputBinding:
    position: 103
    prefix: -w
- id: hide_inserts
  type: boolean?
  doc: hide inserts
  inputBinding:
    position: 103
    prefix: -i
- id: input_fmt_option
  type: string[]?
  doc: Specify a single input file format option in the form of OPTION or 
    OPTION=VALUE
  inputBinding:
    position: 103
    prefix: --input-fmt-option
- id: position
  type: string?
  doc: go directly to this position (chr:pos)
  inputBinding:
    position: 103
    prefix: -p
- id: reference
  type: File?
  doc: Reference sequence FASTA FILE
  inputBinding:
    position: 103
    prefix: --reference
- id: sample_group
  type: string?
  doc: display only reads from this sample or group
  inputBinding:
    position: 103
    prefix: -s
- id: verbosity
  type: int?
  doc: Set level of verbosity
  inputBinding:
    position: 103
    prefix: --verbosity
outputs:
- id: stdout
  type: stdout
  doc: Standard output
hints:
- class: DockerRequirement
  dockerPull: quay.io/biocontainers/samtools:1.23--h96c455f_0
stdout: samtools_tview.out
