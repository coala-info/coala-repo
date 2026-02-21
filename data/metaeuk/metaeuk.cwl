cwlVersion: v1.2
class: CommandLineTool
baseCommand: metaeuk
label: metaeuk
doc: "MetaEuk is a modular software for high-throughput, sensitive eukaryotic gene
  discovery and phylogenetic analysis in metagenomic and metatranscriptomic data.\n
  \nTool homepage: https://github.com/soedinglab/metaeuk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
stdout: metaeuk.out
