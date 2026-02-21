cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - gfftagstat
label: bioformats_gfftagstat
doc: "Extract tag statistics from a GFF file.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: gff_file
    type: File
    doc: Input GFF file to analyze
    inputBinding:
      position: 1
  - id: source
    type:
      - 'null'
      - string
    doc: Filter by source
    inputBinding:
      position: 102
      prefix: -s
  - id: type
    type:
      - 'null'
      - string
    doc: Filter by type
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
stdout: bioformats_gfftagstat.out
