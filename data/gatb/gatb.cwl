cwlVersion: v1.2
class: CommandLineTool
baseCommand: gatb
label: gatb
doc: "Genome Analysis Tool Box (Note: The provided text is a container runtime error
  log and does not contain help documentation or argument definitions.)\n\nTool homepage:
  https://gatb.inria.fr/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gatb:1.4.2--hee927d3_5
stdout: gatb.out
