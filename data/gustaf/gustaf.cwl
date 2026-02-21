cwlVersion: v1.2
class: CommandLineTool
baseCommand: gustaf
label: gustaf
doc: "The provided text does not contain help information or usage instructions for
  the tool 'gustaf'. It appears to be an error log from a container runtime (Apptainer/Singularity)
  indicating a failure to build a SIF image due to lack of disk space.\n\nTool homepage:
  https://github.com/seqan/seqan/tree/master/apps/gustaf/README.rst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gustaf:1.0.10--h8ecad89_1
stdout: gustaf.out
