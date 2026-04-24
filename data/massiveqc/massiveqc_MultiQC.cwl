cwlVersion: v1.2
class: CommandLineTool
baseCommand: MultiQC
label: massiveqc_MultiQC
doc: "MultiQC is a modular tool to run multiple                       bioinformatics
  tools and aggregate their                       results into a single, interactive
  HTML report.\n\nTool homepage: https://github.com/shimw6828/MassiveQC"
inputs:
  - id: ascp_key
    type:
      - 'null'
      - string
    doc: "Locate aspera key. Default\n                        $HOME/.aspera/connect/etc/asperaweb_id_dsa.openssh"
    inputBinding:
      position: 101
      prefix: --ascp_key
  - id: conf
    type:
      - 'null'
      - string
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --conf
  - id: download
    type:
      - 'null'
      - Directory
    doc: "Path to SRA fastq files. The default is\n                        $OUTDIR/download"
    inputBinding:
      position: 101
      prefix: --download
  - id: fastq_screen_config
    type:
      - 'null'
      - string
    doc: "Path to the fastq_screen conf file, can be download\n                  \
      \      from fastq_screen website"
    inputBinding:
      position: 101
      prefix: --fastq_screen_config
  - id: gtf
    type:
      - 'null'
      - string
    doc: Path to the GTF file with annotations
    inputBinding:
      position: 101
      prefix: --gtf
  - id: ht2_idx
    type:
      - 'null'
      - string
    doc: Hisat2 index filename prefix
    inputBinding:
      position: 101
      prefix: --ht2-idx
  - id: input
    type: string
    doc: Input file, containing two columns srx and srr
    inputBinding:
      position: 101
      prefix: --input
  - id: known_splicesite_infile
    type:
      - 'null'
      - string
    doc: "Hisat2 splicesite file, provide a list of known splice\n               \
      \         sites"
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
    type:
      - 'null'
      - string
    doc: Path to picard.jar
    inputBinding:
      position: 101
      prefix: --picard
  - id: ref_flat
    type:
      - 'null'
      - string
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
  - id: threads
    type:
      - 'null'
      - int
    doc: "The number of threads for tools like Hisat2 in one\n                   \
      \     task"
    inputBinding:
      position: 101
      prefix: --THREADS
  - id: workers
    type:
      - 'null'
      - int
    doc: The number of simultaneous tasks
    inputBinding:
      position: 101
      prefix: --workers
outputs:
  - id: outdir
    type: Directory
    doc: "Path to result output directory. If it doesn't exist,\n                \
      \        it will be created automatically"
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/massiveqc:0.1.2--pyh086e186_0
