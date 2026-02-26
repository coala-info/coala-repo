cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dicey
  - blacklist
label: dicey_blacklist
doc: "Generates a blacklist file for a given genome.\n\nTool homepage: https://github.com/gear-genomics/dicey"
inputs:
  - id: input_genome
    type: File
    doc: Input genome file in FASTA format (gzipped).
    inputBinding:
      position: 1
  - id: blacklist_file
    type: File
    doc: blacklist in BED format
    default: blacklist.bed
    inputBinding:
      position: 102
      prefix: --blacklist
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: gzipped output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dicey:0.3.4--h4d20210_0
