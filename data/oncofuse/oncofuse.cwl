cwlVersion: v1.2
class: CommandLineTool
baseCommand: Oncofuse.jar
label: oncofuse
doc: "Oncofuse.jar is a tool for analyzing fusion genes. It takes an input file, its
  type, and optionally a tissue type, and produces an output file.\n\nTool homepage:
  https://github.com/mikessh/oncofuse"
inputs:
  - id: input_file
    type: string
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
    doc: "Supported tissue types: EPI, HEM, MES, AVG or '-'"
    inputBinding:
      position: 3
  - id: genome_assembly
    type:
      - 'null'
      - string
    doc: 'Genome assembly version. Allowed values: hg18, hg19, hg38'
    default: hg19
    inputBinding:
      position: 104
      prefix: -a
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Uses all available processors by default.
    inputBinding:
      position: 104
      prefix: -p
outputs:
  - id: output_file
    type: File
    doc: Output file for the results
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncofuse:1.1.1--0
