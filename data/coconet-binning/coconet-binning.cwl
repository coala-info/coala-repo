cwlVersion: v1.2
class: CommandLineTool
baseCommand: coconet-binning
label: coconet-binning
doc: "CoCoNet is a tool for binning metagenomic contigs using a deep learning approach.
  (Note: The provided text is an error log and does not contain help information;
  arguments could not be extracted.)\n\nTool homepage: https://github.com/Puumanamana/CoCoNet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coconet-binning:1.1.0--py_0
stdout: coconet-binning.out
