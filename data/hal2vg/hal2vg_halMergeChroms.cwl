cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - halMergeChroms
label: hal2vg_halMergeChroms
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failure due
  to insufficient disk space.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/hal2vg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hal2vg:1.1.8--hee927d3_0
stdout: hal2vg_halMergeChroms.out
