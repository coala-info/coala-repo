cwlVersion: v1.2
class: CommandLineTool
baseCommand: qtip
label: qtip
doc: "The provided text does not contain help information or usage instructions for
  the tool 'qtip'. It appears to be a log from a container build process (Apptainer/Singularity)
  that failed while fetching the image.\n\nTool homepage: https://github.com/BenLangmead/qtip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qtip:1.6.2--py36_0
stdout: qtip.out
