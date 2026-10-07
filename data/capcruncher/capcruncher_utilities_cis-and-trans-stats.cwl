cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - capcruncher
  - utilities
  - cis-and-trans-stats
label: capcruncher_utilities_cis-and-trans-stats
doc: "Count cis and trans reporters per viewpoint from CapCruncher slices.\n\nTool homepage: https://github.com/sims-lab/CapCruncher.git"
inputs:
  - id: slices
    type:
      - File
      - Directory
    doc: "Reporter slices (parquet file or directory)"
    inputBinding:
      position: 1
  - id: output
    type: string
    default: cis_and_trans_stats.csv
    doc: "Output file name"
    inputBinding:
      position: 2
      prefix: -o
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Name of sample e.g. DOX_treated_1"
    inputBinding:
      position: 2
      prefix: --sample-name
  - id: assay
    type:
      - 'null'
      - string
    doc: "Assay used to generate slices (capture, tri or tiled)"
    inputBinding:
      position: 2
      prefix: --assay
outputs:
  - id: stats
    type: File
    doc: "Cis and trans statistics"
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/capcruncher:0.3.14--pyhdfd78af_1
