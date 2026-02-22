cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl-escape-houdini
label: perl-escape-houdini
doc: "The provided text does not contain help information or usage instructions; it
  consists of system error messages related to a Singularity/Docker container execution
  failure (no space left on device).\n\nTool homepage: https://github.com/yanick/Escape-Houdini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: 
      quay.io/biocontainers/perl-escape-houdini:0.3.0--pl5321h7b50bb2_4
stdout: perl-escape-houdini.out
