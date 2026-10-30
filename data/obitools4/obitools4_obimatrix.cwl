cwlVersion: v1.2
class: CommandLineTool
baseCommand: obimatrix
label: obitools4_obimatrix
doc: "Build a sample by sequence abundance matrix from a merged attribute (for example merged_sample).\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input sequence file(s).
    inputBinding:
      position: 100
  - id: batch_size
    type:
      - 'null'
      - int
    doc: "Number of sequence per batch for paralelle processing."
    inputBinding:
      position: 20
      prefix: --batch-size
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Enable debug mode, by setting log level to debug."
    inputBinding:
      position: 20
      prefix: --debug
  - id: ecopcr
    type:
      - 'null'
      - boolean
    doc: "Read data following the ecoPCR output format."
    inputBinding:
      position: 20
      prefix: --ecopcr
  - id: embl
    type:
      - 'null'
      - boolean
    doc: "Read data following the EMBL flatfile format."
    inputBinding:
      position: 20
      prefix: --embl
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Read data following the fasta format."
    inputBinding:
      position: 20
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Read data following the fastq format."
    inputBinding:
      position: 20
      prefix: --fastq
  - id: force_one_cpu
    type:
      - 'null'
      - boolean
    doc: "Force to use only one cpu core for parallel processing."
    inputBinding:
      position: 20
      prefix: --force-one-cpu
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: "Read data following the Genbank flatfile format."
    inputBinding:
      position: 20
      prefix: --genbank
  - id: input_OBI_header
    type:
      - 'null'
      - boolean
    doc: "FASTA/FASTQ title line annotations follow OBI format."
    inputBinding:
      position: 20
      prefix: --input-OBI-header
  - id: input_json_header
    type:
      - 'null'
      - boolean
    doc: "FASTA/FASTQ title line annotations follow json format."
    inputBinding:
      position: 20
      prefix: --input-json-header
  - id: map
    type:
      - 'null'
      - string
    doc: "Which attribute is usd to produce th matrix."
    inputBinding:
      position: 20
      prefix: --map
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: "Number of parallele threads computing the result."
    inputBinding:
      position: 20
      prefix: --max-cpu
  - id: na_value
    type:
      - 'null'
      - string
    doc: "Value used when the map attribute is not defined for a sequence."
    inputBinding:
      position: 20
      prefix: --na-value
  - id: no_order
    type:
      - 'null'
      - boolean
    doc: "When several input files are provided, indicates that there is no order among them."
    inputBinding:
      position: 20
      prefix: --no-order
  - id: sample_name
    type:
      - 'null'
      - string
    doc: "Name of the coulumn containing the sample names in the three column format."
    inputBinding:
      position: 20
      prefix: --sample-name
  - id: solexa
    type:
      - 'null'
      - boolean
    doc: "Decodes quality string according to the Solexa specification."
    inputBinding:
      position: 20
      prefix: --solexa
  - id: three_columns
    type:
      - 'null'
      - boolean
    doc: "Printouts the matrix in tree column format."
    inputBinding:
      position: 20
      prefix: --three-columns
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: "Printouts the transposed matrix."
    inputBinding:
      position: 20
      prefix: --transpose
  - id: value_name
    type:
      - 'null'
      - string
    doc: "Name of the coulumn containing the values in the three column format."
    inputBinding:
      position: 20
      prefix: --value-name
outputs:
  - id: stdout
    type: stdout
    doc: Result printed on standard output when no output file is given.
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obimatrix.out
