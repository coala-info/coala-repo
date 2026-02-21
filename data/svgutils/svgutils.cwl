cwlVersion: v1.2
class: CommandLineTool
baseCommand: svgutils
label: svgutils
doc: "The provided text does not contain help information for the tool 'svgutils'.
  It appears to be a log of a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/throrin19/svgutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svgutils:0.1.0--py36_0
stdout: svgutils.out
