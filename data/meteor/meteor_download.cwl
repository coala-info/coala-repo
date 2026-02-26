cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Meteor
  - download
label: meteor_download
doc: "Download a specific catalogue for Meteor analysis.\n\nTool homepage: https://github.com/metagenopolis/meteor"
inputs:
  - id: catalogue
    type: string
    doc: Select the catalogue to download (e.g., fc_1_3_gut, hs_10_4_gut, etc.).
    inputBinding:
      position: 101
      prefix: -i
  - id: check_md5
    type:
      - 'null'
      - boolean
    doc: Check the md5sum of the catalogue after download.
    inputBinding:
      position: 101
      prefix: -c
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Select the short catalogue variant (only for taxonomic profiling).
    inputBinding:
      position: 101
      prefix: --fast
outputs:
  - id: output_directory
    type: Directory
    doc: Directory where the downloaded catalogue is saved.
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
