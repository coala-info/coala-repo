cwlVersion: v1.2
class: CommandLineTool
baseCommand: DAJIN2
label: dajin2_DAJIN2
doc: "DAJIN2 batch mode or DAJIN2 GUI mode\n\nTool homepage: https://github.com/akikuno/DAJIN2"
inputs:
  - id: mode
    type: string
    doc: DAJIN2 batch mode or DAJIN2 GUI mode
    inputBinding:
      position: 1
  - id: allele_file
    type:
      - 'null'
      - File
    doc: Path to a FASTA file
    inputBinding:
      position: 102
      prefix: --allele
  - id: control_dir
    type:
      - 'null'
      - Directory
    doc: Path to a control directory including FASTQ file
    inputBinding:
      position: 102
      prefix: --control
  - id: genome_coordinate_bed
    type:
      - 'null'
      - File
    doc: Path to BED6 file containing genomic coordinates
    default: ''
    inputBinding:
      position: 102
      prefix: --bed
  - id: genome_id
    type:
      - 'null'
      - string
    doc: Reference genome ID (e.g hg38, mm39)
    default: ''
    inputBinding:
      position: 102
      prefix: --genome
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Disable minor allele filtering (keep alleles <0.5%)
    inputBinding:
      position: 102
      prefix: --no-filter
  - id: output_dir_name
    type:
      - 'null'
      - string
    doc: Output directory name
    inputBinding:
      position: 102
      prefix: --name
  - id: sample_dir
    type:
      - 'null'
      - Directory
    doc: Path to a sample directory including FASTQ file
    inputBinding:
      position: 102
      prefix: --sample
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dajin2:0.8.0--pyhdfd78af_0
stdout: dajin2_DAJIN2.out
