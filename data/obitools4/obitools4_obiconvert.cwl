cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiconvert
label: obitools4_obiconvert
doc: "Converts sequence files between formats (fasta, fastq, genbank, embl, ecopcr,
  json), with optional header conversion and taxonomy checks.\n\nTool homepage:
  https://obitools4.metabarcoding.org"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input sequence file(s).
    inputBinding:
      position: 1
  - id: batch_size
    type:
      - 'null'
      - int
    doc: Number of sequence per batch for paralelle processing.
    inputBinding:
      position: 102
      prefix: --batch-size
  - id: compressed
    type:
      - 'null'
      - boolean
    doc: Compress all the result using gzip.
    inputBinding:
      position: 102
      prefix: --compressed
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debug mode, by setting log level to debug.
    inputBinding:
      position: 102
      prefix: --debug
  - id: ecopcr
    type:
      - 'null'
      - boolean
    doc: Read data following the ecoPCR output format.
    inputBinding:
      position: 102
      prefix: --ecopcr
  - id: embl
    type:
      - 'null'
      - boolean
    doc: Read data following the EMBL flatfile format.
    inputBinding:
      position: 102
      prefix: --embl
  - id: fail_on_taxonomy
    type:
      - 'null'
      - boolean
    doc: Make obitools failing on error if a used taxid is not a currently valid one.
    inputBinding:
      position: 102
      prefix: --fail-on-taxonomy
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: Read data following the fasta format.
    inputBinding:
      position: 102
      prefix: --fasta
  - id: fasta_output
    type:
      - 'null'
      - boolean
    doc: Write sequence in fasta format (default if no quality data available).
    inputBinding:
      position: 102
      prefix: --fasta-output
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: Read data following the fastq format.
    inputBinding:
      position: 102
      prefix: --fastq
  - id: fastq_output
    type:
      - 'null'
      - boolean
    doc: Write sequence in fastq format (default if quality data available).
    inputBinding:
      position: 102
      prefix: --fastq-output
  - id: force_one_cpu
    type:
      - 'null'
      - boolean
    doc: Force to use only one cpu core for parallel processing.
    inputBinding:
      position: 102
      prefix: --force-one-cpu
  - id: genbank
    type:
      - 'null'
      - boolean
    doc: Read data following the Genbank flatfile format.
    inputBinding:
      position: 102
      prefix: --genbank
  - id: input_obi_header
    type:
      - 'null'
      - boolean
    doc: FASTA/FASTQ title line annotations follow OBI format.
    inputBinding:
      position: 102
      prefix: --input-OBI-header
  - id: input_json_header
    type:
      - 'null'
      - boolean
    doc: FASTA/FASTQ title line annotations follow json format.
    inputBinding:
      position: 102
      prefix: --input-json-header
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: Write sequence in json format.
    inputBinding:
      position: 102
      prefix: --json-output
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: Number of parallele threads computing the result.
    inputBinding:
      position: 102
      prefix: --max-cpu
  - id: no_order
    type:
      - 'null'
      - boolean
    doc: When several input files are provided, indicates that there is no order among them.
    inputBinding:
      position: 102
      prefix: --no-order
  - id: no_progressbar
    type:
      - 'null'
      - boolean
    doc: Disable the progress bar printing.
    inputBinding:
      position: 102
      prefix: --no-progressbar
  - id: output_obi_header
    type:
      - 'null'
      - boolean
    doc: Output FASTA/FASTQ title line annotations follow OBI format.
    inputBinding:
      position: 102
      prefix: --output-OBI-header
  - id: output_json_header
    type:
      - 'null'
      - boolean
    doc: Output FASTA/FASTQ title line annotations follow json format.
    inputBinding:
      position: 102
      prefix: --output-json-header
  - id: paired_with
    type:
      - 'null'
      - File
    doc: Filename containing the paired reads.
    inputBinding:
      position: 102
      prefix: --paired-with
  - id: pprof
    type:
      - 'null'
      - boolean
    doc: Enable pprof server. Look at the log for details.
    inputBinding:
      position: 102
      prefix: --pprof
  - id: pprof_goroutine
    type:
      - 'null'
      - int
    doc: Enable profiling of goroutine blocking profile.
    inputBinding:
      position: 102
      prefix: --pprof-goroutine
  - id: pprof_mutex
    type:
      - 'null'
      - int
    doc: Enable profiling of mutex lock.
    inputBinding:
      position: 102
      prefix: --pprof-mutex
  - id: skip_empty
    type:
      - 'null'
      - boolean
    doc: Sequences of length equal to zero are suppressed from the output.
    inputBinding:
      position: 102
      prefix: --skip-empty
  - id: solexa
    type:
      - 'null'
      - boolean
    doc: Decodes quality string according to the Solexa specification.
    inputBinding:
      position: 102
      prefix: --solexa
  - id: taxonomy
    type:
      - 'null'
      - File
    doc: Path to the taxonomy database.
    inputBinding:
      position: 102
      prefix: --taxonomy
  - id: update_taxid
    type:
      - 'null'
      - boolean
    doc: Make obitools automatically updating the taxid that are declared merged to a newest one.
    inputBinding:
      position: 102
      prefix: --update-taxid
  - id: out
    type:
      - 'null'
      - string
    doc: Filename used for saving the output (default is standard output).
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Converted sequences when no output file is given
  - id: output_file
    type:
      - 'null'
      - File
    doc: Converted sequence file written with --out
    outputBinding:
      glob: "$(inputs.out ? inputs.out : 'no_out_given')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obiconvert.out
