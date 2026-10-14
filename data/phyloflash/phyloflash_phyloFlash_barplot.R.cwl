cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloFlash_barplot.R
label: phyloflash_phyloFlash_barplot.R
doc: "Generate a barplot of NTU abundances by sample.\n\nTool homepage: https://hrgv.github.io/phyloFlash/"
inputs:
  - id: toptaxa
    type:
      - 'null'
      - int
    doc: "Number of taxa to display in the barplot. By default takes the top 10 by total proportional abundance in the library"
    inputBinding:
      position: 1
      prefix: "--toptaxa="
      separate: false
  - id: file
    type: File
    doc: "CSV file containing three columns: Taxon, sample, and counts"
    inputBinding:
      position: 1
      prefix: "--file="
      separate: false
  - id: out
    type: string
    doc: "Name of output PDF or PNG file"
    inputBinding:
      position: 1
      prefix: "--out="
      separate: false
  - id: palette
    type:
      - 'null'
      - string
    doc: "Palette name for taxon colors. One of the qualitative palettes from the ColorBrewer2 set: Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, or Set3."
    inputBinding:
      position: 1
      prefix: "--palette="
      separate: false
  - id: subset
    type:
      - 'null'
      - string
    doc: "Display only subset from this taxon (e.g. show only Bacteria). Supply full taxon string prefix, excluding trailing semicolon."
    inputBinding:
      position: 1
      prefix: "--subset="
      separate: false
  - id: rawval
    type:
      - 'null'
      - boolean
    doc: "Plot raw counts rather than proportions"
    inputBinding:
      position: 1
      prefix: "--rawval"
  - id: scaleplotwidth
    type:
      - 'null'
      - float
    doc: "Change the plot width by this scaling factor (e.g. 2 makes it twice as wide). Allows adjustment when bars are hidden because the legend labels are too long."
    inputBinding:
      position: 1
      prefix: "--scaleplotwidth="
      separate: false
outputs:
  - id: barplot
    type:
      - 'null'
      - File
    doc: "Barplot (png or pdf)"
    outputBinding:
      glob: "$(inputs.out)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
stdout: phyloflash_phyloFlash_barplot.R.out
