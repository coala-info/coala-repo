cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyrodigal-rv
label: pyrodigal-rv
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Singularity/Apptainer) failing
  to fetch an image.\n\nTool homepage: https://github.com/LanderDC/pyrodigal-rv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyrodigal-rv:0.1.0--pyh7e72e81_0
stdout: pyrodigal-rv.out
