cwlVersion: v1.2
class: CommandLineTool
baseCommand: hic2cool extract-norms
label: hic2cool_extract-norms
doc: "extract normalization vectors from a cooler file and add them to a cooler file\n\
  \nTool homepage: https://github.com/4dn-dcic/hic2cool"
inputs:
  - id: infile
    type: File
    doc: hic file path
    inputBinding:
      position: 1
  - id: outfile
    type: File
    doc: cooler file path
    inputBinding:
      position: 2
  - id: exclude_mt
    type:
      - 'null'
      - boolean
    doc: if used, exclude the mitochondria (MT) from the output
    inputBinding:
      position: 103
      prefix: --exclude-mt
  - id: silent
    type:
      - 'null'
      - boolean
    doc: if used, silence standard program output
    inputBinding:
      position: 103
      prefix: --silent
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: if used, print out non-critical WARNING messages, which are hidden by 
      default. Silent mode takes precedence over this
    inputBinding:
      position: 103
      prefix: --warnings
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
stdout: hic2cool_extract-norms.out
