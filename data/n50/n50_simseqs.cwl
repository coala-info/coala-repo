cwlVersion: v1.2
class: CommandLineTool
baseCommand: n50_simseqs
label: n50_simseqs
doc: "Simulate sequences with the desired lengths (ARGS are COUNT*SIZE pairs).\n\nTool homepage: https://github.com/quadram-institute-bioscience/n50"
inputs:
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Write FASTA files"
    inputBinding:
      position: 1
      prefix: "--fasta"
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Write FASTQ files"
    inputBinding:
      position: 1
      prefix: "--fastq"
  - id: outdir
    type: string
    doc: "Output directory (created by the tool)"
    inputBinding:
      position: 2
      prefix: "-o"
  - id: prefix
    type:
      - 'null'
      - string
    doc: "Prefix for the output file names"
    inputBinding:
      position: 3
      prefix: "-p"
  - id: sizes
    type:
      type: array
      items: string
    doc: "Sequences to generate, each as COUNT*SIZE (for example 10*1000)"
    inputBinding:
      position: 4
outputs:
  - id: output_dir
    type: Directory
    doc: Folder with the simulated FASTA or FASTQ files
    outputBinding:
      glob: $(inputs.outdir)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/n50:1.9.3--h577a1d6_0
stdout: n50_simseqs.out
