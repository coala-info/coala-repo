cwlVersion: v1.2
class: CommandLineTool
baseCommand: rbpbench compare
label: rbpbench_compare
doc: "Compare motif search results from rbpbench.\n\nTool homepage: https://github.com/michauhl/RBPBench"
inputs:
  - id: input_data
    type:
      type: array
      items: string
    doc: Supply motif search results data, either as folders (--out folders of 
      rbpbench search or batch), or as files (both RBP and motif hit stats files
      needed!). Order of files does NOT matter
    inputBinding:
      position: 1
  - id: output_folder
    type: Directory
    doc: Comparison results output folder
    inputBinding:
      position: 2
  - id: plot_abs_paths
    type:
      - 'null'
      - boolean
    doc: Store plot files with absolute paths in HTML files. Default is relative
      paths
    default: false
    inputBinding:
      position: 103
      prefix: --plot-abs-paths
  - id: plot_pdf
    type:
      - 'null'
      - boolean
    doc: Also output .png plots as .pdf in plotting subfolder
    default: false
    inputBinding:
      position: 103
      prefix: --plot-pdf
  - id: sort_js_mode
    type:
      - 'null'
      - string
    doc: 'Define how to provide sorttable.js file. 1: link to packaged .js file. 2:
      copy .js file to plots output folder. 3: include .js code in HTML'
    default: 1
    inputBinding:
      position: 103
      prefix: --sort-js-mode
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rbpbench:1.1.0--pyhdfd78af_0
stdout: rbpbench_compare.out
