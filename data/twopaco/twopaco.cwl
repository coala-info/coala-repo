cwlVersion: v1.2
class: CommandLineTool
baseCommand: twopaco
label: twopaco
doc: "Program for construction of the condensed de Bruijn graph from complete genomes\n\
  \nTool homepage: https://github.com/medvedevgroup/TwoPaCo"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: FASTA file(s) with nucleotide sequences.
    inputBinding:
      position: 1
  - id: abundance
    type:
      - 'null'
      - int
    doc: Vertex abundance threshold
    inputBinding:
      position: 102
      prefix: --abundance
  - id: filtermemory
    type: float
    doc: Memory in GBs allocated for the filter
    inputBinding:
      position: 102
      prefix: --filtermemory
  - id: filtersize
    type: int
    doc: Size of the filter
    inputBinding:
      position: 102
      prefix: --filtersize
  - id: hashfnumber
    type:
      - 'null'
      - int
    doc: Number of hash functions
    inputBinding:
      position: 102
      prefix: --hashfnumber
  - id: kvalue
    type:
      - 'null'
      - string
    doc: Value of k
    inputBinding:
      position: 102
      prefix: --kvalue
  - id: rounds
    type:
      - 'null'
      - int
    doc: Number of computation rounds
    inputBinding:
      position: 102
      prefix: --rounds
  - id: test
    type:
      - 'null'
      - boolean
    doc: Run tests
    inputBinding:
      position: 102
      prefix: --test
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of worker threads
    inputBinding:
      position: 102
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory name
    inputBinding:
      position: 102
      prefix: --tmpdir
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file name prefix
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/twopaco:1.1.0--hc252753_1
