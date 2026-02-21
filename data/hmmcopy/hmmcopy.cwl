cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmcopy
label: hmmcopy
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) indicating
  a failure to pull or build the image due to insufficient disk space.\n\nTool homepage:
  http://compbio.bccrc.ca/software/hmmcopy/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmcopy:0.1.1--h5b0a936_12
stdout: hmmcopy.out
