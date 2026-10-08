cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - construct
label: graphtyper_construct
doc: "Construct a graph.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: graph
    type: string
    doc: "Path to graph (output)."
    inputBinding:
      position: 1
  - id: reference_fasta
    type: File
    secondaryFiles:
      - pattern: .fai
        required: false
    doc: "Reference genome in FASTA format."
    inputBinding:
      position: 2
  - id: region_to_construct
    type: string
    doc: "Genomic region to construct graph for."
    inputBinding:
      position: 3
  - id: log
    type:
      - 'null'
      - string
    doc: "Set path to log file."
    inputBinding:
      position: 10
      prefix: "--log="
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Set to output verbose logging."
    inputBinding:
      position: 10
      prefix: "--verbose"
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: "Set to output very verbose logging."
    inputBinding:
      position: 10
      prefix: "--vverbose"
  - id: sv_graph
    type:
      - 'null'
      - boolean
    doc: "Set to construct an SV graph."
    inputBinding:
      position: 10
      prefix: "--sv_graph"
  - id: add_all_variants
    type:
      - 'null'
      - boolean
    doc: "Set to create a graph with every possible haplotype on overlapping variants."
    inputBinding:
      position: 10
      prefix: "--add_all_variants"
  - id: use_tabix
    type:
      - 'null'
      - boolean
    doc: "Set to use tabix index to extract variants of the given region."
    inputBinding:
      position: 10
      prefix: "--use_tabix"
  - id: vcf
    type:
      - 'null'
      - File
    secondaryFiles:
      - pattern: .tbi
        required: false
    doc: "VCF variant input."
    inputBinding:
      position: 10
      prefix: "--vcf="
      separate: false
outputs:
  - id: graph_file
    type: File
    doc: Constructed graph
    outputBinding:
      glob: $(inputs.graph)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_construct.out
