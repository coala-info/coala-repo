cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtars
label: rust-gtars
doc: "The provided text does not contain help information or usage instructions for
  rust-gtars. It appears to be an error log from a failed container build/fetch process
  (Singularity/Apptainer).\n\nTool homepage: https://github.com/databio/gtars"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rust-gtars:0.6.0--h885253a_0
stdout: rust-gtars.out
