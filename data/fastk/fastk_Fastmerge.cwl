cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fastmerge
label: fastk_Fastmerge
doc: "Merges FastK histograms or k-mer tables of different runs by adding the counts of equal k-mers.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
inputs:
  - id: source_files
    type: File[]
    doc: 'Source histogram, table or profile files to merge: stubs (.hist, .ktab, .prof) and their hidden part files.'
  - id: sources
    type: string[]
    doc: Names of the source stubs (as in source_files).
    inputBinding:
      position: 101
  - id: target
    type: string
    doc: Name of the merged output (without extension).
    inputBinding:
      position: 100
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: Produce a merged histogram.
    inputBinding:
      position: 50
      prefix: '-h'
  - id: table
    type:
      - 'null'
      - boolean
    doc: Produce a merged k-mer table.
    inputBinding:
      position: 50
      prefix: '-t'
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Use -T threads. [default: 4]'
    inputBinding:
      position: 50
      prefix: '-T'
      separate: false
  - id: parts_per_thread
    type:
      - 'null'
      - int
    doc: 'Produce # parts per thread. [default: 1]'
    inputBinding:
      position: 50
      prefix: '#'
      separate: false
  - id: cache_dir
    type:
      - 'null'
      - string
    doc: 'Cache table inputs to this directory. [default: /tmp]'
    inputBinding:
      position: 50
      prefix: '-P'
      separate: false
  - id: slice
    type:
      - 'null'
      - string
    doc: 'Divide into D slices and do slice N in [1,D]: <N>of<D>.'
    inputBinding:
      position: 50
      prefix: '-S'
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: merged_files
    type:
      type: array
      items: File
    doc: Merged outputs.
    outputBinding:
      glob: |
        ${
          var s = inputs.target;
          return [s + '.hist', s + '.ktab', s + '.prof', '.' + s + '.ktab.*', '.' + s + '.prof.*', '.' + s + '.pidx.*'];
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.source_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Fastmerge.out
