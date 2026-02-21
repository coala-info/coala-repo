cwlVersion: v1.2
class: CommandLineTool
baseCommand: open-cravat
label: open-cravat
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build a Singularity/Apptainer image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: http://www.opencravat.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/open-cravat:2.16.0--pyhdfd78af_0
stdout: open-cravat.out
