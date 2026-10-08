cwlVersion: v1.2
class: CommandLineTool
baseCommand: affiliation_filters.py
label: frogs_affiliation_filters
doc: "Filters an abundance biom file on affiliations metrics\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
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
  - id: taxonomy_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the taxonomy. Use this parameter if the taxonomic affiliation has been processed by a software that adds only one affiliation or if you does not have a metadata with the consensus taxonomy (see \"--tax- consensus-tag\").Not allowed with --tax-consensus-tag. [Default: None]"
    inputBinding:
      position: 3
      prefix: --taxonomy-tag
  - id: tax_consensus_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the consensus taxonomy. This parameter is used instead of \"--taxonomy-tag\" when you have several affiliations for each ASV. [Default: blast_taxonomy]"
    inputBinding:
      position: 4
      prefix: --tax-consensus-tag
  - id: multiple_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the list of possible taxonomies. Use this parameter if the taxonomic affiliation has been processed by a software that adds several affiliation in the BIOM file (example: same score ambiguity). [Default: None]"
    inputBinding:
      position: 5
      prefix: --multiple-tag
  - id: bootstrap_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the taxonomy bootstraps. [Default: None]"
    inputBinding:
      position: 6
      prefix: --bootstrap-tag
  - id: identity_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the alignment identity. [Default: None]"
    inputBinding:
      position: 7
      prefix: --identity-tag
  - id: coverage_tag
    type: ['null', string]
    doc: "The metadata tag used in BIOM file to store the alignment observation coverage. [Default: None]"
    inputBinding:
      position: 8
      prefix: --coverage-tag
  - id: mask
    type: ['null', boolean]
    doc: "If affiliations do not respect one of the filter they are replaced by NA (mutually exclusive with --delete) [Default: False]"
    inputBinding:
      position: 9
      prefix: --mask
  - id: delete
    type: ['null', boolean]
    doc: "If affiliations do not respect one of the filter the entire ASV is deleted.(mutually exclusive with --mask) [Default: False]"
    inputBinding:
      position: 10
      prefix: --delete
  - id: ignore_blast_taxa
    type: ['null', {type: array, items: string}]
    doc: "Taxon list to masks/delete in Blast affiliations"
    inputBinding:
      position: 11
      prefix: --ignore-blast-taxa
  - id: keep_blast_taxa
    type: ['null', {type: array, items: string}]
    doc: "Taxon list to keep in Blast affiliations. All others affiliations will be masks/delete."
    inputBinding:
      position: 12
      prefix: --keep-blast-taxa
  - id: min_rdp_bootstrap
    type: ['null', string]
    doc: "The TAXONOMIC_LEVEL must be one of the --taxonomic- ranks. The minimal RDP bootstrap must be between 0 and 1."
    inputBinding:
      position: 13
      prefix: --min-rdp-bootstrap
  - id: min_blast_identity
    type: ['null', float]
    doc: "The number corresponding to the blast percentage identity (between 0 and 100)."
    inputBinding:
      position: 14
      prefix: --min-blast-identity
  - id: min_blast_coverage
    type: ['null', float]
    doc: "The number corresponding to the query blast percentage coverage (between 0 and 100)."
    inputBinding:
      position: 15
      prefix: --min-blast-coverage
  - id: min_blast_subject_coverage
    type: ['null', float]
    doc: "The number min corresponding to the subject blast percentage coverage (between 0 and 100)."
    inputBinding:
      position: 16
      prefix: --min-blast-subject-coverage
  - id: max_blast_subject_coverage
    type: ['null', float]
    doc: "The number max corresponding to the subject blast percentage coverage (between 0 and 100)."
    inputBinding:
      position: 17
      prefix: --max-blast-subject-coverage
  - id: max_blast_evalue
    type: ['null', float]
    doc: "The number corresponding to the blast e value (between 0 and 1)."
    inputBinding:
      position: 18
      prefix: --max-blast-evalue
  - id: min_blast_length
    type: ['null', int]
    doc: "The number corresponding to the blast length."
    inputBinding:
      position: 19
      prefix: --min-blast-length
  - id: input_biom
    type: File
    doc: "The input biom file."
    inputBinding:
      position: 20
      prefix: --input-biom
  - id: input_fasta
    type: File
    doc: "The input fasta file."
    inputBinding:
      position: 21
      prefix: --input-fasta
  - id: output_biom_path
    type: ['null', string]
    doc: "The Biom file output. [Default: affiliation- filtered.biom]"
    inputBinding:
      position: 22
      prefix: --output-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "The fasta output file. [Default: affiliation- filtered.fasta]"
    inputBinding:
      position: 23
      prefix: --output-fasta
  - id: html_path
    type: ['null', string]
    doc: "The HTML file containing the graphs. [Default: summary.html]"
    inputBinding:
      position: 24
      prefix: --html
  - id: impacted_path
    type: ['null', string]
    doc: "The abundance file that summarizes all the clusters impacted (deleted or with affiliations masked). [Default: impacted_clusters.tsv]"
    inputBinding:
      position: 25
      prefix: --impacted
  - id: impacted_multihit_path
    type: ['null', string]
    doc: "The multihit TSV file associated with impacted ASV. [Default: impacted_clusters_multihit.tsv]"
    inputBinding:
      position: 26
      prefix: --impacted-multihit
  - id: log_file_path
    type: ['null', string]
    doc: "The list of commands executed. [Default: stdout]"
    inputBinding:
      position: 27
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "The Biom file output. [Default: affiliation- filtered.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''affiliation-filtered.biom''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "The fasta output file. [Default: affiliation- filtered.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''affiliation-filtered.fasta''; }'
  - id: html
    type: ['null', File]
    doc: "The HTML file containing the graphs. [Default: summary.html]"
    outputBinding:
      glob: '${ return inputs.html_path ? inputs.html_path : ''summary.html''; }'
  - id: impacted
    type: ['null', File]
    doc: "The abundance file that summarizes all the clusters impacted (deleted or with affiliations masked). [Default: impacted_clusters.tsv]"
    outputBinding:
      glob: '${ return inputs.impacted_path ? inputs.impacted_path : ''impacted_clusters.tsv''; }'
  - id: impacted_multihit
    type: ['null', File]
    doc: "The multihit TSV file associated with impacted ASV. [Default: impacted_clusters_multihit.tsv]"
    outputBinding:
      glob: '${ return inputs.impacted_multihit_path ? inputs.impacted_multihit_path : ''impacted_clusters_multihit.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "The list of commands executed. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''affiliation_filters_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: affiliation_filters_stdout.txt
