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
    type: File
    doc: traits.csv file (taxon,country,lineage,uk_lineage,acc_lineage,...). 
      Despite the option name, the tool opens this path as a file.
    inputBinding:
      position: 101
      prefix: --input-directory
  - id: output_file_path
    type: string
    inputBinding:
      position: 102
      prefix: --output_file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Name of output CSV
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/datafunk:0.1.0--pyh5e36f6f_0
