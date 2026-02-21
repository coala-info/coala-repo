cwlVersion: v1.2
class: CommandLineTool
baseCommand: ExtractAdaptersFastqc
label: biopet-extractadaptersfastqc
doc: "Extracts adapters and contaminations from FastQC data files.\n\nTool homepage:
  https://github.com/biopet/extractadaptersfastqc"
inputs:
  - id: adapter_cutoff
    type:
      - 'null'
      - float
    doc: The fraction of the adapters in a read should be above this fraction, default
      is 0.001
    default: 0.001
    inputBinding:
      position: 101
      prefix: --adapterCutoff
  - id: input_file
    type: File
    doc: Fastqc data file (i.e., fastqc_data.txt file in the FastQC output)
    inputBinding:
      position: 101
      prefix: --inputFile
  - id: known_adapter_file
    type:
      - 'null'
      - File
    doc: This file should contain the known adapters from fastqc
    inputBinding:
      position: 101
      prefix: --knownAdapterFile
  - id: known_contam_file
    type:
      - 'null'
      - File
    doc: This file should contain the known contaminations from fastqc
    inputBinding:
      position: 101
      prefix: --knownContamFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: output_as_fasta
    type:
      - 'null'
      - boolean
    doc: Output in fasta format, default only sequences
    inputBinding:
      position: 101
      prefix: --outputAsFasta
  - id: skip_contams
    type:
      - 'null'
      - boolean
    doc: If this is set only the adapters block is used, other wise contaminations
      is also used
    inputBinding:
      position: 101
      prefix: --skipContams
outputs:
  - id: adapter_output_file
    type:
      - 'null'
      - File
    doc: Output file for adapters, if not supplied output will go to stdout
    outputBinding:
      glob: $(inputs.adapter_output_file)
  - id: contams_output_file
    type:
      - 'null'
      - File
    doc: Output file for adapters, if not supplied output will go to stdout
    outputBinding:
      glob: $(inputs.contams_output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-extractadaptersfastqc:0.2--1
