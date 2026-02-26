cwlVersion: v1.2
class: CommandLineTool
baseCommand: votuderep trainingdata
label: votuderep_trainingdata
doc: "Download training dataset from the internet. Uses a registry (DATASETS) of named
  datasets, each containing a set of {url, path} items. Adds new datasets by extending
  the DATASETS dict.\n\nTool homepage: https://github.com/quadram-institute-bioscience/votuderep"
inputs:
  - id: name
    type:
      - 'null'
      - string
    doc: Dataset name to download (registered in DATASETS)
    default: virome
    inputBinding:
      position: 101
      prefix: --name
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Where to put the output files
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/votuderep:0.6.0--pyhdfd78af_0
