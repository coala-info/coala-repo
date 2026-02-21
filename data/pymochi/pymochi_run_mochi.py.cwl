cwlVersion: v1.2
class: CommandLineTool
baseCommand: pymochi_run_mochi.py
label: pymochi_run_mochi.py
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container image retrieval (Singularity/Apptainer error).\n
  \nTool homepage: https://github.com/lehner-lab/MoCHI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pymochi:1.1--pyhdfd78af_0
stdout: pymochi_run_mochi.py.out
