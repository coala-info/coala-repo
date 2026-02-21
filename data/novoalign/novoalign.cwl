cwlVersion: v1.2
class: CommandLineTool
baseCommand: novoalign
label: novoalign
doc: "The provided text is an error log indicating a failure to run the tool via a
  container (Apptainer/Singularity) due to insufficient disk space. No help text or
  argument definitions were found in the input.\n\nTool homepage: http://www.novocraft.com/products/novoalign/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/novoalign:4.03.04--h5ca1c30_4
stdout: novoalign.out
