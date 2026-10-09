cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - lowerbound
label: kmercamel_lowerbound
doc: "Compute a lower bound on the length of a masked superstring of the k-mers of a FASTA file\n\nTool homepage: https://github.com/OndrejSladky/kmercamel"
inputs:
  - id: kmer_size
    type: int
    doc: "k-mer size [required; up to 127]"
    inputBinding:
      position: 1
      prefix: "-k"
  - id: distinct_reverse_complement
    type: ['null', boolean]
    doc: "Treat k-mer and its reverse complement as distinct"
    inputBinding:
      position: 1
      prefix: "-u"
  - id: fasta
    type: File
    doc: "Input FASTA file"
    inputBinding:
      position: 10
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
stdout: kmercamel_lowerbound.out
