cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastagap_fastagap.pl
label: fastagap_fastagap.pl
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  due to insufficient disk space.\n\nTool homepage: https://github.com/nylander/fastagap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastagap:1.0.1--hdfd78af_0
stdout: fastagap_fastagap.pl.out
