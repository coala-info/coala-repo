cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metacherchant.sh
  - --tool
  - environment-finder-multi
label: metacherchant_environment-finder-multi
doc: "MetaCherchant environment-finder-multi: displays the difference between multiple genomic environments.\n\nTool homepage: https://github.com/ctlab/metacherchant"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: env
    type: 
      type: array
      items: File
    doc: "environment files to build the difference for (MANDATORY)"
    inputBinding:
      position: 1
      prefix: --env
  - id: seq
    type: File
    doc: ".fasta file with nucleotide sequence[s] (MANDATORY)"
    inputBinding:
      position: 2
      prefix: --seq
  - id: output
    type: string
    doc: "output directory to write results to (MANDATORY)"
    inputBinding:
      position: 3
      prefix: --output
  - id: geneid
    type: 
      - 'null'
      - string
    doc: "gene id from .fasta file (optional, default: 1)"
    inputBinding:
      position: 4
      prefix: --geneid
  - id: memory
    type: 
      - 'null'
      - string
    doc: "memory to use (for example: 1500M, 4G, etc.) (optional, default: 2 Gb); always pass it, the wrapper script cannot detect free memory in the container"
    inputBinding:
      position: 20
      prefix: --memory
  - id: available_processors
    type: 
      - 'null'
      - int
    doc: "available processors (optional, default: all)"
    inputBinding:
      position: 21
      prefix: --available-processors
  - id: work_dir
    type: 
      - 'null'
      - string
    doc: "working directory (optional, default: workDir)"
    inputBinding:
      position: 22
      prefix: --work-dir
  - id: continue_run
    type: 
      - 'null'
      - boolean
    doc: "continue the previous run from last succeed stage, saved in working directory (optional)"
    inputBinding:
      position: 23
      prefix: --continue
  - id: force_run
    type: 
      - 'null'
      - boolean
    doc: "force run with rewriting old results (optional)"
    inputBinding:
      position: 24
      prefix: --force
  - id: start_stage
    type: 
      - 'null'
      - string
    doc: "first force run stage (with rewriting old results) (optional)"
    inputBinding:
      position: 25
      prefix: --start
  - id: finish_stage
    type: 
      - 'null'
      - string
    doc: "stop after running this stage (optional)"
    inputBinding:
      position: 26
      prefix: --finish
  - id: enable_assertions
    type: 
      - 'null'
      - boolean
    doc: "enable assertions (optional, default: assertions disabled)"
    inputBinding:
      position: 27
      prefix: --enable-assertions
  - id: verbose
    type: 
      - 'null'
      - boolean
    doc: "enable debug output (optional)"
    inputBinding:
      position: 28
      prefix: --verbose
outputs:
  - id: difference
    type: Directory
    doc: "Output directory with the difference between the environments"
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metacherchant:0.1.0--1
stdout: metacherchant_multi.out
