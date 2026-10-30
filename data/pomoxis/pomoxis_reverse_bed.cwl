cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - reverse_bed
label: pomoxis_reverse_bed
doc: "Convert bed-file coordinates to coordinates on the reverse strand.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: bed_in
    type: File
    doc: Input bed file.
    inputBinding:
      position: 1
  - id: ref_fasta
    type: File
    doc: Input reference fasta file (with its .fai index next to it).
    inputBinding:
      position: 2
    secondaryFiles:
      - pattern: .fai
        required: false
  - id: bed_out
    type: string
    default: reversed.bed
    doc: Output bed file.
    inputBinding:
      position: 3
outputs:
  - id: reversed_bed
    type: File
    doc: Bed file with reverse strand coordinates.
    outputBinding:
      glob: $(inputs.bed_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
