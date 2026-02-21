cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyslim
label: pyslim
doc: "The provided text does not contain help information or a description of the
  tool; it consists of error logs from a container runtime (Singularity/Apptainer)
  attempting to fetch the pyslim image.\n\nTool homepage: https://github.com/tskit-dev/pyslim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyslim:0.401--py_0
stdout: pyslim.out
