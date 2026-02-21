cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-pslliftsubrangeblat_build
label: ucsc-pslliftsubrangeblat_build
doc: "The provided text is a build error log from a container engine (Apptainer/Singularity)
  and does not contain command-line help information or argument definitions for the
  tool.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslliftsubrangeblat:482--h0b57e2e_0
stdout: ucsc-pslliftsubrangeblat_build.out
