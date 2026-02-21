cwlVersion: v1.2
class: CommandLineTool
baseCommand: pseudo_it.py
label: pseudo-it_pseudo_it.py
doc: "The provided text does not contain help documentation for pseudo_it.py; it contains
  a system error log from a container runtime (Apptainer/Singularity) failing to fetch
  a Docker image.\n\nTool homepage: https://github.com/goodest-goodlab/pseudo-it"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pseudo-it:3.1.1--pyhdfd78af_0
stdout: pseudo-it_pseudo_it.py.out
