cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - coatran
  - inftime
label: coatran_coatran_inftime
doc: "The provided text contains error logs from a container runtime (Apptainer/Singularity)
  and does not include the help documentation for the tool. No arguments could be
  extracted.\n\nTool homepage: https://github.com/niemasd/CoaTran"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coatran:0.0.4--h503566f_1
stdout: coatran_coatran_inftime.out
