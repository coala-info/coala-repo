cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_io_ideal_sdf
label: biobb_io_ideal_sdf
doc: "The provided text does not contain help information. It is an error log indicating
  a failure to build or extract a Singularity/Apptainer container image due to lack
  of disk space.\n\nTool homepage: https://github.com/bioexcel/biobb_io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0
stdout: biobb_io_ideal_sdf.out
