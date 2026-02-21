cwlVersion: v1.2
class: CommandLineTool
baseCommand: bgenix
label: bgen-cpp_bgenix
doc: "The provided text is an error log from a container runtime (Singularity/Apptainer)
  indicating a failure to build or extract the image due to 'no space left on device'.
  It does not contain the actual help text or usage instructions for the bgenix tool.\n
  \nTool homepage: https://enkre.net/cgi-bin/code/bgen/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bgen-cpp:1.1.7--h5ca1c30_0
stdout: bgen-cpp_bgenix.out
