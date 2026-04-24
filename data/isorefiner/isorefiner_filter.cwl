cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner filter
label: isorefiner_filter
doc: "Filter transcript structures based on read alignments.\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: genome
    type: File
    doc: Reference genome (FASTA, mandatory)
    inputBinding:
      position: 101
      prefix: --genome
  - id: input_gtf
    type: File
    doc: Input transcript isoform structures (GTF, mandatory)
    inputBinding:
      position: 101
      prefix: --input_gtf
  - id: max_clip
    type:
      - 'null'
      - int
    doc: Max clip (unaligned) length for read mapping
    inputBinding:
      position: 101
      prefix: --max_clip
  - id: max_indel
    type:
      - 'null'
      - int
    doc: Max indel for read mapping
    inputBinding:
      position: 101
      prefix: --max_indel
  - id: min_cov
    type:
      - 'null'
      - float
    doc: Min coverage for filtering [0-1]
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_idt
    type:
      - 'null'
      - float
    doc: Min identity for read mapping [0-1]
    inputBinding:
      position: 101
      prefix: --min_idt
  - id: min_mean_depth
    type:
      - 'null'
      - float
    doc: Min mean coverage depth for filtering
    inputBinding:
      position: 101
      prefix: --min_mean_depth
  - id: reads
    type:
      type: array
      items: File
    doc: Reads (FASTQ or FASTA, gzip allowed, mandatory)
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Working directory containing intermediate and log files
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: out_gtf
    type:
      - 'null'
      - File
    doc: Final output file name (GTF)
    outputBinding:
      glob: $(inputs.out_gtf)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
