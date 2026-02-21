cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_pmx
label: biobb_pmx
doc: "The provided text is a system error log (Apptainer/Singularity) indicating a
  failure to build the container image due to lack of disk space. It does not contain
  the help text or usage information for the biobb_pmx tool.\n\nTool homepage: https://github.com/bioexcel/biobb_pmx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_pmx:5.2.1--pyhdfd78af_0
stdout: biobb_pmx.out
