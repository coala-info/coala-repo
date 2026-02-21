cwlVersion: v1.2
class: CommandLineTool
baseCommand: tablet
label: tablet
doc: "Tablet is a graphical viewer for next-generation sequence assemblies and alignments.
  (Note: The provided text contains container build logs and error messages rather
  than tool help text, so no arguments could be extracted.)\n\nTool homepage: https://ics.hutton.ac.uk/tablet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tablet:1.17.08.17--0
stdout: tablet.out
