cwlVersion: v1.2
class: CommandLineTool
baseCommand: sepp
label: sepp
doc: "The provided text does not contain help information for the tool 'sepp'. It
  is an error log from a container build process (Singularity/Apptainer) indicating
  a failure due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/seppukudevelopment/seppuku"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sepp:4.5.6--py39hbcbf7aa_2
stdout: sepp.out
