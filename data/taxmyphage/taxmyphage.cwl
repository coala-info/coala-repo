cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxmyphage
label: taxmyphage
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to pull the taxmyphage image.\n\nTool homepage: https://github.com/amillard/tax_myPHAGE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxmyphage:0.3.6--pyhdfd78af_0
stdout: taxmyphage.out
