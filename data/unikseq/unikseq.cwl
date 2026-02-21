cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikseq
label: unikseq
doc: "The provided text appears to be a container build log (Apptainer/Singularity)
  showing a fatal error during image retrieval, rather than the command-line help
  text for 'unikseq'. As a result, no arguments or usage descriptions could be extracted.\n
  \nTool homepage: https://github.com/bcgsc/unikseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq.out
