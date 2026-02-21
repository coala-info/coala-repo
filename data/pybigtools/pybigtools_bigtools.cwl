cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybigtools
label: pybigtools_bigtools
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container build process.\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybigtools:0.2.4--py311h33b73ba_0
stdout: pybigtools_bigtools.out
