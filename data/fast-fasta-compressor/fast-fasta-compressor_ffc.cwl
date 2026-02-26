cwlVersion: v1.2
class: CommandLineTool
baseCommand: ffc
label: fast-fasta-compressor_ffc
doc: "Fast FASTA Compressor (ffc)\n\nTool homepage: https://github.com/kowallus/ffc"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file, use hyphen symbol (-) for stdin
    inputBinding:
      position: 1
  - id: block
    type:
      - 'null'
      - int
    doc: Block size order
    default: 22
    inputBinding:
      position: 102
      prefix: --block
  - id: decompress
    type:
      - 'null'
      - boolean
    doc: Decompress mode
    inputBinding:
      position: 102
      prefix: --decompress
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output file if exists
    inputBinding:
      position: 102
      prefix: --force
  - id: input
    type:
      - 'null'
      - File
    doc: Input file, use hyphen symbol (-) for stdin
    inputBinding:
      position: 102
      prefix: --input
  - id: level
    type:
      - 'null'
      - int
    doc: 'Backend compr. level, default: adaptive'
    inputBinding:
      position: 102
      prefix: --level
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads, default: 12c / 4d'
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file, use hyphen symbol (-) for stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fast-fasta-compressor:1.0--h9948957_0
