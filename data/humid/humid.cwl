cwlVersion: v1.2
class: CommandLineTool
baseCommand: humid
label: humid
doc: "A tool for deduplicating UMI-tagged reads (Note: The provided text is a container
  execution error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/jfjlaros/HUMID"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/humid:1.0.4--heae3180_2
stdout: humid.out
