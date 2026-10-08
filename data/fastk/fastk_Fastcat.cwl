cwlVersion: v1.2
class: CommandLineTool
baseCommand: Fastcat
label: fastk_Fastcat
doc: "Concatenates FastK histograms, tables or profiles of different runs into one.\n\nTool homepage: https://github.com/thegenemyers/FASTK"
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
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print progress as you go.
    inputBinding:
      position: 50
      prefix: '-v'
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep source files (requires copying all parts).
    inputBinding:
      position: 50
      prefix: '-k'
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
  - id: profile
    type:
      - 'null'
      - boolean
    doc: Produce a merged profile.
    inputBinding:
      position: 50
      prefix: '-p'
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
      - entry: $(inputs.source_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastk:1.2--h71df26d_1
stdout: fastk_Fastcat.out
