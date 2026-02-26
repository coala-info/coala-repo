cwlVersion: v1.2
class: CommandLineTool
baseCommand: orsum.py
label: orsum_orsum.py
doc: "orsum summarizes enrichment results\n\nTool homepage: https://github.com/ozanozisik/orsum/"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Paths of the enrichment result files.
    inputBinding:
      position: 1
  - id: file_aliases
    type:
      - 'null'
      - type: array
        items: string
    doc: Aliases for input enrichment result files to be used in orsum results
    inputBinding:
      position: 102
      prefix: --fileAliases
  - id: gmt
    type: File
    doc: Path of the GMT file.
    inputBinding:
      position: 102
      prefix: --gmt
  - id: max_rep_size
    type:
      - 'null'
      - float
    doc: The maximum size of a representative term. Terms larger than this will 
      not be discarded but also will not be used to represent other terms. By 
      default, it is larger than any annotation term (1E6), which means that it 
      has no effect.
    default: '1E6'
    inputBinding:
      position: 102
      prefix: --maxRepSize
  - id: max_term_size
    type:
      - 'null'
      - float
    doc: The maximum size of the terms to be processed. Larger terms will be 
      discarded. By default, it is larger than any annotation term (1E6), which 
      means that it has no effect.
    default: '1E6'
    inputBinding:
      position: 102
      prefix: --maxTermSize
  - id: min_term_size
    type:
      - 'null'
      - int
    doc: The minimum size of the terms to be processed. Smaller terms will be 
      discarded. By default, minTermSize = 10
    default: 10
    inputBinding:
      position: 102
      prefix: --minTermSize
  - id: number_of_terms_to_plot
    type:
      - 'null'
      - int
    doc: The number of representative terms to be presented in barplot and 
      heatmap. By default (and maximum), numberOfTermsToPlot = 50
    default: 50
    inputBinding:
      position: 102
      prefix: --numberOfTermsToPlot
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Path for the output result files. If it is not specified, results are 
      written to the current directory.
    inputBinding:
      position: 102
      prefix: --outputFolder
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/orsum:1.8.0--hdfd78af_0
stdout: orsum_orsum.py.out
