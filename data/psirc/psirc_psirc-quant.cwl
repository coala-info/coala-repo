cwlVersion: v1.2
class: CommandLineTool
baseCommand: psirc-quant
label: psirc_psirc-quant
doc: "A tool for building indices and running quantification algorithms for transcriptomics.\n\
  \nTool homepage: https://github.com/nictru/psirc"
inputs:
  - id: command
    type: string
    doc: The command to execute (index, quant, pseudo, query, h5dump, inspect, 
      version, or cite)
    inputBinding:
      position: 1
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments specific to the chosen command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psirc:1.0.0--h6f0a7f7_1
stdout: psirc_psirc-quant.out
