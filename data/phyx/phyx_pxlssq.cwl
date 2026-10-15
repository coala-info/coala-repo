cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pxlssq]
label: phyx_pxlssq
doc: |-
  Print sequence file summary.
  By default returns all properties. Alternatively choose 1 property.
  This will take fasta, phylip, and nexus formats from a file or STDIN.

  Tool homepage: https://github.com/FePhyFoFum/phyx
inputs:
  - id: seq_file
    type: File
    doc: "input seq file"
    inputBinding:
      prefix: -s
  - id: indiv
    type: ['null', boolean]
    doc: "output stats for individual sequences"
    inputBinding:
      prefix: -i
  - id: nseq
    type: ['null', boolean]
    doc: "return the number of sequences"
    inputBinding:
      prefix: -n
  - id: nchar
    type: ['null', boolean]
    doc: "return the number of characters (only if aligned); for unaligned seqs, use with indiv"
    inputBinding:
      prefix: -c
  - id: labels
    type: ['null', boolean]
    doc: "return all taxon labels (one per line)"
    inputBinding:
      prefix: -l
  - id: prot
    type: ['null', boolean]
    doc: "force interpret as protein (if inference fails)"
    inputBinding:
      prefix: -p
  - id: aligned
    type: ['null', boolean]
    doc: "return whether sequences are aligned (same length)"
    inputBinding:
      prefix: -a
  - id: freqs
    type: ['null', boolean]
    doc: "return character state frequencies"
    inputBinding:
      prefix: -f
  - id: missing
    type: ['null', boolean]
    doc: "return the proportion of missing (-,?) characters"
    inputBinding:
      prefix: -m
  - id: out_file_path
    type: string
    doc: "output stats file name"
    inputBinding:
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: "sequence summary"
    outputBinding:
      glob: $(inputs.out_file_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyx:1.1--hc0837bd_5
