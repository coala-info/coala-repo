cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar GOEnrichment.jar
label: goenrichment
doc: "GOEnrichment analyses a set of gene products for GO term enrichment\n\nTool
  homepage: https://github.com/DanFaria/GOEnrichment"
inputs:
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: Path to the tabular annotation file (GAF, BLAST2GO or 2-column table 
      format
    inputBinding:
      position: 101
      prefix: --annotation
  - id: correction_strategy
    type:
      - 'null'
      - string
    doc: Multiple test correction strategy (Bonferroni, Bonferroni-Holm, Sidak, 
      SDA, or Benjamini-Hochberg)
    inputBinding:
      position: 101
      prefix: --correction
  - id: cut_off
    type:
      - 'null'
      - float
    doc: q-value (or corrected p-value) cut-off to apply for the graph output
    inputBinding:
      position: 101
      prefix: --cut_off
  - id: exclude_singletons
    type:
      - 'null'
      - boolean
    doc: Exclude GO terms that are annotated to a single gene product in the 
      study set
    inputBinding:
      position: 101
      prefix: --exclude_singletons
  - id: go_file
    type:
      - 'null'
      - File
    doc: Path to the Gene Ontology OBO or OWL file
    inputBinding:
      position: 101
      prefix: --go
  - id: graph_format
    type:
      - 'null'
      - string
    doc: Output graph format (PNG,SVG,TXT)
    inputBinding:
      position: 101
      prefix: --graph_format
  - id: population_file
    type:
      - 'null'
      - File
    doc: Path to the file listing the population set gene products
    inputBinding:
      position: 101
      prefix: --population
  - id: study_file
    type: File
    doc: Path to the file listing the study set gene products
    inputBinding:
      position: 101
      prefix: --study
  - id: summarize_output
    type:
      - 'null'
      - boolean
    doc: Summarizes the list of enriched GO terms by removing closely related 
      terms
    inputBinding:
      position: 101
      prefix: --summarize_output
  - id: use_all_relations
    type:
      - 'null'
      - boolean
    doc: Infer annotations through 'part_of' and other non-hierarchical 
      relations
    inputBinding:
      position: 101
      prefix: --use_all_relations
outputs:
  - id: mf_result_file
    type:
      - 'null'
      - File
    doc: Path to the output MF result file
    outputBinding:
      glob: $(inputs.mf_result_file)
  - id: bp_result_file
    type:
      - 'null'
      - File
    doc: Path to the output BP result file
    outputBinding:
      glob: $(inputs.bp_result_file)
  - id: cc_result_file
    type:
      - 'null'
      - File
    doc: Path to the output CC result file
    outputBinding:
      glob: $(inputs.cc_result_file)
  - id: mf_graph_file
    type:
      - 'null'
      - File
    doc: Path to the output MF graph file
    outputBinding:
      glob: $(inputs.mf_graph_file)
  - id: bp_graph_file
    type:
      - 'null'
      - File
    doc: Path to the output BP graph file
    outputBinding:
      glob: $(inputs.bp_graph_file)
  - id: cc_graph_file
    type:
      - 'null'
      - File
    doc: Path to the output CC graph file
    outputBinding:
      glob: $(inputs.cc_graph_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/goenrichment:2.0.1--0
