cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx plot-vcf-read-depth
label: pypgx_plot-vcf-read-depth
doc: "Plot read depth profile with VCF data.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: gene
    type: string
    doc: Target gene.
    inputBinding:
      position: 1
  - id: vcf
    type: File
    doc: Input VCF file.
    inputBinding:
      position: 2
  - id: assembly
    type:
      - 'null'
      - string
    doc: "Reference genome assembly (default: 'GRCh37') (choices: 'GRCh37', 'GRCh38')."
    default: GRCh37
    inputBinding:
      position: 103
      prefix: --assembly
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
    doc: Y-axis top.
    inputBinding:
      position: 103
      prefix: --ymax
  - id: ymin
    type:
      - 'null'
      - float
    doc: Y-axis bottom.
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
stdout: pypgx_plot-vcf-read-depth.out
