cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alevin-fry
  - view
label: alevin-fry_view
doc: "View the contents of a RAD file\n\nTool homepage: https://github.com/COMBINE-lab/alevin-fry"
inputs:
  - id: rad_file
    type: File
    doc: The RAD file to view
    inputBinding:
      position: 101
      prefix: --rad
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alevin-fry:0.11.2--ha6fb395_0
stdout: alevin-fry_view.out
