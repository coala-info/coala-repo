cwlVersion: v1.2
class: CommandLineTool
baseCommand: recycler_recycle.py
label: recycler_recycle.py
doc: "The provided text does not contain help information or usage instructions for
  recycler_recycle.py. It appears to be a log of a failed container build process
  (Apptainer/Singularity).\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
stdout: recycler_recycle.py.out
