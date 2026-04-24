cwlVersion: v1.2
class: CommandLineTool
baseCommand: viralFlye.py
label: viralflye_viralFlye.py
doc: "Wrapper script for viralFlye pipeline \n\nSee readme for details\n\nTool homepage:
  https://github.com/Dmitry-Antipov/viralFlye/"
inputs:
  - id: completeness
    type:
      - 'null'
      - float
    doc: Completeness cutoff for viralComplete
    inputBinding:
      position: 101
      prefix: --completeness
  - id: dir
    type: Directory
    doc: metaFlye output directory
    inputBinding:
      position: 101
      prefix: --dir
  - id: hmm
    type: string
    doc: Path to Pfam-A HMM database for viralVerify script
    inputBinding:
      position: 101
      prefix: --hmm
  - id: ill1
    type:
      - 'null'
      - File
    doc: file with left illumina reads for polishing
    inputBinding:
      position: 101
      prefix: --ill1
  - id: ill2
    type:
      - 'null'
      - File
    doc: file with right illumina reads for polishing
    inputBinding:
      position: 101
      prefix: --ill2
  - id: min_viral_length
    type:
      - 'null'
      - int
    doc: minimal limit on the viral length under study
    inputBinding:
      position: 101
      prefix: --min_viral_length
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --outdir
  - id: raven
    type:
      - 'null'
      - boolean
    doc: Use raven assembler
    inputBinding:
      position: 101
      prefix: --raven
  - id: reads
    type: File
    doc: Path to long reads
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads used
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viralflye:0.2--pyhdfd78af_0
stdout: viralflye_viralFlye.py.out
