cwlVersion: v1.2
class: CommandLineTool
baseCommand: mirdeep2_quantifier.pl
label: mirdeep2_quantifier.pl
doc: "The module maps the deep sequencing reads to predefined miRNA precursors and
  determines the counts for the respective mature miRNAs, star and loop sequences.\n
  \nTool homepage: https://www.mdc-berlin.de/8551903/en/research/research_teams/systems_biology_of_gene_regulatory_elements/projects/miRDeep"
inputs:
  - id: discard_non_mapping
    type:
      - 'null'
      - boolean
    doc: do not discard reads that do not map to precursors
    inputBinding:
      position: 101
      prefix: -d
  - id: downstream_nt
    type:
      - 'null'
      - int
    doc: number of nucleotides downstream of the mature sequence to consider
    default: 5
    inputBinding:
      position: 101
      prefix: -f
  - id: mature
    type: File
    doc: mature miRNA sequences in fasta format
    inputBinding:
      position: 101
      prefix: -m
  - id: mismatches
    type:
      - 'null'
      - int
    doc: number of allowed mismatches when mapping reads to precursors
    default: 1
    inputBinding:
      position: 101
      prefix: -g
  - id: precursors
    type: File
    doc: miRNA precursor sequences in fasta format
    inputBinding:
      position: 101
      prefix: -p
  - id: reads
    type: File
    doc: deep sequencing reads in fasta format
    inputBinding:
      position: 101
      prefix: -r
  - id: sort_by_sample
    type:
      - 'null'
      - boolean
    doc: sort output by sample
    inputBinding:
      position: 101
      prefix: -y
  - id: species
    type:
      - 'null'
      - string
    doc: species being analyzed (e.g. hsa or mmu)
    inputBinding:
      position: 101
      prefix: -t
  - id: star_sequences
    type:
      - 'null'
      - File
    doc: star sequences in fasta format (optional)
    inputBinding:
      position: 101
      prefix: -s
  - id: upstream_nt
    type:
      - 'null'
      - int
    doc: number of nucleotides upstream of the mature sequence to consider
    default: 2
    inputBinding:
      position: 101
      prefix: -e
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirdeep2:2.0.1.3--hdfd78af_2
stdout: mirdeep2_quantifier.pl.out
