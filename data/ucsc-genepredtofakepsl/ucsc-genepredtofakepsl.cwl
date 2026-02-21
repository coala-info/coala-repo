cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredToFakePsl
label: ucsc-genepredtofakepsl
doc: "The provided text does not contain help information for the tool, but rather
  a fatal error from the Apptainer/Singularity container runtime while attempting
  to fetch the image. No arguments could be parsed from the input.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredtofakepsl:482--h0b57e2e_1
stdout: ucsc-genepredtofakepsl.out
