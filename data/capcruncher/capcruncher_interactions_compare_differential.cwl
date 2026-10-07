cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - interactions
  - compare
  - differential
label: capcruncher_interactions_compare_differential
doc: "Perform differential testing on CapCruncher HDF5 files. Requires a design matrix and a contrast to test; the output is a tab separated bedgraph.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: interaction_files
    type:
      type: array
      items: File
    doc: "CapCruncher HDF5 files, one per sample"
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    default: differential
    doc: "Output file prefix"
    inputBinding:
      position: 2
      prefix: -o
  - id: viewpoint
    type: string
    doc: "Viewpoint to extract"
    inputBinding:
      position: 2
      prefix: -v
  - id: design_matrix
    type: File
    doc: "Design matrix file"
    inputBinding:
      position: 2
      prefix: -d
  - id: contrast
    type:
      - 'null'
      - string
    doc: "Contrast to test"
    inputBinding:
      position: 2
      prefix: -c
  - id: regions_of_interest
    type:
      - 'null'
      - File
    doc: "Regions of interest to test for differential interactions"
    inputBinding:
      position: 2
      prefix: -r
  - id: viewpoint_distance
    type:
      - 'null'
      - int
    doc: "Distance from viewpoint to test for differential interactions"
    inputBinding:
      position: 2
      prefix: --viewpoint-distance
  - id: threshold_count
    type:
      - 'null'
      - int
    doc: "Minimum number of interactions to test for differential interactions"
    inputBinding:
      position: 2
      prefix: --threshold-count
  - id: threshold_q
    type:
      - 'null'
      - float
    doc: "Minimum q-value to test for differential interactions"
    inputBinding:
      position: 2
      prefix: --threshold-q
outputs:
  - id: differential
    type:
      type: array
      items: File
    doc: "Differential interaction results"
    outputBinding:
      glob: $(inputs.output_prefix)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
