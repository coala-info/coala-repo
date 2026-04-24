cwlVersion: v1.2
class: CommandLineTool
baseCommand: PyLOH preprocess
label: pyloh_PyLOH.py preprocess
doc: "Preprocesses BAM files for PyLOH analysis.\n\nTool homepage: https://github.com/uci-cbcl/PyLOH"
inputs:
  - id: reference_genome
    type: File
    doc: FASTA file for reference genome.
    inputBinding:
      position: 1
  - id: normal_bam
    type: File
    doc: BAM file for normal sample.
    inputBinding:
      position: 2
  - id: tumor_bam
    type: File
    doc: BAM file for tumor sample.
    inputBinding:
      position: 3
  - id: filename_base
    type: string
    doc: Base name of preprocessed files to be created.
    inputBinding:
      position: 4
  - id: min_base_qual
    type:
      - 'null'
      - int
    doc: Minimum base quality required.
    inputBinding:
      position: 105
      prefix: --min_base_qual
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum reads depth required for both normal and tumor samples.
    inputBinding:
      position: 105
      prefix: --min_depth
  - id: min_map_qual
    type:
      - 'null'
      - int
    doc: Minimum mapping quality required.
    inputBinding:
      position: 105
      prefix: --min_map_qual
  - id: process_num
    type:
      - 'null'
      - int
    doc: Number of processes to launch for preprocessing.
    inputBinding:
      position: 105
      prefix: --process_num
  - id: segments_bed
    type:
      - 'null'
      - File
    doc: BED file for segments. If not provided, use autosomes as segments.
    inputBinding:
      position: 105
      prefix: --segments_bed
  - id: wes
    type:
      - 'null'
      - boolean
    doc: Flag indicating whether the BAM files are whole exome sequencing(WES) 
      or not. If not provided, the BAM files are assumed to be whole genome 
      sequencing(WGS).
    inputBinding:
      position: 105
      prefix: --WES
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyloh:1.4.3--py27_0
stdout: pyloh_PyLOH.py preprocess.out
