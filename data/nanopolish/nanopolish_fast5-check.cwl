cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - fast5-check
label: nanopolish_fast5-check
doc: "Check whether the fast5 files are indexed correctly and readable by nanopolish\n\
  \nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: reads
    type: File
    doc: file containing the basecalled reads
    inputBinding:
      position: 101
      prefix: --reads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_fast5-check.out
