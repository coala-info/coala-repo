cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxonkit
  - reformat
label: taxonkit_reformat
doc: "Reformat lineage in canonical ranks\n\nTool homepage: https://github.com/shenwei356/taxonkit"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: 'File(s) with a lineage column (or a TaxId column, see taxid_field), tab-separated'
    inputBinding:
      position: 1
  - id: add_prefix
    type:
      - 'null'
      - boolean
    doc: 'Add prefixes for all ranks, single prefix for a rank is defined by the prefix_* options'
    inputBinding:
      position: 101
      prefix: --add-prefix
  - id: delimiter
    type:
      - 'null'
      - string
    doc: 'Field delimiter in input lineage (default '';'')'
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: fill_miss_rank
    type:
      - 'null'
      - boolean
    doc: 'Fill missing rank with lineage information of the next higher rank'
    inputBinding:
      position: 101
      prefix: --fill-miss-rank
  - id: format
    type:
      - 'null'
      - string
    doc: 'Output format, placeholders of rank are needed (default ''{k};{p};{c};{o};{f};{g};{s}'')'
    inputBinding:
      position: 101
      prefix: --format
  - id: lineage_field
    type:
      - 'null'
      - int
    doc: 'Field index of lineage. Data should be tab-separated (default 2)'
    inputBinding:
      position: 101
      prefix: --lineage-field
  - id: miss_rank_repl
    type:
      - 'null'
      - string
    doc: 'Replacement string for missing rank'
    inputBinding:
      position: 101
      prefix: --miss-rank-repl
  - id: miss_rank_repl_prefix
    type:
      - 'null'
      - string
    doc: 'Prefix for estimated taxon names (default ''unclassified '')'
    inputBinding:
      position: 101
      prefix: --miss-rank-repl-prefix
  - id: miss_rank_repl_suffix
    type:
      - 'null'
      - string
    doc: 'Suffix for estimated taxon names. ''rank'' for rank name, '''' for no suffix (default ''rank'')'
    inputBinding:
      position: 101
      prefix: --miss-rank-repl-suffix
  - id: miss_taxid_repl
    type:
      - 'null'
      - string
    doc: 'Replacement string for missing taxid'
    inputBinding:
      position: 101
      prefix: --miss-taxid-repl
  - id: output_ambiguous_result
    type:
      - 'null'
      - boolean
    doc: 'Output one of the ambiguous result'
    inputBinding:
      position: 101
      prefix: --output-ambiguous-result
  - id: prefix_C
    type:
      - 'null'
      - string
    doc: 'Prefix for cellular root, used along with add_prefix (default ''d__'')'
    inputBinding:
      position: 101
      prefix: --prefix-C
  - id: prefix_K
    type:
      - 'null'
      - string
    doc: 'Prefix for kingdom, used along with add_prefix (default ''K__'')'
    inputBinding:
      position: 101
      prefix: --prefix-K
  - id: prefix_S
    type:
      - 'null'
      - string
    doc: 'Prefix for subspecies, used along with add_prefix (default ''S__'')'
    inputBinding:
      position: 101
      prefix: --prefix-S
  - id: prefix_T
    type:
      - 'null'
      - string
    doc: 'Prefix for strain, used along with add_prefix (default ''T__'')'
    inputBinding:
      position: 101
      prefix: --prefix-T
  - id: prefix_a
    type:
      - 'null'
      - string
    doc: 'Prefix for acellular root, used along with add_prefix (default ''d__'')'
    inputBinding:
      position: 101
      prefix: --prefix-a
  - id: prefix_c
    type:
      - 'null'
      - string
    doc: 'Prefix for class, used along with add_prefix (default ''c__'')'
    inputBinding:
      position: 101
      prefix: --prefix-c
  - id: prefix_d
    type:
      - 'null'
      - string
    doc: 'Prefix for domain, used along with add_prefix (default ''d__'')'
    inputBinding:
      position: 101
      prefix: --prefix-d
  - id: prefix_f
    type:
      - 'null'
      - string
    doc: 'Prefix for family, used along with add_prefix (default ''f__'')'
    inputBinding:
      position: 101
      prefix: --prefix-f
  - id: prefix_g
    type:
      - 'null'
      - string
    doc: 'Prefix for genus, used along with add_prefix (default ''g__'')'
    inputBinding:
      position: 101
      prefix: --prefix-g
  - id: prefix_k
    type:
      - 'null'
      - string
    doc: 'Prefix for superkingdom, used along with add_prefix (default ''k__'')'
    inputBinding:
      position: 101
      prefix: --prefix-k
  - id: prefix_o
    type:
      - 'null'
      - string
    doc: 'Prefix for order, used along with add_prefix (default ''o__'')'
    inputBinding:
      position: 101
      prefix: --prefix-o
  - id: prefix_p
    type:
      - 'null'
      - string
    doc: 'Prefix for phylum, used along with add_prefix (default ''p__'')'
    inputBinding:
      position: 101
      prefix: --prefix-p
  - id: prefix_r
    type:
      - 'null'
      - string
    doc: 'Prefix for realm, used along with add_prefix (default ''r__'')'
    inputBinding:
      position: 101
      prefix: --prefix-r
  - id: prefix_s
    type:
      - 'null'
      - string
    doc: 'Prefix for species, used along with add_prefix (default ''s__'')'
    inputBinding:
      position: 101
      prefix: --prefix-s
  - id: prefix_t
    type:
      - 'null'
      - string
    doc: 'Prefix for subspecies/strain, used along with add_prefix (default ''t__'')'
    inputBinding:
      position: 101
      prefix: --prefix-t
  - id: pseudo_strain
    type:
      - 'null'
      - boolean
    doc: 'Use the node with lowest rank as strain name, only if which rank is lower than species and not subspecies nor strain. Needs fill_miss_rank'
    inputBinding:
      position: 101
      prefix: --pseudo-strain
  - id: show_lineage_taxids
    type:
      - 'null'
      - boolean
    doc: 'Show corresponding taxids of reformatted lineage'
    inputBinding:
      position: 101
      prefix: --show-lineage-taxids
  - id: taxid_field
    type:
      - 'null'
      - int
    doc: 'Field index of taxid. Input data should be tab-separated. It overrides lineage_field'
    inputBinding:
      position: 101
      prefix: --taxid-field
  - id: trim
    type:
      - 'null'
      - boolean
    doc: 'Do not fill or add prefix for missing rank lower than current rank'
    inputBinding:
      position: 101
      prefix: --trim
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: 'Directory containing nodes.dmp and names.dmp (NCBI taxdump files)'
    inputBinding:
      position: 101
      prefix: --data-dir
  - id: line_buffered
    type:
      - 'null'
      - boolean
    doc: 'Use line buffering on output, i.e., immediately writing to stdin/file for every line of output'
    inputBinding:
      position: 101
      prefix: --line-buffered
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPUs. 4 is enough'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Print verbose information'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_file_path
    type: string
    doc: 'Output file name (suffix .gz for gzipped output)'
    inputBinding:
      position: 102
      prefix: --out-file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.out_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxonkit:0.20.0--h9ee0642_1
