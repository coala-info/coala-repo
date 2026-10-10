cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metabuli
  - extract
label: metabuli_extract
doc: "Extract reads classified to a certain taxon (used after classification).\n\nTool homepage: https://github.com/steineggerlab/Metabuli"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: query_files
    type:
      type: array
      items: File
    doc: "Query file(s)"
    inputBinding:
      position: 1
  - id: read_by_read_result
    type: File
    doc: "Read-by-read classification result of metabuli classify"
    inputBinding:
      position: 2
  - id: database_directory
    type: Directory
    doc: "Database directory"
    inputBinding:
      position: 3
  - id: taxonomy_path
    type: 
      - 'null'
      - Directory
    doc: "Directory where the taxonomy dump files are stored"
    inputBinding:
      position: 100
      prefix: --taxonomy-path
  - id: seq_mode
    type: 
      - 'null'
      - int
    doc: "Single-end: 1, Paired-end: 2, Long read: 3 [2]"
    inputBinding:
      position: 11
      prefix: --seq-mode
  - id: tax_id
    type: 
      - 'null'
      - int
    doc: "Tax. ID of clade to be extracted [0]"
    inputBinding:
      position: 12
      prefix: --tax-id
  - id: extract_format
    type: 
      - 'null'
      - int
    doc: "0: original format, 1: FASTA, 2: FASTQ [0]"
    inputBinding:
      position: 13
      prefix: --extract-format
  - id: outdir
    type: 
      - 'null'
      - string
    doc: "Output directory"
    inputBinding:
      position: 14
      prefix: --outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: extracted
    type: ['null', Directory]
    doc: "Output directory with the extracted reads"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metabuli:1.1.1--pl5321h0bb26bb_0
stdout: metabuli_extract.out
