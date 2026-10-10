cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mikado
  - util
  - grep
label: mikado_util_grep
doc: "Extract specific models from GFF/GTF files.\n\nTool homepage: https://github.com/EI-CoreBioinformatics/mikado"
inputs:
  - id: exclude
    type:
      - 'null'
      - boolean
    doc: Exclude from the gff all the records in the id file.
    inputBinding:
      position: 101
      prefix: -v
  - id: genes
    type:
      - 'null'
      - boolean
    doc: The id file lists only genes; include/exclude all the transcripts that are children of the selected
      genes.
    inputBinding:
      position: 101
      prefix: --genes
  - id: ids
    type: File
    doc: 'ID file (format: mrna_id, gene_id - tab separated).'
    inputBinding:
      position: 201
  - id: gff
    type: File
    doc: The GFF file to parse.
    inputBinding:
      position: 202
  - id: out
    type:
      - 'null'
      - string
    doc: Output file name; printed to standard output if omitted.
    inputBinding:
      position: 203
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file.
    outputBinding:
      glob: $(inputs.out)
  - id: stdout_text
    type: stdout
    doc: Output printed to standard output when no output file is given.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mikado:2.3.4--py310h8ea774a_2
stdout: mikado_util_grep.out
