cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tombo
  - plot
  - roc
label: ont-tombo_plot_roc
doc: "Plot ROC curve from known motif(s).\n\nTool homepage: https://github.com/nanoporetech/tombo"
inputs:
  - id: statistics_filenames
    type:
      type: array
      items: File
    doc: "Files to load genomic base anchored statistics."
    inputBinding:
      position: 101
      prefix: "--statistics-filenames"
  - id: modified_locations
    type:
      - 'null'
      - type: array
        items: File
    doc: "Modification description and bed format files containing single base locations of ground truth modified sites. Bed files should contain 6 fields including strand. Format descriptions as \"mod_name:locs.bed\". Example: \"CpG bisulfite\":bisulfite_locs.bed"
    inputBinding:
      position: 101
      prefix: "--modified-locations"
  - id: unmodified_locations
    type:
      - 'null'
      - type: array
        items: File
    doc: "Bed format files containing single base locations of ground truth unmodified sites. Bed files should contain 6 fields including strand."
    inputBinding:
      position: 101
      prefix: "--unmodified-locations"
  - id: motif_descriptions
    type:
      - 'null'
      - type: array
        items: string
    doc: "Ground truth, motif centered, modified base descriptions for computing ROC and PR curves. Each statistics file is associated with a set of motif descriptions. Format descriptions as: \"motif:mod_pos:name[::motif2:mod_pos2:name2...]\". mod_pos indicates the alternate-base within the motif (1-based index). Example: CCWGG:2:\"dcm 5mC\"::GATC:2:\"dam 6mA\" would assess the performance of a single Tombo statistics file for identification of E. coli dam and dcm methylation."
    inputBinding:
      position: 101
      prefix: "--motif-descriptions"
  - id: genome_fasta
    type:
      - 'null'
      - File
    doc: "FASTA file used to re-squiggle. For faster sequence access."
    inputBinding:
      position: 101
      prefix: "--genome-fasta"
      valueFrom: "$(self.basename)"
  - id: pdf_filename
    type:
      - 'null'
      - string
    doc: "PDF filename to store plot(s). Default: tombo_results.roc.pdf"
    default: "tombo_results.roc.pdf"
    inputBinding:
      position: 101
      prefix: "--pdf-filename"
  - id: statistics_per_block
    type:
      - 'null'
      - int
    doc: "Number of randomly selected per-read, per-base statistics to extract from each genomic block for plotting. Default: Include all stats"
    inputBinding:
      position: 101
      prefix: "--statistics-per-block"
  - id: total_statistics_limit
    type:
      - 'null'
      - int
    doc: "Total per-read statistics to be extracted for plotting. Avoids memory overflow for large runs. Default: 5000000"
    inputBinding:
      position: 101
      prefix: "--total-statistics-limit"
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Don't print status information."
    inputBinding:
      position: 101
      prefix: "--quiet"
outputs:
  - id: plot_pdf
    type: File
    doc: "PDF with the plots"
    outputBinding:
      glob: "$(inputs.pdf_filename)"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_fasta)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0
