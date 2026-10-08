cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - seeds
label: polap_seeds
doc: "Select seed contigs for organelle-genome assembly from an annotated Flye genome assembly.\n\
  \nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: outdir
    type: Directory
    doc: Polap output folder with the annotated assembly graph; it is updated in place.
    inputBinding:
      position: 101
      prefix: -o
      valueFrom: $(self.basename)
  - id: inum
    type:
      - 'null'
      - int
    doc: Index of the source assembly (folder <outdir>/<inum>); default 0.
    inputBinding:
      position: 101
      prefix: -i
  - id: jnum
    type:
      - 'null'
      - int
    doc: Index of the target organelle-genome assembly; default 1.
    inputBinding:
      position: 101
      prefix: -j
  - id: plastid
    type:
      - 'null'
      - boolean
    doc: Use plastid genes instead of mitochondrial genes.
    inputBinding:
      position: 101
      prefix: --plastid
  - id: max_seeds
    type:
      - 'null'
      - int
    doc: Maximum number of seed contigs (seeds-graph selection).
    inputBinding:
      position: 101
      prefix: --max-seeds
  - id: long_reads
    type:
      - 'null'
      - File
    doc: Long-read data file in FASTQ format.
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_seeds.out
