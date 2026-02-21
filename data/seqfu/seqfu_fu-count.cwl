cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - count
label: seqfu_fu-count
doc: "The provided text is a system error log from a container runtime (Apptainer/Singularity)
  and does not contain help text or usage information for the tool. As a result, no
  arguments could be extracted.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_fu-count.out
