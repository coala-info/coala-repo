cwlVersion: v1.2
class: CommandLineTool
baseCommand: famdb
label: repeatmasker_famdb
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the RepeatMasker image.\n\nTool homepage: https://www.repeatmasker.org/RepeatMasker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmasker:4.2.2--pl5321hdfd78af_0
stdout: repeatmasker_famdb.out
