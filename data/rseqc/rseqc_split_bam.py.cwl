cwlVersion: v1.2
class: CommandLineTool
baseCommand: [split_bam.py]
label: rseqc_split_bam.py
doc: "Split a BAM file according to an input gene list (bed). Reads that hit exons of the gene list go to one BAM file, the remaining reads to another.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_file
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: "Alignment file in BAM or SAM format. BAM file should be sorted and indexed."
    inputBinding:
      position: 1
      prefix: --input-file
  - id: genelist
    type: File
    doc: "Gene list in bed foramt. All reads hits to exon regions (defined by this gene list) will be saved into one BAM file, the remaining reads will saved into another BAM file."
    inputBinding:
      position: 1
      prefix: --genelist
  - id: output_prefix
    type: string
    doc: "Prefix of output files(s). \"prefix.in.bam\" file contains reads mapped to the gene list specified by \"-r\", \"prefix.ex.bam\" contains reads that cannot mapped to gene list. \"prefix.junk.bam\" contains qcfailed or unmapped reads."
    inputBinding:
      position: 1
      prefix: --out-prefix
outputs:
  - id: in_bam
    type: File
    doc: "Reads mapped to the gene list."
    outputBinding:
      glob: "$(inputs.output_prefix).in.bam"
  - id: ex_bam
    type: File
    doc: "Reads not mapped to the gene list."
    outputBinding:
      glob: "$(inputs.output_prefix).ex.bam"
  - id: junk_bam
    type: File
    doc: "QC-failed or unmapped reads."
    outputBinding:
      glob: "$(inputs.output_prefix).junk.bam"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
