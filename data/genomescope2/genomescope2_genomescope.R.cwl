cwlVersion: v1.2
class: CommandLineTool
baseCommand: genomescope.R
label: genomescope2_genomescope.R
doc: "GenomeScope 2.0: Reference-free profiling of polyploid genomes from k-mer frequencies.\n
  \nTool homepage: https://github.com/tbenavi1/genomescope2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/genomescope2:2.1.0--py313r44hdfd78af_0
stdout: genomescope2_genomescope.R.out
