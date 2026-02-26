cwlVersion: v1.2
class: CommandLineTool
baseCommand: perl cFLSeq.pl
label: jccirc_JCcirc.pl
doc: "CIRCSeq (circRNA sequence)\n\nTool homepage: https://github.com/cbbzhang/JCcirc"
inputs:
  - id: annotation_file
    type:
      - 'null'
      - File
    doc: "gene annotation file in gtf format. Please make sure this file is\nthe same
      one provided to prediction tool."
    inputBinding:
      position: 101
      prefix: --annotation
  - id: circ_file
    type: File
    doc: input circRNA file, which including chromosome, start site, end site, 
      host gene, and junction reads ID (required).
    inputBinding:
      position: 101
      prefix: --circ
  - id: contig_file
    type: File
    doc: contig sequences (required).
    inputBinding:
      position: 101
  - id: difference
    type:
      - 'null'
      - int
    doc: the difference in support numbers between adjacent fragments when 
      generating circRNA isoforms, default is 0 (recommend setting to 0, 1, or 
      2, the larger number means stricter).
    default: 0
    inputBinding:
      position: 101
  - id: genome_file
    type: File
    doc: "FASTA file of all reference sequences. Please make sure this file is\nthe
      same one provided to prediction tool (required)."
    inputBinding:
      position: 101
      prefix: --genome
  - id: output_dir
    type: Directory
    doc: directory of output (required).
    inputBinding:
      position: 101
      prefix: --output
  - id: read1
    type:
      - 'null'
      - File
    doc: RNA-Seq data, read_1 (paired end, fastq format).
    inputBinding:
      position: 101
  - id: read2
    type:
      - 'null'
      - File
    doc: RNA-Seq data, read_1 (paired end, fastq format).
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: set number of threads for parallel running, default is 4.
    default: 4
    inputBinding:
      position: 101
      prefix: --thread
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jccirc:1.0.0--hdfd78af_1
stdout: jccirc_JCcirc.pl.out
