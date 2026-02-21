cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerStreamJoin
label: kmerstream_KmerStreamJoin
doc: "The provided text does not contain help information for the tool; it contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to lack of disk space.\n\nTool homepage: https://github.com/pmelsted/KmerStream"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
stdout: kmerstream_KmerStreamJoin.out
