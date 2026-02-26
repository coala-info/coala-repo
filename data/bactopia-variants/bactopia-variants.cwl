cwlVersion: v1.2
class: CommandLineTool
baseCommand: bactopia-variants
label: bactopia-variants
doc: "This is snippy 4.6.0\n\nTool homepage: https://bactopia.github.io/"
inputs:
  - id: cpus
    type:
      - 'null'
      - int
    doc: Number of CPUs to use
    inputBinding:
      position: 101
      prefix: --cpus
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reference
    type: File
    doc: Please supply a reference FASTA/GBK/EMBL file with --reference
    inputBinding:
      position: 101
      prefix: --reference
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bactopia-variants:1.0.2--hdfd78af_0
stdout: bactopia-variants.out
