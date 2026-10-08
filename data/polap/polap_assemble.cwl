cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - polap
  - assemble
label: polap_assemble
doc: "Assemble plant organelle-genome sequences from ONT long reads: miniasm seed contigs,\
  \ Flye assembly, Oatk pathfinder extraction and polishing with Racon, fmlrc2 and polypolish.\n\
  \nTool homepage: https://github.com/goshng/polap"
inputs:
  - id: long_reads
    type: File
    doc: Long-read data file in FASTQ format.
    inputBinding:
      position: 101
      prefix: -l
  - id: short_read1
    type: File
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
  - id: outdir
    type: string
    doc: Output folder name.
    default: o
    inputBinding:
      position: 101
      prefix: -o
  - id: prefix
    type: string
    doc: Prefix of the result files <prefix>.pt.gfa, .mt.gfa, .pt.fa and .mt.fa.
    default: polap
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (log).
  - id: outdir_out
    type: Directory
    doc: Output folder with all polap results.
    outputBinding:
      glob: $(inputs.outdir)
  - id: pt_gfa
    type:
      - 'null'
      - File
    doc: Plastid genome assembly graph.
    outputBinding:
      glob: $(inputs.prefix).pt.gfa
  - id: mt_gfa
    type:
      - 'null'
      - File
    doc: Mitochondrial genome assembly graph.
    outputBinding:
      glob: $(inputs.prefix).mt.gfa
  - id: pt_fasta
    type:
      - 'null'
      - File
    doc: Polished plastid genome sequence.
    outputBinding:
      glob: $(inputs.prefix).pt.fa
  - id: mt_fasta
    type:
      - 'null'
      - File
    doc: Polished mitochondrial genome sequence.
    outputBinding:
      glob: $(inputs.prefix).mt.fa
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
stdout: polap_assemble.out
