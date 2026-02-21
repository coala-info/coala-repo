cwlVersion: v1.2
class: CommandLineTool
baseCommand: hal2vg
label: hal2vg_clip-vg
doc: "The provided text does not contain help information for the tool, but rather
  error logs from a container runtime (Singularity/Apptainer) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/hal2vg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hal2vg:1.1.8--hee927d3_0
stdout: hal2vg_clip-vg.out
