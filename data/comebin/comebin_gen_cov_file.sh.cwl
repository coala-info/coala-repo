cwlVersion: v1.2
class: CommandLineTool
baseCommand: gen_coverage_file.sh
label: comebin_gen_cov_file.sh
doc: "Generates coverage files from reads and a metagenomic assembly.\n\nTool homepage:
  https://github.com/ziyewang/COMEBin"
inputs:
  - id: readsA_1
    type: File
    doc: First read file for replicate A (paired-end, read 1)
    inputBinding:
      position: 1
  - id: readsA_2
    type: File
    doc: Second read file for replicate A (paired-end, read 2)
    inputBinding:
      position: 2
  - id: readsX
    type:
      - 'null'
      - type: array
        items: File
    doc: Additional read files for other replicates (paired-end, read 1 and read
      2)
    inputBinding:
      position: 3
  - id: assembly_file
    type: File
    doc: metagenomic assembly file
    inputBinding:
      position: 104
      prefix: -a
  - id: bam_dir
    type:
      - 'null'
      - Directory
    doc: directory for the bam files
    inputBinding:
      position: 104
      prefix: -b
  - id: forward_suffix
    type:
      - 'null'
      - string
    doc: Forward read suffix for paired reads
    inputBinding:
      position: 104
      prefix: -f
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: the input read files contain interleaved paired-end reads
    inputBinding:
      position: 104
      prefix: --interleaved
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: minimum contig length to bin
    inputBinding:
      position: 104
      prefix: -l
  - id: ram_amount
    type:
      - 'null'
      - int
    doc: amount of RAM available
    inputBinding:
      position: 104
      prefix: -m
  - id: reverse_suffix
    type:
      - 'null'
      - string
    doc: Reverse read suffix for paired reads
    inputBinding:
      position: 104
      prefix: -r
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: non-paired reads mode (provide *.fastq files)
    inputBinding:
      position: 104
      prefix: --single-end
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 104
      prefix: -t
outputs:
  - id: output_dir
    type: Directory
    doc: output directory (to save the coverage files)
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/comebin:1.0.4--hdfd78af_1
