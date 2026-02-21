cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite_addss.pl
label: hhsuite_addss.pl
doc: "The provided text is a container execution error log and does not contain help
  information for the tool. hhsuite_addss.pl is typically used to add secondary structure
  information to HH-suite files.\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_addss.pl.out
