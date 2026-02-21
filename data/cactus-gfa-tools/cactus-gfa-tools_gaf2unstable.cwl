cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gaf2unstable
label: cactus-gfa-tools_gaf2unstable
doc: "Replace stable sequences in path steps, ex >chr1:500-1000, with the unstable
  graph node names, ex >s1:1-100>s2:100-600\n\nTool homepage: https://github.com/ComparativeGenomicsToolkit/cactus-gfa-tools"
inputs:
  - id: gaf
    type: File
    doc: Input GAF file
    inputBinding:
      position: 1
  - id: rgfa
    type: File
    doc: (uncompressed) minigraph rGFA, required to look up unstable mappings
    inputBinding:
      position: 102
      prefix: --rGFA
outputs:
  - id: out_lengths
    type:
      - 'null'
      - File
    doc: Output lengths of all minigraph sequences in given file (can be passed to
      gaf2paf)
    outputBinding:
      glob: $(inputs.out_lengths)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cactus-gfa-tools:0.1--h9948957_0
