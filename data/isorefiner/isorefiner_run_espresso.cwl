cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - run_espresso
label: isorefiner_run_espresso
doc: "Run espresso (read mapping-based tool).\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: bam
    type: File[]
    doc: "Mapped reads files (BAM, with a .bai index beside each file)."
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      position: 1
      prefix: --bam
  - id: genome
    type: File
    doc: "Reference genome (FASTA)."
    inputBinding:
      position: 2
      prefix: --genome
  - id: ref_gtf
    type: File
    doc: "Reference genome annotation (GTF)."
    inputBinding:
      position: 3
      prefix: --ref_gtf
  - id: out_gtf
    type: string
    default: isorefiner_espresso.gtf
    doc: "Final output file name (GTF)."
    inputBinding:
      position: 4
      prefix: --out_gtf
  - id: tool_s_option
    type: ['null', string]
    doc: "Option for ESPRESSO_S.pl (quoted string)."
    inputBinding:
      position: 6
      prefix: --tool_s_option
  - id: tool_c_option
    type: ['null', string]
    doc: "Option for ESPRESSO_C.pl (quoted string)."
    inputBinding:
      position: 7
      prefix: --tool_c_option
  - id: tool_q_option
    type: ['null', string]
    doc: "Option for ESPRESSO_Q.pl (quoted string)."
    inputBinding:
      position: 8
      prefix: --tool_q_option
  - id: work_dir
    type: string
    default: isorefiner_espresso_work
    doc: "Working directory containing intermediate and log files."
    inputBinding:
      position: 5
      prefix: --work_dir
  - id: threads
    type: ['null', int]
    doc: "Number of threads."
    inputBinding:
      position: 5
      prefix: --threads
outputs:
  - id: output_gtf
    type: File
    doc: "Transcript isoform structures from ESPRESSO."
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
