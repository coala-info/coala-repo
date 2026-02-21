cwlVersion: v1.2
class: CommandLineTool
baseCommand: lipyphilic_flipflop
label: biobb_mem_lipyphilic_flipflop
doc: "Analyze flip-flop of lipids using the LiPyphilic library.\n\nTool homepage:
  https://github.com/bioexcel/biobb_mem"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: input_index_path
    type:
      - 'null'
      - File
    doc: Path to the input index file
    inputBinding:
      position: 101
      prefix: --input_index_path
  - id: input_top_path
    type: File
    doc: Path to the input topology file
    inputBinding:
      position: 101
      prefix: --input_top_path
  - id: input_traj_path
    type: File
    doc: Path to the input trajectory file
    inputBinding:
      position: 101
      prefix: --input_traj_path
outputs:
  - id: output_csv_path
    type: File
    doc: Path to the output CSV file
    outputBinding:
      glob: $(inputs.output_csv_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_mem:5.2.1--pyh7e72e81_0
