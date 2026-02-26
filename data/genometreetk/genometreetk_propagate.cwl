cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometreetk propagate
label: genometreetk_propagate
doc: "Propagate labels to all genomes in a cluster.\n\nTool homepage: http://pypi.python.org/pypi/genometreetk/"
inputs:
  - id: input_taxonomy
    type: File
    doc: input taxonomy file
    inputBinding:
      position: 1
  - id: metadata_file
    type: File
    doc: metadata file for all genomes in the GTDB
    inputBinding:
      position: 2
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output
    inputBinding:
      position: 103
      prefix: --silent
outputs:
  - id: output_taxonomy
    type: File
    doc: output taxonomy file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometreetk:0.1.6--py_2
