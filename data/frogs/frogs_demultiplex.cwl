cwlVersion: v1.2
class: CommandLineTool
baseCommand: demultiplex.py
label: frogs_demultiplex
doc: "Divide the reads into samples based on their internal barcode.\n\nTool homepage: https://github.com/geraldinepascal/FROGS"
inputs:
  - id: debug
    type: ['null', boolean]
    doc: "Keep temporary files to debug program. [Default: False]"
    inputBinding:
      position: 1
      prefix: --debug
  - id: mismatches
    type: ['null', int]
    doc: "Number of mismatches allowed in barcode. [Default: 0]"
    inputBinding:
      position: 2
      prefix: --mismatches
  - id: end
    type: ['null', {type: enum, symbols: [bol, eol, both]}]
    doc: "barcode is at the begining of the forward end (bol) or of the reverse (eol) or both (both). [Default: bol]"
    inputBinding:
      position: 3
      prefix: --end
  - id: input_R1
    type: File
    doc: "The R1 sequence file with all samples (format: fastq)."
    inputBinding:
      position: 4
      prefix: --input-R1
  - id: input_R2
    type: ['null', File]
    doc: "The R2 sequence file with all samples (format: fastq)."
    inputBinding:
      position: 5
      prefix: --input-R2
  - id: input_barcode
    type: ['null', File]
    doc: "This file describes barcodes and samples (one line by sample). Line format : SAMPLE_NAME<TAB>BARCODE or SAMPLE_NAME<TAB>BARCODE_FW<TAB>BARCODE_RV."
    inputBinding:
      position: 6
      prefix: --input-barcode
  - id: output_demultiplexed_path
    type: ['null', string]
    doc: "The tar file containing R1 files and R2 files for each sample (format: tar). [Default: demultiplexed_read.tar.gz]"
    inputBinding:
      position: 7
      prefix: --output-demultiplexed
  - id: output_undemultiplexed_path
    type: ['null', string]
    doc: "The tar file containing R1 files and R2 files not demultiplexed (format: tar). [Default: undemultiplexed_read.tar.gz]"
    inputBinding:
      position: 8
      prefix: --output-undemultiplexed
  - id: summary_path
    type: ['null', string]
    doc: "TSV file with summary of filters results (format: TSV). [Default: demultiplex_summary.tsv]"
    inputBinding:
      position: 9
      prefix: --summary
  - id: log_file_path
    type: ['null', string]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    inputBinding:
      position: 10
      prefix: --log-file
outputs:
  - id: output_demultiplexed
    type: ['null', File]
    doc: "The tar file containing R1 files and R2 files for each sample (format: tar). [Default: demultiplexed_read.tar.gz]"
    outputBinding:
      glob: '${ return inputs.output_demultiplexed_path ? inputs.output_demultiplexed_path : ''demultiplexed_read.tar.gz''; }'
  - id: output_undemultiplexed
    type: ['null', File]
    doc: "The tar file containing R1 files and R2 files not demultiplexed (format: tar). [Default: undemultiplexed_read.tar.gz]"
    outputBinding:
      glob: '${ return inputs.output_undemultiplexed_path ? inputs.output_undemultiplexed_path : ''undemultiplexed_read.tar.gz''; }'
  - id: summary
    type: ['null', File]
    doc: "TSV file with summary of filters results (format: TSV). [Default: demultiplex_summary.tsv]"
    outputBinding:
      glob: '${ return inputs.summary_path ? inputs.summary_path : ''demultiplex_summary.tsv''; }'
  - id: log_file
    type: ['null', File]
    doc: "This output file will contain several informations on executed commands. [Default: stdout]"
    outputBinding:
      glob: '${ return inputs.log_file_path ? inputs.log_file_path : ''demultiplex_stdout.txt''; }'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/frogs:5.1.0--h9ee0642_0
stdout: demultiplex_stdout.txt
