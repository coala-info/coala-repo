cwlVersion: v1.2
class: CommandLineTool
baseCommand: caspeak_plot
label: caspeak_plot
doc: "Plot MAF files\n\nTool homepage: https://github.com/Rye-lxy/CasPeak"
inputs:
  - id: alignments
    type:
      - 'null'
      - File
    doc: secondary alignments
    inputBinding:
      position: 101
      prefix: --alignments
  - id: bed1
    type:
      - 'null'
      - File
    doc: read genome1 annotations
    inputBinding:
      position: 101
      prefix: --bed1
  - id: bed2
    type:
      - 'null'
      - File
    doc: read genome2 annotations
    inputBinding:
      position: 101
      prefix: --bed2
  - id: border_color
    type:
      - 'null'
      - string
    doc: color for pixels between sequences
    default: black
    inputBinding:
      position: 101
      prefix: --border-color
  - id: border_pixels
    type:
      - 'null'
      - int
    doc: number of pixels between sequences
    default: 1
    inputBinding:
      position: 101
      prefix: --border-pixels
  - id: bridged_color
    type:
      - 'null'
      - string
    doc: color for bridged gaps
    default: yellow
    inputBinding:
      position: 101
      prefix: --bridged-color
  - id: cds_color
    type:
      - 'null'
      - string
    doc: color for protein-coding regions
    default: LimeGreen
    inputBinding:
      position: 101
      prefix: --cds-color
  - id: exon_color
    type:
      - 'null'
      - string
    doc: color for exons
    default: PaleGreen
    inputBinding:
      position: 101
      prefix: --exon-color
  - id: fontfile
    type:
      - 'null'
      - File
    doc: TrueType or OpenType font file
    inputBinding:
      position: 101
      prefix: --fontfile
  - id: fontsize
    type:
      - 'null'
      - string
    doc: TrueType or OpenType font size
    default: '14'
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: forwardcolor
    type:
      - 'null'
      - string
    doc: color for forward alignments
    default: red
    inputBinding:
      position: 101
      prefix: --forwardcolor
  - id: gap1
    type:
      - 'null'
      - File
    doc: read genome1 annotations
    inputBinding:
      position: 101
      prefix: --gap1
  - id: gap2
    type:
      - 'null'
      - File
    doc: read genome2 annotations
    inputBinding:
      position: 101
      prefix: --gap2
  - id: genePred1
    type:
      - 'null'
      - File
    doc: read genome1 annotations
    inputBinding:
      position: 101
      prefix: --genePred1
  - id: genePred2
    type:
      - 'null'
      - File
    doc: read genome2 annotations
    inputBinding:
      position: 101
      prefix: --genePred2
  - id: height
    type:
      - 'null'
      - int
    doc: maximum height in pixels
    default: 1000
    inputBinding:
      position: 101
      prefix: --height
  - id: join
    type:
      - 'null'
      - int
    doc: 'join: 0=nothing, 1=alignments adjacent in genome1, 2=alignments adjacent
      in genome2'
    default: 0
    inputBinding:
      position: 101
      prefix: --join
  - id: labels1
    type:
      - 'null'
      - int
    doc: 'genome1 labels: 0=name, 1=name:length, 2=name:start:length, 3=name:start-end'
    default: 0
    inputBinding:
      position: 101
      prefix: --labels1
  - id: labels2
    type:
      - 'null'
      - int
    doc: 'genome2 labels: 0=name, 1=name:length, 2=name:start:length, 3=name:start-end'
    default: 0
    inputBinding:
      position: 101
      prefix: --labels2
  - id: maf
    type: File
    doc: the maf file to plot (required)
    inputBinding:
      position: 101
      prefix: --maf
  - id: margin_color
    type:
      - 'null'
      - string
    doc: margin color
    inputBinding:
      position: 101
      prefix: --margin-color
  - id: max_gap1
    type:
      - 'null'
      - float
    doc: 'maximum unaligned (end,mid) gap in genome1: fraction of aligned length'
    default: 1,4
    inputBinding:
      position: 101
      prefix: --max-gap1
  - id: max_gap2
    type:
      - 'null'
      - float
    doc: 'maximum unaligned (end,mid) gap in genome2: fraction of aligned length'
    default: 1,4
    inputBinding:
      position: 101
      prefix: --max-gap2
  - id: maxseqs
    type:
      - 'null'
      - int
    doc: maximum number of horizontal or vertical sequences
    default: 100
    inputBinding:
      position: 101
      prefix: --maxseqs
  - id: pad
    type:
      - 'null'
      - float
    doc: 'pad length when cutting unaligned gaps: fraction of aligned length'
    default: 0.04
    inputBinding:
      position: 101
      prefix: --pad
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix of the output figure name
    default: fig/peak
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reversecolor
    type:
      - 'null'
      - string
    doc: color for reverse alignments
    default: blue
    inputBinding:
      position: 101
      prefix: --reversecolor
  - id: rmsk1
    type:
      - 'null'
      - File
    doc: read genome1 annotations
    inputBinding:
      position: 101
      prefix: --rmsk1
  - id: rmsk2
    type:
      - 'null'
      - File
    doc: read genome2 annotations
    inputBinding:
      position: 101
      prefix: --rmsk2
  - id: rot1
    type:
      - 'null'
      - string
    doc: text rotation for the 1st genome
    default: h
    inputBinding:
      position: 101
      prefix: --rot1
  - id: rot2
    type:
      - 'null'
      - string
    doc: text rotation for the 2nd genome
    default: v
    inputBinding:
      position: 101
      prefix: --rot2
  - id: seq1
    type:
      - 'null'
      - string
    doc: which sequences to show from the 1st genome
    inputBinding:
      position: 101
      prefix: --seq1
  - id: seq2
    type:
      - 'null'
      - string
    doc: which sequences to show from the 2nd genome
    inputBinding:
      position: 101
      prefix: --seq2
  - id: sort1
    type:
      - 'null'
      - int
    doc: 'genome1 sequence order: 0=input order, 1=name order, 2=length order, 3=alignment
      order'
    default: 1
    inputBinding:
      position: 101
      prefix: --sort1
  - id: sort2
    type:
      - 'null'
      - int
    doc: 'genome2 sequence order: 0=input order, 1=name order, 2=length order, 3=alignment
      order'
    default: 1
    inputBinding:
      position: 101
      prefix: --sort2
  - id: strands1
    type:
      - 'null'
      - int
    doc: 'genome1 sequence orientation: 0=forward orientation, 1=alignment orientation'
    default: 0
    inputBinding:
      position: 101
      prefix: --strands1
  - id: strands2
    type:
      - 'null'
      - int
    doc: 'genome2 sequence orientation: 0=forward orientation, 1=alignment orientation'
    default: 0
    inputBinding:
      position: 101
      prefix: --strands2
  - id: unbridged_color
    type:
      - 'null'
      - string
    doc: color for unbridged gaps
    default: orange
    inputBinding:
      position: 101
      prefix: --unbridged-color
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: show progress messages and data
    inputBinding:
      position: 101
      prefix: --verbose
  - id: width
    type:
      - 'null'
      - int
    doc: maximum width in pixels
    default: 1000
    inputBinding:
      position: 101
      prefix: --width
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/caspeak:1.1.5--pyhdfd78af_0
stdout: caspeak_plot.out
