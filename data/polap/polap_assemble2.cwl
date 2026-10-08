cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - assemble2
label: polap_assemble2
doc: "Assemble an organelle genome with Flye from seed contigs selected in a previous whole-genome\
  \ assembly (output folder of assemble1 and seeds).\n\nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: outdir
    type: Directory
    doc: Polap output folder from assemble1/annotate/seeds; it is updated in place.
    inputBinding:
      position: 101
      prefix: -o
      valueFrom: $(self.basename)
  - id: long_reads
    type: File
    doc: Long-read data file in FASTQ format.
    inputBinding:
      position: 101
      prefix: -l
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
  - id: single_min
    type:
      - 'null'
      - int
    doc: Minimum mapping length for read selection.
    inputBinding:
      position: 101
      prefix: -w
  - id: coverage
    type:
      - 'null'
      - int
    doc: Coverage option for the Flye assembly.
    inputBinding:
      position: 101
      prefix: -c
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU cores.
    inputBinding:
      position: 101
      prefix: -t
  - id: polap_reads
    type:
      - 'null'
      - boolean
    doc: Use the POLAP read selection instead of ptGAUL's.
    inputBinding:
      position: 101
      prefix: --polap-reads
  - id: coverage_check
    type:
      - 'null'
      - boolean
    doc: Reduce data in the organelle-genome assembly by coverage.
    inputBinding:
      position: 101
      prefix: --coverage-check
  - id: no_coverage_check
    type:
      - 'null'
      - boolean
    doc: No data reduction in the organelle-genome assembly.
    inputBinding:
      position: 101
      prefix: --no-coverage-check
  - id: min_read_length
    type:
      - 'null'
      - int
    doc: Minimum read length.
    inputBinding:
      position: 101
      prefix: -m
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
stdout: polap_assemble2.out
