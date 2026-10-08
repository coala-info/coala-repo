cwlVersion: v1.2
class: CommandLineTool
baseCommand: run-calling
label: fermikit_run-calling
doc: "Print the shell commands that map assembled unitigs to a reference and call small\
  \ variants and structural variants (run the output with sh).\n\nTool homepage: https://github.com/lh3/fermikit"
inputs:
  - id: indexed_ref
    type: File
    doc: reference FASTA indexed with bwa index
    secondaryFiles:
      - pattern: .amb
        required: true
      - pattern: .ann
        required: true
      - pattern: .bwt
        required: true
      - pattern: .pac
        required: true
      - pattern: .sa
        required: true
    inputBinding:
      position: 201
  - id: unitigs_mag_gz
    type: File
    doc: unitigs.mag.gz
    inputBinding:
      position: 202
  - id: bwa_index_prefix
    type:
      - 'null'
      - string
    doc: prefix for BWA index
    inputBinding:
      position: 103
      prefix: -b
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: prefix of output files
    inputBinding:
      position: 103
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: commands
    type: stdout
    doc: Shell script that maps the unitigs and calls variants; run it with sh
      to write PREFIX.flt.vcf.gz and PREFIX.sv.vcf.gz
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermikit:0.14.dev1--pl5321h86e5fe9_2
stdout: fermikit_run-calling.out
