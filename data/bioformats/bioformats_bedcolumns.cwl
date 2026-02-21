cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - bedcolumns
label: bioformats_bedcolumns
doc: "A command within the bioformats toolset to process or display columns of a BED
  file.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: bed_file
    type: File
    doc: The input BED file to process.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
stdout: bioformats_bedcolumns.out
