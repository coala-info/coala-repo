cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - f5c
  - resquiggle
label: f5c_resquiggle
doc: "f5c resquiggle aligns nanopore signals to reference sequences\n\nTool homepage:
  https://github.com/hasindu2008/f5c"
inputs:
  - id: reads_fastq
    type: File
    doc: Input reads in FASTQ format
    inputBinding:
      position: 1
  - id: signals_blow5
    type: File
    doc: Input signals in BLOW5 format
    inputBinding:
      position: 2
  - id: batch_size
    type:
      - 'null'
      - int
    doc: batch size (max number of reads loaded at once)
    default: 512
    inputBinding:
      position: 103
      prefix: -K
  - id: kmer_model
    type:
      - 'null'
      - File
    doc: custom nucleotide k-mer model file
    inputBinding:
      position: 103
      prefix: --kmer-model
  - id: max_bases
    type:
      - 'null'
      - string
    doc: max number of bases loaded at once
    default: 5.0M
    inputBinding:
      position: 103
      prefix: -B
  - id: paf_format
    type:
      - 'null'
      - boolean
    doc: print in paf format
    inputBinding:
      position: 103
      prefix: -c
  - id: pore
    type:
      - 'null'
      - string
    doc: r9, r10 or rna004
    inputBinding:
      position: 103
      prefix: --pore
  - id: profile
    type:
      - 'null'
      - string
    doc: parameter profile to be used for better performance (e.g., laptop, 
      desktop, hpc)
    inputBinding:
      position: 103
      prefix: -x
  - id: rna
    type:
      - 'null'
      - boolean
    doc: the dataset is direct RNA
    inputBinding:
      position: 103
      prefix: --rna
  - id: threads
    type:
      - 'null'
      - int
    doc: number of processing threads
    default: 8
    inputBinding:
      position: 103
      prefix: -t
  - id: verbose
    type:
      - 'null'
      - int
    doc: verbosity level
    default: 0
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output to file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/f5c:1.6--hee927d3_0
