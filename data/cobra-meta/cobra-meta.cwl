cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobra-meta
label: cobra-meta
doc: "This script is used to get higher quality (including circular) virus genomes
  by joining assembled contigs based on their end overlaps.\n\nTool homepage: https://github.com/linxingchen/cobra"
inputs:
  - id: assembler
    type: string
    doc: de novo assembler used, COBRA not tested for others (idba, megahit, or 
      metaspades).
    inputBinding:
      position: 101
      prefix: --assembler
  - id: coverage
    type: File
    doc: the contig coverage file (two columns divided by tab).
    inputBinding:
      position: 101
      prefix: --coverage
  - id: fasta
    type: File
    doc: the whole set of assembled contigs (fasta format).
    inputBinding:
      position: 101
      prefix: --fasta
  - id: linkage_mismatch
    type:
      - 'null'
      - int
    doc: the max read mapping mismatches for determining if two contigs are 
      spanned by paired reads.
    inputBinding:
      position: 101
      prefix: --linkage_mismatch
  - id: mapping
    type: File
    doc: the reads mapping file in sam or bam format.
    inputBinding:
      position: 101
      prefix: --mapping
  - id: maxk
    type: int
    doc: the max kmer size used in de novo assembly.
    inputBinding:
      position: 101
      prefix: --maxk
  - id: mink
    type: int
    doc: the min kmer size used in de novo assembly.
    inputBinding:
      position: 101
      prefix: --mink
  - id: query
    type: File
    doc: the query contigs file (fasta format), or the query name list (text 
      file, one column).
    inputBinding:
      position: 101
      prefix: --query
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of threads for blastn.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: the name of output folder (default = '<query>_COBRA').
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobra-meta:1.2.3--pyhdfd78af_0
