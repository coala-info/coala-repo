cwlVersion: v1.2
class: CommandLineTool
baseCommand: hhsuite-data_reformat.pl
label: hhsuite-data_reformat.pl
doc: "A tool from the HH-suite package for reformating data. (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.)\n\nTool homepage: https://github.com/soedinglab/hh-suite"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hhsuite-data:v3.0beta2dfsg-3-deb_cv1
stdout: hhsuite-data_reformat.pl.out
