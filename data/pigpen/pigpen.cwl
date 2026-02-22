cwlVersion: v1.2
class: CommandLineTool
baseCommand: pigpen
label: pigpen
doc: "A tool for quantifying conversion-based RNA-seq data. (Note: The provided text
  contains system error logs regarding a container execution failure and does not
  include the standard help documentation or argument list.)\n\nTool homepage: https://github.com/TaliaferroLab/OINC-seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pigpen:0.0.9--pyhdfd78af_0
stdout: pigpen.out
