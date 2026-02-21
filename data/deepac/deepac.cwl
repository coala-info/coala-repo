cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepac
label: deepac
doc: "Deep Learning for Pathogenic Agent Classification. (Note: The provided text
  is a container runtime error log and does not contain help documentation or argument
  definitions.)\n\nTool homepage: https://gitlab.com/rki_bioinformatics/DeePaC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepac:0.14.1--pyhdfd78af_0
stdout: deepac.out
