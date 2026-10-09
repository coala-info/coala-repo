cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - refine
label: isorefiner_refine
doc: "Merge and refine transcript isoforms.\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: input_gtf
    type: File[]
    doc: "Input transcript isoform structures (GTF)."
    inputBinding:
      position: 1
      prefix: --input_gtf
  - id: reads
    type: File[]
    doc: "Reads (FASTQ or FASTA, gzip allowed)."
    inputBinding:
      position: 2
      prefix: --reads
  - id: genome
    type: File
    doc: "Reference genome (FASTA)."
    inputBinding:
      position: 3
      prefix: --genome
  - id: ref_gtf
    type: File
    doc: "Reference genome annotation (GTF)."
    inputBinding:
      position: 4
      prefix: --ref_gtf
  - id: out_gtf
    type: string
    default: isorefiner_refined.gtf
    doc: "Final output file name (GTF)."
    inputBinding:
      position: 5
      prefix: --out_gtf
  - id: max_indel
    type: ['null', int]
    doc: "Max indel for read mapping."
    inputBinding:
      position: 7
      prefix: --max_indel
  - id: max_clip
    type: ['null', int]
    doc: "Max clip (unaligned) length for read mapping."
    inputBinding:
      position: 8
      prefix: --max_clip
  - id: min_idt
    type: ['null', float]
    doc: "Min identity for read mapping [0-1]."
    inputBinding:
      position: 9
      prefix: --min_idt
  - id: intron_dist_th
    type: ['null', int]
    doc: "Intron distance threshold to exclude erroneous isoforms."
    inputBinding:
      position: 10
      prefix: --intron_dist_th
  - id: work_dir
    type: string
    default: isorefiner_refine_work
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
  - id: output_gtf
    type: File
    doc: "Refined transcript isoform structures."
    outputBinding:
      glob: $(inputs.out_gtf)
  - id: log_file
    type: ['null', File]
    doc: "Log file of the run (in the working directory)."
    outputBinding:
      glob: $(inputs.work_dir)/log.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
