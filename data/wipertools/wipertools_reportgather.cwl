cwlVersion: v1.2
class: CommandLineTool
baseCommand: wipertools reportgather
label: wipertools_reportgather
doc: "Gathers multiple report files into a single final report.\n\nTool homepage:
  https://github.com/mazzalab/fastqwiper"
inputs:
  - id: reports
    type:
      type: array
      items: File
    doc: List of report files
    inputBinding:
      position: 101
      prefix: --reports
outputs:
  - id: final_report
    type: File
    doc: The final report file
    outputBinding:
      glob: $(inputs.final_report)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wipertools:1.1.5--pyhdfd78af_0
