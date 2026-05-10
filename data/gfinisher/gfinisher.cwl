cwlVersion: v1.2
class: CommandLineTool
baseCommand: gfinisher
label: gfinisher
doc: Genome Assembler Finisher
inputs:
  - id: config_file
    type:
      - 'null'
      - File
    doc: configuration file
    inputBinding:
      position: 101
      prefix: -config
  - id: contigs_scaffolds_input_file
    type:
      - 'null'
      - File
    doc: contigs/scaffolds input file
    inputBinding:
      position: 101
      prefix: -i
  - id: create_config_template
    type:
      - 'null'
      - boolean
    doc: generate template config file
    inputBinding:
      position: 101
      prefix: -config -create
  - id: dataset_files
    type:
      - 'null'
      - type: array
        items: string
    doc: dataset files names (one or more separated by comma)
    inputBinding:
      position: 101
      prefix: -ds
  - id: genome_sequence_reference
    type:
      - 'null'
      - File
    doc: genome sequence reference in fasta format
    inputBinding:
      position: 101
      prefix: -ref
  - id: verbose_mode
    type:
      - 'null'
      - boolean
    doc: verbose mode
    inputBinding:
      position: 101
      prefix: -v
  - id: output_directory_path
    type: Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 102
      prefix: --output-directory
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gfinisher:1.4--py27_0
