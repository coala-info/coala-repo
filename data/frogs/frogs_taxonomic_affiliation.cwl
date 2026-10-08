cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomic_affiliation.py
label: frogs_taxonomic_affiliation
doc: "Taxonomic affiliation of each ASV's seed by RDPtools and BLAST.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: nb_cpus
    type: ['null', int]
    doc: "The maximum number of CPUs used. [Default: 1]"
    inputBinding:
      position: 2
      prefix: --nb-cpus
  - id: java_mem
    type: ['null', int]
    doc: "Java memory allocation in Go. [Default: 2]"
    inputBinding:
      position: 3
      prefix: --java-mem
  - id: taxonomy_ranks
    type: ['null', {type: array, items: string}]
    doc: "The ordered ranks levels present in the reference databank. [Default: ['Domain', 'Phylum', 'Class', 'Order', 'Family', 'Genus', 'Species']]"
    inputBinding:
      position: 4
      prefix: --taxonomy-ranks
  - id: rdp
    type: ['null', boolean]
    doc: "Use RDP classifier to affiliate ASV [Default: False]"
    inputBinding:
      position: 5
      prefix: --rdp
  - id: taxonomy_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the taxonomy. Use this parameter if the taxonomic affiliation has been processed by a software that adds only one affiliation or if you does not have a metadata with the consensus taxonomy (see \"--tax- consensus-tag\").Not allowed with --tax-consensus-tag. [Default: None]"
    inputBinding:
      position: 6
      prefix: --taxonomy-tag
  - id: tax_consensus_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the consensus taxonomy. This parameter is used instead of \"--taxonomy-tag\" when you have several affiliations for each ASV. [Default: blast_taxonomy]"
    inputBinding:
      position: 7
      prefix: --tax-consensus-tag
  - id: multiple_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the list of possible taxonomies. Use this parameter if the taxonomic affiliation has been processed by a software that adds several affiliation in the BIOM file (example: same score ambiguity). [Default: None]"
    inputBinding:
      position: 8
      prefix: --multiple-tag
  - id: bootstrap_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the taxonomy bootstraps. [Default: None]"
    inputBinding:
      position: 9
      prefix: --bootstrap-tag
  - id: identity_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the alignment identity. [Default: None]"
    inputBinding:
      position: 10
      prefix: --identity-tag
  - id: coverage_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the alignment observation coverage. [Default: None]"
    inputBinding:
      position: 11
      prefix: --coverage-tag
  - id: reference
    type: File
    secondaryFiles: ['.nhr', '.nin', '.nsq', '.properties']
    doc: "Preformated reference file (format: blast-indexed FASTA)."
    inputBinding:
      position: 12
      prefix: --reference
  - id: input_biom
    type: File
    doc: "BIOM file (format: BIOM)."
    inputBinding:
      position: 13
      prefix: --input-biom
  - id: input_fasta
    type: File
    doc: "FASTA file of ASV's seed (format: FASTA)."
    inputBinding:
      position: 14
      prefix: --input-fasta
  - id: output_biom_path
    type: ['null', string]
    doc: "BIOM file with added affiliation annotations from blast/needleall and/or RDPtools. [Default: affiliation_abundance.biom]"
    inputBinding:
      position: 15
      prefix: --output-biom
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: taxonomic_affiliation.html]"
    inputBinding:
      position: 16
      prefix: --html
  - id: log_file_path
    type: ['null', string]
    doc: "The list of commands executed. [Default: stdout]"
    inputBinding:
      position: 17
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "BIOM file with added affiliation annotations from blast/needleall and/or RDPtools. [Default: affiliation_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''affiliation_abundance.biom''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: taxonomic_affiliation.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''taxonomic_affiliation.html''; }'
  - id: log_file
    type: ['null', File]
    doc: "The list of commands executed. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''taxonomic_affiliation_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: taxonomic_affiliation_stdout.txt
