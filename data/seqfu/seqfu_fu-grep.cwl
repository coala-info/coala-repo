cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqfu
  - grep
label: seqfu_fu-grep
doc: "The provided text does not contain help information for the tool, but rather
  an error log from a container build process (Apptainer/Singularity) indicating a
  'no space left on device' failure.\n\nTool homepage: http://github.com/quadram-institute-bioscience/seqfu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqfu:1.23.0--hfd12232_0
stdout: seqfu_fu-grep.out
