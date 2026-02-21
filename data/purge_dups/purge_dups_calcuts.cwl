cwlVersion: v1.2
class: CommandLineTool
baseCommand: calcuts
label: purge_dups_calcuts
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the image.\n\nTool homepage: https://github.com/dfguan/purge_dups"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge_dups_calcuts.out
