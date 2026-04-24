cwlVersion: v1.2
class: CommandLineTool
baseCommand: discovardenovo
label: discovardenovo
doc: "DISCOVAR de novo is a large genome assembler that can also be used for variant
  calling. It is designed to operate on a single Illumina library of PCR-free 250bp
  paired-end reads.\n\nTool homepage: https://github.com/bayolau/discovardenovo"
inputs:
  - id: max_bam_files
    type:
      - 'null'
      - int
    doc: Maximum number of BAM files to open at once.
    inputBinding:
      position: 101
      prefix: MAX_BAM_FILES
  - id: max_mem_gb
    type:
      - 'null'
      - int
    doc: Maximum memory to use in GB.
    inputBinding:
      position: 101
      prefix: MAX_MEM_GB
  - id: memory_check
    type:
      - 'null'
      - boolean
    doc: If true, check that there is enough memory available.
    inputBinding:
      position: 101
      prefix: MEMORY_CHECK
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 101
      prefix: NUM_THREADS
  - id: reads
    type: string
    doc: Comma-separated list of input BAM or FASTQ files.
    inputBinding:
      position: 101
      prefix: READS
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Directory for temporary files.
    inputBinding:
      position: 101
      prefix: TMP_DIR
outputs:
  - id: out_dir
    type: Directory
    doc: Name of the output directory.
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/discovardenovo:52488--1
