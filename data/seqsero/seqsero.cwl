cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqsero
label: seqsero
doc: "The provided text does not contain help information for the 'seqsero' tool;
  it is an error log describing a failure to build or extract a Singularity/Apptainer
  container image due to insufficient disk space ('no space left on device').\n\n
  Tool homepage: https://github.com/denglab/SeqSero2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seqsero:v1.0.1dfsg-1-deb_cv1
stdout: seqsero.out
