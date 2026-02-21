cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamtofastq
label: biobambam_bamtofastq
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build or extract a container image due to insufficient
  disk space.\n\nTool homepage: https://gitlab.com/german.tischler/biobambam2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobambam:2.0.185--h02148a2_0
stdout: biobambam_bamtofastq.out
