cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastqutils
label: ngsutils_fastqutils
doc: "The provided input text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a 'no space left on device' failure during image conversion.\n\nTool homepage: https://github.com/ngsutils/ngsutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngsutils:0.5.9--py27_0
stdout: ngsutils_fastqutils.out
