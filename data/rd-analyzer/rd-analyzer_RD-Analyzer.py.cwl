cwlVersion: v1.2
class: CommandLineTool
baseCommand: RD-Analyzer.py
label: rd-analyzer_RD-Analyzer.py
doc: "RD-Analyzer.py\n\nTool homepage: https://github.com/xiaeryu/RD-Analyzer"
inputs:
  - id: fastq_1
    type: File
    doc: FASTQ_1
    inputBinding:
      position: 1
  - id: fastq_2
    type:
      - 'null'
      - File
    doc: FASTQ_2(optional)
    inputBinding:
      position: 2
  - id: coverage
    type:
      - 'null'
      - float
    doc: sequence coverage cut-off (0-1), used when '-p' is set
    inputBinding:
      position: 103
      prefix: --coverage
  - id: debug
    type:
      - 'null'
      - boolean
    doc: enable debug mode, keeping all intermediate files
    inputBinding:
      position: 103
      prefix: --debug
  - id: min_read_depth
    type:
      - 'null'
      - float
    doc: read depth cut-off (in the unit of average depth, 0-1), used when '-p' 
      is set
    inputBinding:
      position: 103
      prefix: --min
  - id: outdir
    type:
      - 'null'
      - string
    doc: output directory
    inputBinding:
      position: 103
      prefix: --outdir
  - id: output
    type:
      - 'null'
      - string
    doc: basename of output files
    inputBinding:
      position: 103
      prefix: --output
  - id: personalized
    type:
      - 'null'
      - boolean
    doc: use personalized cut-offs
    inputBinding:
      position: 103
      prefix: --personalized
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
stdout: rd-analyzer_RD-Analyzer.py.out
