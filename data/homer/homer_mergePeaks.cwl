cwlVersion: v1.2
class: CommandLineTool
baseCommand: mergePeaks
label: homer_mergePeaks
doc: "Merge and/or compare peak and position files, with overlap statistics\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs:
  - id: peak_files
    type:
      type: array
      items: File
    doc: 'Primary peak file followed by additional peak/annotation files'
    inputBinding:
      position: 2
  - id: strand
    type:
      - 'null'
      - boolean
    doc: 'only merge/consider peaks on the same strand (default: either strand)'
    inputBinding:
      position: 1
      prefix: '-strand'
  - id: d
    type:
      - 'null'
      - string
    doc: 'maximum distance between peak centers to merge: a number or given (literal overlap of peak regions, default)'
    inputBinding:
      position: 1
      prefix: '-d'
  - id: file
    type:
      - 'null'
      - File
    doc: 'file listing the peak files to compare (for many peak files)'
    inputBinding:
      position: 1
      prefix: '-file'
  - id: gsize
    type:
      - 'null'
      - float
    doc: 'genome size for significance calculations (default: 2e9)'
    inputBinding:
      position: 1
      prefix: '-gsize'
  - id: prefix
    type:
      - 'null'
      - string
    doc: 'generate separate files for overlapping and unique peaks, named with this prefix (default: all peaks to standard output)'
    inputBinding:
      position: 1
      prefix: '-prefix'
  - id: matrix
    type:
      - 'null'
      - string
    doc: 'generate pairwise comparison statistics files with this name (.logPvalue.matrix.txt, .logRatio.matrix.txt, .count.matrix.txt)'
    inputBinding:
      position: 1
      prefix: '-matrix'
  - id: venn
    type:
      - 'null'
      - string
    doc: 'file name for the venn diagram numbers (default: standard error)'
    inputBinding:
      position: 1
      prefix: '-venn'
  - id: code
    type:
      - 'null'
      - boolean
    doc: 'report peak membership as binary code instead of file names'
    inputBinding:
      position: 1
      prefix: '-code'
  - id: cobound
    type:
      - 'null'
      - int
    doc: 'classify peaks by how many other peak files co-bind them: maximum number of co-bound peaks to consider (writes coBoundBy0.txt, coBoundBy1.txt, ...)'
    inputBinding:
      position: 1
      prefix: '-cobound'
  - id: filter
    type:
      - 'null'
      - string
    doc: 'single peak file mode: only analyze peaks within the range chrN:XXX-YYY'
    inputBinding:
      position: 1
      prefix: '-filter'
  - id: coverage
    type:
      - 'null'
      - string
    doc: 'output file with the total bp covered by each peak file (use with -d given)'
    inputBinding:
      position: 1
      prefix: '-coverage'
outputs:
  - id: merged_peaks
    type: stdout
    doc: 'Merged peaks (tab separated, written to standard output)'
  - id: prefix_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Separate files of overlapping and unique peaks (-prefix)'
    outputBinding:
      glob: $(inputs.prefix)*
  - id: matrix_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Pairwise comparison statistics files (-matrix)'
    outputBinding:
      glob: $(inputs.matrix).*
  - id: venn_file
    type:
      - 'null'
      - File
    doc: 'Venn diagram numbers (-venn)'
    outputBinding:
      glob: $(inputs.venn)
  - id: cobound_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Peaks co-bound by various numbers of peak files (-cobound)'
    outputBinding:
      glob: ["coBoundBy*.txt", "$(inputs.prefix).coBoundBy*"]
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: 'Total bp covered by each peak file (-coverage)'
    outputBinding:
      glob: $(inputs.coverage)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_mergePeaks.out
