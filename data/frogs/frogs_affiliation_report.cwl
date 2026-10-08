cwlVersion: v1.2
class: CommandLineTool
baseCommand: affiliation_report.py
label: frogs_affiliation_report
doc: "Produces several metrics describing ASVs based on their taxonomies and the quality of the affiliations.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: taxonomic_ranks
    type: ['null', {type: array, items: string}]
    doc: "The ordered ranks levels used in the metadata taxonomy. [Default: ['Domain', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species']]"
    inputBinding:
      position: 2
      prefix: --taxonomic-ranks
  - id: rarefaction_ranks
    type: ['null', {type: array, items: string}]
    doc: "The ranks that will be evaluated in rarefaction. [Default: ['Genus']]"
    inputBinding:
      position: 3
      prefix: --rarefaction-ranks
  - id: taxonomy_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the taxonomy. Use this parameter if the taxonomic affiliation has been processed by a software that adds only one affiliation or if you don't have a metadata with the consensus taxonomy (see \"--tax-consensus- tag\").Not allowed with --tax-consensus-tag. ex: rdp_taxonomy"
    inputBinding:
      position: 4
      prefix: --taxonomy-tag
  - id: tax_consensus_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the consensus taxonomy. This parameter is used instead of \"--taxonomy-tag\" when you have several affiliations for each ASV. ex: blast_taxonomy"
    inputBinding:
      position: 5
      prefix: --tax-consensus-tag
  - id: multiple_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the list of possible taxonomies. Use this parameter if the taxonomic affiliation has been processed by a software that adds several affiliation in the BIOM file (example: same score ambiguity). ex blast_affiliations"
    inputBinding:
      position: 6
      prefix: --multiple-tag
  - id: bootstrap_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the taxonomy bootstraps. ex: rdp_bootstrap"
    inputBinding:
      position: 7
      prefix: --bootstrap-tag
  - id: identity_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the alignment identity. ex: perc_identity"
    inputBinding:
      position: 8
      prefix: --identity-tag
  - id: coverage_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the alignment observation coverage. ex: perc_query_coverage"
    inputBinding:
      position: 9
      prefix: --coverage-tag
  - id: input_biom
    type: File
    doc: "The input abundance file (format: BIOM)."
    inputBinding:
      position: 10
      prefix: --input-biom
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: affiliation_report.html]"
    inputBinding:
      position: 11
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "The list of commands executed. [Default: stdout]"
    inputBinding:
      position: 12
      prefix: --log-file
outputs:
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: affiliation_report.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''affiliation_report.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "The list of commands executed. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''affiliation_report_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: affiliation_report_stdout.txt
