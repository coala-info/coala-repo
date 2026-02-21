cwlVersion: v1.2
class: CommandLineTool
baseCommand: transabyss
label: transabyss
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build or run the container due
  to insufficient disk space.\n\nTool homepage: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transabyss:2.0.1--py27_4
stdout: transabyss.out
