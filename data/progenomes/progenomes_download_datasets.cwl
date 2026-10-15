cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - progenomes
  - download
  - datasets
label: progenomes_download_datasets
doc: "Download a table dataset from the Progenomes database into the working directory.\n\nTool homepage: https://github.com/BigDataBiology/progenomes-cli"
requirements:
  - class: NetworkAccess
    networkAccess: true
inputs:
  - id: dataset
    type: string
    doc: "Dataset to download: highly-important-strains, excluded-genomes, ani-representatives, ani-clustering or functional-annotations."
    inputBinding:
      position: 1
outputs:
  - id: downloaded_files
    type:
      type: array
      items: File
    doc: Downloaded dataset files
    outputBinding:
      glob: pg4_*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
stdout: progenomes_download_datasets.out
