cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mimseq
  - usearch
label: mimseq_usearch
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull the mimseq image due to lack of disk space.\n\nTool homepage: https://github.com/nedialkova-lab/mim-tRNAseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mimseq:1.3.10--pyhdfd78af_0
stdout: mimseq_usearch.out
