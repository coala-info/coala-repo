cwlVersion: v1.2
class: CommandLineTool
baseCommand: biom_to_stdBiom.py
label: frogs_biom_to_stdBiom
doc: "The detailed FROGS blast affiliations can trigger problem with tools like Qiime. This script extracts the problematic metadata in a second file and writes a BIOM usable in every tool using BIOM.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: input_biom
    type: File
    doc: "The abundance file (format: BIOM)."
    inputBinding:
      position: 1
      prefix: --input-biom
  - id: output_biom_path
    type: ['null', string]
    doc: "The fully compatible abundance file (format: BIOM). [Default: abundance.std.biom]"
    inputBinding:
      position: 2
      prefix: --output-biom
  - id: output_metadata_path
    type: ['null', string]
    doc: "The blast affiliations informations (format: TSV). [Default: blast_informations.std.tsv]"
    inputBinding:
      position: 3
      prefix: --output-metadata
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    inputBinding:
      position: 4
      prefix: --log-file
outputs:
  - id: output_biom
    type: ['null', File]
    doc: "The fully compatible abundance file (format: BIOM). [Default: abundance.std.biom]"
    outputBinding:
      glob: '${ return inputs.output_biom_path ? inputs.output_biom_path : ''abundance.std.biom''; }'
  - id: output_metadata
    type: ['null', File]
    doc: "The blast affiliations informations (format: TSV). [Default: blast_informations.std.tsv]"
    outputBinding:
      glob: '${ return inputs.output_metadata_path ? inputs.output_metadata_path : ''blast_informations.std.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several information on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''biom_to_stdBiom_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: biom_to_stdBiom_stdout.txt
