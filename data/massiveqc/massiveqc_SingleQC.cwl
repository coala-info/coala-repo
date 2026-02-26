cwlVersion: v1.2
class: CommandLineTool
baseCommand: SingleQC
label: massiveqc_SingleQC
doc: "Single-cell RNA-seq quality control tool\n\nTool homepage: https://github.com/shimw6828/MassiveQC"
inputs:
  - id: ascp_key
    type:
      - 'null'
      - string
    doc: Locate aspera key.
    default: $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh
    inputBinding:
      position: 101
      prefix: --ascp_key
  - id: conf
    type:
      - 'null'
      - string
    inputBinding:
      position: 101
      prefix: --conf
  - id: download
    type:
      - 'null'
      - Directory
    doc: Path to SRA fastq files.
    default: $OUTDIR/download
    inputBinding:
      position: 101
      prefix: --download
  - id: fastq_screen_config
    type: File
    doc: Path to the fastq_screen conf file, can be download from fastq_screen 
      website
    inputBinding:
      position: 101
      prefix: --fastq_screen_config
  - id: gtf
    type: File
    doc: Path to the GTF file with annotations
    inputBinding:
      position: 101
      prefix: --gtf
  - id: ht2_idx
    type: string
    doc: Hisat2 index filename prefix
    inputBinding:
      position: 101
      prefix: --ht2-idx
  - id: known_splicesite_infile
    type:
      - 'null'
      - File
    doc: Hisat2 splicesite file, provide a list of known splice sites
    inputBinding:
      position: 101
      prefix: --known-splicesite-infile
  - id: only_download
    type:
      - 'null'
      - boolean
    doc: Only run the download step
    inputBinding:
      position: 101
      prefix: --only_download
  - id: picard
    type: File
    doc: Path to picard.jar
    inputBinding:
      position: 101
      prefix: --picard
  - id: ref_flat
    type: File
    doc: Path to refflat file
    inputBinding:
      position: 101
      prefix: --ref_flat
  - id: remove_bam
    type:
      - 'null'
      - boolean
    doc: Don't remain the bam after running FeatureCounts
    inputBinding:
      position: 101
      prefix: --remove_bam
  - id: remove_fastq
    type:
      - 'null'
      - boolean
    doc: Don't remain the fastq after running hisat2
    inputBinding:
      position: 101
      prefix: --remove_fastq
  - id: skip_download
    type:
      - 'null'
      - boolean
    doc: Skip the download step
    inputBinding:
      position: 101
      prefix: --skip_download
  - id: srr
    type: string
    doc: SRR id
    inputBinding:
      position: 101
      prefix: --srr
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads for tools like Hisat2 in one task
    inputBinding:
      position: 101
      prefix: --THREADS
outputs:
  - id: outdir
    type: Directory
    doc: Path to result output directory. If it doesn't exist, it will be 
      created automatically
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
