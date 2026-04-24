cwlVersion: v1.2
class: CommandLineTool
baseCommand: TEcount
label: tecount_TEcount
doc: "Count reads mapping on Transposable Elements subfamilies, families and classes.\n\
  \nTool homepage: https://github.com/bodegalab/tecount"
inputs:
  - id: bam_file
    type: File
    doc: scRNA-seq reads aligned to a reference genome
    inputBinding:
      position: 101
      prefix: --bam
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Keep temporary files
    inputBinding:
      position: 101
      prefix: --keeptmp
  - id: min_overlap
    type:
      - 'null'
      - int
    doc: Minimum bp overlap between read and feature
    inputBinding:
      position: 101
      prefix: --overlap
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output file names
    inputBinding:
      position: 101
      prefix: --prefix
  - id: rmsk_bed_gz
    type: File
    doc: Genomic TE coordinates in bed format, with subfamily, family and class 
      on columns 7, 8 and 9. Plain text or gzip-compressed.
    inputBinding:
      position: 101
      prefix: --rmsk
  - id: strandness
    type:
      - 'null'
      - string
    doc: 'Strandness of the library. One of: "unstranded" (default), "forward", "reverse".'
    inputBinding:
      position: 101
      prefix: --strandness
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of cpus to use
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary files directory
    inputBinding:
      position: 101
      prefix: --tmpdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tecount:1.0.1--pyhdfd78af_0
stdout: tecount_TEcount.out
