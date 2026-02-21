cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybigtools
label: pybigtools
doc: "A tool for manipulating bigWig and bigBed files (Note: The provided text contains
  only container build logs and no usage information; arguments could not be extracted).\n
  \nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybigtools:0.2.4--py311h33b73ba_0
stdout: pybigtools.out
