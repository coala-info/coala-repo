cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqan3_needle
label: seqan3_Needle
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a Singularity/Apptainer container due to insufficient
  disk space.\n\nTool homepage: https://www.seqan.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqan3:3.4.0--haf24da9_0
stdout: seqan3_Needle.out
