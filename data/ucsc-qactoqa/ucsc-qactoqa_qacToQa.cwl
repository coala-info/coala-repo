cwlVersion: v1.2
class: CommandLineTool
baseCommand: qacToQa
label: ucsc-qactoqa_qacToQa
doc: "The provided text does not contain help information for the tool; it contains
  container runtime (Singularity/Apptainer) error logs regarding a failed image build.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qactoqa:482--h0b57e2e_0
stdout: ucsc-qactoqa_qacToQa.out
