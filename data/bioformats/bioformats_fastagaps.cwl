cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - fastagaps
label: bioformats_fastagaps
doc: "Identify gaps in a FASTA file and output their coordinates in BED format.\n\n
  Tool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file to analyze for gaps
    inputBinding:
      position: 1
outputs:
  - id: bed_gaps
    type: File
    doc: Output BED file where gap coordinates will be written
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
