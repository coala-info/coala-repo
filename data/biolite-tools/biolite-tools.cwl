cwlVersion: v1.2
class: CommandLineTool
baseCommand: biolite-tools
label: biolite-tools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Singularity/Apptainer)
  failing due to insufficient disk space.\n\nTool homepage: https://bitbucket.org/caseywdunn/biolite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biolite-tools:0.4.0--h077b44d_9
stdout: biolite-tools.out
