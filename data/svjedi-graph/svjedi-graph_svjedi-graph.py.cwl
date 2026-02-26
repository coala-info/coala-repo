cwlVersion: v1.2
class: CommandLineTool
baseCommand: svjedi-graph.py
label: svjedi-graph_svjedi-graph.py
doc: "Generates a graph representation of structural variants from VCF, reference,
  and reads.\n\nTool homepage: https://github.com/SandraLouise/SVJedi-graph"
inputs:
  - id: minsupport
    type:
      - 'null'
      - int
    doc: Minimum number of alignments to genotype a SV
    default: 3>=
    inputBinding:
      position: 101
      prefix: --minsupport
  - id: prefix
    type: string
    doc: Prefix of generated files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reads
    type: File
    doc: Long reads in fastq format
    inputBinding:
      position: 101
      prefix: --reads
  - id: ref
    type: File
    doc: Reference genome in fasta format
    inputBinding:
      position: 101
      prefix: --ref
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for read mapping
    inputBinding:
      position: 101
      prefix: --threads
  - id: vcf
    type: File
    doc: SV set in vcf format
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svjedi-graph:1.2.1--hdfd78af_0
stdout: svjedi-graph_svjedi-graph.py.out
