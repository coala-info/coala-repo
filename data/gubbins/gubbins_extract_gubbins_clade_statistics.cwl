cwlVersion: v1.2
class: CommandLineTool
baseCommand: extract_gubbins_clade_statistics.py
label: gubbins_extract_gubbins_clade_statistics
doc: "Extract a clade from a Gubbins output (per-clade recombination statistics)\n\nTool homepage: https://github.com/nickjcroucher/gubbins"
inputs:
  - id: clades
    type: File
    doc: "Two column file assigning isolates (first column) to clades (second column)"
    inputBinding:
      position: 101
      prefix: --clades
  - id: gff
    type: File
    doc: "recombination prediction GFF file output by Gubbins"
    inputBinding:
      position: 102
      prefix: --gff
  - id: snps
    type: File
    doc: "branch base reconstruction EMBL file output by Gubbins"
    inputBinding:
      position: 103
      prefix: --snps
  - id: exclude_regions
    type:
      - 'null'
      - File
    doc: "Two column file specifying start and end of regions to be excluded"
    inputBinding:
      position: 104
      prefix: --exclude-regions
  - id: tree
    type: File
    doc: "Labelled tree output by Gubbins"
    inputBinding:
      position: 105
      prefix: --tree
  - id: print_trees
    type:
      - 'null'
      - boolean
    doc: "Print clade trees"
    inputBinding:
      position: 106
      prefix: --print-trees
  - id: print_rec_lengths
    type:
      - 'null'
      - boolean
    doc: "Print recombination lengths"
    inputBinding:
      position: 107
      prefix: --print-rec-lengths
  - id: out
    type: string
    doc: "Output file prefix; suffix is \"_clades.csv\""
    inputBinding:
      position: 108
      prefix: --out
outputs:
  - id: clade_files
    type:
      type: array
      items: File
    doc: "Files written for the clades"
    outputBinding:
      glob: $(inputs.out)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gubbins:3.4.3--py39h746d604_0
