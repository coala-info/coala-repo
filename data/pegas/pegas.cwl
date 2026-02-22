cwlVersion: v1.2
class: CommandLineTool
baseCommand: pegas
label: pegas
doc: "The provided text appears to be a system error log (Singularity/Docker image
  pull failure due to lack of disk space) rather than a command-line help menu. As
  a result, no functional arguments or tool descriptions could be extracted.\n\nTool
  homepage: https://github.com/liviurotiul/PeGAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pegas:1.2.3--pyhdfd78af_0
stdout: pegas.out
