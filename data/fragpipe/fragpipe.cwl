cwlVersion: v1.2
class: CommandLineTool
baseCommand: fragpipe
label: fragpipe
doc: "FragPipe is a suite of computational tools for comprehensive analysis of mass
  spectrometry-based proteomics data. (Note: The provided text is a system error log
  and does not contain help documentation or argument definitions).\n\nTool homepage:
  https://github.com/Nesvilab/FragPipe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fragpipe:24.0--hdfd78af_0
stdout: fragpipe.out
