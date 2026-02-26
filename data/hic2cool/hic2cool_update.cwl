cwlVersion: v1.2
class: CommandLineTool
baseCommand: hic2cool update
label: hic2cool_update
doc: "update a cooler file produced by hic2cool\n\nTool homepage: https://github.com/4dn-dcic/hic2cool"
inputs:
  - id: infile
    type: File
    doc: cooler input file path
    inputBinding:
      position: 1
  - id: silent
    type:
      - 'null'
      - boolean
    doc: if used, silence standard program output
    inputBinding:
      position: 102
      prefix: --silent
  - id: warnings
    type:
      - 'null'
      - boolean
    doc: if used, print out non-critical WARNING messages, which are hidden by 
      default. Silent mode takes precedence over this
    inputBinding:
      position: 102
      prefix: --warnings
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: optional new output file path
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hic2cool:1.0.1--pyh7cba7a3_0
