cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite_reformat.pl
label: hhsuite_reformat.pl
doc: "The provided text does not contain help information for hhsuite_reformat.pl;
  it is an error log regarding a container execution failure (no space left on device).\n
  \nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_reformat.pl.out
