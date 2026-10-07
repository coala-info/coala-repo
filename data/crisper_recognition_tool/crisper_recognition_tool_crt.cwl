cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - crt
  - crt
label: crisper_recognition_tool_crt
doc: "CRISPR Recognition Tool (CRT): finds CRISPR repeat arrays in a FASTA genome
  sequence. The bioconda wrapper `crt` runs `java -cp CRT1.2-CLI.jar`, so the
  class name `crt` is the first argument.\n\nTool homepage: http://www.room220.com/crt/"
inputs:
  - id: min_nr
    type:
      - 'null'
      - int
    doc: minimum number of repeats a CRISPR must contain; default 3
    inputBinding:
      position: 1
      prefix: -minNR
  - id: min_rl
    type:
      - 'null'
      - int
    doc: minimum length of a CRISPR's repeated region; default 19
    inputBinding:
      position: 1
      prefix: -minRL
  - id: max_rl
    type:
      - 'null'
      - int
    doc: maximum length of a CRISPR's repeated region; default 38
    inputBinding:
      position: 1
      prefix: -maxRL
  - id: min_sl
    type:
      - 'null'
      - int
    doc: minimum length of a CRISPR's non-repeated region (or spacer region); 
      default 19
    inputBinding:
      position: 1
      prefix: -minSL
  - id: max_sl
    type:
      - 'null'
      - int
    doc: maximum length of a CRISPR's non-repeated region (or spacer region); 
      default 48
    inputBinding:
      position: 1
      prefix: -maxSL
  - id: screen
    type:
      - 'null'
      - int
    doc: print results to the screen, instead of a file; (range 0-1); default 0
    inputBinding:
      position: 1
      prefix: -screen
  - id: search_wl
    type:
      - 'null'
      - int
    doc: length of search window used to discover CRISPRs; (range 6-9); default 
      8
    inputBinding:
      position: 1
      prefix: -searchWL
  - id: input_file
    type: File
    doc: Input genome sequence in FASTA format
    inputBinding:
      position: 2
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output report file; default a.out
    inputBinding:
      position: 3
outputs:
  - id: crispr_report
    type:
      - 'null'
      - File
    doc: CRISPR arrays found (repeats and spacers per array)
    outputBinding:
      glob: '$(inputs.output_file ? inputs.output_file : "a.out")'
  - id: stdout
    type: stdout
    doc: Standard output (the report when -screen 1 is set)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisper_recognition_tool:1.2--py35_0
stdout: crisper_recognition_tool_crt.out
