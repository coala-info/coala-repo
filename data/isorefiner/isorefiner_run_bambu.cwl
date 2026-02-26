cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner run_bambu
label: isorefiner_run_bambu
doc: "Run Bambu for isoform refinement\n\nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Mapped reads files (BAM, mandatory)
    inputBinding:
      position: 101
      prefix: --bam
  - id: genome
    type: File
    doc: Reference genome (FASTA, mandatory)
    inputBinding:
      position: 101
      prefix: --genome
  - id: ref_gtf
    type: File
    doc: Reference genome annotation (GTF, mandatory)
    inputBinding:
      position: 101
      prefix: --ref_gtf
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Working directory containing intermediate and log files
    default: isorefiner_bambu_work
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
