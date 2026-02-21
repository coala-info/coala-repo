cwlVersion: v1.2
class: CommandLineTool
baseCommand: htslib
label: htslib
doc: "The provided text does not contain help information for htslib; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to pull
  the htslib image due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/samtools/htslib"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/htslib:1.23--h566b1c6_0
stdout: htslib.out
