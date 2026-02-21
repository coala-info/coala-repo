cwlVersion: v1.2
class: CommandLineTool
baseCommand: watchdog
label: watchdog
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages indicating a failure to fetch the
  OCI image.\n\nTool homepage: https://github.com/gorakhargosh/watchdog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/watchdog:0.8.3--py36_0
stdout: watchdog.out
