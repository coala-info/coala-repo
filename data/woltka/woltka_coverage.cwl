cwlVersion: v1.2
class: CommandLineTool
baseCommand: woltka_coverage
label: woltka_coverage
doc: "Calculate per-sample coverage of feature groups.\n\nTool homepage: https://github.com/qiyunzhu/woltka"
inputs:
  - id: count
    type:
      - 'null'
      - boolean
    doc: Record numbers of covered features instead of percentages (overrides 
      threshold).
    inputBinding:
      position: 101
      prefix: --count
  - id: input_file
    type: File
    doc: Path to input profile.
    inputBinding:
      position: 101
      prefix: --input
  - id: map_file
    type: File
    doc: Mapping of feature groups to member features.
    inputBinding:
      position: 101
      prefix: --map
  - id: names_path
    type:
      - 'null'
      - Directory
    doc: Names of feature groups to append to the coverage table.
    inputBinding:
      position: 101
      prefix: --names
  - id: threshold
    type:
      - 'null'
      - int
    doc: Convert coverage to presence (1) / absence (0) data by this percentage 
      threshold. [1<=x<=100]
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_file
    type: File
    doc: Path to output coverage table.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/woltka:0.1.7--pyhdfd78af_0
