cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidhawk
label: plasmidhawk
doc: "PlasmidHawk: A tool for plasmid analysis\n\nTool homepage: https://gitlab.com/treangenlab/plasmidhawk"
inputs:
  - id: sub_command
    type: string
    doc: sub-command help
    inputBinding:
      position: 1
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Create annotation file which maps labs to fragments
    inputBinding:
      position: 102
  - id: predict
    type:
      - 'null'
      - boolean
    doc: Predict lab of origin of input sequences
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0
stdout: plasmidhawk.out
