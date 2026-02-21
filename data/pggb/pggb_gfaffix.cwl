cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfaffix
label: pggb_gfaffix
doc: "The provided text does not contain help information for the tool; it is an error
  log indicating a failure to build or extract a Singularity/Apptainer container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/pangenome/pggb"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pggb:0.7.4--h9ee0642_0
stdout: pggb_gfaffix.out
