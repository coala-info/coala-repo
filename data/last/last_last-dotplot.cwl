cwlVersion: v1.2
class: CommandLineTool
baseCommand: last-dotplot
label: last_last-dotplot
doc: Draw a dotplot of pair-wise sequence alignments.
inputs:
  - id: alignments
    type: File
    doc: maf-or-psl-or-tab-alignments
    inputBinding:
      position: 1
  - id: output_plot
    type: string
    doc: Output dotplot image (e.g., dotplot.png, gif, etc.)
    inputBinding:
      position: 2
  - id: width
    type:
      - 'null'
      - int
    doc: maximum width in pixels
    inputBinding:
      position: 103
      prefix: --width
  - id: height
    type:
      - 'null'
      - int
    doc: maximum height in pixels
    inputBinding:
      position: 103
      prefix: --height
  - id: maxseqs
    type:
      - 'null'
      - int
    doc: maximum number of horizontal or vertical sequences
    inputBinding:
      position: 103
      prefix: --maxseqs
  - id: seq1
    type:
      - 'null'
      - string
    doc: which sequences to show from the 1st genome
    inputBinding:
      position: 103
      prefix: --seq1
  - id: seq2
    type:
      - 'null'
      - string
    doc: which sequences to show from the 2nd genome
    inputBinding:
      position: 103
      prefix: --seq2
  - id: alignments_secondary
    type:
      - 'null'
      - File
    doc: secondary alignments
    inputBinding:
      position: 103
      prefix: --alignments
  - id: sort1
    type:
      - 'null'
      - int
    doc: 'genome1 sequence order: 0=input order, 1=name order, 2=length order, 3=alignment
      order'
    inputBinding:
      position: 103
      prefix: --sort1
  - id: sort2
    type:
      - 'null'
      - int
    doc: 'genome2 sequence order: 0=input order, 1=name order, 2=length order, 3=alignment
      order'
    inputBinding:
      position: 103
      prefix: --sort2
  - id: strands1
    type:
      - 'null'
      - int
    doc: 'genome1 sequence orientation: 0=forward orientation, 1=alignment orientation'
    inputBinding:
      position: 103
      prefix: --strands1
  - id: strands2
    type:
      - 'null'
      - int
    doc: 'genome2 sequence orientation: 0=forward orientation, 1=alignment orientation'
    inputBinding:
      position: 103
      prefix: --strands2
  - id: max_gap1
    type:
      - 'null'
      - string
    doc: 'maximum unaligned (end,mid) gap in genome1: fraction of aligned length'
    inputBinding:
      position: 103
      prefix: --max-gap1
  - id: max_gap2
    type:
      - 'null'
      - string
    doc: 'maximum unaligned (end,mid) gap in genome2: fraction of aligned length'
    inputBinding:
      position: 103
      prefix: --max-gap2
  - id: pad
    type:
      - 'null'
      - float
    doc: 'pad length when cutting unaligned gaps: fraction of aligned length'
    inputBinding:
      position: 103
      prefix: --pad
  - id: join
    type:
      - 'null'
      - int
    doc: 'join: 0=nothing, 1=alignments adjacent in genome1, 2=alignments adjacent
      in genome2'
    inputBinding:
      position: 103
      prefix: --join
  - id: border_pixels
    type:
      - 'null'
      - int
    doc: number of pixels between sequences
    inputBinding:
      position: 103
      prefix: --border-pixels
  - id: annotations1
    type:
      - 'null'
      - File
    doc: read genome1 annotations (accepts --bed1, --rmsk1, --genePred1, --gap1)
    inputBinding:
      position: 103
      prefix: --bed1
  - id: annotations2
    type:
      - 'null'
      - File
    doc: read genome2 annotations (accepts --bed2, --rmsk2, --genePred2, --gap2)
    inputBinding:
      position: 103
      prefix: --bed2
  - id: fontfile
    type:
      - 'null'
      - File
    doc: TrueType or OpenType font file
    inputBinding:
      position: 103
      prefix: --fontfile
  - id: fontsize
    type:
      - 'null'
      - int
    doc: TrueType or OpenType font size
    inputBinding:
      position: 103
      prefix: --fontsize
  - id: labels1
    type:
      - 'null'
      - int
    doc: 'genome1 labels: 0=name, 1=name:length, 2=name:start:length, 3=name:start-end'
    inputBinding:
      position: 103
      prefix: --labels1
  - id: labels2
    type:
      - 'null'
      - int
    doc: 'genome2 labels: 0=name, 1=name:length, 2=name:start:length, 3=name:start-end'
    inputBinding:
      position: 103
      prefix: --labels2
  - id: rot1
    type:
      - 'null'
      - string
    doc: text rotation for the 1st genome
    inputBinding:
      position: 103
      prefix: --rot1
  - id: rot2
    type:
      - 'null'
      - string
    doc: text rotation for the 2nd genome
    inputBinding:
      position: 103
      prefix: --rot2
  - id: forwardcolor
    type:
      - 'null'
      - string
    doc: color for forward alignments
    inputBinding:
      position: 103
      prefix: --forwardcolor
  - id: reversecolor
    type:
      - 'null'
      - string
    doc: color for reverse alignments
    inputBinding:
      position: 103
      prefix: --reversecolor
  - id: border_color
    type:
      - 'null'
      - string
    doc: color for pixels between sequences
    inputBinding:
      position: 103
      prefix: --border-color
  - id: margin_color
    type:
      - 'null'
      - string
    doc: margin color
    inputBinding:
      position: 103
      prefix: --margin-color
  - id: exon_color
    type:
      - 'null'
      - string
    doc: color for exons
    inputBinding:
      position: 103
      prefix: --exon-color
  - id: cds_color
    type:
      - 'null'
      - string
    doc: color for protein-coding regions
    inputBinding:
      position: 103
      prefix: --cds-color
  - id: bridged_color
    type:
      - 'null'
      - string
    doc: color for bridged gaps
    inputBinding:
      position: 103
      prefix: --bridged-color
  - id: unbridged_color
    type:
      - 'null'
      - string
    doc: color for unbridged gaps
    inputBinding:
      position: 103
      prefix: --unbridged-color
outputs:
  - id: out_output_plot
    type:
      type: array
      items: File
    doc: Output dotplot image (e.g., dotplot.png, gif, etc.)
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/last:1650--h5ca1c30_0
s:url: https://gitlab.com/mcfrith/last
$namespaces:
  s: https://schema.org/
