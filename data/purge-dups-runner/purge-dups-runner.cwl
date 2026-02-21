cwlVersion: v1.2
class: CommandLineTool
baseCommand: purge-dups-runner
label: purge-dups-runner
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log indicating a failure to fetch or build the OCI
  image.\n\nTool homepage: https://github.com/dfguan/runner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/purge-dups-runner:2019.12.20--pyhdfd78af_0
stdout: purge-dups-runner.out
