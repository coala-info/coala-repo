cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncofuse
label: oncofuse
doc: "Oncofuse.jar is a tool for analyzing fusion genes. It takes an input file, its
  type, and optionally a tissue type, and produces an output file.\n\nTool homepage:
  https://github.com/mikessh/oncofuse"
inputs:
  - id: input_file
    type: File
    doc: Input file for analysis
    inputBinding:
      position: 1
  - id: input_type
    type: string
    doc: 'Type of the input file. Supported types: coord, fcatcher, fcatcher-N-M,
      tophat, tophat-N-M, tophat-post, rnastar, rnastar-N-M, starfusion, starfusion-N-M.
      For N-M types, N is the number of spanning reads and M is the number of total
      supporting read pairs.'
    inputBinding:
      position: 2
  - id: tissue_type
    type:
      - 'null'
      - string
    default: '-'
    doc: "Supported tissue types: EPI, HEM, MES, AVG or '-' (default '-')"
    inputBinding:
      position: 3
  - id: genome_assembly
    type:
      - 'null'
      - string
    doc: 'Genome assembly version. Allowed values: hg18, hg19, hg38'
    inputBinding:
      position: 0
      prefix: -a
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Uses all available processors by default.
    inputBinding:
      position: 0
      prefix: -p
  - id: output_file_path
    type: string
    doc: Output file for the results
    inputBinding:
      position: 4
outputs:
  - id: output_file
    type: File
    doc: Output file for the results
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncofuse:1.1.1--0
