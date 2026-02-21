cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite_renumberpdb.pl
label: hhsuite_renumberpdb.pl
doc: "A tool from the HH-suite for renumbering PDB files. Note: The provided help
  text contains only system error messages and no usage information.\n\nTool homepage:
  https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hhsuite:3.3.0--h503566f_15
stdout: hhsuite_renumberpdb.pl.out
