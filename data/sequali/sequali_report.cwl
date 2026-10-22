cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sequali-report
label: sequali_report
doc: "Create an HTML report from a Sequali JSON file.\n\nTool homepage: https://github.com/rhpvorderman/sequali"
inputs:
  - id: json
    type: File
    doc: Sequali JSON file
    inputBinding:
      position: 1
  - id: html_path
    type: string
    doc: Output html file
    inputBinding:
      position: 102
      prefix: --html
outputs:
  - id: html
    type: File
    doc: HTML report.
    outputBinding:
      glob: $(inputs.html_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequali:1.0.2--py310h1fe012e_0
