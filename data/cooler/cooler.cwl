cwlVersion: v1.2
class: CommandLineTool
baseCommand: cooler
label: cooler
doc: "The provided text does not contain help information for the 'cooler' tool; it
  contains error messages related to a container runtime (Singularity/Apptainer) failing
  to pull or build the image due to insufficient disk space.\n\nTool homepage: https://github.com/open2c/cooler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cooler:0.10.4--pyhdfd78af_0
stdout: cooler.out
