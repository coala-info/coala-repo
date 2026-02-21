cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite-data_addss.pl
label: hhsuite-data_addss.pl
doc: "Add secondary structure information to HH-suite data. (Note: The provided text
  contains system error messages regarding container execution and does not include
  the tool's help documentation.)\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hhsuite-data:v3.0beta2dfsg-3-deb_cv1
stdout: hhsuite-data_addss.pl.out
