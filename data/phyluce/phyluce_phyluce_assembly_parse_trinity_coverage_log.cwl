cwlVersion: v1.2
class: CommandLineTool
baseCommand: phyluce_assembly_parse_trinity_coverage_log
label: phyluce_phyluce_assembly_parse_trinity_coverage_log
doc: "Parse the log file from get_trinity_coverage.py to output a nice table of results\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: log
    type: File
    doc: "The log file to parse"
    inputBinding:
      position: 1
      prefix: --log
  - id: output
    type:
      - 'null'
      - string
    doc: "The output CSV file to create"
    inputBinding:
      position: 1
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output, including the log messages."
  - id: output_csv
    type:
      - 'null'
      - File
    doc: "The output CSV file"
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
stdout: phyluce_phyluce_assembly_parse_trinity_coverage_log.out
