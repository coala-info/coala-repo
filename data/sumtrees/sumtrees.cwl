cwlVersion: v1.2
class: CommandLineTool
baseCommand: sumtrees
label: sumtrees
doc: "The provided text does not contain help information or documentation for the
  'sumtrees' command. It appears to be a fatal error log from a container execution
  environment (Apptainer/Singularity) failing to pull a Docker image.\n\nTool homepage:
  https://github.com/brmassa/SumTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/sumtrees:v4.4.0-1-deb_cv1
stdout: sumtrees.out
