cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_dna
label: biobb_dna
doc: "The provided text does not contain help information or a description of the
  tool. It is an error log indicating a failure to build a Singularity/Apptainer image
  due to insufficient disk space.\n\nTool homepage: https://github.com/bioexcel/biobb_dna"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_dna:5.2.0--pyhdfd78af_0
stdout: biobb_dna.out
