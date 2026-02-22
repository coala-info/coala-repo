cwlVersion: v1.2
class: CommandLineTool
baseCommand: palikiss
label: palikiss
doc: "The provided text does not contain help information or usage instructions for
  the tool 'palikiss'. It contains system error messages related to a container runtime
  (Singularity/Apptainer) failing to pull an image due to lack of disk space.\n\n\
  Tool homepage: https://bibiserv.cebitec.uni-bielefeld.de/palikiss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/palikiss:1.1.0--pl5321h9948957_2
stdout: palikiss.out
