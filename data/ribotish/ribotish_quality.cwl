cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ribotish
  - quality
label: ribotish_quality
doc: "Quality control of riboseq bam files: P-site offset estimation and periodicity plots.\n\nTool homepage: https://github.com/zhpn1024/ribotish"
inputs:
  - id: ribo_bam_path
    type: File
    secondaryFiles:
      - .bai
    doc: "Riboseq bam file"
    inputBinding:
      position: 101
      prefix: '-b'
  - id: gene_path
    type:
      - 'null'
      - File
    doc: "Gene annotation file"
    inputBinding:
      position: 101
      prefix: '-g'
  - id: tis
    type:
      - 'null'
      - boolean
    doc: "The data is TIS enriched (for LTM & Harritonine)"
    inputBinding:
      position: 101
      prefix: '--tis'
  - id: input
    type:
      - 'null'
      - File
    doc: "Input previous output file, do not read gene file and bam file again"
    inputBinding:
      position: 101
      prefix: '-i'
  - id: gene_format
    type:
      - 'null'
      - string
    doc: "Gene annotation file format (gtf, bed, gpd, gff, default: auto)"
    inputBinding:
      position: 101
      prefix: '--geneformat'
  - id: chr_map
    type:
      - 'null'
      - File
    doc: "Input chromosome id mapping table file if annotation chr ids are not same as chr ids in bam/fasta files"
    inputBinding:
      position: 101
      prefix: '--chrmap'
  - id: output
    type:
      - 'null'
      - string
    doc: "Output data file (default: ribobampath[:-4]+ '_qual.txt')"
    inputBinding:
      position: 101
      prefix: '-o'
  - id: fig_pdf_path
    type:
      - 'null'
      - string
    doc: "Output pdf figure file (default: ribobampath[:-4]+ '_qual.pdf')"
    inputBinding:
      position: 101
      prefix: '-f'
  - id: para_path
    type:
      - 'null'
      - string
    doc: "Output offset parameter file (default: ribobampath[:-4]+ '.para.py')"
    inputBinding:
      position: 101
      prefix: '-r'
  - id: lens
    type:
      - 'null'
      - string
    doc: "Range of tag length (default: 25,35)"
    inputBinding:
      position: 101
      prefix: '-l'
  - id: dis
    type:
      - 'null'
      - string
    doc: "Position range near start codon or stop codon (default: -40,20)"
    inputBinding:
      position: 101
      prefix: '-d'
  - id: bins
    type:
      - 'null'
      - int
    doc: "Bins for cds profile (default: 20)"
    inputBinding:
      position: 101
      prefix: '--bins'
  - id: nom0
    type:
      - 'null'
      - boolean
    doc: "Do not consider reads with mismatch at position 0 as a new group"
    inputBinding:
      position: 101
      prefix: '--nom0'
  - id: th
    type:
      - 'null'
      - float
    doc: "Threshold for quality (default: 0.5)"
    inputBinding:
      position: 101
      prefix: '--th'
  - id: end3
    type:
      - 'null'
      - boolean
    doc: "Plot 3' end profile"
    inputBinding:
      position: 101
      prefix: '--end3'
  - id: max_nh
    type:
      - 'null'
      - int
    doc: "Max NH value allowed for bam alignments (default: 1)"
    inputBinding:
      position: 101
      prefix: '--maxNH'
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: "Min MapQ value required for bam alignments (default: 1)"
    inputBinding:
      position: 101
      prefix: '--minMapQ'
  - id: secondary_alignments
    type:
      - 'null'
      - boolean
    doc: "Use bam secondary alignments"
    inputBinding:
      position: 101
      prefix: '--secondary'
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: "Reads are paired end"
    inputBinding:
      position: 101
      prefix: '--paired'
  - id: colorblind
    type:
      - 'null'
      - boolean
    doc: "Use a color style readable for color blind people ('#F00078,#00F000,#0078F0')"
    inputBinding:
      position: 101
      prefix: '--colorblind'
  - id: colors
    type:
      - 'null'
      - string
    doc: "User specified Matplotlib accepted color codes for three frames (default: 'r,g,b')"
    inputBinding:
      position: 101
      prefix: '--colors'
  - id: num_processes
    type:
      - 'null'
      - int
    doc: "Number of processes (default: 1)"
    inputBinding:
      position: 101
      prefix: '-p'
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Increase output verbosity"
    inputBinding:
      position: 101
      prefix: '-v'
outputs:
  - id: quality_files
    type:
      type: array
      items: File
    doc: "Quality data table, figure and offset parameter files written beside the working directory"
    outputBinding:
      glob: "$(inputs.output ? inputs.output : \"*_qual.txt\")"
  - id: figure
    type:
      - 'null'
      - File
    doc: "Output pdf figure"
    outputBinding:
      glob: "$(inputs.fig_pdf_path ? inputs.fig_pdf_path : \"*_qual.pdf\")"
  - id: parameters
    type:
      - 'null'
      - File
    doc: "Output offset parameter file"
    outputBinding:
      glob: "$(inputs.para_path ? inputs.para_path : \"*.para.py\")"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
stdout: ribotish_quality.out
