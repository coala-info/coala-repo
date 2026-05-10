cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_tool_pvals.R
label: cell-types-analysis_get_tool_pvals.R
doc: "Calculate p-values for tool performance statistics.\n\nTool homepage: https://github.com/ebi-gene-expression-group/cell-types-analysis"
inputs:
  - id: emp_dist_list
    type: File
    doc: Path to the list of empirical distributions in .rds format
    inputBinding:
      position: 101
      prefix: --emp-dist-list
  - id: input_table
    type: File
    doc: Path to the table of tool statistics from get_tool_performance_table.R
    inputBinding:
      position: 101
      prefix: --input-table
  - id: output_table_path
    type: string
    doc: Output or path parameter `output_table_path`
    inputBinding:
      position: 102
      prefix: --output-table
outputs:
  - id: output_table
    type: File
    doc: Path to the modified output table in text format
    outputBinding:
      glob: $(inputs.output_table_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
