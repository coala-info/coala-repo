cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fuc
  - ngs-hc
label: fuc_ngs-hc
doc: "Pipeline for germline short variant discovery.\n\nTool homepage: https://github.com/sbslee/fuc"
inputs:
  - id: manifest
    type: File
    doc: Sample manifest CSV file.
    inputBinding:
      position: 1
  - id: fasta
    type: File
    doc: Reference FASTA file.
    inputBinding:
      position: 2
  - id: output
    type: Directory
    doc: Output directory.
    inputBinding:
      position: 3
  - id: qsub
    type: string
    doc: SGE resoruce to request for qsub.
    inputBinding:
      position: 4
  - id: java1
    type: string
    doc: Java resoruce to request for single-sample variant calling.
    inputBinding:
      position: 5
  - id: java2
    type: string
    doc: Java resoruce to request for joint variant calling.
    inputBinding:
      position: 6
  - id: batch
    type:
      - 'null'
      - int
    doc: Batch size used for GenomicsDBImport. This controls the number of 
      samples for which readers are open at once and therefore provides a way to
      minimize memory consumption. The size of 0 means no batching (i.e. readers
      for all samples will be opened at once).
    inputBinding:
      position: 107
      prefix: --batch
  - id: bed
    type:
      - 'null'
      - File
    doc: BED file.
    inputBinding:
      position: 107
      prefix: --bed
  - id: dbsnp
    type:
      - 'null'
      - File
    doc: VCF file from dbSNP.
    inputBinding:
      position: 107
      prefix: --dbsnp
  - id: force
    type:
      - 'null'
      - boolean
    doc: Overwrite the output directory if it already exists.
    inputBinding:
      position: 107
      prefix: --force
  - id: job
    type:
      - 'null'
      - string
    doc: Job submission ID for SGE.
    inputBinding:
      position: 107
      prefix: --job
  - id: keep
    type:
      - 'null'
      - boolean
    doc: Keep temporary files.
    inputBinding:
      position: 107
      prefix: --keep
  - id: posix
    type:
      - 'null'
      - boolean
    doc: Set GenomicsDBImport to allow for optimizations to improve the 
      usability and performance for shared Posix Filesystems (e.g. NFS, Lustre).
      If set, file level locking is disabled and file system writes are 
      minimized by keeping a higher number of file descriptors open for longer 
      periods of time. Use with --batch if keeping a large number of file 
      descriptors open is an issue.
    inputBinding:
      position: 107
      prefix: --posix
  - id: thread
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 107
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fuc:0.38.0--pyh7e72e81_0
stdout: fuc_ngs-hc.out
