cwlVersion: v1.2
class: CommandLineTool
baseCommand: plannotate
label: plannotate
doc: "The provided text does not contain help information for the tool 'plannotate'.
  It appears to be a fatal error log from a Singularity/Apptainer container build
  process indicating a 'no space left on device' error.\n\nTool homepage: https://github.com/barricklab/pLannotate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plannotate:1.2.4--pyhdfd78af_0
stdout: plannotate.out
