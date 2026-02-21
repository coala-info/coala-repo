cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyopenms_ProteomicsLFQ
label: pyopenms_ProteomicsLFQ
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/OpenMS/OpenMS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyopenms:3.4.1--py310h7ad0250_2
stdout: pyopenms_ProteomicsLFQ.out
