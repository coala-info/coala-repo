cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metafx
  - extract_kmers
label: metafx_extract_kmers
doc: "Counting k-mers presence for samples\n\nTool homepage: https://github.com/ctlab/metafx"
inputs:
  - id: k
    type: int
    doc: k-mer size
    inputBinding:
      position: 101
      prefix: --k
  - id: workDir
    type: Directory
    doc: Working directory
    inputBinding:
      position: 101
      prefix: --workDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metafx:1.1.0--hdfd78af_0
stdout: metafx_extract_kmers.out
