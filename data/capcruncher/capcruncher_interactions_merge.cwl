cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - merge
label: capcruncher_interactions_merge
doc: "Merges capcruncher HDF5 files together.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: coolers
    type:
      type: array
      items: File
    doc: "CapCruncher HDF5 files to merge"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: merged.hdf5
    doc: "Output file name"
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: merged
    type: File
    doc: "Merged HDF5 file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
