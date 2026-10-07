cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - counts-to-cooler
label: capcruncher_interactions_counts-to-cooler
doc: "Stores restriction fragment interaction combinations at the restriction fragment level in a cooler formatted group in an HDF5 file.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: counts
    type: File
    doc: "Reporter restriction fragment interaction counts"
    inputBinding:
      position: 1
  - id: fragment_map
    type: File
    doc: "Path to digested genome bed file"
    inputBinding:
      position: 2
      prefix: -f
  - id: viewpoint_path
    type: File
    doc: "Path to viewpoints file"
    inputBinding:
      position: 2
      prefix: -v
  - id: viewpoint_name
    type:
      - 'null'
      - string
    doc: "Name of viewpoint to store"
    inputBinding:
      position: 2
      prefix: -n
  - id: genome
    type:
      - 'null'
      - string
    doc: "Name of genome"
    inputBinding:
      position: 2
      prefix: -g
  - id: suffix
    type:
      - 'null'
      - string
    doc: "Suffix to append after the capture name for the output file"
    inputBinding:
      position: 2
      prefix: --suffix
  - id: output
    type: string
    default: out.hdf5
    doc: "Name of output file. (Cooler formatted hdf5 file)"
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: cooler
    type: File
    doc: "Cooler formatted HDF5 file"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
