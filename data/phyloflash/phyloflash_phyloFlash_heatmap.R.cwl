cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phyloFlash_heatmap.R
label: phyloflash_phyloFlash_heatmap.R
doc: "Generates a heatmap plot from multiple phyloFlash result sets.\n\nTool homepage: https://hrgv.github.io/phyloFlash/"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Be more talkative"
    inputBinding:
      position: 1
      prefix: "--verbose"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Be less talkative"
    inputBinding:
      position: 1
      prefix: "--quiet"
  - id: debug
    type:
      - 'null'
      - boolean
    doc: "Show debug messages"
    inputBinding:
      position: 1
      prefix: "--debug"
  - id: min_ntu_count
    type:
      - 'null'
      - int
    doc: "Sum NTUs with less counts in pseudo NTU \"Other\". Default 50."
    inputBinding:
      position: 1
      prefix: "--min-ntu-count="
      separate: false
  - id: no_split
    type:
      - 'null'
      - boolean
    doc: "Do not split heatmap"
    inputBinding:
      position: 1
      prefix: "--no-split"
  - id: split_regex
    type:
      - 'null'
      - string
    doc: "Split heatmap using this regex on taxa. Multiple regex can be specified comma separated. Default 'Eukaryota'"
    inputBinding:
      position: 1
      prefix: "--split-regex="
      separate: false
  - id: long_taxnames
    type:
      - 'null'
      - boolean
    doc: "Do not shorten taxa names to last two groups"
    inputBinding:
      position: 1
      prefix: "--long-taxnames"
  - id: absolute
    type:
      - 'null'
      - boolean
    doc: "Do not scale columns to percentages"
    inputBinding:
      position: 1
      prefix: "--absolute"
  - id: cluster_samples
    type:
      - 'null'
      - string
    doc: "Use this method for clustering/sorting samples. Can be: alpha, ward.D, single, complete, average, mcquitty, median, centroid, or custom. Default is ward.D."
    inputBinding:
      position: 1
      prefix: "--cluster-samples="
      separate: false
  - id: cluster_taxa
    type:
      - 'null'
      - string
    doc: "Use this method for clustering/sorting taxa. Can be: alpha, ward.D, single, complete, average, mcquitty, median or centroid. Default is ward.D"
    inputBinding:
      position: 1
      prefix: "--cluster-taxa="
      separate: false
  - id: rows
    type:
      - 'null'
      - string
    doc: "Component rows, in order, to render (separated by commas). Valid terms are: tree, map, chao and labels. Default is tree,map,chao,labels."
    inputBinding:
      position: 1
      prefix: "--rows="
      separate: false
  - id: cols
    type:
      - 'null'
      - string
    doc: "Component columns, in order, to render (separated by commas). Valid terms are: labels, map and tree. Default is labels,map,tree."
    inputBinding:
      position: 1
      prefix: "--cols="
      separate: false
  - id: colors
    type:
      - 'null'
      - string
    doc: "Colors for heatmaps. Default is steelblue,indianred,green,orange."
    inputBinding:
      position: 1
      prefix: "--colors="
      separate: false
  - id: out
    type: string
    doc: "Name of output file. Must end in .png or .pdf. Default is out.png."
    default: "out.png"
    inputBinding:
      position: 1
      prefix: "--out="
      separate: false
  - id: aa
    type:
      - 'null'
      - string
    doc: "Type of anti-aliasing to use for PNG output. Can be one of default, none, gray, or subpixel. Default is gray."
    inputBinding:
      position: 1
      prefix: "--aa="
      separate: false
  - id: out_size
    type:
      - 'null'
      - string
    doc: "Size of output graphic in pixels (e.g. 100x100). Assumes 72 DPI for PDF. Using \"auto\" for a dimension will attempt to guess at suitable size. Default autoXauto"
    inputBinding:
      position: 1
      prefix: "--out-size="
      separate: false
  - id: library_name_from_file
    type:
      - 'null'
      - boolean
    doc: "Use the filename to derive library name instead of parsing ...report.csv"
    inputBinding:
      position: 1
      prefix: "--library-name-from-file"
  - id: custom_distance_matrix_sample
    type:
      - 'null'
      - File
    doc: "Import custom distance matrix for samples instead of calculating from abundance matrix"
    inputBinding:
      position: 1
      prefix: "--custom-distance-matrix-sample="
      separate: false
  - id: files
    type:
      type: array
      items: File
      inputBinding:
        valueFrom: $(self.basename)
    doc: "phyloFlash result files (for example *.phyloFlash.NTUabundance.csv). They are staged in the working directory"
    inputBinding:
      position: 2
outputs:
  - id: heatmap
    type:
      - 'null'
      - File
    doc: "Heatmap (png or pdf)"
    outputBinding:
      glob: "$(inputs.out)"
  - id: stdout
    type: stdout
    doc: "Standard output"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyloflash:3.4.2--hdfd78af_0
stdout: phyloflash_phyloFlash_heatmap.R.out
