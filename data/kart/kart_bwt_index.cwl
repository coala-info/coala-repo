cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bwt_index
label: kart_bwt_index
doc: "Build the BWT index of a reference FASTA file for Kart\n\nTool homepage: https://github.com/hsinnan75/Kart"
inputs:
  - id: ref_file
    type: File
    doc: Reference FASTA file (ex. ref.fa)
    inputBinding:
      position: 1
  - id: prefix
    type: string
    doc: Prefix of the index files (ex. MyRef)
    inputBinding:
      position: 2
outputs:
  - id: index
    type: File
    doc: BWT index file (<prefix>.bwt) with the .amb, .ann, .pac and .sa files
    secondaryFiles:
      - ^.amb
      - ^.ann
      - ^.pac
      - ^.sa
    outputBinding:
      glob: $(inputs.prefix).bwt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kart:2.5.6--h13024bc_6
