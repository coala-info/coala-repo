cwlVersion: v1.2
class: CommandLineTool
baseCommand: WhatsGNU_plotter.py
label: whatsgnu_plotter
doc: "WhatsGNU plotter script: heatmaps, histograms, metadata barplots and volcano
  plots from WhatsGNU reports.\n\nTool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs:
  - id: prefix_name
    type: string
    doc: prefix name for the the output folder and heatmap/volcano output files
    inputBinding:
      position: 100
  - id: directory_path
    type: Directory
    doc: path to directory of WhatsGNU reports (staged as input_dir; the tool creates
      its output folder beside the input directory)
    inputBinding:
      position: 101
      valueFrom: input_dir/
  - id: heatmap
    type:
      - 'null'
      - string
    doc: 'heatmap of GNU scores for orthologous genes in multiple isolates (ortholog or basic)'
    inputBinding:
      position: 1
      prefix: --heatmap
  - id: list_genes
    type:
      - 'null'
      - File
    doc: 'a txt file of ortholog group names from one of the WhatsGNU reports for heatmap'
    inputBinding:
      position: 1
      prefix: --list_genes
  - id: fasta
    type:
      - 'null'
      - File
    doc: 'a FASTA file of sequences for the proteins of interest for heatmap or metadata barplot'
    inputBinding:
      position: 1
      prefix: --fasta
  - id: output_blastp
    type:
      - 'null'
      - boolean
    doc: 'get the output report of blastp run, it has to be used with --fasta'
    inputBinding:
      position: 1
      prefix: --output_blastp
  - id: strains_order
    type:
      - 'null'
      - File
    doc: 'list of strains order for heatmap'
    inputBinding:
      position: 1
      prefix: --strains_order
  - id: rarity
    type:
      - 'null'
      - boolean
    doc: 'Annotate heatmap cells with OVRI (default off)'
    inputBinding:
      position: 1
      prefix: --rarity
  - id: rarity_color
    type:
      - 'null'
      - string
    doc: 'OVRI data text color in the heatmap'
    inputBinding:
      position: 1
      prefix: --rarity_color
  - id: figure_size
    type:
      - 'null'
      - type: array
        items: float
    doc: 'heatmap width and height in inches w,h, respectively'
    inputBinding:
      position: 1
      prefix: --figure_size
  - id: heatmap_color
    type:
      - 'null'
      - string
    doc: 'heatmap color'
    inputBinding:
      position: 1
      prefix: --heatmap_color
  - id: masked_color
    type:
      - 'null'
      - string
    doc: 'missing data color in heatmap'
    inputBinding:
      position: 1
      prefix: --masked_color
  - id: font_size
    type:
      - 'null'
      - int
    doc: 'heatmap font size'
    inputBinding:
      position: 1
      prefix: --font_size
  - id: title
    type:
      - 'null'
      - string
    doc: 'title for the heatmap [Default WhatsGNU heatmap]'
    inputBinding:
      position: 1
      prefix: --title
  - id: metadata_barplot
    type:
      - 'null'
      - string
    doc: 'Metadata percentage distribution for proteins in a FASTA file (ortholog or basic)'
    inputBinding:
      position: 1
      prefix: --metadata_barplot
  - id: all_metadata
    type:
      - 'null'
      - boolean
    doc: 'all metadata'
    inputBinding:
      position: 1
      prefix: --all_metadata
  - id: select_metadata
    type:
      - 'null'
      - string
    doc: 'select some metadata'
    inputBinding:
      position: 1
      prefix: --select_metadata
  - id: histogram
    type:
      - 'null'
      - boolean
    doc: 'histogram of GNU scores'
    inputBinding:
      position: 1
      prefix: --histogram
  - id: histogram_color
    type:
      - 'null'
      - string
    doc: 'histogram color'
    inputBinding:
      position: 1
      prefix: --histogram_color
  - id: histogram_bins
    type:
      - 'null'
      - int
    doc: 'number of bins for the histograms [10]'
    inputBinding:
      position: 1
      prefix: --histogram_bins
  - id: novel_conserved
    type:
      - 'null'
      - type: array
        items: int
    doc: 'upper and lower GNU score limits for novel and conserved proteins [Default 10, 100]'
    inputBinding:
      position: 1
      prefix: --novel_conserved
  - id: strains_tag_volcano
    type:
      - 'null'
      - File
    doc: 'a csv file of the strains of the two groups to be compared with (case/control) tag'
    inputBinding:
      position: 1
      prefix: --strains_tag_volcano
  - id: cutoff_volcano
    type:
      - 'null'
      - float
    doc: 'a percentage of isolates a protein must be in [Default 100]'
    inputBinding:
      position: 1
      prefix: --cutoff_volcano
  - id: case_control_name
    type:
      - 'null'
      - type: array
        items: string
    doc: 'case and control groups names [Default case control]'
    inputBinding:
      position: 1
      prefix: --case_control_name
outputs:
  - id: output_folder
    type: Directory
    doc: Output folder (named after prefix_name) with plots and tables
    outputBinding:
      glob: $(inputs.prefix_name)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: input_dir
        entry: $(inputs.directory_path)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
