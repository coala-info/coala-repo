cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller-define
label: epimuller_define
doc: "Defines clades from a tree and a trait (for example amino acid mutations or lineages) and counts them over time windows.\n\nTool homepage: https://github.com/jennifer-bio/epimuller"
inputs:
  - id: out_directory
    type:
      - 'null'
      - string
    doc: "folder for output"
    inputBinding:
      position: 101
      prefix: --outDirectory
  - id: out_prefix
    type: string
    doc: "prefix of out files withen outDirectory"
    inputBinding:
      position: 101
      prefix: --outPrefix
  - id: in_nextstrain
    type:
      - 'null'
      - Directory
    doc: "nextstrain results with tree.nwk and [traitOfInterstFile].json"
    inputBinding:
      position: 101
      prefix: --inNextstrain
  - id: annotated_tree
    type:
      - 'null'
      - File
    doc: "nexus file name with annotation: [&!traitOfInterstKey=value], as output by treetime"
    inputBinding:
      position: 101
      prefix: --annotatedTree
  - id: in_meta
    type: File
    doc: "metadata tsv with 'strain' and 'date'cols, optional: col for [traitOfInterstKey]; and pangolin col named: 'pangolin_lineage' 'lineage' or 'pangolin_lin'"
    inputBinding:
      position: 101
      prefix: --inMeta
  - id: in_pangolin
    type:
      - 'null'
      - File
    doc: "pangolin output lineage_report.csv file, if argument not supplied looks in inMeta for col with 'pangolin_lineage', 'pangolin_lin', or 'lineage'"
    inputBinding:
      position: 101
      prefix: --inPangolin
  - id: no_pangolin
    type:
      - 'null'
      - boolean
    doc: "do not add lineage to clade names"
    inputBinding:
      position: 101
      prefix: --noPangolin
  - id: trait_of_interest_key
    type:
      - 'null'
      - string
    doc: "key for trait of interst in json file OR (if -a/--annotatedTree AND key is mutations with aa (not nuc): use 'aa_muts')"
    inputBinding:
      position: 101
      prefix: --traitOfInterstKey
  - id: trait_of_interest_file
    type:
      - 'null'
      - string
    doc: "[use with -n/--inNextstrain] name of [traitOfInterstFile].json in '-n/--inNextstrain' folder"
    inputBinding:
      position: 101
      prefix: --traitOfInterstFile
  - id: gene_boundry
    type:
      - 'null'
      - File
    doc: "[use with -a/--annotatedTree AND -k/--traitOfInterst aa_muts] json formated file specifing start end postions of genes in alignment for annotatedTree"
    inputBinding:
      position: 101
      prefix: --geneBoundry
  - id: voc_list
    type:
      - 'null'
      - type: array
        items: string
    doc: "list of aa of interest in form [GENE][*ORAncAA][site][*ORtoAA] ex. S*501*, gaps represented by X, wild card aa represented by *"
    inputBinding:
      position: 101
      prefix: --VOClist
  - id: time_window
    type:
      - 'null'
      - int
    doc: "number of days for sampling window"
    inputBinding:
      position: 101
      prefix: --timeWindow
  - id: start_date
    type:
      - 'null'
      - string
    doc: "start date in iso format YYYY-MM-DD or 'firstDate' which is in metadata"
    inputBinding:
      position: 101
      prefix: --startDate
  - id: end_date
    type:
      - 'null'
      - string
    doc: "end date in iso format YYYY-MM-DD or 'lastDate' which is in metadata"
    inputBinding:
      position: 101
      prefix: --endDate
outputs:
  - id: out_directory_dir
    type:
      - 'null'
      - Directory
    doc: folder for output
    outputBinding:
      glob: $(inputs.out_directory)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller_define.out
