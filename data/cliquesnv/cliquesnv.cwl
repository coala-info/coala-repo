cwlVersion: v1.2
class: CommandLineTool
baseCommand: cliquesnv
label: cliquesnv
doc: "CliqueSNV is a tool for detecting sub-populations (cliques) of viruses or bacteria
  from NGS data.\n\nTool homepage: https://github.com/vtsyvina/CliqueSNV"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file (e.g., reads.sam)
    inputBinding:
      position: 101
      prefix: -in
  - id: method
    type:
      - 'null'
      - string
    doc: 'Run one of predefined methods: snv-pacbio, snv-illumina, snv-pacbio-vc,
      snv-illumina-vc'
    inputBinding:
      position: 101
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: How many threads to use in parallel. Usually just the number of cores 
      is the best choice
    inputBinding:
      position: 101
      prefix: -threads
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Folder with output
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cliquesnv:2.0.3--hdfd78af_0
