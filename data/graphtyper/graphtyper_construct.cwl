cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphtyper
label: graphtyper_construct
doc: "Construct a graph.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: graph
    type: File
    doc: Path to graph.
    inputBinding:
      position: 1
  - id: ref_fa
    type: File
    doc: Reference genome in FASTA format.
    inputBinding:
      position: 2
  - id: region
    type: string
    doc: Genomic region to construct graph for.
    inputBinding:
      position: 3
  - id: add_all_variants
    type:
      - 'null'
      - boolean
    doc: Set to create a graph with every possible haplotype on overlapping 
      variants.
    inputBinding:
      position: 104
      prefix: --add_all_variants
  - id: log
    type:
      - 'null'
      - string
    doc: Set path to log file.
    inputBinding:
      position: 104
      prefix: --log
  - id: sv_graph
    type:
      - 'null'
      - boolean
    doc: Set to construct an SV graph.
    inputBinding:
      position: 104
      prefix: --sv_graph
  - id: use_tabix
    type:
      - 'null'
      - boolean
    doc: Set to use tabix index to extract variants of the given region.
    inputBinding:
      position: 104
      prefix: --use_tabix
  - id: vcf
    type:
      - 'null'
      - File
    doc: VCF variant input.
    inputBinding:
      position: 104
      prefix: --vcf
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 104
      prefix: --verbose
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 104
      prefix: --vverbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_construct.out
