cwlVersion: v1.2
class: CommandLineTool
baseCommand: grzctl
label: grz-db_grzctl
doc: "The provided text appears to be a system error log from a container runtime
  (Apptainer/Singularity) rather than the help text for the tool. As a result, no
  arguments or descriptions could be extracted from the input.\n\nTool homepage: https://github.com/BfArM-MVH/grz-tools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grz-db:1.2.0--pyhdfd78af_0
stdout: grz-db_grzctl.out
