cwlVersion: v1.2
class: CommandLineTool
baseCommand: clippy
label: clippy
doc: "Call CLIP peaks.\n\nTool homepage: https://github.com/ulelab/clippy"
inputs:
  - id: alt_features
    type:
      - 'null'
      - string
    doc: A list of alternative GTF features to set individual thresholds on in 
      the comma-separated format <alt_feature_name>-<gtf_key>-<search_pattern>
    inputBinding:
      position: 101
      prefix: --alt_features
  - id: annotation
    type: File
    doc: gtf annotation file
    inputBinding:
      position: 101
      prefix: --annotation
  - id: chunksize_factor
    type:
      - 'null'
      - int
    doc: A factor used to control the number of jobs given to a thread at a 
      time. A larger number reduces the number of jobs per chunk. Only increase 
      if you experience crashes
    inputBinding:
      position: 101
      prefix: --chunksize_factor
  - id: downstream_extension
    type:
      - 'null'
      - int
    doc: downstream extension added to gene models
    inputBinding:
      position: 101
      prefix: --downstream_extension
  - id: genome_file
    type: File
    doc: genome file containing chromosome lengths. Also known as a FASTA index 
      file, which usually ends in .fai. This file is used by BEDTools for 
      genomic operations
    inputBinding:
      position: 101
      prefix: --genome_file
  - id: input_bed
    type: File
    doc: bed file containing cDNA counts at each crosslink position
    inputBinding:
      position: 101
      prefix: --input_bed
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: starts a Dash server to allow for interactive parameter tuning
    inputBinding:
      position: 101
      prefix: --interactive
  - id: intergenic_peak_threshold
    type:
      - 'null'
      - int
    doc: Intergenic peaks are called by first creating intergenic regions and 
      calling peaks on the regions as though they were genes. The regions are 
      made by expanding intergenic crosslinks and merging the result. This 
      parameter is the threshold number of summed cDNA counts required to 
      include a region. If set to zero, the default, no intergenic peaks will be
      called.
    inputBinding:
      position: 101
      prefix: --intergenic_peak_threshold
  - id: min_gene_counts
    type:
      - 'null'
      - int
    doc: minimum cDNA counts per gene to look for peaks
    inputBinding:
      position: 101
      prefix: --min_gene_counts
  - id: min_height_adjust
    type:
      - 'null'
      - float
    doc: adjustment for the minimum height threshold, calculated as this value 
      multiplied by the mean
    inputBinding:
      position: 101
      prefix: --min_height_adjust
  - id: min_peak_counts
    type:
      - 'null'
      - int
    doc: minimum cDNA counts per broad peak
    inputBinding:
      position: 101
      prefix: --min_peak_counts
  - id: min_prom_adjust
    type:
      - 'null'
      - float
    doc: adjustment for minimum prominence threshold, calculated as this value 
      multiplied by the mean
    inputBinding:
      position: 101
      prefix: --min_prom_adjust
  - id: no_exon_info
    type:
      - 'null'
      - boolean
    doc: Turn off individual exon and intron thresholds
    inputBinding:
      position: 101
      prefix: --no_exon_info
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
  - id: upstream_extension
    type:
      - 'null'
      - int
    doc: upstream extension added to gene models
    inputBinding:
      position: 101
      prefix: --upstream_extension
  - id: width
    type:
      - 'null'
      - float
    doc: proportion of prominence to calculate peak widths at. Smaller values 
      will give narrow peaks and large values will give wider peaks
    inputBinding:
      position: 101
      prefix: --width
  - id: window_size
    type:
      - 'null'
      - int
    doc: rolling mean window size
    inputBinding:
      position: 101
      prefix: --window_size
outputs:
  - id: output_prefix
    type: File
    doc: prefix for output files
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clippy:1.5.0--pyh3cd468f_1
