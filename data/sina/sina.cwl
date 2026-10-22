cwlVersion: v1.2
class: CommandLineTool
baseCommand: sina
label: sina
doc: "SINA (Structure-based Alignment of Nucleic Acids) is a tool for aligning nucleic
  acid sequences.\n\nTool homepage: https://github.com/epruesse/SINA"
inputs:
  - id: add_relatives
    type:
      - 'null'
      - string
    doc: add the ARG nearest relatives for each sequence to output
    inputBinding:
      position: 101
      prefix: --add-relatives
  - id: db
    type:
      - 'null'
      - File
    doc: reference database
    inputBinding:
      position: 101
      prefix: --db
  - id: fs_engine
    type:
      - 'null'
      - string
    doc: "search engine to use for reference selection \n                        \
      \   [*pt-server*|internal]"
    inputBinding:
      position: 101
      prefix: --fs-engine
  - id: fs_full_len
    type:
      - 'null'
      - int
    doc: minimum length of full length reference
    inputBinding:
      position: 101
      prefix: --fs-full-len
  - id: fs_kmer_len
    type:
      - 'null'
      - int
    doc: length of k-mers
    inputBinding:
      position: 101
      prefix: --fs-kmer-len
  - id: fs_max
    type:
      - 'null'
      - int
    doc: number of references used at most
    inputBinding:
      position: 101
      prefix: --fs-max
  - id: fs_min
    type:
      - 'null'
      - int
    doc: "number of references used regardless of shared \n                      \
      \     fraction"
    inputBinding:
      position: 101
      prefix: --fs-min
  - id: fs_min_len
    type:
      - 'null'
      - int
    doc: minimal reference length
    inputBinding:
      position: 101
      prefix: --fs-min-len
  - id: fs_msc
    type:
      - 'null'
      - float
    doc: required fractional identity of references
    inputBinding:
      position: 101
      prefix: --fs-msc
  - id: fs_req
    type:
      - 'null'
      - int
    doc: "required number of reference sequences (1)\n                           queries
      with less matches will be dropped"
    inputBinding:
      position: 101
      prefix: --fs-req
  - id: fs_req_full
    type:
      - 'null'
      - int
    doc: required number of full length references
    inputBinding:
      position: 101
      prefix: --fs-req-full
  - id: fs_req_gaps
    type:
      - 'null'
      - int
    doc: ignore references with less internal gaps
    inputBinding:
      position: 101
      prefix: --fs-req-gaps
  - id: input_file
    type: File
    doc: input file (arb or fasta)
    inputBinding:
      position: 101
      prefix: --in
  - id: lca_fields
    type:
      - 'null'
      - string
    doc: "names of fields containing source taxonomy (colon \n                   \
      \        separated list)"
    inputBinding:
      position: 101
      prefix: --lca-fields
  - id: lca_quorum
    type:
      - 'null'
      - float
    doc: "fraction of search result that must share resulting \n                 \
      \          classification"
    inputBinding:
      position: 101
      prefix: --lca-quorum
  - id: log_file
    type:
      - 'null'
      - File
    doc: file to write log to
    inputBinding:
      position: 101
      prefix: --log-file
  - id: meta_fmt
    type:
      - 'null'
      - string
    doc: meta data in (*none*|header|comment|csv)
    inputBinding:
      position: 101
      prefix: --meta-fmt
  - id: num_pts
    type:
      - 'null'
      - int
    doc: number of PT servers to start
    inputBinding:
      position: 101
      prefix: --num-pts
  - id: prealigned
    type:
      - 'null'
      - boolean
    doc: skip alignment stage
    inputBinding:
      position: 101
      prefix: --prealigned
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: decrease verbosity
    inputBinding:
      position: 101
      prefix: --quiet
  - id: search
    type:
      - 'null'
      - boolean
    doc: enable search stage
    inputBinding:
      position: 101
      prefix: --search
  - id: search_db
    type:
      - 'null'
      - File
    doc: reference db if different from -r/--db
    inputBinding:
      position: 101
      prefix: --search-db
  - id: search_engine
    type:
      - 'null'
      - string
    doc: engine if different from --fs-engine
    inputBinding:
      position: 101
      prefix: --search-engine
  - id: search_max_result
    type:
      - 'null'
      - int
    doc: desired number of search results
    inputBinding:
      position: 101
      prefix: --search-max-result
  - id: search_min_sim
    type:
      - 'null'
      - float
    doc: required sequence similarity
    inputBinding:
      position: 101
      prefix: --search-min-sim
  - id: threads
    type:
      - 'null'
      - int
    doc: limit number of threads (automatic)
    inputBinding:
      position: 101
      prefix: --threads
  - id: turn
    type:
      - 'null'
      - string
    doc: "check other strand as well\n                           'all' checks all
      four frames"
    inputBinding:
      position: 101
      prefix: --turn
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: increase verbosity
    inputBinding:
      position: 101
      prefix: --verbose
  - id: intype
    type:
      - 'null'
      - string
    doc: "override input file type [*auto*|none|arb|fasta|csv] (default: AUTO)"
    inputBinding:
      position: 101
      prefix: --intype
  - id: outtype
    type:
      - 'null'
      - string
    doc: "override output file type for next output file [*auto*|none|arb|fasta|csv]"
    inputBinding:
      position: 101
      prefix: --outtype
  - id: preserve_order
    type:
      - 'null'
      - boolean
    doc: "maintain order of sequences"
    inputBinding:
      position: 101
      prefix: --preserve-order
  - id: max_in_flight
    type:
      - 'null'
      - string
    doc: "max number of sequences processed at a time (default: 40)"
    inputBinding:
      position: 101
      prefix: --max-in-flight
  - id: has_cli_vers
    type:
      - 'null'
      - string
    doc: "verify support of cli version"
    inputBinding:
      position: 101
      prefix: --has-cli-vers
  - id: no_align
    type:
      - 'null'
      - boolean
    doc: "disable alignment stage (same as prealigned)"
    inputBinding:
      position: 101
      prefix: --no-align
  - id: fields
    type:
      - 'null'
      - string
    doc: "select fields to write"
    inputBinding:
      position: 101
      prefix: --fields
  - id: show_diff
    type:
      - 'null'
      - boolean
    doc: "show difference to original alignment"
    inputBinding:
      position: 101
      prefix: --show-diff
  - id: show_dist
    type:
      - 'null'
      - boolean
    doc: "show distance to original alignment"
    inputBinding:
      position: 101
      prefix: --show-dist
  - id: orig_db
    type:
      - 'null'
      - string
    doc: "ARB DB containing original alignment"
    inputBinding:
      position: 101
      prefix: --orig-db
  - id: colors
    type:
      - 'null'
      - boolean
    doc: "distinguish printed bases using colors"
    inputBinding:
      position: 101
      prefix: --colors
  - id: markcopied
    type:
      - 'null'
      - boolean
    doc: "mark copied references"
    inputBinding:
      position: 101
      prefix: --markcopied
  - id: markaligned
    type:
      - 'null'
      - boolean
    doc: "mark aligned sequences"
    inputBinding:
      position: 101
      prefix: --markaligned
  - id: prot_level
    type:
      - 'null'
      - string
    doc: "arb export protection level (4)"
    inputBinding:
      position: 101
      prefix: --prot-level
  - id: select_file
    type:
      - 'null'
      - string
    doc: "file containting arb names to be used ('-' for STDIN)"
    inputBinding:
      position: 101
      prefix: --select-file
  - id: select_step
    type:
      - 'null'
      - string
    doc: "use every n-th sequence (1)"
    inputBinding:
      position: 101
      prefix: --select-step
  - id: select_skip
    type:
      - 'null'
      - string
    doc: "skip the first n sequences (0)"
    inputBinding:
      position: 101
      prefix: --select-skip
  - id: line_length
    type:
      - 'null'
      - string
    doc: "wrap output sequence (unlimited)"
    inputBinding:
      position: 101
      prefix: --line-length
  - id: min_idty
    type:
      - 'null'
      - string
    doc: "only write sequences with align_idty_slv > X, implies calc-idty"
    inputBinding:
      position: 101
      prefix: --min-idty
  - id: fasta_write_dna
    type:
      - 'null'
      - boolean
    doc: "Write DNA sequences (default: RNA)"
    inputBinding:
      position: 101
      prefix: --fasta-write-dna
  - id: fasta_write_dots
    type:
      - 'null'
      - boolean
    doc: "Use dots instead of dashes to distinguish unknown sequence data from indels"
    inputBinding:
      position: 101
      prefix: --fasta-write-dots
  - id: fasta_idx
    type:
      - 'null'
      - string
    doc: "process only sequences beginning in block <arg> (0 is first)"
    inputBinding:
      position: 101
      prefix: --fasta-idx
  - id: fasta_block
    type:
      - 'null'
      - string
    doc: "block length in bytes"
    inputBinding:
      position: 101
      prefix: --fasta-block
  - id: csv_crlf
    type:
      - 'null'
      - boolean
    doc: "Write CSV using CRLF line ends (as RFC4180 demands)"
    inputBinding:
      position: 101
      prefix: --csv-crlf
  - id: csv_sep
    type:
      - 'null'
      - string
    doc: "Overrides field separator. Default is ',', or TAB if the  output file ends in '.tsv'"
    inputBinding:
      position: 101
      prefix: --csv-sep
  - id: csv_id
    type:
      - 'null'
      - string
    doc: "Override column header for sequence ID (default: name)"
    inputBinding:
      position: 101
      prefix: --csv-id
  - id: realign
    type:
      - 'null'
      - boolean
    doc: "do not copy alignment from reference"
    inputBinding:
      position: 101
      prefix: --realign
  - id: overhang
    type:
      - 'null'
      - string
    doc: "select type of overhang placement [*attach*|remove|edge]"
    inputBinding:
      position: 101
      prefix: --overhang
  - id: lowercase
    type:
      - 'null'
      - string
    doc: "select which bases to put in lower case [*none*|original|unaligned]"
    inputBinding:
      position: 101
      prefix: --lowercase
  - id: insertion
    type:
      - 'null'
      - string
    doc: "handling of insertions not accomodatable by reference alignment [*shift*|forbid|remove]"
    inputBinding:
      position: 101
      prefix: --insertion
  - id: fs_no_graph
    type:
      - 'null'
      - boolean
    doc: "use profile vector instead of DAG to as template"
    inputBinding:
      position: 101
      prefix: --fs-no-graph
  - id: fs_weight
    type:
      - 'null'
      - string
    doc: "scales weight derived from fs base freq (1)"
    inputBinding:
      position: 101
      prefix: --fs-weight
  - id: match_score
    type:
      - 'null'
      - string
    doc: "score awarded for a match (2)"
    inputBinding:
      position: 101
      prefix: --match-score
  - id: mismatch_score
    type:
      - 'null'
      - string
    doc: "score awarded for a mismatch (-1)"
    inputBinding:
      position: 101
      prefix: --mismatch-score
  - id: pen_gap
    type:
      - 'null'
      - string
    doc: "gap open penalty (5)"
    inputBinding:
      position: 101
      prefix: --pen-gap
  - id: pen_gapext
    type:
      - 'null'
      - string
    doc: "gap extend penalty (2)"
    inputBinding:
      position: 101
      prefix: --pen-gapext
  - id: debug_graph
    type:
      - 'null'
      - boolean
    doc: "dump reference graphs to disk"
    inputBinding:
      position: 101
      prefix: --debug-graph
  - id: use_subst_matrix
    type:
      - 'null'
      - boolean
    doc: "use experimental scoring system (slow)"
    inputBinding:
      position: 101
      prefix: --use-subst-matrix
  - id: write_used_rels
    type:
      - 'null'
      - boolean
    doc: "write used reference sequences to field 'used_rels'"
    inputBinding:
      position: 101
      prefix: --write-used-rels
  - id: calc_idty
    type:
      - 'null'
      - boolean
    doc: "calculate highest identity of aligned sequence with any reference"
    inputBinding:
      position: 101
      prefix: --calc-idty
  - id: ptdb
    type:
      - 'null'
      - string
    doc: "PT server database (old name)"
    inputBinding:
      position: 101
      prefix: --ptdb
  - id: ptport
    type:
      - 'null'
      - string
    doc: "PT server port (:/tmp/sina_pt_<pid>)"
    inputBinding:
      position: 101
      prefix: --ptport
  - id: fs_kmer_no_fast
    type:
      - 'null'
      - boolean
    doc: "don't use fast family search"
    inputBinding:
      position: 101
      prefix: --fs-kmer-no-fast
  - id: fs_kmer_mm
    type:
      - 'null'
      - string
    doc: "allowed mismatches per k-mer (0)"
    inputBinding:
      position: 101
      prefix: --fs-kmer-mm
  - id: fs_kmer_norel
    type:
      - 'null'
      - boolean
    doc: "don't score k-mer distance relative to target length"
    inputBinding:
      position: 101
      prefix: --fs-kmer-norel
  - id: fs_msc_max
    type:
      - 'null'
      - string
    doc: "max identity of used references (for evaluation)"
    inputBinding:
      position: 101
      prefix: --fs-msc-max
  - id: fs_leave_query_out
    type:
      - 'null'
      - boolean
    doc: "ignore candidate if found in reference (for evaluation)"
    inputBinding:
      position: 101
      prefix: --fs-leave-query-out
  - id: gene_start
    type:
      - 'null'
      - string
    doc: "alignment position of first base of gene (0)"
    inputBinding:
      position: 101
      prefix: --gene-start
  - id: gene_end
    type:
      - 'null'
      - string
    doc: "alignment position of last base of gene (0)"
    inputBinding:
      position: 101
      prefix: --gene-end
  - id: fs_cover_gene
    type:
      - 'null'
      - string
    doc: "required number of references covering each gene end (0)"
    inputBinding:
      position: 101
      prefix: --fs-cover-gene
  - id: filter
    type:
      - 'null'
      - string
    doc: "select posvar filter"
    inputBinding:
      position: 101
      prefix: --filter
  - id: auto_filter_field
    type:
      - 'null'
      - string
    doc: "select field for auto filter selection"
    inputBinding:
      position: 101
      prefix: --auto-filter-field
  - id: auto_filter_threshold
    type:
      - 'null'
      - string
    doc: "quorum for auto filter selection (0.8)"
    inputBinding:
      position: 101
      prefix: --auto-filter-threshold
  - id: fs_oldmatch
    type:
      - 'null'
      - boolean
    doc: "use legacy family composition algorithm"
    inputBinding:
      position: 101
      prefix: --fs-oldmatch
  - id: search_port
    type:
      - 'null'
      - string
    doc: "PT server port (:/tmp/sina_pt2_<pid>)"
    inputBinding:
      position: 101
      prefix: --search-port
  - id: search_all
    type:
      - 'null'
      - boolean
    doc: "do not use k-mer heuristic"
    inputBinding:
      position: 101
      prefix: --search-all
  - id: search_no_fast
    type:
      - 'null'
      - boolean
    doc: "don't use fast family search"
    inputBinding:
      position: 101
      prefix: --search-no-fast
  - id: search_kmer_candidates
    type:
      - 'null'
      - string
    doc: "number of most similar sequences to acquire via kmer-step (1000)"
    inputBinding:
      position: 101
      prefix: --search-kmer-candidates
  - id: search_kmer_len
    type:
      - 'null'
      - string
    doc: "length of k-mers (12)"
    inputBinding:
      position: 101
      prefix: --search-kmer-len
  - id: search_kmer_mm
    type:
      - 'null'
      - string
    doc: "allowed mismatches per k-mer (0)"
    inputBinding:
      position: 101
      prefix: --search-kmer-mm
  - id: search_kmer_norel
    type:
      - 'null'
      - boolean
    doc: "don't score k-mer distance relative to target length"
    inputBinding:
      position: 101
      prefix: --search-kmer-norel
  - id: search_ignore_super
    type:
      - 'null'
      - boolean
    doc: "ignore sequences containing query"
    inputBinding:
      position: 101
      prefix: --search-ignore-super
  - id: search_copy_fields
    type:
      - 'null'
      - string
    doc: "copy fields from result sequences to query sequence"
    inputBinding:
      position: 101
      prefix: --search-copy-fields
  - id: search_iupac
    type:
      - 'null'
      - string
    doc: "strategy for comparing ambiguous bases [pessimistic|*optimistic*|exact]"
    inputBinding:
      position: 101
      prefix: --search-iupac
  - id: search_correction
    type:
      - 'null'
      - string
    doc: "apply distance correction. [*none*|jc]"
    inputBinding:
      position: 101
      prefix: --search-correction
  - id: search_cover
    type:
      - 'null'
      - string
    doc: "compute comparative measure relative to abs: 1 *query: query sequence length target: target sequence length min: length of shorter sequence max: length of longer sequence avg: average length overlap: length of overlap all: columns with bases in either nogap: columns with bases in both "
    inputBinding:
      position: 101
      prefix: --search-cover
  - id: search_filter_lowercase
    type:
      - 'null'
      - boolean
    doc: "ignore bases in lowercase when comparing sequences"
    inputBinding:
      position: 101
      prefix: --search-filter-lowercase
  - id: output_file_path
    type: string
    doc: output file (arb, fasta or csv; may be specified
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file (arb, fasta or csv; may be specified multiple times)
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sina:1.7.2--h9aa86b4_0
