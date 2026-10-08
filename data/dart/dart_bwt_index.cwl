cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwt_index
label: dart_bwt_index
doc: "Build the BWT index of a reference genome for DART.\n\nTool homepage: https://github.com/hsinnan75/Dart"
inputs:
  - id: ref_file
    type: File
    doc: Reference genome in FASTA format (ex. ref.fa)
    inputBinding:
      position: 1
  - id: prefix
    type: string
    doc: Prefix of the index files (ex. MyRef)
    inputBinding:
      position: 2
outputs:
  - id: bwt_index
    type: File
    doc: BWT index (.bwt) with the .amb, .ann, .pac and .sa files beside it
    secondaryFiles:
      - ^.amb
      - ^.ann
      - ^.pac
      - ^.sa
    outputBinding:
      glob: $(inputs.prefix).bwt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dart:1.4.6--h13024bc_7
