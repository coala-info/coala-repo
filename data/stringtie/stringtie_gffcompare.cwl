cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffcompare
label: stringtie_gffcompare
doc: "The provided text is an error log from a container build process and does not
  contain help documentation or argument definitions for the tool.\n\nTool homepage:
  https://ccb.jhu.edu/software/stringtie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringtie:3.0.3--h29c0135_0
stdout: stringtie_gffcompare.out
