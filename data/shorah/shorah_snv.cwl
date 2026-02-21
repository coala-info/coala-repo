cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - shorah
  - snv
label: shorah_snv
doc: "The provided text does not contain help information as it is an error log from
  a container runtime (Apptainer/Singularity) indicating a failure to fetch or build
  the OCI image.\n\nTool homepage: https://github.com/cbg-ethz/shorah"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shorah:1.99.2--py38h73782ee_8
stdout: shorah_snv.out
