cwlVersion: v1.2
class: CommandLineTool
baseCommand: tandem_tracking_euroc.sh
label: tandem_tracking_euroc.sh
doc: "The provided text is an error log from a container build process and does not
  contain help information or argument definitions for the tool.\n\nTool homepage:
  https://github.com/tum-vision/tandem"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tandem:v17-02-01-4_cv4
stdout: tandem_tracking_euroc.sh.out
