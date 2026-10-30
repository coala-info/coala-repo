cwlVersion: v1.2
class: CommandLineTool
baseCommand: obiscript
label: obitools4_obiscript
doc: "Process sequence records with a Lua script, optionally after selecting records with obigrep-like conditions.\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Input sequence file(s).
    inputBinding:
      position: 100
  - id: allows_indels
    type:
      - 'null'
      - boolean
    doc: "Allows for indel during pattern matching."
    inputBinding:
      position: 20
      prefix: --allows-indels
  - id: approx_pattern
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --approx-pattern}}
    doc: "Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive."
    inputBinding:
      position: 20
  - id: attribute
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --attribute}}
    doc: "Regular expression pattern matched against the attributes of the sequence record. the value of this attribute is of the form : key:regular_pattern. The pattern is case sensitive. Several -a options can be used on the same command line and in this last case, the selected sequence records will match all constraints."
    inputBinding:
      position: 20
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
  - id: definition
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --definition}}
    doc: "Regular expression pattern to be tested against the sequence definition. The pattern is case insensitive."
    inputBinding:
      position: 20
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
  - id: has_attribute
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --has-attribute}}
    doc: "Selects sequence records having an attribute whose key = <KEY>."
    inputBinding:
      position: 20
  - id: id_list
    type:
      - 'null'
      - File
    doc: "<FILENAME> points to a text file containing the list of sequence record identifiers to be selected. The file format consists in a single identifier per line."
    inputBinding:
      position: 20
      prefix: --id-list
  - id: identifier
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --identifier}}
    doc: "Regular expression pattern to be tested against the sequence identifier. The pattern is case insensitive."
    inputBinding:
      position: 20
  - id: ignore_taxon
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --ignore-taxon}}
    doc: "Require that the actual taxon of the sequence doesn't belong the provided taxid."
    inputBinding:
      position: 20
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
  - id: inverse_match
    type:
      - 'null'
      - boolean
    doc: "Inverts the sequence record selection."
    inputBinding:
      position: 20
      prefix: --inverse-match
  - id: json_output
    type:
      - 'null'
      - boolean
    doc: "Write sequence in json format."
    inputBinding:
      position: 20
      prefix: --json-output
  - id: max_count
    type:
      - 'null'
      - int
    doc: "Selects sequence records occuring no more than max count time in the data set."
    inputBinding:
      position: 20
      prefix: --max-count
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: "Number of parallele threads computing the result."
    inputBinding:
      position: 20
      prefix: --max-cpu
  - id: max_length
    type:
      - 'null'
      - int
    doc: "Selects sequence records whose sequence length is equal or shorter than lmax."
    inputBinding:
      position: 20
      prefix: --max-length
  - id: min_count
    type:
      - 'null'
      - int
    doc: "Selects sequence records occuring at least min count time in the data set."
    inputBinding:
      position: 20
      prefix: --min-count
  - id: min_length
    type:
      - 'null'
      - int
    doc: "Selects sequence records whose sequence length is equal or longer than lmin."
    inputBinding:
      position: 20
      prefix: --min-length
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
  - id: only_forward
    type:
      - 'null'
      - boolean
    doc: "Look for pattern only on forward strand."
    inputBinding:
      position: 20
      prefix: --only-forward
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
  - id: paired_mode
    type:
      - 'null'
      - {type: enum, symbols: [forward, reverse, and, or, andnot, xor]}
    doc: "If paired reads are passed to obibrep, that option determines how the conditions are applied to both reads."
    inputBinding:
      position: 20
      prefix: --paired-mode
  - id: paired_with
    type:
      - 'null'
      - File
    doc: "Filename containing the paired reads."
    inputBinding:
      position: 20
      prefix: --paired-with
  - id: pattern_error
    type:
      - 'null'
      - int
    doc: "Maximum number of allowed error during pattern matching."
    inputBinding:
      position: 20
      prefix: --pattern-error
  - id: predicate
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --predicate}}
    doc: "boolean expression to be evaluated for each sequence record. The attribute keys defined for each sequence record can be used in the expression as variable names. An extra variable named ‘sequence’ refers to the sequence record itself. Several -p options can be used on the same command line and in this last case, the selected sequence records will match all constraints."
    inputBinding:
      position: 20
  - id: require_rank
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --require-rank}}
    doc: "Select sequences belonging a taxon with a rank <RANK_NAME>."
    inputBinding:
      position: 20
  - id: restrict_to_taxon
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --restrict-to-taxon}}
    doc: "Require that the actual taxon of the sequence belongs the provided taxid."
    inputBinding:
      position: 20
  - id: script
    type:
      - 'null'
      - File
    doc: "The script to execute."
    inputBinding:
      position: 20
      prefix: --script
  - id: sequence
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --sequence}}
    doc: "Regular expression pattern to be tested against the sequence itself. The pattern is case insensitive."
    inputBinding:
      position: 20
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
  - id: template
    type:
      - 'null'
      - boolean
    doc: "Print on the standard output a script template."
    inputBinding:
      position: 20
      prefix: --template
  - id: update_taxid
    type:
      - 'null'
      - boolean
    doc: "Make obitools automatically updating the taxid that are declared merged to a newest one."
    inputBinding:
      position: 20
      prefix: --update-taxid
  - id: valid_taxid
    type:
      - 'null'
      - boolean
    doc: "Validate the taxonomic classification of the sequences."
    inputBinding:
      position: 20
      prefix: --valid-taxid
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
stdout: obitools4_obiscript.out
