cwlVersion: v1.2
class: CommandLineTool
baseCommand: ptGAUL.sh
label: ptgaul_ptGAUL.sh
doc: "this pipeline is used for plastome assembly using long read data.\n\nTool homepage:
  https://github.com/Bean061/ptgaul"
inputs:
  - id: coverage
    type:
      - 'null'
      - int
    doc: a rough coverage of data used for plastome assembly
    default: 50
    inputBinding:
      position: 101
      prefix: --coverage
  - id: filtered
    type:
      - 'null'
      - int
    doc: the raw long reads will be filtered if the lengths are less than this 
      number (bp)
    default: 3000
    inputBinding:
      position: 101
      prefix: --filtered
  - id: genome_size
    type:
      - 'null'
      - int
    doc: expected genome size of plastome (bp)
    default: 160000
    inputBinding:
      position: 101
      prefix: --genomesize
  - id: long_reads
    type: File
    doc: 'MANDATORY: raw long reads in fasta/fastq/fq.gz format'
    inputBinding:
      position: 101
      prefix: --longreads
  - id: reference
    type: File
    doc: 'MANDATORY: reference contigs or scaffolds in fasta format'
    inputBinding:
      position: 101
      prefix: --reference
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory of results, defult is current directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ptgaul:1.0.5--pyhdfd78af_1
