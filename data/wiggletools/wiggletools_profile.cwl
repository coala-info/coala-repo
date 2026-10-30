cwlVersion: v1.2
class: CommandLineTool
baseCommand: wiggletools
label: wiggletools_profile
doc: "Summed profile of a track across a set of regions: one fixed-width profile that adds up all regions (extraction profile).\n\nTool homepage: https://github.com/Ensembl/WiggleTools"
arguments:
  - position: 1
    valueFrom: profile
  - position: 2
    valueFrom: $(inputs.output_name)
inputs:
  - id: width
    type: int
    doc: Number of bins of each profile.
    inputBinding:
      position: 3
  - id: regions
    type: File
    doc: Track whose intervals define the regions (for example BED).
    inputBinding:
      position: 4
  - id: data
    type: File
    doc: Track summarised across the regions.
    inputBinding:
      position: 5
  - id: output_name
    type: string
    doc: Output text file (use '-' for standard output).
    default: profile.txt
outputs:
  - id: output_file
    type: File
    doc: Text file with the profile(s).
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wiggletools:1.2.11--h7118728_10
