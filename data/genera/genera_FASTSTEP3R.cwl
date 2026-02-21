cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - genera
  - FASTSTEP3R
label: genera_FASTSTEP3R
doc: "The provided text does not contain help information or documentation for the
  tool. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: https://github.com/josuebarrera/GenEra"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genera:1.4.2--py38hdfd78af_0
stdout: genera_FASTSTEP3R.out
