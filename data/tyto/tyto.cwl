cwlVersion: v1.2
class: CommandLineTool
baseCommand: tyto
label: tyto
doc: "The provided text appears to be a system error log (Apptainer/Singularity build
  failure) rather than CLI help text. As a result, no command-line arguments, flags,
  or tool descriptions could be extracted.\n\nTool homepage: https://github.com/SynBioDex/tyto"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tyto:1.4--pyhdfd78af_0
stdout: tyto.out
