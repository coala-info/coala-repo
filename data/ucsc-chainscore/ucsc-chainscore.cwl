cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-chainscore
label: ucsc-chainscore
doc: "The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) failing
  to fetch or build the image for ucsc-chainscore.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainscore:455--h1536b3f_1
stdout: ucsc-chainscore.out
