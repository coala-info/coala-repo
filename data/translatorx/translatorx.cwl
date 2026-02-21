cwlVersion: v1.2
class: CommandLineTool
baseCommand: translatorx
label: translatorx
doc: "The provided text does not contain help information or usage instructions for
  translatorx; it is an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to insufficient disk space.\n\nTool
  homepage: http://pc16141.mncn.csic.es/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/translatorx:1.1--pl5.22.0_0
stdout: translatorx.out
