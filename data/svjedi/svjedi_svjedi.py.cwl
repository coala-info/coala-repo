cwlVersion: v1.2
class: CommandLineTool
baseCommand: svjedi.py
label: svjedi_svjedi.py
doc: "Structural variations genotyping using long reads\n\nTool homepage: https://github.com/llecompte/SVJedi"
inputs:
  - id: allele_size
    type:
      - 'null'
      - string
    doc: Sequence allele adjacencies at each side of the SV
    inputBinding:
      position: 101
      prefix: -ladj
  - id: dist_end
    type:
      - 'null'
      - string
    doc: soft clipping length allowed for semi global alingments
    inputBinding:
      position: 101
      prefix: -dend
  - id: dist_overlap
    type:
      - 'null'
      - string
    doc: breakpoint distance overlap
    inputBinding:
      position: 101
      prefix: -dover
  - id: minNbAln
    type:
      - 'null'
      - int
    doc: Minimum number of alignments to genotype a SV
    default: 3>=
    inputBinding:
      position: 101
      prefix: --minsupport
  - id: nb_threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: paffile
    type:
      - 'null'
      - File
    doc: PAF format
    inputBinding:
      position: 101
      prefix: --paf
  - id: readfile
    type:
      - 'null'
      - type: array
        items: File
    doc: reads
    inputBinding:
      position: 101
      prefix: --input
  - id: refallelefile
    type:
      - 'null'
      - File
    doc: fasta format
    inputBinding:
      position: 101
      prefix: --allele
  - id: refgenomefile
    type:
      - 'null'
      - File
    doc: fasta format
    inputBinding:
      position: 101
      prefix: --ref
  - id: seq_data_type
    type:
      - 'null'
      - string
    doc: seq data type
    inputBinding:
      position: 101
      prefix: --data
  - id: vcffile
    type: File
    doc: vcf format
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: genotype output file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svjedi:1.1.6--hdfd78af_1
