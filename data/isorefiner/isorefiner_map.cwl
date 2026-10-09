cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - map
label: isorefiner_map
doc: "Map reads to the reference genome using Minimap2, and sort BAM files.\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: reads
    type: File[]
    doc: "Reads (FASTQ or FASTA, gzip allowed)."
    inputBinding:
      position: 1
      prefix: --reads
  - id: genome
    type: File
    doc: "Reference genome (FASTA)."
    inputBinding:
      position: 2
      prefix: --genome
  - id: out_prefix
    type: string
    default: isorefiner_mapped
    doc: "Prefix of output BAM files."
    inputBinding:
      position: 3
      prefix: --out_prefix
  - id: mm2_option
    type: ['null', string]
    doc: "Option for minimap2 (quoted string). Default: -x splice -ub -k14 --secondary=no"
    inputBinding:
      position: 4
      prefix: --mm2_option
  - id: sort_option
    type: ['null', string]
    doc: "Option for samtools sort (quoted string). Default: -m 2G"
    inputBinding:
      position: 5
      prefix: --sort_option
  - id: work_dir
    type: string
    default: isorefiner_map_work
    doc: "Working directory containing intermediate and log files."
    inputBinding:
      position: 6
      prefix: --work_dir
  - id: threads
    type: ['null', int]
    doc: "Number of threads."
    inputBinding:
      position: 6
      prefix: --threads
outputs:
  - id: mapped_bam
    type:
      type: array
      items: File
    doc: "Sorted BAM files."
    outputBinding:
      glob: $(inputs.out_prefix)*.bam
  - id: mapped_bam_index
    type:
      type: array
      items: File
    doc: "BAM index files."
    outputBinding:
      glob: $(inputs.out_prefix)*.bam.bai
  - id: log_file
    type: ['null', File]
    doc: "Log file of the run (in the working directory)."
    outputBinding:
      glob: $(inputs.work_dir)/log.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
