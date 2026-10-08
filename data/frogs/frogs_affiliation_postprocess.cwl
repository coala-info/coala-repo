cwlVersion: v1.2
class: CommandLineTool
baseCommand: affiliation_postprocess.py
label: frogs_affiliation_postprocess
doc: "Refine affiliations, to manage ampli1con included in other sequence, and to deal with surnumerary ASV (ASV with same affiliations).\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: identity
    type: ['null', float]
    doc: "Min percentage identity to agggregate ASV. [Default: 99.0]"
    inputBinding:
      position: 2
      prefix: --identity
  - id: coverage
    type: ['null', float]
    doc: "Min percentage coverage to agggregate ASV. [Default: 99.0]"
    inputBinding:
      position: 3
      prefix: --coverage
  - id: taxon_ignored
    type: ['null', {type: array, items: string}]
    doc: "Taxon list to ignore when ASVs agggregation"
    inputBinding:
      position: 4
      prefix: --taxon-ignored
  - id: input_biom
    type: File
    doc: "Abundance table with affiliations metadata from the affiliation_ASV program (format: BIOM)."
    inputBinding:
      position: 5
      prefix: --input-biom
  - id: input_fasta
    type: File
    doc: "ASV seed sequence file (format: FASTA)."
    inputBinding:
      position: 6
      prefix: --input-fasta
  - id: reference
    type: ['null', File]
    doc: "amplicon reference file, to resolve inclusive amplicon affiliations (format: FASTA)"
    inputBinding:
      position: 7
      prefix: --reference
  - id: output_biom_path
    type: ['null', string]
    doc: "BIOM file whith refind affiliation annotations. (format: BIOM) [Default: affiliation_postprocess_abundance.biom]"
    inputBinding:
      position: 8
      prefix: --output-biom
  - id: output_compo_path
    type: ['null', string]
    doc: "Aggregated ASV composition (format: TSV) [Default: affiliation_postprocess_asv_composition.tsv]"
    inputBinding:
      position: 9
      prefix: --output-compo
  - id: output_fasta_path
    type: ['null', string]
    doc: "Updated ASV FASTA file (format: FASTA) [Default: affiliation_postprocess_ASV.fasta]"
    inputBinding:
      position: 10
      prefix: --output-fasta
  - id: log_file_path
    type: ['null', string]
    doc: "The list of commands executed. [Default: stdout]"
    inputBinding:
      position: 11
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "BIOM file whith refind affiliation annotations. (format: BIOM) [Default: affiliation_postprocess_abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''affiliation_postprocess_abundance.biom''; }'
  - id: output_compo
    type: ['null', File]
    doc: "Aggregated ASV composition (format: TSV) [Default: affiliation_postprocess_asv_composition.tsv]"
    outputBinding:
      glob: '${ return inputs.output_compo_path ? inputs.output_compo_path : ''affiliation_postprocess_asv_composition.tsv''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "Updated ASV FASTA file (format: FASTA) [Default: affiliation_postprocess_ASV.fasta]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''affiliation_postprocess_ASV.fasta''; }'
  - id: log_file
    type: ['null', File]
    doc: "The list of commands executed. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''affiliation_postprocess_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: affiliation_postprocess_stdout.txt
