cwlVersion: v1.2
class: CommandLineTool
baseCommand: ScatterRegions
label: biopet-scatterregions
doc: "A tool to scatter genomic regions into smaller chunks, potentially based on
  a reference fasta or BAM file index.\n\nTool homepage: https://github.com/biopet/scatterregions"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: When given the regions will be scattered based on number of reads in the
      index file
    inputBinding:
      position: 101
      prefix: --bamFile
  - id: log_level
    type:
      - 'null'
      - string
    doc: "Level of log information printed. Possible levels: 'debug', 'info', 'warn',
      'error'"
    inputBinding:
      position: 101
      prefix: --log_level
  - id: max_contigs_in_scatter_job
    type:
      - 'null'
      - int
    doc: If set each scatter can only contain 1 contig
    inputBinding:
      position: 101
      prefix: --maxContigsInScatterJob
  - id: not_combine_contigs
    type:
      - 'null'
      - boolean
    doc: If set each scatter can only contain 1 contig
    inputBinding:
      position: 101
      prefix: --notCombineContigs
  - id: not_split_contigs
    type:
      - 'null'
      - boolean
    doc: When this option is set contigs are not split.
    inputBinding:
      position: 101
      prefix: --notSplitContigs
  - id: reference_fasta
    type: File
    doc: Reference fasta file, (dict file should be next to it)
    inputBinding:
      position: 101
      prefix: --referenceFasta
  - id: regions
    type:
      - 'null'
      - File
    doc: If given only regions in the given bed file will be used for scattering
    inputBinding:
      position: 101
      prefix: --regions
  - id: scatter_size
    type:
      - 'null'
      - int
    doc: Approximately scatter size, tool will make all scatters the same size.
    default: 1000000
    inputBinding:
      position: 101
      prefix: --scatterSize
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biopet-scatterregions:0.2--0
