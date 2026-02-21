cwlVersion: v1.2
class: CommandLineTool
baseCommand: clairvoyante_callVarBamParallel.py
label: clairvoyante_callVarBamParallel.py
doc: "The provided text does not contain help documentation for the tool. It contains
  system logs and a fatal error message indicating a failure to build a Singularity/Apptainer
  container due to insufficient disk space ('no space left on device').\n\nTool homepage:
  https://github.com/aquaskyline/Clairvoyante"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clairvoyante:1.02--0
stdout: clairvoyante_callVarBamParallel.py.out
