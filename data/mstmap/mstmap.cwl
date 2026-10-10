cwlVersion: v1.2
class: CommandLineTool
baseCommand: mstmap
label: mstmap
doc: "MSTmap builds genetic linkage maps from a genotype table (minimum spanning tree algorithm).\n\nTool homepage: http://mstmap.org/"
inputs:
  - id: input_file
    type: File
    doc: Input file with the mapping parameters and the marker genotype table
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: Name of the output file with the linkage groups
    default: output.txt
    inputBinding:
      position: 2
outputs:
  - id: output_map
    type: File
    doc: Linkage groups with ordered markers and genetic distances
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mstmap:1--h4ac6f70_3
