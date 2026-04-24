cwlVersion: v1.2
class: CommandLineTool
baseCommand: callstate
label: callstate
doc: "Calculate callable states for a BAM file based on a BED file.\n\nTool homepage:
  https://github.com/LuobinY/Callstate"
inputs:
  - id: bed_file
    type: File
    doc: The BED file that contains regions.
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: the alignment file for which to calculate callable states
    inputBinding:
      position: 2
  - id: flag
    type:
      - 'null'
      - int
    doc: exclude reads with any of the bits in FLAG set
    inputBinding:
      position: 103
      prefix: --flag
  - id: low_mapq_frac
    type:
      - 'null'
      - float
    doc: If the fraction of low mapping reads exceeds this value, the site is 
      considered poorly mapped
    inputBinding:
      position: 103
      prefix: --low-mapq-frac
  - id: max_depth
    type:
      - 'null'
      - int
    doc: The maximum read depth before a locus is considered high coverage
    inputBinding:
      position: 103
      prefix: --max-depth
  - id: max_low_mapq
    type:
      - 'null'
      - int
    doc: The maximum value of MAPQ before a read is considered as problematic 
      mapped read.
    inputBinding:
      position: 103
      prefix: --max-low-mapq
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: The minimum base quality for a base to contribute to QC depth
    inputBinding:
      position: 103
      prefix: --min-base-qual
  - id: min_depth
    type:
      - 'null'
      - int
    doc: The minimum QC read depth before a read is considered callable
    inputBinding:
      position: 103
      prefix: --min-depth
  - id: min_depth_low_mapq
    type:
      - 'null'
      - int
    doc: Minimum read depth before a locus is considered candidate for poorly 
      mapped
    inputBinding:
      position: 103
      prefix: --min-depth-low-mapq
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: The minimum mapping quality of reads to count as QC depth
    inputBinding:
      position: 103
      prefix: --min-mapq
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of BAM decompression threads
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output BED file
    outputBinding:
      glob: $(inputs.output_file)
  - id: base_depth_output
    type:
      - 'null'
      - File
    doc: If a file name is given, per-base depth will be written to this file
    outputBinding:
      glob: $(inputs.base_depth_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callstate:0.0.2--h0fde405_1
