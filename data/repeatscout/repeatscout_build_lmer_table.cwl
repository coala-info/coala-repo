cwlVersion: v1.2
class: CommandLineTool
baseCommand: build_lmer_table
label: repeatscout_build_lmer_table
doc: "The provided text does not contain help information for the tool, as it consists
  of container execution error logs. build_lmer_table is part of the RepeatScout package
  used to build an l-mer frequency table from a sequence file.\n\nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
stdout: repeatscout_build_lmer_table.out
