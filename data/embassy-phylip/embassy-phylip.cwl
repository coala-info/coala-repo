cwlVersion: v1.2
class: CommandLineTool
baseCommand: embassy-phylip
label: embassy-phylip
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to build a Singularity/Apptainer image
  due to insufficient disk space.\n\nTool homepage: http://emboss.open-bio.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/embassy-phylip:3.69.650--ha92aebf_2
stdout: embassy-phylip.out
