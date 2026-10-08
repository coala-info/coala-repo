cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gffmunger
  - move_polypeptide_annot
label: gffmunger_move_polypeptide_annot
doc: "Transfer annotations from polypeptides to the feature (e.g. mRNA) they derive
  from. Reads GFF3 (for example exported from Chado) and writes a GFF3 suitable
  for loading into WebApollo.\n\nTool homepage: https://github.com/sanger-pathogens/gffmunger"
inputs:
  - id: input_file
    type:
      - 'null'
      - File
    doc: Read GFF3 from file instead of STDIN
    inputBinding:
      position: 1
      prefix: --input-file
  - id: fasta_file
    type:
      - 'null'
      - File
    doc: Read FASTA from separate file instead of GFF3 input
    inputBinding:
      position: 1
      prefix: --fasta-file
  - id: output_file_path
    type: string
    default: output.gff3
    doc: Write GFF3 to file instead of STDOUT
    inputBinding:
      position: 1
      prefix: --output-file
  - id: config
    type:
      - 'null'
      - File
    doc: Config file
    inputBinding:
      position: 1
      prefix: --config
  - id: genometools
    type: string
    default: /usr/local/bin/gt
    doc: genometools path (override path in config; the config of the image points
      to /usr/bin/gt, which does not exist)
    inputBinding:
      position: 1
      prefix: --genometools
  - id: no_validate
    type:
      - 'null'
      - boolean
    doc: Do not validate the input GFF3
    inputBinding:
      position: 1
      prefix: --no-validate
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force writing of output file, even if it already exists
    inputBinding:
      position: 1
      prefix: --force
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress messages & warnings
    inputBinding:
      position: 1
      prefix: --quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Turn on debugging
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: output_file
    type: File
    doc: Munged GFF3 file
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.fasta_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gffmunger:0.1.3--py_0
