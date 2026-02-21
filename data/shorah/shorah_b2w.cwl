cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - shorah
  - b2w
label: shorah_b2w
doc: "The provided text does not contain help information or usage instructions for
  shorah_b2w. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the ShoRAH OCI image.\n\nTool homepage: https://github.com/cbg-ethz/shorah"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
stdout: shorah_b2w.out
