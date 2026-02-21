cwlVersion: v1.2
class: CommandLineTool
baseCommand: novoloci
label: novoloci
doc: "The provided text does not contain help information or usage instructions for
  the tool 'novoloci'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build the image due to lack of disk space.\n\nTool homepage:
  https://github.com/ndierckx/NOVOLoci"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoloci:0.5--hdfd78af_0
stdout: novoloci.out
