cwlVersion: v1.2
class: CommandLineTool
baseCommand: forked-path
label: forked-path
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a container runtime environment.\n\nTool homepage: https://github.com/zszszszsz/.config"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/forked-path:0.2.3--py27_2
stdout: forked-path.out
