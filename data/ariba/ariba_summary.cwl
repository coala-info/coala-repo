cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ariba
  - summary
label: ariba_summary
doc: "Make a summary of multiple ARIBA report files, and also make Phandango files\n\nTool homepage: https://github.com/sanger-pathogens/ariba"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ return inputs.fofn_files ? inputs.fofn_files : []; }'
inputs:
  - id: outprefix
    type: string
    doc: "Prefix of output files"
    default: summary
    inputBinding:
      position: 10
  - id: infiles
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files to be summarised"
    inputBinding:
      position: 11
  - id: fofn
    type:
      - 'null'
      - File
    doc: "File of filenames of ariba reports to be summarised. The first column should be the filename; an optional second column gives a sample name. Give the listed report files in fofn_files so their names resolve."
    inputBinding:
      position: 1
      prefix: --fofn
  - id: fofn_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Report files named in the --fofn file; staged in the working directory so the names resolve
  - id: preset
    type:
      - 'null'
      - string
    doc: "Shorthand for setting --cluster_cols,--col_filter,--row_filter,--v_groups,--variants: minimal|cluster_small|cluster_all|cluster_var_groups|all|all_no_filter"
    inputBinding:
      position: 1
      prefix: --preset
  - id: cluster_cols
    type:
      - 'null'
      - string
    doc: "Comma separated list of cluster columns to include. Choose from: assembled, match, ref_seq, pct_id, ctg_cov, known_var, novel_var [match]"
    inputBinding:
      position: 1
      prefix: --cluster_cols
  - id: col_filter
    type:
      - 'null'
      - string
    doc: "Choose whether columns where all values are \"no\" or \"NA\" are removed (y|n) [y]"
    inputBinding:
      position: 1
      prefix: --col_filter
  - id: no_tree
    type:
      - 'null'
      - boolean
    doc: "Do not make phandango tree"
    inputBinding:
      position: 1
      prefix: --no_tree
  - id: row_filter
    type:
      - 'null'
      - string
    doc: "Choose whether rows where all values are \"no\" or \"NA\" are removed (y|n) [y]"
    inputBinding:
      position: 1
      prefix: --row_filter
  - id: min_id
    type:
      - 'null'
      - float
    doc: "Minimum percent identity cutoff to count as assembled [90]"
    inputBinding:
      position: 1
      prefix: --min_id
  - id: only_clusters
    type:
      - 'null'
      - string
    doc: "Only report data for the given comma-separated list of cluster names, eg: cluster1,cluster2,cluster42"
    inputBinding:
      position: 1
      prefix: --only_clusters
  - id: v_groups
    type:
      - 'null'
      - boolean
    doc: "Show a group column for each group of variants"
    inputBinding:
      position: 1
      prefix: --v_groups
  - id: known_variants
    type:
      - 'null'
      - boolean
    doc: "Report all known variants"
    inputBinding:
      position: 1
      prefix: --known_variants
  - id: novel_variants
    type:
      - 'null'
      - boolean
    doc: "Report all novel variants"
    inputBinding:
      position: 1
      prefix: --novel_variants
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be verbose"
    inputBinding:
      position: 1
      prefix: --verbose
outputs:
  - id: summary_csv
    type: File
    doc: Summary table (outprefix.csv)
    outputBinding:
      glob: $(inputs.outprefix).csv
  - id: phandango_files
    type: File[]
    doc: Phandango files (outprefix.phandango.csv, outprefix.phandango.tre)
    outputBinding:
      glob: $(inputs.outprefix).phandango.*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ariba:2.14.7--py310h5140242_0
