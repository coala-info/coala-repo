cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - polish
label: polap_polish
doc: "Polish a draft organelle genome sequence in FASTA format with short-read (FMLRC) or\
  \ long-read data.\n\nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: outdir
    type: Directory
    doc: Polap output folder from prepare-polishing (holds the short-read index); it is updated
      in place.
    inputBinding:
      position: 101
      prefix: -o
      valueFrom: $(self.basename)
  - id: unpolished_fasta
    type: File
    doc: Draft genome assembly sequence file.
    inputBinding:
      position: 101
      prefix: -p
  - id: final_assembly
    type: string
    doc: Name of the polished (final) genome assembly sequence file.
    default: mt.1.fa
    inputBinding:
      position: 101
      prefix: -f
  - id: long_reads
    type:
      - 'null'
      - File
    doc: Long-read data file (FASTQ) for long-read polishing.
    inputBinding:
      position: 101
      prefix: -l
  - id: short_read1
    type:
      - 'null'
      - File
    doc: Short-read FASTQ file 1.
    inputBinding:
      position: 101
      prefix: -a
  - id: short_read2
    type:
      - 'null'
      - File
    doc: Short-read FASTQ file 2.
    inputBinding:
      position: 101
      prefix: -b
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir.basename)
  - id: polished_fasta
    type: File
    doc: Polished genome sequence.
    outputBinding:
      glob: $(inputs.final_assembly)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outdir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_polish.out
