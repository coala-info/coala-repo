cwlVersion: v1.2
class: CommandLineTool
baseCommand: unikseq_unikseq.pl
label: unikseq_unikseq.pl
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log from Apptainer/Singularity while attempting
  to fetch the unikseq image.\n\nTool homepage: https://github.com/bcgsc/unikseq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unikseq:2.0.1--hdfd78af_0
stdout: unikseq_unikseq.pl.out
