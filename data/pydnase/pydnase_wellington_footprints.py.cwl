cwlVersion: v1.2
class: CommandLineTool
baseCommand: wellington_footprints.py
label: pydnase_wellington_footprints.py
doc: "Wellington footprinting algorithm for identifying protein-DNA binding sites
  from DNase-seq data.\n\nTool homepage: http://jpiper.github.io/pyDNase"
inputs:
  - id: bam_file
    type: File
    doc: The BAM file containing the DNase-seq reads (must be indexed)
    inputBinding:
      position: 1
  - id: regions_bed
    type: File
    doc: BED file containing the regions to search for footprints (e.g., DHS regions)
    inputBinding:
      position: 2
  - id: bonferroni
    type:
      - 'null'
      - boolean
    doc: Use Bonferroni correction instead of FDR
    inputBinding:
      position: 103
      prefix: --bonferroni
  - id: dont_merge_targets
    type:
      - 'null'
      - boolean
    doc: Do not merge overlapping target regions
    inputBinding:
      position: 103
      prefix: --dont-merge-targets
  - id: fdr_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for FDR calculation
    inputBinding:
      position: 103
      prefix: --fdr-iterations
  - id: fdr_limit
    type:
      - 'null'
      - float
    doc: The FDR threshold for footprinting
    inputBinding:
      position: 103
      prefix: --fdr-limit
  - id: one_based
    type:
      - 'null'
      - boolean
    doc: Use 1-based coordinates for output
    inputBinding:
      position: 103
      prefix: --one-based
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processes to use
    inputBinding:
      position: 103
      prefix: --processes
outputs:
  - id: output_directory
    type: Directory
    doc: Directory to write the output files
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pydnase:0.3.0--py35_0
