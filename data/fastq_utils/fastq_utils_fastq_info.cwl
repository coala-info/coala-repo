cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fastq_utils
  - fastq_info
label: fastq_utils_fastq_info
doc: "The provided text does not contain help information for the tool, but rather
  error messages from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: https://github.com/nunofonseca/fastq_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastq_utils:0.25.3--ha9dfd29_0
stdout: fastq_utils_fastq_info.out
