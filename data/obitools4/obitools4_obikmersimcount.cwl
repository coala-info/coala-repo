cwlVersion: v1.2
class: CommandLineTool
baseCommand: obikmersimcount
label: obitools4_obikmersimcount
doc: "Count the kmers that query sequences share with reference sequences.\n\nTool homepage: https://obitools4.metabarcoding.org"
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
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: "Kmer size to use."
    inputBinding:
      position: 20
      prefix: --kmer-size
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: "Number of parallele threads computing the result."
    inputBinding:
      position: 20
      prefix: --max-cpu
  - id: max_kmers
    type:
      - 'null'
      - int
    doc: "Maximum number of occurrence of a kmer."
    inputBinding:
      position: 20
      prefix: --max-kmers
  - id: min_shared_kmers
    type:
      - 'null'
      - int
    doc: "Minimum number of shared kmers between two sequences."
    inputBinding:
      position: 20
      prefix: --min-shared-kmers
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
  - id: reference
    type:
      - 'null'
      - {type: array, items: File, inputBinding: {prefix: --reference}}
    doc: "Reference sequence."
    inputBinding:
      position: 20
  - id: self
    type:
      - 'null'
      - boolean
    doc: "Compare references with themselves."
    inputBinding:
      position: 20
      prefix: --self
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
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: "Set sparse kmer mode."
    inputBinding:
      position: 20
      prefix: --sparse
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
stdout: obitools4_obikmersimcount.out
