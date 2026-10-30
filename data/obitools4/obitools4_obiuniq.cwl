cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiuniq
label: obitools4_obiuniq
doc: "Dereplicate sequences: merge identical sequences into one record that carries the count and merged attributes.\n\nTool homepage: https://obitools4.metabarcoding.org"
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
  - id: category_attribute
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --category-attribute}}
    doc: "Adds one attribute to the list of attributes used to define sequence groups (this option can be used several times)."
    inputBinding:
      position: 20
  - id: chunk_count
    type:
      - 'null'
      - int
    doc: "In how many chunk the dataset is pre-devided for speeding up the process."
    inputBinding:
      position: 20
      prefix: --chunk-count
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: "Compress all the result using gzip."
    inputBinding:
      position: 20
      prefix: --compressed
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
  - id: fail_on_taxonomy
    type:
      - 'null'
      - boolean
    doc: "Make obitools failing on error if a used taxid is not a currently valid one."
    inputBinding:
      position: 20
      prefix: --fail-on-taxonomy
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "Read data following the fasta format."
    inputBinding:
      position: 20
      prefix: --fasta
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: "Write sequence in fasta format."
    inputBinding:
      position: 20
      prefix: --fasta-output
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "Read data following the fastq format."
    inputBinding:
      position: 20
      prefix: --fastq
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: "Write sequence in fastq format."
    inputBinding:
      position: 20
      prefix: --fastq-output
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
  - id: in_memory
    type:
      - 'null'
      - boolean
    doc: "Use memory instead of disk to store data chunks."
    inputBinding:
      position: 20
      prefix: --in-memory
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
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: "Write sequence in json format."
    inputBinding:
      position: 20
      prefix: --json-output
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: "Number of parallele threads computing the result."
    inputBinding:
      position: 20
      prefix: --max-cpu
  - id: merge
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --merge}}
    doc: "Adds a merged attribute containing the list of sequence record ids merged within this group."
    inputBinding:
      position: 20
  - id: na_value
    type:
      - 'null'
      - string
    doc: "Value used when the classifier tag is not defined for a sequence."
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
  - id: no_progressbar
    type:
      - 'null'
      - boolean
    doc: "Disable the progress bar printing."
    inputBinding:
      position: 20
      prefix: --no-progressbar
  - id: no_singleton
    type:
      - 'null'
      - boolean
    doc: "If set, sequences occurring a single time in the data set are discarded."
    inputBinding:
      position: 20
      prefix: --no-singleton
  - id: out
    type:
      - 'null'
      - string
    doc: Filename used for saving the output (default is standard output).
    inputBinding:
      position: 10
      prefix: --out
  - id: output_OBI_header
    type:
      - 'null'
      - boolean
    doc: "output FASTA/FASTQ title line annotations follow OBI format."
    inputBinding:
      position: 20
      prefix: --output-OBI-header
  - id: output_json_header
    type:
      - 'null'
      - boolean
    doc: "output FASTA/FASTQ title line annotations follow json format."
    inputBinding:
      position: 20
      prefix: --output-json-header
  - id: paired_with
    type:
      - 'null'
      - File
    doc: "Filename containing the paired reads."
    inputBinding:
      position: 20
      prefix: --paired-with
  - id: skip_empty
    type:
      - 'null'
      - boolean
    doc: "Sequences of length equal to zero are suppressed from the output."
    inputBinding:
      position: 20
      prefix: --skip-empty
  - id: solexa
    type:
      - 'null'
      - boolean
    doc: "Decodes quality string according to the Solexa specification."
    inputBinding:
      position: 20
      prefix: --solexa
  - id: taxonomy
    type:
      - 'null'
      - File
      - Directory
    doc: "Path to the taxonomy database. Provide a taxdump archive (.tgz/.tar.gz) or a taxonomy directory."
    inputBinding:
      position: 20
      prefix: --taxonomy
  - id: update_taxid
    type:
      - 'null'
      - boolean
    doc: "Make obitools automatically updating the taxid that are declared merged to a newest one."
    inputBinding:
      position: 20
      prefix: --update-taxid
outputs:
  - id: stdout
    type: stdout
    doc: Result printed on standard output when no output file is given.
  - id: output_file
    type:
      - 'null'
      - File
    doc: Result file written with --out
    outputBinding:
      glob: "$(inputs.out ? inputs.out : 'no_out_given')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obiuniq.out
