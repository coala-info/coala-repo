cwlVersion: v1.2
class: CommandLineTool
baseCommand: isorefiner_map
label: isorefiner_map
doc: "Map reads to a reference genome using minimap2 and sort the output.\n\nTool
  homepage: https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: genome
    type: File
    doc: Reference genome (FASTA, mandatory)
    inputBinding:
      position: 101
      prefix: --genome
  - id: mm2_option
    type:
      - 'null'
      - string
    doc: Option for minimap2 (quoted string)
    default: -x splice -ub -k14 --secondary=no
    inputBinding:
      position: 101
      prefix: --mm2_option
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output BAM files
    default: isorefiner_mapped
    inputBinding:
      position: 101
      prefix: --out_prefix
  - id: reads
    type:
      type: array
      items: File
    doc: Reads (FASTQ or FASTA, gzip allowed, mandatory)
    default: None
    inputBinding:
      position: 101
      prefix: --reads
  - id: sort_option
    type:
      - 'null'
      - string
    doc: Option for samtools sort (quoted string)
    default: -m 2G
    inputBinding:
      position: 101
      prefix: --sort_option
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
    default: isorefiner_map_work
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isorefiner:0.1.0--pyh7e72e81_1
stdout: isorefiner_map.out
