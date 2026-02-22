cwlVersion: v1.2
class: CommandLineTool
baseCommand: blastmining
label: blastmining
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a Singularity/Docker container execution failure
  ('no space left on device'). As a result, no arguments or tool descriptions could
  be extracted.\n\nTool homepage: https://github.com/NuruddinKhoiry/blastMining"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0
stdout: blastmining.out
