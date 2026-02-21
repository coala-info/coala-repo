cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepeatMasker
label: repeatmodeler_RepeatMasker
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Singularity/Apptainer) failing
  to fetch the RepeatModeler image.\n\nTool homepage: https://www.repeatmasker.org/RepeatModeler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmodeler:2.0.7--pl5321hdfd78af_0
stdout: repeatmodeler_RepeatMasker.out
