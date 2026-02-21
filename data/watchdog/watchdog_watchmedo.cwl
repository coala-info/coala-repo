cwlVersion: v1.2
class: CommandLineTool
baseCommand: watchmedo
label: watchdog_watchmedo
doc: "The provided text does not contain help information or documentation for the
  tool; it appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/gorakhargosh/watchdog"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/watchdog:0.8.3--py36_0
stdout: watchdog_watchmedo.out
