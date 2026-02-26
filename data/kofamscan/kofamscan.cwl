cwlVersion: v1.2
class: CommandLineTool
baseCommand: exec_annotation
label: kofamscan
doc: "KofamScan is a tool for gene annotation using Kofam (KEGG Ortholog Hidden Markov
  Model profiles) and HMMER.\n\nTool homepage: https://www.genome.jp/tools/kofamkoala/"
inputs:
  - id: query
    type: File
    doc: Input query gene file (protein FASTA format)
    inputBinding:
      position: 1
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPU cores to use
    inputBinding:
      position: 102
      prefix: --cpu
  - id: e_value
    type:
      - 'null'
      - float
    doc: E-value threshold for HMMER search
    inputBinding:
      position: 102
      prefix: --e-value
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (detail, detail-tsv, mapper, mapper-tsv)
    inputBinding:
      position: 102
      prefix: --format
  - id: ko_list
    type:
      - 'null'
      - File
    doc: Path to the KO list file
    inputBinding:
      position: 102
      prefix: --ko-list
  - id: profile
    type:
      - 'null'
      - Directory
    doc: Path to the directory containing KOfam HMM profiles
    inputBinding:
      position: 102
      prefix: --profile
  - id: report_unannotated
    type:
      - 'null'
      - boolean
    doc: Report sequences that do not match any KO
    inputBinding:
      position: 102
      prefix: --report-unannotated
  - id: threshold_scale
    type:
      - 'null'
      - float
    doc: The score thresholds are multiplied by this value
    inputBinding:
      position: 102
      prefix: --threshold-scale
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for HMMER output
    inputBinding:
      position: 102
      prefix: --tmp-dir
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kofamscan:1.3.0--hdfd78af_2
