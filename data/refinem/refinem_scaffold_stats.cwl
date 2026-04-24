cwlVersion: v1.2
class: CommandLineTool
baseCommand: refinem scaffold_stats
label: refinem_scaffold_stats
doc: "Calculate statistics for scaffolds.\n\nTool homepage: http://pypi.python.org/pypi/refinem/"
inputs:
  - id: scaffold_file
    type: File
    doc: scaffolds binned to generate putative genomes
    inputBinding:
      position: 1
  - id: genome_nt_dir
    type: Directory
    doc: directory containing nucleotide scaffolds for each genome
    inputBinding:
      position: 2
  - id: output_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 3
  - id: bam_files
    type:
      - 'null'
      - type: array
        items: File
    doc: BAM files to parse for coverage profile
    inputBinding:
      position: 4
  - id: cov_all_reads
    type:
      - 'null'
      - boolean
    doc: use all reads to estimate coverage instead of just proper pairs
    inputBinding:
      position: 105
      prefix: --cov_all_reads
  - id: cov_max_edit_dist
    type:
      - 'null'
      - float
    doc: maximum edit distance as percentage of read length
    inputBinding:
      position: 105
      prefix: --cov_max_edit_dist
  - id: cov_min_align
    type:
      - 'null'
      - float
    doc: minimum alignment length as percentage of read length
    inputBinding:
      position: 105
      prefix: --cov_min_align
  - id: coverage_file
    type:
      - 'null'
      - File
    doc: file containing coverage profile information
    inputBinding:
      position: 105
      prefix: --coverage_file
  - id: cpus
    type:
      - 'null'
      - int
    doc: number of CPUs to use
    inputBinding:
      position: 105
      prefix: --cpus
  - id: genome_ext
    type:
      - 'null'
      - string
    doc: extension of genomes (other files in directory are ignored)
    inputBinding:
      position: 105
      prefix: --genome_ext
  - id: silent
    type:
      - 'null'
      - boolean
    doc: suppress output of logger
    inputBinding:
      position: 105
      prefix: --silent
  - id: tetra_file
    type:
      - 'null'
      - File
    doc: file containing tetranucleotide signatures information
    inputBinding:
      position: 105
      prefix: --tetra_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/refinem:0.1.2--pyh3252c3a_0
stdout: refinem_scaffold_stats.out
