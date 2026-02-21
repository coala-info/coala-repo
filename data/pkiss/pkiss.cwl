cwlVersion: v1.2
class: CommandLineTool
baseCommand: pkiss
label: pkiss
doc: "The provided text is a system error log (Apptainer/Singularity build failure)
  and does not contain CLI help information or usage instructions for the tool 'pkiss'.\n
  \nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/pkiss"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pkiss:2.3.0--pl5321h9948957_4
stdout: pkiss.out
