cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiconsensus
label: obitools4_obiconsensus
doc: "Build consensus sequences from sequence variants (denoising by consensus), optionally in clustering mode.\n\nTool homepage: https://obitools4.metabarcoding.org"
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
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: "Switch obiconsensus into its clustering mode."
    inputBinding:
      position: 20
      prefix: --cluster
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
  - id: distance
    type:
      - 'null'
      - int
    doc: "Maximum numbers of differences between two variant sequences."
    inputBinding:
      position: 20
      prefix: --distance
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
    doc: "The size of the kmer used to build the consensus. Default value = -1, which means that the kmer size is estimated from the data."
    inputBinding:
      position: 20
      prefix: --kmer-size
  - id: low_coverage
    type:
      - 'null'
      - float
    doc: "If the coverage of a sample is lower than this value, it will be discarded."
    inputBinding:
      position: 20
      prefix: --low-coverage
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: "Number of parallele threads computing the result."
    inputBinding:
      position: 20
      prefix: --max-cpu
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
  - id: sample
    type:
      - 'null'
      - string
    doc: "Attribute containing sample descriptions."
    inputBinding:
      position: 20
      prefix: --sample
  - id: save_graph
    type:
      - 'null'
      - string
    doc: "Creates a directory containing the set of DAG used by the obiclean clustering algorithm. The graph files follow the graphml format. The directory is created in the working directory."
    inputBinding:
      position: 20
      prefix: --save-graph
  - id: save_ratio
    type:
      - 'null'
      - string
    doc: "Creates a file containing the set of abundance ratio on the graph edge. The ratio file follows the csv format. The file is written to the working directory."
    inputBinding:
      position: 20
      prefix: --save-ratio
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
  - id: unique
    type:
      - 'null'
      - boolean
    doc: "If set, sequences are dereplicated on the output (obiuniq)."
    inputBinding:
      position: 20
      prefix: --unique
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
  - id: graph_dir
    type:
      - 'null'
      - Directory
    doc: Directory written with --save-graph
    outputBinding:
      glob: "$(inputs.save_graph ? inputs.save_graph : 'no_save_graph_given')"
  - id: ratio_file
    type:
      - 'null'
      - File
    doc: File written with --save-ratio
    outputBinding:
      glob: "$(inputs.save_ratio ? inputs.save_ratio : 'no_save_ratio_given')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obitools4:4.4.0--h6e5cb0d_0
stdout: obitools4_obiconsensus.out
