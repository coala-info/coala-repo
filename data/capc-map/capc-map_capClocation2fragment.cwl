cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capClocation2fragment
label: capc-map_capClocation2fragment
doc: "Find the restriction fragments that contain genomic locations.\n\nTool homepage: https://capc-map.readthedocs.io/"
inputs:
  - id: restfragfile
    type: File
    doc: "filename for bed file containing the list of restriction fragments"
    inputBinding:
      position: 1
      prefix: -r
  - id: outfile
    type: string
    doc: "filename for output bed file"
    inputBinding:
      position: 1
      prefix: -o
  - id: inputfile
    type:
      - 'null'
      - File
    doc: "filename for bed file containing genomic locations (give exactly one of inputfile or location)"
    inputBinding:
      position: 1
      prefix: -i
  - id: location
    type:
      - 'null'
      - string
    doc: "is a single genomic location in format chr1:1234-5678 (give exactly one of inputfile or location)"
    inputBinding:
      position: 1
      prefix: -l
outputs:
  - id: fragments_bed
    type: File
    doc: "bed file of restriction fragments for the locations"
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capc-map:1.1.3--py36h8619c78_0
