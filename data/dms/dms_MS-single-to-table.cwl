cwlVersion: v1.2
class: CommandLineTool
baseCommand: dms_MS-single-to-table
label: dms_MS-single-to-table
doc: "The provided text does not contain help information for the tool. It contains
  error logs related to a container runtime (Apptainer/Singularity) failing to build
  an image due to insufficient disk space.\n\nTool homepage: https://github.com/qibebt-bioinfo/dynamic-meta-storms"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dms:1.1--h9948957_2
stdout: dms_MS-single-to-table.out
