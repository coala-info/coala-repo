cwlVersion: v1.2
class: CommandLineTool
baseCommand: hint
label: hint
doc: "The provided text does not contain help information or usage instructions. It
  appears to be an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to lack of disk space.\n\nTool
  homepage: https://github.com/suwangbio/HiNT_py3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hint:2.2.8--py_1
stdout: hint.out
