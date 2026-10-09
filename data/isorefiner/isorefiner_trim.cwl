cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - trim
label: isorefiner_trim
doc: "Trim nanopore reads using Porechop_ABI.\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: reads
    type: File[]
    doc: "Reads (FASTQ or FASTA, gzip allowed)."
    inputBinding:
      position: 1
      prefix: --reads
  - id: out_prefix
    type: string
    default: isorefiner_trimmed
    doc: "Prefix of final output files (extentions are those of input files). Gzipped input must have the extension .fastq.gz or .fasta.gz to get a gzipped output."
    inputBinding:
      position: 2
      prefix: --out_prefix
  - id: tool_option
    type: ['null', string]
    doc: "Option for Porechomp_ABI (quoted string)."
    inputBinding:
      position: 3
      prefix: --tool_option
  - id: work_dir
    type: string
    default: isorefiner_trim_work
    doc: "Working directory containing intermediate and log files."
    inputBinding:
      position: 4
      prefix: --work_dir
  - id: threads
    type: ['null', int]
    doc: "Number of threads."
    inputBinding:
      position: 4
      prefix: --threads
outputs:
  - id: trimmed_reads
    type:
      type: array
      items: File
    doc: "Trimmed reads."
    outputBinding:
      glob: $(inputs.out_prefix)*
  - id: log_file
    type: ['null', File]
    doc: "Log file of the run (in the working directory)."
    outputBinding:
      glob: $(inputs.work_dir)/log.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
