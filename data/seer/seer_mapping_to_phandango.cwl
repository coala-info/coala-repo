cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapping_to_phandango
label: seer_mapping_to_phandango
doc: "Creates a plot file for visualisation in phandango\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: sam
    type: File
    doc: "Sam file of kmers mapped to reference (unsorted)"
    inputBinding:
      position: 1
      prefix: --sam
  - id: kmers
    type: File
    doc: "Kmers that were mapped"
    inputBinding:
      position: 1
      prefix: --kmers
  - id: map
    type: ['null', int]
    doc: "Minimum mapping quality"
    inputBinding:
      position: 1
      prefix: --map
  - id: print_kmer
    type: ['null', boolean]
    doc: "Also print k-mer sequence in output"
    inputBinding:
      position: 1
      prefix: --print_kmer
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_mapping_to_phandango.out
