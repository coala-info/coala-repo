cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cressent
  - recombination
label: cressent_recombination
doc: "Detect recombination events in ssDNA virus sequences.\n\nTool homepage: https://github.com/ricrocha82/cressent"
inputs:
  - id: input_fasta
    type: File
    doc: "Input alignment file in FASTA format"
    inputBinding:
      position: 101
      prefix: --input_fasta
  - id: output_dir
    type: string
    doc: "Path to the output directory (created by the tool; collected as the output). It is passed as an absolute path because the tool changes into it before writing the results file"
    inputBinding:
      position: 101
      prefix: --output
      valueFrom: $(runtime.outdir + '/' + self)
  - id: output_file
    type: string
    doc: "Output file for results (CSV format)"
    inputBinding:
      position: 101
      prefix: --output_file
  - id: config
    type:
      - 'null'
      - File
    doc: "Configuration file in INI format for OpenRDP parameters"
    inputBinding:
      position: 101
      prefix: --config
  - id: rdp
    type:
      - 'null'
      - boolean
    doc: "Run RDP method"
    inputBinding:
      position: 101
      prefix: -rdp
  - id: threeseq
    type:
      - 'null'
      - boolean
    doc: "Run 3Seq method"
    inputBinding:
      position: 101
      prefix: -threeseq
  - id: geneconv
    type:
      - 'null'
      - boolean
    doc: "Run GENECONV method"
    inputBinding:
      position: 101
      prefix: -geneconv
  - id: maxchi
    type:
      - 'null'
      - boolean
    doc: "Run MaxChi method"
    inputBinding:
      position: 101
      prefix: -maxchi
  - id: chimaera
    type:
      - 'null'
      - boolean
    doc: "Run Chimaera method"
    inputBinding:
      position: 101
      prefix: -chimaera
  - id: bootscan
    type:
      - 'null'
      - boolean
    doc: "Run Bootscan method"
    inputBinding:
      position: 101
      prefix: -bootscan
  - id: siscan
    type:
      - 'null'
      - boolean
    doc: "Run Siscan method"
    inputBinding:
      position: 101
      prefix: -siscan
  - id: all_methods
    type:
      - 'null'
      - boolean
    doc: "Run all methods"
    inputBinding:
      position: 101
      prefix: -all
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: "Suppress console output"
    inputBinding:
      position: 101
      prefix: -quiet
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Enable verbose logging"
    inputBinding:
      position: 101
      prefix: -verbose
outputs:
  - id: output
    type: Directory
    doc: Output directory with all result files
    outputBinding:
      glob: $(inputs.output_dir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cressent:1.0.2--pyhdfd78af_0
