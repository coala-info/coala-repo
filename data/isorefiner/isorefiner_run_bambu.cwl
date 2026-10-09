cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - run_bambu
label: isorefiner_run_bambu
doc: "Run bambu (read mapping-based tool).\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
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
    default: isorefiner_bambu.gtf
    doc: "Final output file name (GTF)."
    inputBinding:
      position: 4
      prefix: --out_gtf
  - id: work_dir
    type: string
    default: isorefiner_bambu_work
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
    doc: "Transcript isoform structures from bambu."
    outputBinding:
      glob: $(inputs.out_gtf)
  - id: log_file
    type: ['null', File]
    doc: "Log file of the run (in the working directory)."
    outputBinding:
      glob: $(inputs.work_dir)/log.txt
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: R_BIOC_VERSION
        envValue: "3.18"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
