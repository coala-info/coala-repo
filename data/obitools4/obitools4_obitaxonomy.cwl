cwlVersion: v1.2
class: CommandLineTool
baseCommand: obitaxonomy
label: obitools4_obitaxonomy
doc: "Query, extract, download or dump a taxonomy (NCBI taxdump or a taxonomy extracted from sequences).\n\nTool homepage: https://obitools4.metabarcoding.org"
inputs:
  - id: input
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxon name patterns (regular expressions, or fixed strings with --fixed) to search in the taxonomy.
    inputBinding:
      position: 100
  - id: alternative_names
    type:
      - 'null'
      - boolean
    doc: "Enable the search on all alternative names and not only scientific names."
    inputBinding:
      position: 20
      prefix: --alternative-names
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
  - id: download_ncbi
    type:
      - 'null'
      - boolean
    doc: "Download the current NCBI taxonomy taxdump."
    inputBinding:
      position: 20
      prefix: --download-ncbi
  - id: dump
    type:
      - 'null'
      - string
    doc: "Dump a sub-taxonomy corresponding to the precised clade."
    inputBinding:
      position: 20
      prefix: --dump
  - id: extract_taxonomy
    type:
      - 'null'
      - boolean
    doc: "Extract taxonomy from a sequence file."
    inputBinding:
      position: 20
      prefix: --extract-taxonomy
  - id: fail_on_taxonomy
    type:
      - 'null'
      - boolean
    doc: "Make obitools failing on error if a used taxid is not a currently valid one."
    inputBinding:
      position: 20
      prefix: --fail-on-taxonomy
  - id: fixed
    type:
      - 'null'
      - boolean
    doc: "Match taxon names using a fixed pattern, not a regular expression."
    inputBinding:
      position: 20
      prefix: --fixed
  - id: force_one_cpu
    type:
      - 'null'
      - boolean
    doc: "Force to use only one cpu core for parallel processing."
    inputBinding:
      position: 20
      prefix: --force-one-cpu
  - id: max_cpu
    type:
      - 'null'
      - int
    doc: "Number of parallele threads computing the result."
    inputBinding:
      position: 20
      prefix: --max-cpu
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
  - id: parents
    type:
      - 'null'
      - string
    doc: "Displays every parental tree's information for the provided taxid."
    inputBinding:
      position: 20
      prefix: --parents
  - id: rank
    type:
      - 'null'
      - string
    doc: "Restrict to the given taxonomic rank."
    inputBinding:
      position: 20
      prefix: --rank
  - id: rank_list
    type:
      - 'null'
      - boolean
    doc: "List every taxonomic rank available in the taxonomy."
    inputBinding:
      position: 20
      prefix: --rank-list
  - id: raw_taxid
    type:
      - 'null'
      - boolean
    doc: "Displays the raw taxid for each displayed taxon."
    inputBinding:
      position: 20
      prefix: --raw-taxid
  - id: restrict_to_taxon
    type:
      - 'null'
      - {type: array, items: string, inputBinding: {prefix: --restrict-to-taxon}}
    doc: "Restrict output to some subclades."
    inputBinding:
      position: 20
  - id: solexa
    type:
      - 'null'
      - boolean
    doc: "Decodes quality string according to the Solexa specification."
    inputBinding:
      position: 20
      prefix: --solexa
  - id: sons
    type:
      - 'null'
      - string
    doc: "Displays every sons' tree's information for the provided taxid."
    inputBinding:
      position: 20
      prefix: --sons
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
  - id: with_path
    type:
      - 'null'
      - boolean
    doc: "Adds a column containing the full path for each displayed taxon."
    inputBinding:
      position: 20
      prefix: --with-path
  - id: with_query
    type:
      - 'null'
      - boolean
    doc: "Adds a column containing query used to filter taxon name for each displayed taxon."
    inputBinding:
      position: 20
      prefix: --with-query
  - id: without_parent
    type:
      - 'null'
      - boolean
    doc: "Supress the column containing the parent's taxonid from the output."
    inputBinding:
      position: 20
      prefix: --without-parent
  - id: without_rank
    type:
      - 'null'
      - boolean
    doc: "Supress the column containing the taxonomic rank from the output."
    inputBinding:
      position: 20
      prefix: --without-rank
  - id: without_scientific_name
    type:
      - 'null'
      - boolean
    doc: "Supress the column containing the scientific name from the output."
    inputBinding:
      position: 20
      prefix: --without-scientific-name
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
stdout: obitools4_obitaxonomy.out
