cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicCorrectMatrix
label: hicexplorer_hicCorrectMatrix
doc: "The provided text does not contain help information for the tool, but rather
  a system error message indicating a failure to build a Singularity/Apptainer container
  due to lack of disk space. No command-line arguments could be extracted from the
  input.\n\nTool homepage: https://github.com/deeptools/HiCExplorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicexplorer:3.7.6--pyhdfd78af_0
stdout: hicexplorer_hicCorrectMatrix.out
