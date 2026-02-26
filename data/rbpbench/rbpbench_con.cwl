cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench con
label: rbpbench_con
doc: "Compares conservation scores between two sets of genomic sites.\n\nTool homepage:
  https://github.com/michauhl/RBPBench"
inputs:
  - id: control_sites
    type: File
    doc: Genomic control sites to compare to --in genomic sites regarding 
      conservation scores in BED format
    inputBinding:
      position: 101
      prefix: --ctrl-in
  - id: input_sites
    type: File
    doc: Genomic sites of interest in BED format
    inputBinding:
      position: 101
      prefix: --in
  - id: no_id_check
    type:
      - 'null'
      - boolean
    doc: Do not check region IDs, instead overwriting existing regions if they 
      have identical IDs
    default: false
    inputBinding:
      position: 101
      prefix: --no-id-check
  - id: phastcons_file
    type:
      - 'null'
      - File
    doc: Genomic .bigWig file with phastCons conservation scores
    inputBinding:
      position: 101
      prefix: --phastcons
  - id: phylop_file
    type:
      - 'null'
      - File
    doc: Genomic .bigWig file with phyloP conservation scores
    inputBinding:
      position: 101
      prefix: --phylop
  - id: plot_abs_paths
    type:
      - 'null'
      - boolean
    doc: Store plot files with absolute paths in HTML files. Default is relative
      paths
    default: false
    inputBinding:
      position: 101
      prefix: --plot-abs-paths
  - id: plot_pdf
    type:
      - 'null'
      - boolean
    doc: Also output .png plots as .pdf in plotting subfolder
    default: false
    inputBinding:
      position: 101
      prefix: --plot-pdf
  - id: sort_js_mode
    type:
      - 'null'
      - int
    doc: 'Define how to provide sorttable.js file. 1: link to packaged .js file. 2:
      copy .js file to output folder. 3: include .js code in HTML'
    default: 1
    inputBinding:
      position: 101
      prefix: --sort-js-mode
  - id: use_regions
    type:
      - 'null'
      - boolean
    doc: Use genomic regions as --in / --ctrl-in input site IDs instead of BED 
      col4 IDs
    default: false
    inputBinding:
      position: 101
      prefix: --use-regions
  - id: wrs_mode
    type:
      - 'null'
      - int
    doc: 'Defines Wilcoxon rank-sum test alternative hypothesis for testing whether
      --in sites have significantly different average conservation scores compared
      to --ctrl-in sites. 1: test for higher (greater) scores, 2: test for lower (less)
      scores'
    default: 1
    inputBinding:
      position: 101
      prefix: --wrs-mode
outputs:
  - id: output_folder
    type: Directory
    doc: Results output folder
    outputBinding:
      glob: $(inputs.output_folder)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
