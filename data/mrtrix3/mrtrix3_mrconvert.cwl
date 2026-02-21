cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrconvert
label: mrtrix3_mrconvert
doc: "The provided text does not contain help information for mrconvert, but rather
  a fatal error log from a container runtime (Apptainer/Singularity) indicating a
  failure to build the image due to lack of disk space. No arguments or tool descriptions
  could be extracted from this specific input.\n\nTool homepage: https://www.mrtrix.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrtrix3_mrconvert.out
