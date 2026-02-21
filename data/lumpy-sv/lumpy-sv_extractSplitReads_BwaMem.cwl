cwlVersion: v1.2
class: CommandLineTool
baseCommand: extractSplitReads_BwaMem
label: lumpy-sv_extractSplitReads_BwaMem
doc: "Extract split reads from BWA-MEM aligned SAM/BAM files for use with LUMPY.\n
  \nTool homepage: https://github.com/arq5x/lumpy-sv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lumpy-sv:0.3.1--3
stdout: lumpy-sv_extractSplitReads_BwaMem.out
