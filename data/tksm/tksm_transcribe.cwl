cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - tksm
  - transcribe
label: tksm_transcribe
doc: "RNA splicing module: builds RNA transcript molecules (MDF) given transcript abundances and a GTF annotation\n\nTool homepage: https://github.com/vpc-ccg/tksm"
inputs:
  - id: gtf
    type: File
    doc: "Path to gtf annotation file"
    inputBinding:
      position: 1
      prefix: --gtf
  - id: abundance
    type:
      - 'null'
      - File
    doc: "Path to tab separated abundances table (formatted as transcript_id, tpm, cell-barcode)"
    inputBinding:
      position: 1
      prefix: --abundance
  - id: use_whole_id
    type:
      - 'null'
      - boolean
    doc: "Do not trim the transcript version"
    inputBinding:
      position: 1
      prefix: --use-whole-id
  - id: molecule_count
    type:
      - 'null'
      - int
    doc: "Number of molecules to simulate"
    inputBinding:
      position: 1
      prefix: --molecule-count
  - id: output
    type: string
    doc: "Output path"
    inputBinding:
      position: 1
      prefix: --output
  - id: non_coding
    type:
      - 'null'
      - boolean
    doc: "Process non-coding genes/transcripts as well"
    inputBinding:
      position: 1
      prefix: --non-coding
  - id: default_depth
    type:
      - 'null'
      - float
    doc: "Default depth for transcripts that are not in expression table (default: 0)"
    inputBinding:
      position: 1
      prefix: --default-depth
  - id: molecule_prefix
    type:
      - 'null'
      - string
    doc: "Prefix for molecule names (default: M)"
    inputBinding:
      position: 1
      prefix: --molecule-prefix
  - id: weights
    type:
      - 'null'
      - string
    doc: "Comma separated weights of each provided abundance file (default: 1)"
    inputBinding:
      position: 1
      prefix: --weights
  - id: fusion_gtf
    type:
      - 'null'
      - string
    doc: "Path to output GTF annotation file for fusions"
    inputBinding:
      position: 1
      prefix: --fusion-gtf
  - id: fusion_file
    type:
      - 'null'
      - File
    doc: "Path to tab separated fusion file"
    inputBinding:
      position: 1
      prefix: --fusion-file
  - id: fusion_output
    type:
      - 'null'
      - string
    doc: "Description of generated fusions (output path)"
    inputBinding:
      position: 1
      prefix: --fusion-output
  - id: fusion_count
    type:
      - 'null'
      - int
    doc: "Number of random fusions to generate (default: 0)"
    inputBinding:
      position: 1
      prefix: --fusion-count
  - id: disable_deletions
    type:
      - 'null'
      - boolean
    doc: "Disables deletions (from fusions) that remove expression on the overlapping genes"
    inputBinding:
      position: 1
      prefix: --disable-deletions
  - id: translocation_ratio
    type:
      - 'null'
      - float
    doc: "Ratio of translocated fusions (default: 0)"
    inputBinding:
      position: 1
      prefix: --translocation-ratio
  - id: expression_fallback
    type:
      - 'null'
      - string
    doc: "Fallback expression distribution for transcripts that are not expressed, e.g. uniform,s,e or normal,mu,sigma"
    inputBinding:
      position: 1
      prefix: --expression-fallback
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random seed (default: 42)"
    inputBinding:
      position: 1
      prefix: --seed
  - id: verbosity
    type:
      - 'null'
      - string
    doc: "Verbosity level to choose from [DEBUG, ERROR, INFO, OFF, WARN] (default: INFO)"
    inputBinding:
      position: 1
      prefix: --verbosity
  - id: log_file
    type:
      - 'null'
      - string
    doc: "Log file to write the logs (or stderr/stdout) (default: stderr)"
    inputBinding:
      position: 1
      prefix: --log-file
outputs:
  - id: molecules
    type: File
    doc: "Simulated molecules (MDF)"
    outputBinding:
      glob: "$(inputs.output)"
  - id: fusion_gtf_file
    type:
      - 'null'
      - File
    doc: "Fusion GTF"
    outputBinding:
      glob: "$(inputs.fusion_gtf)"
  - id: fusion_description
    type:
      - 'null'
      - File
    doc: "Fusion description"
    outputBinding:
      glob: "$(inputs.fusion_output)"
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tksm:0.6.1--py310ha025fb0_1
stdout: tksm_transcribe.out
