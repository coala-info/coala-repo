cwlVersion: v1.2
class: CommandLineTool
baseCommand: alfa
label: alfa
doc: "ALFA (Automated Labelling of Feature Annotations) is a tool for genome-wide
  annotation of sequencing data, providing a global overview of the distribution of
  reads across genomic features.\n\nTool homepage: https://github.com/biocompibens/ALFA"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: Genomic annotations file (GTF format).
    inputBinding:
      position: 101
      prefix: --annotation
  - id: bam
    type:
      - 'null'
      - type: array
        items: string
    doc: Input BAM file(s) and label(s). The BAM files must be sorted by 
      position.
    inputBinding:
      position: 101
      prefix: --bam
  - id: bedgraph
    type:
      - 'null'
      - type: array
        items: string
    doc: Use this options if your input(s) is/are BedGraph file(s). If stranded,
      provide the BedGraph files for each strand for all samples.
    inputBinding:
      position: 101
      prefix: --bedgraph
  - id: categories_depth
    type:
      - 'null'
      - int
    doc: "Hierarchical level that will be considered in the GTF file: (1) gene,intergenic;
      (2) intron,exon,intergenic; (3) 5'UTR,CDS,3'UTR,intron,intergenic; (4) start_codon,5'UTR,CDS,3'UTR,stop_codon,intron,intergenic."
    default: 3
    inputBinding:
      position: 101
      prefix: --categories_depth
  - id: chr_len
    type:
      - 'null'
      - File
    doc: Tabulated file containing chromosome names and lengths.
    inputBinding:
      position: 101
      prefix: --chr_len
  - id: counts
    type:
      - 'null'
      - type: array
        items: File
    doc: Use this options instead of '--bam/--bedgraph' to provide ALFA counts 
      files as input instead of bam/bedgraph files.
    inputBinding:
      position: 101
      prefix: --counts
  - id: genome_index
    type:
      - 'null'
      - string
    doc: Genome index files path and basename for existing index, or path and 
      basename for new index creation.
    inputBinding:
      position: 101
      prefix: --genome_index
  - id: keep_ambiguous
    type:
      - 'null'
      - boolean
    doc: Keep reads mapping to different features (discarded by default).
    inputBinding:
      position: 101
      prefix: --keep_ambiguous
  - id: no_display
    type:
      - 'null'
      - boolean
    doc: Do not display plots.
    inputBinding:
      position: 101
      prefix: --no_display
  - id: processors
    type:
      - 'null'
      - int
    doc: Set the number of processors used for multi-processing operations.
    inputBinding:
      position: 101
      prefix: --processors
  - id: strandness
    type:
      - 'null'
      - string
    doc: "Library orientation. Choose within: 'unstranded', 'forward'/'fr-firststrand'
      or 'reverse'/'fr-secondstrand'."
    default: unstranded
    inputBinding:
      position: 101
      prefix: --strandness
  - id: temp_dir
    type:
      - 'null'
      - Directory
    doc: Temp directory to store pybedtools files.
    default: /tmp/
    inputBinding:
      position: 101
      prefix: --temp_dir
  - id: threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: Set ordinate axis limits for enrichment plots (YMIN YMAX).
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: pdf
    type:
      - 'null'
      - File
    doc: Save produced plots in PDF format at the specified path 
      ('categories_plots.pdf' if no argument provided).
    outputBinding:
      glob: $(inputs.pdf)
  - id: png
    type:
      - 'null'
      - File
    doc: Save produced plots in PNG format with the provided argument as 
      basename ('categories.png' and 'biotypes.png' if no argument provided).
    outputBinding:
      glob: $(inputs.png)
  - id: svg
    type:
      - 'null'
      - File
    doc: Save produced plots in SVG format with the provided argument as 
      basename or 'categories.svg' and 'biotypes.svg' if no argument provided.
    outputBinding:
      glob: $(inputs.svg)
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory for all files created by ALFA (current dir by 
      default).
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfa:1.1.1--pyh5e36f6f_0
