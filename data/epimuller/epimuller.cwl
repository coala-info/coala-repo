cwlVersion: v1.2
class: CommandLineTool
baseCommand: epimuller
label: epimuller
doc: "epimuller\n\nTool homepage: https://github.com/jennifer-bio/epimuller"
inputs:
  - id: annotated_tree
    type:
      - 'null'
      - File
    doc: 'nexus file name with annotation: [&!traitOfInterst=value], as output by
      treetime'
    inputBinding:
      position: 101
      prefix: --annotatedTree
  - id: avg_window
    type:
      - 'null'
      - string
    doc: "width of rolling mean window in terms of --timeWindow's (recomend using
      with small --timeWindow) ; default: sum of counts withen timeWindow (ie no average)"
    default: None
    inputBinding:
      position: 101
      prefix: --avgWindow
  - id: cases_name
    type:
      - 'null'
      - File
    doc: file with cases - formated with 'date' in ISO format and 
      'confirmed_rolling' cases, in tsv format
    inputBinding:
      position: 101
      prefix: --cases_name
  - id: end_date
    type:
      - 'null'
      - string
    doc: end date in iso format YYYY-MM-DD or 'lastDate' which sets end date as 
      last date in metadata
    default: lastDate
    inputBinding:
      position: 101
      prefix: --endDate
  - id: font_size
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --FONTSIZE
  - id: gene_boundry
    type:
      - 'null'
      - File
    doc: '[use with -a/--annotatedTree AND -k/--traitOfInterst aa_muts] json formated
      file specifing start end postions of genes in alignment for annotatedTree (see
      example data/geneAAboundries.json)'
    inputBinding:
      position: 101
      prefix: --geneBoundry
  - id: height
    type:
      - 'null'
      - int
    doc: HEIGHT of page (px)
    default: 1000
    inputBinding:
      position: 101
      prefix: --HEIGHT
  - id: in_meta
    type: File
    doc: "metadata tsv with 'strain' and 'date'cols, optional: cols of trait of interst;
      and pangolin col named:'pangolin_lineage', 'lineage' or 'pangolin_lin'"
    inputBinding:
      position: 101
      prefix: --inMeta
  - id: in_nextstrain
    type:
      - 'null'
      - File
    doc: nextstrain results with tree.nwk and [traitOfInterst].json
    inputBinding:
      position: 101
      prefix: --inNextstrain
  - id: in_pangolin
    type:
      - 'null'
      - File
    doc: pangolin output lineage_report.csv file, if argument not supplied looks
      in inMeta for col with 'pangolin_lineage', 'pangolin_lin', or 'lineage'
    default: metadata
    inputBinding:
      position: 101
      prefix: --inPangolin
  - id: label_position
    type:
      - 'null'
      - string
    doc: choose position of clade labels
    default: Right
    inputBinding:
      position: 101
      prefix: --labelPosition
  - id: label_shift
    type:
      - 'null'
      - int
    doc: nudge label over by LABELSHIFT (px)
    default: 15
    inputBinding:
      position: 101
      prefix: --LABELSHIFT
  - id: legend_width
    type:
      - 'null'
      - int
    doc: LEGENDWIDTH to the right of plotting area (px)
    default: 220
    inputBinding:
      position: 101
      prefix: --LEGENDWIDTH
  - id: margin
    type:
      - 'null'
      - int
    doc: MARGIN around all sides of plotting area (px)
    default: 60
    inputBinding:
      position: 101
      prefix: --MARGIN
  - id: mintime
    type:
      - 'null'
      - int
    doc: minimum time point to start plotting
    default: 30
    inputBinding:
      position: 101
      prefix: --MINTIME
  - id: mintotalcount
    type:
      - 'null'
      - int
    doc: minimum total count for group to be included
    default: 50
    inputBinding:
      position: 101
      prefix: --MINTOTALCOUNT
  - id: no_pangolin
    type:
      - 'null'
      - boolean
    doc: do not add lineage to clade names
    default: false
    inputBinding:
      position: 101
      prefix: --noPangolin
  - id: out_directory
    type:
      - 'null'
      - Directory
    doc: folder for output
    default: ./
    inputBinding:
      position: 101
      prefix: --outDirectory
  - id: out_prefix
    type: string
    doc: prefix of out files withen outDirectory
    inputBinding:
      position: 101
      prefix: --outPrefix
  - id: start_date
    type:
      - 'null'
      - string
    doc: start date in iso format YYYY-MM-DD or 'firstDate' which sets start 
      date to first date in metadata
    default: '2020-03-01'
    inputBinding:
      position: 101
      prefix: --startDate
  - id: time_window
    type:
      - 'null'
      - int
    doc: number of days for sampling window
    default: 7
    inputBinding:
      position: 101
      prefix: --timeWindow
  - id: trait_of_interest_file
    type:
      - 'null'
      - string
    doc: "[use with -n/--inNextstrain] name of [traitOfInterstFile].json in '-n/--inNextstrain'
      folder"
    default: aa_muts.json
    inputBinding:
      position: 101
      prefix: --traitOfInterstFile
  - id: trait_of_interest_key
    type:
      - 'null'
      - string
    doc: "key for trait of interst in json file OR (if -a/--annotatedTree AND key
      is mutations with aa (not nuc): use 'aa_muts')"
    default: aa_muts
    inputBinding:
      position: 101
      prefix: --traitOfInterstKey
  - id: voc_list
    type:
      - 'null'
      - type: array
        items: string
    doc: list of aa of interest in form [GENE][*ORAncAA][site][*ORtoAA] ex. 
      S*501*, gaps represed by X, wild card aa represented by *
    inputBinding:
      position: 101
      prefix: --VOClist
  - id: width
    type:
      - 'null'
      - int
    doc: WIDTH of page (px)
    default: 1500
    inputBinding:
      position: 101
      prefix: --WIDTH
  - id: xlabel
    type:
      - 'null'
      - string
    doc: 'Format of x axis label: ISO date format or timepoints from start, or dd-Mon-YYYY
      on 1st and 15th'
    default: date
    inputBinding:
      position: 101
      prefix: --xlabel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epimuller:0.0.8--pyhdfd78af_0
stdout: epimuller.out
