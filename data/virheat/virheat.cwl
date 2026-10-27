cwlVersion: v1.2
class: CommandLineTool
baseCommand: virheat
label: virheat
doc: "Generates a heatmap visualization of genetic variants.\n\nTool homepage: https://github.com/jonas-fuchs/virHEAT"
inputs:
  - id: input_folder
    type: Directory
    doc: Folder containing input files (vcf/tsv)
    inputBinding:
      position: 1
  - id: delete
    type:
      - 'null'
      - boolean
    doc: Delete mutations that are present in all samples and their maximum 
      frequency divergence is smaller than 0.5
    inputBinding:
      position: 102
      prefix: --delete
  - id: delete_n
    type:
      - 'null'
      - string
    doc: 'Do not show mutations that occur n times or less (default: Do not delete)'
    inputBinding:
      position: 102
      prefix: --delete-n
  - id: gene_arrows
    type:
      - 'null'
      - boolean
    doc: Show genes as arrows
    inputBinding:
      position: 102
      prefix: --gene-arrows
  - id: genome_length
    type:
      - 'null'
      - int
    doc: Length of the genome (needed if gff3 is not provided)
    inputBinding:
      position: 102
      prefix: --genome-length
  - id: gff3_annotations
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Annotations to display from gff3 file (standard: gene). Multiple possible.'
    inputBinding:
      position: 102
      prefix: --gff3-annotations
  - id: gff3_path
    type:
      - 'null'
      - File
    doc: Path to gff3 (needed if length is not provided)
    inputBinding:
      position: 102
      prefix: --gff3-path
  - id: min_cov
    type:
      - 'null'
      - int
    doc: Display mutations covered at least x time (only if per base cov tsv 
      files are provided)
    inputBinding:
      position: 102
      prefix: --min-cov
  - id: no_delete
    type:
      - 'null'
      - boolean
    doc: Do not delete mutations that are present in all samples and their 
      maximum frequency divergence is smaller than 0.5
    inputBinding:
      position: 102
      prefix: --no-delete
  - id: no_gene_arrows
    type:
      - 'null'
      - boolean
    doc: Do not show genes as arrows
    inputBinding:
      position: 102
      prefix: --no-gene-arrows
  - id: no_sort
    type:
      - 'null'
      - boolean
    doc: Do not sort sample names alphanumerically
    inputBinding:
      position: 102
      prefix: --no-sort
  - id: plot_name
    type:
      - 'null'
      - string
    doc: Plot name and file type (pdf, png, svg, jpg)
    inputBinding:
      position: 102
      prefix: --name
  - id: output_dir_path
    type: string
    doc: Output directory (second positional argument; the plot is written into it)
    inputBinding:
      position: 2
  - id: reference_id
    type: string
    doc: Reference identifier
    inputBinding:
      position: 102
      prefix: --reference
  - id: scores
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Experimental setting (specific for SARS-CoV-2)! Give four values: the scores CSV file name, its column for amino-acid positions, its column for scores, and a descriptive score name. The CSV file must be staged in the working directory (see scores_file).'
    inputBinding:
      position: 102
      prefix: --scores
  - id: scores_file
    type:
      - 'null'
      - File
    doc: Scores CSV file named in the scores option; it is staged in the working directory.
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort sample names alphanumerically
    inputBinding:
      position: 102
      prefix: --sort
  - id: threshold
    type:
      - 'null'
      - float
    doc: Display variant frequencies between upper and lower thresholds (0-1)
    inputBinding:
      position: 102
      prefix: --threshold
  - id: zoom
    type:
      - 'null'
      - type: array
        items: string
    doc: Restrict the plot to a specific genomic region
    inputBinding:
      position: 102
      prefix: --zoom
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the heatmap plot
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: "${ var l = []; if (inputs.scores_file) { l.push(inputs.scores_file); } return l; }"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virheat:0.7.6--pyhdfd78af_0
