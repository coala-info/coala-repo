cwlVersion: v1.2
class: CommandLineTool
baseCommand: RD-Analyzer-extended.py
label: rd-analyzer_RD-Analyzer-extended.py
doc: "RD-Analyzer-extended.py\n\nTool homepage: https://github.com/xiaeryu/RD-Analyzer"
inputs:
  - id: ref_fasta
    type: File
    secondaryFiles:
      - .fai
    doc: Reference FASTA file
    inputBinding:
      position: 1
  - id: fastq_1
    type: File
    doc: FASTQ file 1
    inputBinding:
      position: 2
  - id: fastq_2
    type:
      - 'null'
      - File
    doc: FASTQ file 2 (optional)
    inputBinding:
      position: 3
  - id: debug
    type:
      - 'null'
      - boolean
    doc: enable debug mode, keeping all intermediate files
    inputBinding:
      position: 104
      prefix: --debug
  - id: outdir
    type:
      - 'null'
      - string
    doc: output directory
    inputBinding:
      position: 104
      prefix: --outdir
  - id: output
    type:
      - 'null'
      - string
    doc: basename of output files
    inputBinding:
      position: 104
      prefix: --output
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the prefix given in output
    outputBinding:
      glob: $(inputs.output)*
  - id: outdir_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0
stdout: rd-analyzer_RD-Analyzer-extended.py.out
