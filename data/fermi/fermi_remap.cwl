cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - remap
label: fermi_remap
doc: "Remap reads to contigs using FMD index\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: reads_fmd
    type: File
    doc: Reads in FMD index format
    inputBinding:
      position: 1
  - id: contigs_fq
    type: File
    doc: Contigs in FASTQ format
    inputBinding:
      position: 2
  - id: max_insert_size
    type:
      - 'null'
      - int
    doc: maximum insert size (external distance)
    inputBinding:
      position: 103
      prefix: -D
  - id: min_paired_end_coverage
    type:
      - 'null'
      - int
    doc: minimum paired-end coverage
    inputBinding:
      position: 103
      prefix: -c
  - id: rank_file
    type:
      - 'null'
      - File
    doc: rank
    inputBinding:
      position: 103
      prefix: -r
  - id: skip_ending_bases
    type:
      - 'null'
      - int
    doc: skip ending INT bases of a read pair
    inputBinding:
      position: 103
      prefix: -l
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_remap.out
