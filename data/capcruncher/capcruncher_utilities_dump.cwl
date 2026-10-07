cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - utilities
  - dump
label: capcruncher_utilities_dump
doc: "Dump the interactions of a viewpoint from a CapCruncher parquet or cooler (hdf5) file to a tsv file.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: path
    type:
      - File
      - Directory
    doc: "CapCruncher parquet or cooler (hdf5) file"
    inputBinding:
      position: 1
  - id: viewpoint
    type:
      - 'null'
      - string
    doc: "Viewpoint to extract"
    inputBinding:
      position: 2
      prefix: -v
  - id: resolution
    type:
      - 'null'
      - int
    doc: "Resolution to extract. Only used for cooler (hdf5) files"
    inputBinding:
      position: 2
      prefix: -r
  - id: output
    type: string
    default: capcruncher_dump.tsv
    doc: "Output file name"
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: dump
    type: File
    doc: "Dumped interactions"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
