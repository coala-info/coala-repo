cwlVersion: v1.2
class: CommandLineTool
baseCommand: bcl2fastq
label: bcl2fastq-nextseq_bcl_to_fastq
doc: "The provided text does not contain help documentation for the tool, but rather
  an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space. No arguments could be extracted.\n
  \nTool homepage: https://github.com/brwnj/bcl2fastq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bcl2fastq-nextseq:1.3.0--pyh5e36f6f_0
stdout: bcl2fastq-nextseq_bcl_to_fastq.out
