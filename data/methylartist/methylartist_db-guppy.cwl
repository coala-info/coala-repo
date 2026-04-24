cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylartist
  - db-guppy
label: methylartist_db-guppy
doc: "Process Guppy-called fast5 files to generate a methylation database\n\nTool
  homepage: https://github.com/adamewing/methylartist"
inputs:
  - id: append
    type:
      - 'null'
      - boolean
    doc: append to database
    inputBinding:
      position: 101
      prefix: --append
  - id: bam
    type: File
    doc: .bam file containing alignments of reads from fast5
    inputBinding:
      position: 101
      prefix: --bam
  - id: fast5
    type: Directory
    doc: fast5 with called bases
    inputBinding:
      position: 101
      prefix: --fast5
  - id: force
    type:
      - 'null'
      - boolean
    doc: force overwrite
    inputBinding:
      position: 101
      prefix: --force
  - id: include_unmatched
    type:
      - 'null'
      - boolean
    doc: include sites where read base does not match genome base
    inputBinding:
      position: 101
      prefix: --include_unmatched
  - id: minprob
    type:
      - 'null'
      - float
    doc: probability threshold for calling modified or unmodified base
    inputBinding:
      position: 101
      prefix: --minprob
  - id: modname
    type: string
    doc: mod name in guppy fast5 modified base alphabet (5mC, 6mA, etc)
    inputBinding:
      position: 101
      prefix: --modname
  - id: motif
    type: string
    doc: motif e.g. G[A]TC or [C]G
    inputBinding:
      position: 101
      prefix: --motif
  - id: motifsize
    type:
      - 'null'
      - int
    doc: mod motif size (default is 2 as "CG" is most common use case, e.g. set 
      to 1 for 6mA)
    inputBinding:
      position: 101
      prefix: --motifsize
  - id: procs
    type:
      - 'null'
      - int
    doc: multiprocessing
    inputBinding:
      position: 101
      prefix: --procs
  - id: ref
    type: File
    doc: reference genome fasta (samtools faidx indexed)
    inputBinding:
      position: 101
      prefix: --ref
  - id: samplename
    type: string
    doc: name for sample
    inputBinding:
      position: 101
      prefix: --samplename
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylartist:1.5.3--pyhdfd78af_0
stdout: methylartist_db-guppy.out
