cwlVersion: v1.2
class: CommandLineTool
baseCommand: cannoli_interleaveFastq
label: cannoli_interleaveFastq
doc: "Interleave two FASTQ files (Note: The provided help text contains only system
  error logs and no usage information).\n\nTool homepage: https://github.com/bigdatagenomics/cannoli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cannoli:1.0.1--hdfd78af_0
stdout: cannoli_interleaveFastq.out
