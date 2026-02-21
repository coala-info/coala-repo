cwlVersion: v1.2
class: CommandLineTool
baseCommand: tigmint
label: tigmint
doc: "The provided text is a container runtime error log (Singularity/Apptainer) and
  does not contain the help text or usage information for the tool 'tigmint'. As a
  result, no arguments could be extracted.\n\nTool homepage: https://bcgsc.github.io/tigmint/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4
stdout: tigmint.out
