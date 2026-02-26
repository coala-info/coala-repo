cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx plot-cn-af
label: pypgx_plot-cn-af
doc: "Plot both copy number profile and allele fraction profile in one figure.\n\n\
  Tool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: copy_number
    type: File
    doc: Input archive file with the semantic type CovFrame[CopyNumber].
    inputBinding:
      position: 1
  - id: imported_variants
    type: File
    doc: Input archive file with the semantic type VcfFrame[Imported].
    inputBinding:
      position: 2
  - id: fontsize
    type:
      - 'null'
      - float
    doc: 'Text fontsize (default: 25).'
    default: 25
    inputBinding:
      position: 103
      prefix: --fontsize
  - id: path
    type:
      - 'null'
      - Directory
    doc: 'Create plots in this directory (default: current directory).'
    default: current directory
    inputBinding:
      position: 103
      prefix: --path
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify which samples should be included for analysis by providing a 
      text file (.txt, .tsv, .csv, or .list) containing one sample per line. 
      Alternatively, you can provide a list of samples.
    inputBinding:
      position: 103
      prefix: --samples
  - id: ymax
    type:
      - 'null'
      - float
    doc: 'Y-axis top (default: 6.3).'
    default: 6.3
    inputBinding:
      position: 103
      prefix: --ymax
  - id: ymin
    type:
      - 'null'
      - float
    doc: 'Y-axis bottom (default: -0.3).'
    default: -0.3
    inputBinding:
      position: 103
      prefix: --ymin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_plot-cn-af.out
