cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapless.sh
label: gapless_gapless.sh
doc: "Improves input assembly with reads in {long_reads}.fq using gapless, minimap2,
  racon and seqtk\n\nTool homepage: https://github.com/schmeing/gapless"
inputs:
  - id: long_reads
    type: File
    doc: long_reads.fq
    inputBinding:
      position: 1
  - id: input_assembly
    type:
      - 'null'
      - File
    doc: Input assembly (fasta)
    inputBinding:
      position: 102
      prefix: -i
  - id: iterations
    type:
      - 'null'
      - int
    doc: Number of iterations
    default: 3
    inputBinding:
      position: 102
      prefix: -n
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Output directory (improved assembly is written to gapless.fa in this 
      directory)
    default: gapless_run
    inputBinding:
      position: 102
      prefix: -o
  - id: read_type
    type:
      - 'null'
      - string
    doc: Type of long reads ('pb_clr','pb_hifi','nanopore')
    inputBinding:
      position: 102
      prefix: -t
  - id: restart
    type:
      - 'null'
      - boolean
    doc: Restart at the start iteration and overwrite instead of incorporat 
      already present files
    inputBinding:
      position: 102
      prefix: -r
  - id: start_iteration
    type:
      - 'null'
      - int
    doc: Start iteration (Previous runs must be present in output directory)
    default: 1
    inputBinding:
      position: 102
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 4
    inputBinding:
      position: 102
      prefix: -j
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gapless:0.4--hdfd78af_0
stdout: gapless_gapless.sh.out
