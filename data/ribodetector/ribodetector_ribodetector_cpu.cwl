cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribodetector
label: ribodetector_ribodetector_cpu
doc: "Ribodetector is a tool designed to detect and remove ribosomal RNA sequences
  from metagenomic or metatranscriptomic data. (Note: The provided text contains container
  runtime error logs rather than the tool's help documentation, so no arguments could
  be extracted.)\n\nTool homepage: https://github.com/hzi-bifo/RiboDetector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribodetector:0.3.3--pyhdfd78af_0
stdout: ribodetector_ribodetector_cpu.out
