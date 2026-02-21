cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssuissero
label: ssuissero
doc: "Rapid serotyping of Streptococcus suis from assemblies\n\nTool homepage: https://github.com/jimmyliu1326/SsuisSero"
inputs:
  - id: input
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 101
      prefix: --input
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outdir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssuissero:1.0.1--hdfd78af_1
