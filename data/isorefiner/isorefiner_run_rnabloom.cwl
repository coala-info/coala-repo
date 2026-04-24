cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - isorefiner
  - run_rnabloom
label: isorefiner_run_rnabloom
doc: "Run RNA-Bloom for transcript assembly and quantification.\n\nTool homepage:
  https://github.com/rkajitani/IsoRefiner"
inputs:
  - id: genome
    type:
      - 'null'
      - File
    doc: Reference genome (FASTA)
    inputBinding:
      position: 101
      prefix: --genome
  - id: gmap_max_intron
    type:
      - 'null'
      - int
    doc: Max intron length for GMAP (bp)
    inputBinding:
      position: 101
      prefix: --gmap_max_intron
  - id: gmap_min_cov
    type:
      - 'null'
      - float
    doc: Min alignment coverage for GMAP [0-1]
    inputBinding:
      position: 101
      prefix: --gmap_min_cov
  - id: gmap_min_idt
    type:
      - 'null'
      - float
    doc: Min identity for GMAP [0-1]
    inputBinding:
      position: 101
      prefix: --gmap_min_idt
  - id: gmap_option
    type:
      - 'null'
      - string
    doc: Option for GMAP (quoted string)
    inputBinding:
      position: 101
      prefix: --gmap_option
  - id: max_mem
    type:
      - 'null'
      - string
    doc: Max memory for RNA-Bloom (java -Xmx)
    inputBinding:
      position: 101
      prefix: --max_mem
  - id: reads
    type:
      type: array
      items: File
    doc: Reads (FASTQ or FASTA, gzip allowed, mandatory)
    inputBinding:
      position: 101
      prefix: --reads
  - id: rnabloom_option
    type:
      - 'null'
      - string
    doc: Option for RNA-Bloom (quoted string)
    inputBinding:
      position: 101
      prefix: --rnabloom_option
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: work_dir
    type:
      - 'null'
      - Directory
    doc: Working directory containing intermediate and log files
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
