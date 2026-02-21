cwlVersion: v1.2
class: CommandLineTool
baseCommand: arvados-cwl-runner
label: arvados-cwl-runner_build
doc: "The provided text is an error log from a failed container build process (no
  space left on device) rather than help text. No command-line arguments or usage
  instructions were found in the input.\n\nTool homepage: https://arvados.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/arvados-cwl-runner:3.1.2--pyhdfd78af_0
stdout: arvados-cwl-runner_build.out
