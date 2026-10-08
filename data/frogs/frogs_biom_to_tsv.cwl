cwlVersion: v1.2
class: CommandLineTool
baseCommand: biom_to_tsv.py
label: frogs_biom_to_tsv
doc: "Converts a BIOM file in TSV file.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: header
    type: ['null', boolean]
    doc: "Print header only"
    inputBinding:
      position: 1
      prefix: --header
  - id: input_biom
    type: File
    doc: "The abundance file (format: BIOM)."
    inputBinding:
      position: 2
      prefix: --input-biom
  - id: input_fasta
    type: ['null', File]
    doc: "The sequences file (format: FASTA). If you use this option the sequences will be add in TSV."
    inputBinding:
      position: 3
      prefix: --input-fasta
  - id: output_tsv_path
    type: ['null', string]
    doc: "This output file will contain the abundance and metadata (format: TSV). [Default: abundance.tsv]"
    inputBinding:
      position: 4
      prefix: --output-tsv
  - id: output_multi_affi_path
    type: ['null', string]
    doc: "This output file will contain information about multiple alignements (format: TSV). Use this option only if your affiliation has been produced by FROGS. [Default: multihits.tsv]"
    inputBinding:
      position: 5
      prefix: --output-multi-affi
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 6
      prefix: --log-file
outputs:
  - id: output_tsv
    type: ['null', File]
    doc: "This output file will contain the abundance and metadata (format: TSV). [Default: abundance.tsv]"
    outputBinding:
      glob: '${ return inputs.output_tsv_path ? inputs.output_tsv_path : ''abundance.tsv''; }'
  - id: output_multi_affi
    type: ['null', File]
    doc: "This output file will contain information about multiple alignements (format: TSV). Use this option only if your affiliation has been produced by FROGS. [Default: multihits.tsv]"
    outputBinding:
      glob: '${ return inputs.output_multi_affi_path ? inputs.output_multi_affi_path : ''multihits.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''biom_to_tsv_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: biom_to_tsv_stdout.txt
