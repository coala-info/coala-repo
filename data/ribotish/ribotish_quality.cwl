cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotish quality
label: ribotish_quality
doc: "Quality control for Riboseq data.\n\nTool homepage: https://github.com/zhpn1024/ribotish"
inputs:
  - id: bins
    type:
      - 'null'
      - int
    doc: Bins for cds profile
    default: 20
    inputBinding:
      position: 101
      prefix: --bins
  - id: chrmap
    type:
      - 'null'
      - File
    doc: Input chromosome id mapping table file if annotation chr ids are not 
      same as chr ids in bam/fasta files
    inputBinding:
      position: 101
      prefix: --chrmap
  - id: colorblind
    type:
      - 'null'
      - boolean
    doc: Use a color style readable for color blind people 
      ('#F00078,#00F000,#0078F0')
    inputBinding:
      position: 101
      prefix: --colorblind
  - id: colors
    type:
      - 'null'
      - string
    doc: User specified Matplotlib accepted color codes for three frames
    default: r,g,b
    inputBinding:
      position: 101
      prefix: --colors
  - id: dis
    type:
      - 'null'
      - string
    doc: Position range near start codon or stop codon
    default: -40,20
    inputBinding:
      position: 101
      prefix: -d
  - id: end3
    type:
      - 'null'
      - boolean
    doc: Plot 3' end profile
    inputBinding:
      position: 101
      prefix: --end3
  - id: gene_format
    type:
      - 'null'
      - string
    doc: 'Gene annotation file format (gtf, bed, gpd, gff, default: auto)'
    default: auto
    inputBinding:
      position: 101
      prefix: --geneformat
  - id: gene_path
    type:
      - 'null'
      - File
    doc: Gene annotation file
    inputBinding:
      position: 101
      prefix: -g
  - id: input
    type:
      - 'null'
      - File
    doc: Input previous output file, do not read gene file and bam file again
    inputBinding:
      position: 101
      prefix: -i
  - id: lens
    type:
      - 'null'
      - string
    doc: Range of tag length
    default: 25,35
    inputBinding:
      position: 101
      prefix: -l
  - id: max_nh
    type:
      - 'null'
      - int
    doc: Max NH value allowed for bam alignments
    default: 1
    inputBinding:
      position: 101
      prefix: --maxNH
  - id: min_map_q
    type:
      - 'null'
      - int
    doc: Min MapQ value required for bam alignments
    default: 1
    inputBinding:
      position: 101
      prefix: --minMapQ
  - id: nom0
    type:
      - 'null'
      - boolean
    doc: Do not consider reads with mismatch at position 0 as a new group
    inputBinding:
      position: 101
      prefix: --nom0
  - id: num_proc
    type:
      - 'null'
      - int
    doc: Number of processes
    default: 1
    inputBinding:
      position: 101
      prefix: -p
  - id: paired
    type:
      - 'null'
      - boolean
    doc: Reads are paired end
    inputBinding:
      position: 101
      prefix: --paired
  - id: ribo_bam_path
    type: File
    doc: Riboseq bam file
    inputBinding:
      position: 101
      prefix: -b
  - id: secondary
    type:
      - 'null'
      - boolean
    doc: Use bam secondary alignments
    inputBinding:
      position: 101
      prefix: --secondary
  - id: th
    type:
      - 'null'
      - float
    doc: Threshold for quality
    default: 0.5
    inputBinding:
      position: 101
      prefix: --th
  - id: tis
    type:
      - 'null'
      - boolean
    doc: The data is TIS enriched (for LTM & Harritonine)
    inputBinding:
      position: 101
      prefix: --tis
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Increase output verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output data file
    outputBinding:
      glob: $(inputs.output)
  - id: fig_pdf_path
    type:
      - 'null'
      - File
    doc: Output pdf figure file
    outputBinding:
      glob: $(inputs.fig_pdf_path)
  - id: para_path
    type:
      - 'null'
      - File
    doc: Output offset parameter file
    outputBinding:
      glob: $(inputs.para_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotish:0.2.8--pyhdfd78af_0
