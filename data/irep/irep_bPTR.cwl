cwlVersion: v1.2
class: CommandLineTool
baseCommand: bPTR
label: irep_bPTR
doc: "Calculate peak-to-trough ratio (PTR) to estimate microbial growth rates from
  metagenomic data.\n\nTool homepage: https://github.com/christophertbrown/iRep"
inputs:
  - id: fasta
    type:
      type: array
      items: File
    doc: fasta file(s) (comma separated)
    inputBinding:
      position: 101
      prefix: -f
  - id: mapping_file
    type:
      - 'null'
      - File
    doc: mapping file (output from iRep)
    inputBinding:
      position: 101
      prefix: -m
  - id: max_scaffolds
    type:
      - 'null'
      - int
    doc: maximum number of scaffolds
    inputBinding:
      position: 101
      prefix: -M
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum length of scaffold
    inputBinding:
      position: 101
      prefix: -L
  - id: min_reads
    type:
      - 'null'
      - int
    doc: minimum number of reads
    inputBinding:
      position: 101
      prefix: -n
  - id: plot_ptr
    type:
      - 'null'
      - boolean
    doc: plot PTR (pdf)
    inputBinding:
      position: 101
      prefix: -plot
  - id: sam_files
    type:
      type: array
      items: File
    doc: sam file(s) (comma separated) - must be in the same order as fasta
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/irep:1.1.7--pyh24bf2e0_1
