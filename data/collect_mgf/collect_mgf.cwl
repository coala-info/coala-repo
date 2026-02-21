cwlVersion: v1.2
class: CommandLineTool
baseCommand: collect_mgf
label: collect_mgf
doc: "Collect MGF data from experiment directories and results files\n\nTool homepage:
  http://www.ms-utils.org/collect_mgf.c"
inputs:
  - id: expno_directory
    type: Directory
    doc: EXPNO directory
    inputBinding:
      position: 1
  - id: dd_results_file
    type: File
    doc: dd_results file
    inputBinding:
      position: 2
  - id: start_expno_index
    type: int
    doc: start EXPNO index (even)
    inputBinding:
      position: 3
  - id: end_expno_index
    type: int
    doc: end EXPNO index (even)
    inputBinding:
      position: 4
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/collect_mgf:1.0--h7b50bb2_7
