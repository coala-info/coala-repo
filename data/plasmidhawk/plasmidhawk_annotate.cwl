cwlVersion: v1.2
class: CommandLineTool
baseCommand: plasmidhawk annotate
label: plasmidhawk_annotate
doc: "Annotates plasmid metadata based on fragment metadata and plasmid ordering information.\n\
  \nTool homepage: https://gitlab.com/treangenlab/plasmidhawk"
inputs:
  - id: frag_metadata
    type: File
    doc: The TSV metadata generated from plaster
    inputBinding:
      position: 1
  - id: plasmid_metadata
    type: File
    doc: File containing information on which labs ordered which plasmids
    inputBinding:
      position: 2
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasmidhawk:1.0.3--hdfd78af_0
