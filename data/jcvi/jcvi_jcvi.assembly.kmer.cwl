cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jcvi
  - assembly
  - kmer
label: jcvi_jcvi.assembly.kmer
doc: "K-mer analysis and assembly utilities from the JCVI library.\n\nTool homepage:
  http://github.com/tanghaibao/jcvi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jcvi:1.5.11--py310h20b60a1_0
stdout: jcvi_jcvi.assembly.kmer.out
