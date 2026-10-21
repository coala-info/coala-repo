cwlVersion: v1.2
class: CommandLineTool
baseCommand: [read_distribution.py]
label: rseqc_read_distribution.py
doc: "Check the distribution of reads over exon, intron, UTR and intergenic regions. Skipped reads: qc_failed, PCR duplicate, unmapped and non-primary.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_file
    type: File
    doc: "Alignment file in BAM or SAM format."
    inputBinding:
      position: 1
      prefix: --input-file
  - id: refgene
    type: File
    doc: "Reference gene model in bed format."
    inputBinding:
      position: 1
      prefix: --refgene
outputs:
  - id: stdout
    type: stdout
    doc: "Read distribution table."
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
stdout: read_distribution.txt
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
