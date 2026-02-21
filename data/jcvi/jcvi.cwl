cwlVersion: v1.2
class: CommandLineTool
baseCommand: jcvi
label: jcvi
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi.out
