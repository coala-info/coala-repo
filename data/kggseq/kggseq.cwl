cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar kggseq.jar
label: kggseq
doc: "KGGSeq: a tool for annotating and prioritizing genetic variants.\n\nTool homepage:
  http://grass.cgs.hku.hk/limx/kggseq/"
inputs:
  - id: input_file
    type: File
    doc: Input VCF file
    inputBinding:
      position: 1
  - id: annotation_config
    type:
      - 'null'
      - File
    doc: Configuration file for annotation databases
    inputBinding:
      position: 102
      prefix: --config
  - id: annotation_databases
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of annotation databases to use
    inputBinding:
      position: 102
      prefix: --databases
  - id: disease_config
    type:
      - 'null'
      - File
    doc: Configuration file for disease databases
    inputBinding:
      position: 102
      prefix: --disease-config
  - id: disease_databases
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of disease databases to use
    inputBinding:
      position: 102
      prefix: --diseases
  - id: filter_config
    type:
      - 'null'
      - File
    doc: Configuration file for variant filtering
    inputBinding:
      position: 102
      prefix: --filter-config
  - id: filter_variants
    type:
      - 'null'
      - string
    doc: Filter variants based on criteria
    inputBinding:
      position: 102
      prefix: --filter
  - id: gene_ontology
    type:
      - 'null'
      - File
    doc: Gene Ontology annotation file
    inputBinding:
      position: 102
      prefix: --go
  - id: pathway_config
    type:
      - 'null'
      - File
    doc: Configuration file for pathway databases
    inputBinding:
      position: 102
      prefix: --pathway-config
  - id: pathway_databases
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of pathway databases to use
    inputBinding:
      position: 102
      prefix: --pathways
  - id: population_frequencies
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of population frequency databases to use
    inputBinding:
      position: 102
      prefix: --popfreq
  - id: population_frequency_config
    type:
      - 'null'
      - File
    doc: Configuration file for population frequency databases
    inputBinding:
      position: 102
      prefix: --popfreq-config
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: variant_prioritization
    type:
      - 'null'
      - string
    doc: Variant prioritization method
    inputBinding:
      position: 102
      prefix: --prioritize
  - id: variant_prioritization_config
    type:
      - 'null'
      - File
    doc: Configuration file for variant prioritization
    inputBinding:
      position: 102
      prefix: --prioritize-config
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kggseq:1.1--0
