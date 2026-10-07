cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - count
label: capcruncher_interactions_count
doc: "Determines the number of captured restriction fragment interactions genome wide. The output is a cooler formatted HDF5 file.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: reporters
    type:
      - File
      - Directory
    doc: "Reporter slices (parquet file or directory)"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: counts.hdf5
    doc: "Name of output file"
    inputBinding:
      position: 2
      prefix: -o
  - id: remove_exclusions
    type:
      - 'null'
      - boolean
    doc: "Prevents analysis of fragments marked as proximity exclusions"
    inputBinding:
      position: 2
      prefix: --remove_exclusions
  - id: remove_capture
    type:
      - 'null'
      - boolean
    doc: "Prevents analysis of capture fragment interactions"
    inputBinding:
      position: 2
      prefix: --remove_capture
  - id: subsample
    type:
      - 'null'
      - float
    doc: "Subsamples reporters before analysis of interactions"
    inputBinding:
      position: 2
      prefix: --subsample
  - id: fragment_map
    type:
      - 'null'
      - File
    doc: "Path to digested genome bed file"
    inputBinding:
      position: 2
      prefix: -f
  - id: viewpoint_path
    type:
      - 'null'
      - File
    doc: "Path to viewpoints file"
    inputBinding:
      position: 2
      prefix: -v
  - id: n_cores
    type:
      - 'null'
      - int
    doc: "Number of cores to use for counting."
    inputBinding:
      position: 2
      prefix: -p
  - id: assay
    type:
      - 'null'
      - string
    doc: "Assay type: capture, tri or tiled"
    inputBinding:
      position: 2
      prefix: --assay
outputs:
  - id: counts
    type: File
    doc: "Interaction counts (cooler HDF5)"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
