cwlVersion: v1.2
class: CommandLineTool
baseCommand: metamlst_samtools
label: metamlst_samtools
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log related to a container runtime (Apptainer/Singularity)
  failure due to insufficient disk space.\n\nTool homepage: https://github.com/SegataLab/metamlst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metamlst:1.2.3--hdfd78af_0
stdout: metamlst_samtools.out
