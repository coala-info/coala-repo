cwlVersion: v1.2
class: CommandLineTool
baseCommand: barrnap
label: barrnap
doc: "Finds and annotates ribosomal RNA genes in genome sequences.\n\nTool homepage:
  https://github.com/tseemann/barrnap"
inputs:
  - id: genome_file
    type: File
    doc: Genome sequence file (FASTA format)
    inputBinding:
      position: 1
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value cutoff for nhmmer
    inputBinding:
      position: 102
      prefix: --evalue
  - id: kingdom
    type:
      - 'null'
      - string
    doc: Kingdom to use for database search (e.g., bac, arc, euk, mito, chloro)
    inputBinding:
      position: 102
      prefix: --kingdom
  - id: min_length_ratio
    type:
      - 'null'
      - float
    doc: Tag genes < this ratio of expected length
    inputBinding:
      position: 102
      prefix: --lencutoff
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Suppress progress messages
    inputBinding:
      position: 102
      prefix: --quiet
  - id: reject_length_ratio
    type:
      - 'null'
      - float
    doc: Reject genes < this ratio of expected length
    inputBinding:
      position: 102
      prefix: --reject
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: incseq
    type:
      - 'null'
      - boolean
    doc: Include FASTA input sequences in GFF3 output
    inputBinding:
      position: 102
      prefix: --incseq
  - id: outseq_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `outseq_path`
    inputBinding:
      position: 104
      prefix: --outseq
outputs:
  - id: outseq
    type:
      - 'null'
      - File
    doc: Write sequences with rRNA genes to this file
    outputBinding:
      glob: $(inputs.outseq_path)
  - id: out
    type: stdout
    doc: rRNA annotations in GFF3 format (written to stdout)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.genome_file)
        writable: true
stdout: barrnap.gff
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/barrnap:0.9--1
