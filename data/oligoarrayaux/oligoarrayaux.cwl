cwlVersion: v1.2
class: CommandLineTool
baseCommand: oligoarrayaux
label: oligoarrayaux
doc: "The provided text does not contain help information or usage instructions. It
  is an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build or pull the container image due to insufficient disk space ('no space left
  on device').\n\nTool homepage: http://unafold.rna.albany.edu/?q=DINAMelt/OligoArrayAux"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oligoarrayaux:3.8.1--pl5321h9948957_0
stdout: oligoarrayaux.out
