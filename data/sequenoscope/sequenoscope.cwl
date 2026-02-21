cwlVersion: v1.2
class: CommandLineTool
baseCommand: sequenoscope
label: sequenoscope
doc: "Sequenoscope is a tool for sequencing-based pathogen surveillance and genomic
  analysis.\n\nTool homepage: https://github.com/phac-nml/sequenoscope"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Path to a custom configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: input_directory
    type: Directory
    doc: Path to the directory containing input FASTQ files
    inputBinding:
      position: 101
      prefix: --input
  - id: reference
    type: File
    doc: Path to the reference genome file (FASTA format)
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU threads to use
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose logging output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_directory
    type: Directory
    doc: Path to the directory where results will be written
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sequenoscope:1.0.0--pyh7e72e81_1
