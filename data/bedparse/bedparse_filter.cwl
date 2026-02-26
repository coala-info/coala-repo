cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedparse filter
label: bedparse_filter
doc: "Filters a BED file based on an annotation. BED entries with a name (i.e. col4)
  that appears in the specified column of the annotation are printed to stdout. For
  efficiency reasons this command doesn't perform BED validation.\n\nTool homepage:
  https://github.com/tleonardi/bedparse"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Path to the BED file.
    inputBinding:
      position: 1
  - id: annotation
    type: File
    doc: Path to the annotation file.
    inputBinding:
      position: 102
      prefix: --annotation
  - id: column
    type:
      - 'null'
      - int
    doc: Column of the annotation file (1-based, default=1).
    default: 1
    inputBinding:
      position: 102
      prefix: --column
  - id: inverse
    type:
      - 'null'
      - boolean
    doc: Only report BED entries absent from the annotation file.
    inputBinding:
      position: 102
      prefix: --inverse
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_filter.out
