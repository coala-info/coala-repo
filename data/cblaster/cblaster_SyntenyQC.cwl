cwlVersion: v1.2
class: CommandLineTool
baseCommand: cblaster synteny_qc
label: cblaster_SyntenyQC
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build or extract a container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://github.com/gamcil/cblaster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cblaster:1.4.0--pyhdfd78af_0
stdout: cblaster_SyntenyQC.out
