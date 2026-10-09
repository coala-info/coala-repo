cwlVersion: v1.2
class: CommandLineTool
baseCommand: exec_annotation
label: kofamscan
doc: "KofamScan is a tool for gene annotation using Kofam (KEGG Ortholog Hidden Markov
  Model profiles) and HMMER.\n\nTool homepage: https://www.genome.jp/tools/kofamkoala/"
inputs:
  - id: query
    type: File
    doc: FASTA formatted query sequence file
    inputBinding:
      position: 100
  - id: output_file_path
    type: string
    doc: File to output the result
    inputBinding:
      position: 1
      prefix: -o
  - id: profile
    type:
      - 'null'
      - Directory
    doc: Profile HMM database (directory of KOfam profiles with the .hal file)
    inputBinding:
      position: 1
      prefix: --profile
  - id: ko_list
    type:
      - 'null'
      - File
    doc: KO information file
    inputBinding:
      position: 1
      prefix: --ko-list
  - id: cpu
    type:
      - 'null'
      - int
    doc: Number of CPU to use
    inputBinding:
      position: 1
      prefix: --cpu
  - id: config
    type:
      - 'null'
      - File
    doc: Config file
    inputBinding:
      position: 1
      prefix: --config
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: Temporary directory (default ./tmp)
    inputBinding:
      position: 1
      prefix: --tmp-dir
  - id: e_value
    type:
      - 'null'
      - float
    doc: Largest E-value required of the hits
    inputBinding:
      position: 1
      prefix: --e-value
  - id: threshold_scale
    type:
      - 'null'
      - float
    doc: The score thresholds will be multiplied by this value
    inputBinding:
      position: 1
      prefix: --threshold-scale
  - id: format
    type:
      - 'null'
      - string
    doc: Format of the output (detail, detail-tsv, mapper, mapper-one-line)
    inputBinding:
      position: 1
      prefix: --format
  - id: report_unannotated
    type:
      - 'null'
      - boolean
    doc: Sequence name will be shown even if no KOs are assigned
    inputBinding:
      position: 1
      prefix: --report-unannotated
  - id: no_report_unannotated
    type:
      - 'null'
      - boolean
    doc: Do not show the sequence name when no KOs are assigned
    inputBinding:
      position: 1
      prefix: --no-report-unannotated
  - id: create_alignment
    type:
      - 'null'
      - boolean
    doc: Create domain annotation files for each sequence. They are located in
      the tmp directory. Incompatible with --reannotate
    inputBinding:
      position: 1
      prefix: --create-alignment
  - id: reannotate
    type:
      - 'null'
      - boolean
    doc: Skip hmmsearch. Incompatible with --create-alignment
    inputBinding:
      position: 1
      prefix: --reannotate
  - id: keep_tabular
    type:
      - 'null'
      - boolean
    doc: Neither create tabular.txt nor delete K number files
    inputBinding:
      position: 1
      prefix: --keep-tabular
  - id: keep_output
    type:
      - 'null'
      - boolean
    doc: Neither create output.txt nor delete K number files. Must be with
      --create-alignment
    inputBinding:
      position: 1
      prefix: --keep-output
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Result file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: tmp_output
    type:
      - 'null'
      - Directory
    doc: Temporary directory (holds the alignment files with --create-alignment)
    outputBinding:
      glob: $(inputs.tmp_dir || 'tmp')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kofamscan:1.3.0--hdfd78af_2
