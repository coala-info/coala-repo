cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bioformats
  - interval2bed
label: bioformats_interval2bed
doc: "Convert interval files to BED format.\n\nTool homepage: https://github.com/gtamazian/bioformats"
inputs:
  - id: interval_file
    type: File
    doc: Input interval file
    inputBinding:
      position: 1
  - id: bed_file
    type: string
    doc: the output BED file
    inputBinding:
      position: 2
outputs:
  - id: out_bed_file
    type: File
    doc: Output BED file
    outputBinding:
      glob: $(inputs.bed_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bioformats:0.1.15--py27_0
