cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - run_isoquant
label: isorefiner_run_isoquant
doc: "Run IsoQuant (read mapping-based tool).\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
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
    default: isorefiner_isoquant.gtf
    doc: "Final output file name (GTF)."
    inputBinding:
      position: 4
      prefix: --out_gtf
  - id: tool_option
    type: ['null', string]
    doc: "Option for isoquant (quoted string). Default: --complete_genedb --data_type nanopore --stranded none --transcript_quantification unique_only --gene_quantification unique_only --matching_strategy default --splice_correction_strategy default_ont --model_construction_strategy default_ont --no_secondary --check_canonical --count_exons"
    inputBinding:
      position: 6
      prefix: --tool_option
  - id: work_dir
    type: string
    default: isorefiner_isoquant_work
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
    doc: "Transcript isoform structures from IsoQuant."
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
