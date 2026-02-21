cwlVersion: v1.2
class: CommandLineTool
baseCommand: focus
label: focus
doc: "FOCUS (Fast Organism-level Control of Ultra-high-throughput Sequencing data)
  is a tool for taxonomic profiling of metagenomic samples.\n\nTool homepage: https://edwards.sdsu.edu/FOCUS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/focus:1.8--pyhdfd78af_0
stdout: focus.out
