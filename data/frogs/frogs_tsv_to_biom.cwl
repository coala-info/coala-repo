cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv_to_biom.py
label: frogs_tsv_to_biom
doc: "Converts a TSV file in BIOM file.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: input_tsv
    type: File
    doc: "This input file contain the abundance and metadata (format: TSV)."
    inputBinding:
      position: 1
      prefix: --input-tsv
  - id: input_multi_affi
    type: ['null', File]
    doc: "This input file will contain information about multiple alignements (format: TSV). Use this option only if your affiliation has been produced by FROGS. [Default: None]"
    inputBinding:
      position: 2
      prefix: --input-multi-affi
  - id: output_biom_path
    type: ['null', string]
    doc: "The output abundance file (format: BIOM). [Default: abundance.biom]"
    inputBinding:
      position: 3
      prefix: --output-biom
  - id: output_fasta_path
    type: ['null', string]
    doc: "The output sequences file (format: FASTA). If sequences exist in your input TSV with tag seed_sequence. [Default: None]"
    inputBinding:
      position: 4
      prefix: --output-fasta
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 5
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "The output abundance file (format: BIOM). [Default: abundance.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''abundance.biom''; }'
  - id: output_fasta
    type: ['null', File]
    doc: "The output sequences file (format: FASTA). If sequences exist in your input TSV with tag seed_sequence. [Default: None]"
    outputBinding:
      glob: '${ return inputs.output_fasta_path ? inputs.output_fasta_path : ''None''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''tsv_to_biom_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: tsv_to_biom_stdout.txt
