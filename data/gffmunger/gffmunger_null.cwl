cwlVersion: v1.2
class: CommandLineTool
baseCommand: gffmunger
label: gffmunger_null
doc: "Munges GFF files. Use one or more of the following commands:\n\nTool homepage:
  https://github.com/sanger-pathogens/gffmunger"
inputs:
  - id: commands
    type:
      - 'null'
      - type: array
        items: string
    doc: Command(s) defining how the GFF should be munged
    inputBinding:
      position: 1
  - id: config
    type:
      - 'null'
      - string
    doc: Config file
    inputBinding:
      position: 102
      prefix: --config
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Read FASTA from separate file instead of GFF3 input
    inputBinding:
      position: 102
      prefix: --fasta-file
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing of output file, even if it already exists
    inputBinding:
      position: 102
      prefix: --force
  - id: genometools
    type:
      - 'null'
      - string
    doc: genometools path (override path in config)
    inputBinding:
      position: 102
      prefix: --genometools
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read GFF3 from file instead of STDIN
    inputBinding:
      position: 102
      prefix: --input-file
  - id: no_validate
    type:
      - 'null'
      - boolean
    doc: Do not validate the input GFF3
    inputBinding:
      position: 102
      prefix: --no-validate
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress messages & warnings
    inputBinding:
      position: 102
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write GFF3 to file instead of STDOUT
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffmunger:0.1.3--py_0
