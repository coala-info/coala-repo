cwlVersion: v1.2
class: CommandLineTool
baseCommand: genome_profiler
label: genome_profiler
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error regarding a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/Syrinx55/GenomeProfiler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genometools-genometools:1.6.6--py311h5faa0f1_0
stdout: genome_profiler.out
