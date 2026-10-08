cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastspar_bootstrap
label: fastspar_bootstrap
doc: "Generate bootstrapped OTU count tables for FastSpar (c++ implementation of SparCC)\n\nTool
  homepage: https://github.com/scwatts/fastspar"
inputs:
  - id: otu_table
    type: File
    doc: OTU input table
    inputBinding:
      position: 1
      prefix: --otu_table
  - id: number
    type: int
    doc: Number of bootstrap samples to generate
    inputBinding:
      position: 2
      prefix: --number
  - id: prefix
    type: string
    doc: Prefix of the bootstrap output files (files are named <prefix>_<n>.tsv)
    inputBinding:
      position: 3
      prefix: --prefix
  - id: threads
    type: ['null', int]
    doc: Number of threads (default 1)
    inputBinding:
      position: 4
      prefix: --threads
  - id: seed
    type: ['null', int]
    doc: Random number generator seed (default 1)
    inputBinding:
      position: 5
      prefix: --seed
outputs:
  - id: bootstrap_tables
    type: 'File[]'
    doc: Bootstrapped OTU count tables
    outputBinding:
      glob: $(inputs.prefix)_*.tsv
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastspar:1.0.0--h1b620e3_6
