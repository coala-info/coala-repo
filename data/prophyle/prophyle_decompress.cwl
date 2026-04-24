cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - prophyle
  - decompress
label: prophyle_decompress
doc: "Decompress a prophyle archive\n\nTool homepage: https://github.com/karel-brinda/prophyle"
inputs:
  - id: archive
    type: File
    doc: output archive
    inputBinding:
      position: 1
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 2
  - id: configuration
    type:
      - 'null'
      - type: array
        items: string
    doc: advanced configuration (a JSON dictionary)
    inputBinding:
      position: 103
      prefix: -c
  - id: skip_k_lcp_construction
    type:
      - 'null'
      - boolean
    doc: skip k-LCP construction
    inputBinding:
      position: 103
      prefix: -K
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prophyle:0.3.3.2--py39h746d604_3
stdout: prophyle_decompress.out
