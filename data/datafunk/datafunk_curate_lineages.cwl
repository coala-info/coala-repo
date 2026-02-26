cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - datafunk
  - curate_lineages
label: datafunk_curate_lineages
doc: "Find new lineages, merge ones that need merging, split ones that need splitting\n\
  \nTool homepage: https://github.com/cov-ert/datafunk"
inputs:
  - id: input_directory
    type: Directory
    doc: Path to input directory containing traits.csv files
    inputBinding:
      position: 101
      prefix: --input-directory
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output CSV
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
