cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mumemto, viz]
label: mumemto_viz
doc: "Plots a synteny plot of MUMs from mumemto.\n\nTool homepage: https://github.com/vikshiv/mumemto"
inputs:
  - id: mums
    type: File
    doc: "Path to the *.mums file from mumemto"
    inputBinding:
      position: 100
      prefix: --mums
  - id: lengths
    type:
      - 'null'
      - File
    doc: "Lengths file, first column is the sequence length in the order of the filelist"
    inputBinding:
      position: 100
      prefix: --lengths
  - id: filelist
    type:
      - 'null'
      - File
    doc: Filelist that defines the order of sequences in the plot; first column is the full path from the lengths file
    inputBinding:
      position: 100
      prefix: --filelist
  - id: labels
    type:
      - 'null'
      - File
    doc: "Labels for each sequence in the plot, one per line, in the order of the filelist or lengths file"
    inputBinding:
      position: 100
      prefix: --labels
  - id: len_filter
    type:
      - 'null'
      - int
    doc: Only plot MUMs longer than this threshold
    inputBinding:
      position: 100
      prefix: --len-filter
  - id: subsample
    type:
      - 'null'
      - int
    doc: Subsample every Nth MUM
    inputBinding:
      position: 100
      prefix: --subsample
  - id: center
    type:
      - 'null'
      - boolean
    doc: Center the plot
    inputBinding:
      position: 100
      prefix: --center
  - id: inversion_color
    type:
      - 'null'
      - string
    doc: Color for inversions
    inputBinding:
      position: 100
      prefix: --inversion-color
  - id: mum_color
    type:
      - 'null'
      - string
    doc: "Color as hex (default: #00A2FF)"
    inputBinding:
      position: 100
      prefix: --mum-color
  - id: alpha
    type:
      - 'null'
      - float
    doc: "Opacity of MUMs, 0 to 1 (default: 0.8 for blocks, 0.1 for MUMs)"
    inputBinding:
      position: 100
      prefix: --alpha
  - id: linewidth
    type:
      - 'null'
      - float
    doc: "Line width of MUMs (default: 0 for blocks, 0.05 for MUMs)"
    inputBinding:
      position: 100
      prefix: --linewidth
  - id: fout
    type: string
    doc: "Plot file name; .png is added when no .png, .pdf or .svg ending is given. A name without a directory part gets ./ in front so the plot is written to the working directory"
    inputBinding:
      position: 100
      prefix: --fout
      valueFrom: "$(self.indexOf('/') < 0 ? './' + self : self)"
  - id: dims
    type:
      - 'null'
      - type: array
        items: float
    doc: "Figure dimensions in inches, width and height (default: 6.4 4.8)"
    inputBinding:
      position: 100
      prefix: --dims
  - id: region
    type:
      - 'null'
      - type: array
        items: int
    doc: "Genomic region to zoom in, two global coordinates (contigs are concatenated)"
    inputBinding:
      position: 100
      prefix: --region
  - id: dpi
    type:
      - 'null'
      - int
    doc: Dots per inch of the figure
    inputBinding:
      position: 100
      prefix: --dpi
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode
    inputBinding:
      position: 100
      prefix: --verbose
  - id: no_coll_block
    type:
      - 'null'
      - boolean
    doc: "Plot only MUMs, not collinear blocks (slower)"
    inputBinding:
      position: 100
      prefix: --no-coll-block
  - id: max_gap_len
    type:
      - 'null'
      - int
    doc: "Maximum break between collinear MUMs within a collinear block (default: less than 1 pixel)"
    inputBinding:
      position: 100
      prefix: --max-gap-len
  - id: mode
    type:
      - 'null'
      - string
    doc: "Plotting mode for multi-FASTA inputs: normal, delineated or gapped (default: normal)"
    inputBinding:
      position: 100
      prefix: --mode
  - id: spacer
    type:
      - 'null'
      - float
    doc: "Spacer between contigs as a proportion (0 to 1) of the largest contig length (default: 0.1)"
    inputBinding:
      position: 100
      prefix: --spacer
outputs:
  - id: plots
    type:
      type: array
      items: File
    doc: Plot files written by mumemto viz
    outputBinding:
      glob: "$(inputs.fout)*"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mumemto:1.3.4--py310h275bdba_0
