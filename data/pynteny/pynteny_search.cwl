cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pynteny
  - search
label: pynteny_search
doc: "Query sequence database for HMM hits arranged in provided synteny structure.\n\
  \nTool homepage: http://github.com/robaina/Pynteny"
inputs:
  - id: data
    type: File
    doc: "path to fasta file containing peptide database. \n                     \
      \   Record labels must follow the format specified in docs \n              \
      \          (see section: General Usage). Pynteny build subcommand exports \n\
      \                        the generated database in the correct format"
    inputBinding:
      position: 101
      prefix: --data
  - id: gene_ids
    type:
      - 'null'
      - boolean
    doc: "use gene symbols in synteny structure instead of HMM names. \n         \
      \               If set, a path to the hmm database metadata file must be provided\
      \ \n                        in argument '--hmm_meta'"
    inputBinding:
      position: 101
      prefix: --gene_ids
  - id: hmm_dir
    type:
      - 'null'
      - Directory
    doc: "path to directory containing hmm (i.e, tigrfam or pfam) models. \n     \
      \                   IMPORTANT: the directory must contain one hmm per file,
      and the file \n                        name must coincide with the hmm name
      that will be displayed in the synteny structure. \n                        The
      directory can contain more hmm models than used in the synteny structure. \n\
      \                        It may also be the path to a compressed (tar, tar.gz,
      tgz) directory. \n                        If not provided, hmm models (PGAP
      database) will be downloaded from the NCBI. \n                        (if not
      already downloaded)"
    inputBinding:
      position: 101
      prefix: --hmm_dir
  - id: hmm_meta
    type:
      - 'null'
      - File
    doc: path to hmm database metadata file
    inputBinding:
      position: 101
      prefix: --hmm_meta
  - id: hmmsearch_args
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of comma-separated additional arguments to hmmsearch for each input
      hmm. \n                        A single argument may be provided, in which case
      the same additional argument \n                        is employed in all hmms."
    inputBinding:
      position: 101
      prefix: --hmmsearch_args
  - id: log
    type:
      - 'null'
      - File
    doc: path to log file. Log not written by default.
    inputBinding:
      position: 101
      prefix: --log
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix to be added to output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: processes
    type:
      - 'null'
      - int
    doc: maximum number of processes available to HMMER. Defaults to all but 
      one.
    inputBinding:
      position: 101
      prefix: --processes
  - id: reuse
    type:
      - 'null'
      - boolean
    doc: "reuse hmmsearch result table in following synteny searches. \n         \
      \               Do not delete hmmer_outputs subdirectory for this option to
      work."
    inputBinding:
      position: 101
      prefix: --reuse
  - id: synteny_struc
    type: string
    doc: "string displaying hmm structure to search for, such as: \n             \
      \            \n                        '>hmm_a n_ab <hmm_b n_bc hmm_c'\n   \
      \                      \n                        where '>' indicates a hmm target
      located on the positive strand, \n                        '<' a target located
      on the negative strand, and n_ab cooresponds \n                        to the
      maximum number of genes separating matched genes a and b. \n               \
      \         Multiple hmms may be employed. \n                        No order
      symbol in a hmm indicates that results should be independent \n            \
      \            of strand location."
    inputBinding:
      position: 101
      prefix: --synteny_struc
  - id: unordered
    type:
      - 'null'
      - boolean
    doc: "whether the HMMs should be arranged in the exact same order displayed \n\
      \                        in the synteny_structure or in  any order. If ordered,
      the filters will \n                        filter collinear rather than syntenic
      structures. \n                        If more than two HMMs are employed, the
      largest maximum distance among any \n                        pair is considered
      to run the search."
    inputBinding:
      position: 101
      prefix: --unordered
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pynteny:1.0.0--py310hec16e2b_0
