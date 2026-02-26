cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonkit reformat
label: taxonkit_reformat
doc: "Reformat lineage in canonical ranks\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: add_prefix
    type:
      - 'null'
      - boolean
    doc: add prefixes for all ranks, single prefix for a rank is defined by flag
      --prefix-X
    inputBinding:
      position: 101
      prefix: --add-prefix
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: directory containing nodes.dmp and names.dmp
    default: /root/.taxonkit
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: delimiter
    type:
      - 'null'
      - string
    doc: field delimiter in input lineage
    default: ;
    inputBinding:
      position: 101
      prefix: -d
  - id: fill_miss_rank
    type:
      - 'null'
      - boolean
    doc: fill missing rank with lineage information of the next higher rank
    inputBinding:
      position: 101
      prefix: --fill-miss-rank
  - id: format
    type:
      - 'null'
      - string
    doc: output format, placeholders of rank are needed
    default: '{k};{p};{c};{o};{f};{g};{s}'
    inputBinding:
      position: 101
      prefix: -f
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: use line buffering on output, i.e., immediately writing to stdin/file 
      for every line of output
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: lineage_field
    type:
      - 'null'
      - int
    doc: field index of lineage. data should be tab-separated
    default: 2
    inputBinding:
      position: 101
      prefix: --lineage-field
  - id: miss_rank_repl
    type:
      - 'null'
      - string
    doc: replacement string for missing rank
    inputBinding:
      position: 101
      prefix: --miss-rank-repl
  - id: miss_rank_repl_prefix
    type:
      - 'null'
      - string
    doc: prefix for estimated taxon names
    default: 'unclassified '
    inputBinding:
      position: 101
      prefix: --miss-rank-repl-prefix
  - id: miss_rank_repl_suffix
    type:
      - 'null'
      - string
    doc: suffix for estimated taxon names. "rank" for rank name, "" for no 
      suffix
    default: rank
    inputBinding:
      position: 101
      prefix: --miss-rank-repl-suffix
  - id: miss_taxid_repl
    type:
      - 'null'
      - string
    doc: replacement string for missing taxid
    inputBinding:
      position: 101
      prefix: --miss-taxid-repl
  - id: output_ambiguous_result
    type:
      - 'null'
      - boolean
    doc: output one of the ambigous result
    inputBinding:
      position: 101
      prefix: --output-ambiguous-result
  - id: prefix_C
    type:
      - 'null'
      - string
    doc: prefix for cellular root, used along with flag -P/--add-prefix
    default: d__
    inputBinding:
      position: 101
      prefix: --prefix-C
  - id: prefix_K
    type:
      - 'null'
      - string
    doc: prefix for kingdom, used along with flag -P/--add-prefix
    default: K__
    inputBinding:
      position: 101
      prefix: --prefix-K
  - id: prefix_S
    type:
      - 'null'
      - string
    doc: prefix for subspecies, used along with flag -P/--add-prefix
    default: S__
    inputBinding:
      position: 101
      prefix: --prefix-S
  - id: prefix_T
    type:
      - 'null'
      - string
    doc: prefix for strain, used along with flag -P/--add-prefix
    default: T__
    inputBinding:
      position: 101
      prefix: --prefix-T
  - id: prefix_a
    type:
      - 'null'
      - string
    doc: prefix for acellular root, used along with flag -P/--add-prefix
    default: d__
    inputBinding:
      position: 101
      prefix: --prefix-a
  - id: prefix_c
    type:
      - 'null'
      - string
    doc: prefix for class, used along with flag -P/--add-prefix
    default: c__
    inputBinding:
      position: 101
      prefix: --prefix-c
  - id: prefix_d
    type:
      - 'null'
      - string
    doc: prefix for domain, used along with flag -P/--add-prefix
    default: d__
    inputBinding:
      position: 101
      prefix: --prefix-d
  - id: prefix_f
    type:
      - 'null'
      - string
    doc: prefix for family, used along with flag -P/--add-prefix
    default: f__
    inputBinding:
      position: 101
      prefix: --prefix-f
  - id: prefix_g
    type:
      - 'null'
      - string
    doc: prefix for genus, used along with flag -P/--add-prefix
    default: g__
    inputBinding:
      position: 101
      prefix: --prefix-g
  - id: prefix_k
    type:
      - 'null'
      - string
    doc: prefix for superkingdom, used along with flag -P/--add-prefix
    default: k__
    inputBinding:
      position: 101
      prefix: --prefix-k
  - id: prefix_o
    type:
      - 'null'
      - string
    doc: prefix for order, used along with flag -P/--add-prefix
    default: o__
    inputBinding:
      position: 101
      prefix: --prefix-o
  - id: prefix_p
    type:
      - 'null'
      - string
    doc: prefix for phylum, used along with flag -P/--add-prefix
    default: p__
    inputBinding:
      position: 101
      prefix: --prefix-p
  - id: prefix_r
    type:
      - 'null'
      - string
    doc: prefix for realm, used along with flag -P/--add-prefix
    default: r__
    inputBinding:
      position: 101
      prefix: --prefix-r
  - id: prefix_s
    type:
      - 'null'
      - string
    doc: prefix for species, used along with flag -P/--add-prefix
    default: s__
    inputBinding:
      position: 101
      prefix: --prefix-s
  - id: prefix_t
    type:
      - 'null'
      - string
    doc: prefix for subspecies/strain, used along with flag -P/--add-prefix
    default: t__
    inputBinding:
      position: 101
      prefix: --prefix-t
  - id: pseudo_strain
    type:
      - 'null'
      - boolean
    doc: use the node with lowest rank as strain name, only if which rank is 
      lower than "species" and not "subpecies" nor "strain". It affects {t}, 
      {S}, {T}. This flag needs flag -F
    inputBinding:
      position: 101
      prefix: --pseudo-strain
  - id: show_lineage_taxids
    type:
      - 'null'
      - boolean
    doc: show corresponding taxids of reformated lineage
    inputBinding:
      position: 101
      prefix: --show-lineage-taxids
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: field index of taxid. input data should be tab-separated. it overrides 
      -i/--lineage-field
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPUs. 4 is enough
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: trim
    type:
      - 'null'
      - boolean
    doc: do not fill or add prefix for missing rank lower than current rank
    inputBinding:
      position: 101
      prefix: --trim
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print verbose information
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: out file ("-" for stdout, suffix .gz for gzipped out)
    outputBinding:
      glob: $(inputs.out_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
