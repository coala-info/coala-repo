cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner trans_struct_wf
label: isorefiner_trans_struct_wf
doc: "This tool refines transcript structures based on reads and reference annotation.\n\
  \nTool homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: genome
    type: File
    doc: Reference genome (FASTA, mandatory)
    default: None
    inputBinding:
      position: 101
      prefix: --genome
  - id: reads
    type:
      type: array
      items: File
    doc: Reads (FASTQ or FASTA, gzip allowed, mandatory)
    default: None
    inputBinding:
      position: 101
      prefix: --reads
  - id: ref_gtf
    type: File
    doc: Reference genome annotation (GTF, mandatory)
    default: None
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
    default: isorefiner_trans_struct_wf_work
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
