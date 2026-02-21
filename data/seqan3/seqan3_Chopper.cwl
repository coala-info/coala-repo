cwlVersion: v1.2
class: CommandLineTool
baseCommand: chopper
label: seqan3_Chopper
doc: "The provided text does not contain help information for seqan3_Chopper; it is
  an error log from a failed container build process (no space left on device).\n\n
  Tool homepage: https://www.seqan.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqan3:3.4.0--haf24da9_0
stdout: seqan3_Chopper.out
