cwlVersion: v1.2
class: CommandLineTool
baseCommand: [rsem-gff3-to-gtf]
label: rsem_rsem-gff3-to-gtf
doc: "Convert a GFF3 annotation file to a GTF file that rsem-prepare-reference can use.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: make_genes_as_transcripts
    type: ['null', boolean]
    doc: The GFF3 file does not contain transcripts; make each gene a transcript.
    inputBinding:
      position: 1
      prefix: --make-genes-as-transcripts
  - id: rna_patterns
    type: ['null', string]
    doc: Types of RNAs to extract, e.g. mRNA,rRNA.
    inputBinding:
      position: 2
      prefix: --RNA-patterns
  - id: extract_sequences
    type: ['null', string]
    doc: If the GFF3 file contains reference sequences, extract them to this FASTA file.
    inputBinding:
      position: 3
      prefix: --extract-sequences
  - id: input_gff3_file
    type: File
    doc: Input GFF3 file.
    inputBinding:
      position: 4
  - id: output_gtf_file
    type: string
    doc: Output GTF file name.
    inputBinding:
      position: 5
outputs:
  - id: gtf
    type: File
    doc: Output GTF file.
    outputBinding:
      glob: $(inputs.output_gtf_file)
  - id: sequences
    type: ['null', File]
    doc: Extracted reference sequences (only with extract_sequences).
    outputBinding:
      glob: $(inputs.extract_sequences)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
