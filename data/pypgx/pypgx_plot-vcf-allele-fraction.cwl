cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - plot-vcf-allele-fraction
label: pypgx_plot-vcf-allele-fraction
doc: "Plot allele fraction profile from VcfFrame[Imported].\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: imported_variants
    type: File
    doc: Input archive file with the semantic type VcfFrame[Imported].
    inputBinding:
      position: 1
  - id: fontsize
    type:
      - 'null'
      - float
    doc: Text fontsize
    inputBinding:
      position: 102
      prefix: --fontsize
  - id: path
    type:
      - 'null'
      - Directory
    doc: Create plots in this directory
    inputBinding:
      position: 102
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
      position: 102
      prefix: --samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
stdout: pypgx_plot-vcf-allele-fraction.out
