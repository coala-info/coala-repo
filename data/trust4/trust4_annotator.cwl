cwlVersion: v1.2
class: CommandLineTool
baseCommand: annotator
label: trust4_annotator
doc: "Annotate assembled TCR/BCR contigs with V/D/J/C genes and CDR3 sequences (annotation step of TRUST4). The annotation (fasta or AIRR) goes to standard output.\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: fasta_file
    type: File
    doc: "fasta file containing the receptor genome sequence"
    inputBinding:
      position: 101
      prefix: -f
  - id: assembly_file
    type: File
    doc: "path to the assembly file"
    inputBinding:
      position: 101
      prefix: -a
  - id: reads
    type:
      - 'null'
      - File
    doc: "path to the reads used in the assembly"
    inputBinding:
      position: 101
      prefix: -r
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "the assembly file is in fasta format (default: false)"
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: "the assembly file is in fastq format (default: false)"
    inputBinding:
      position: 101
      prefix: --fastq
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads (default: 1)"
    inputBinding:
      position: 101
      prefix: -t
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "the prefix of the file containing CDR3 information (default: trust)"
    inputBinding:
      position: 101
      prefix: -o
  - id: barcode
    type:
      - 'null'
      - boolean
    doc: "there is barcode information in -a and -r files (default: not set)"
    inputBinding:
      position: 101
      prefix: --barcode
  - id: umi
    type:
      - 'null'
      - boolean
    doc: "there is UMI information in -r file (default: not set)"
    inputBinding:
      position: 101
      prefix: --UMI
  - id: gene_alignment
    type:
      - 'null'
      - boolean
    doc: "output the gene alignment (default: not set)"
    inputBinding:
      position: 101
      prefix: --geneAlignment
  - id: airr_alignment
    type:
      - 'null'
      - boolean
    doc: "output the aligned sequences to prefix_airr_align.tsv (default: not set)"
    inputBinding:
      position: 101
      prefix: --airrAlignment
  - id: no_impute
    type:
      - 'null'
      - boolean
    doc: "do not impute CDR3 sequence for TCR (default: impute)"
    inputBinding:
      position: 101
      prefix: --noImpute
  - id: not_imgt
    type:
      - 'null'
      - boolean
    doc: "the receptor genome sequence is not in IMGT format (default: in IMGT format)"
    inputBinding:
      position: 101
      prefix: --notIMGT
  - id: imgt_additional_gap
    type:
      - 'null'
      - string
    doc: "description for additional gap codon position in IMGT (0-based), e.g. \"TRAV:7,83\" for mouse"
    inputBinding:
      position: 101
      prefix: --imgtAddtionalGap
  - id: output_cdr3_file
    type:
      - 'null'
      - boolean
    doc: "output CDR3 file when not using -r option (default: no output)"
    inputBinding:
      position: 101
      prefix: --outputCDR3File
  - id: need_reverse_complement
    type:
      - 'null'
      - boolean
    doc: "reverse complement sequences on another strand (default: no)"
    inputBinding:
      position: 101
      prefix: --needReverseComplement
  - id: output_format
    type:
      - 'null'
      - int
    doc: "0-fasta, 1-AIRR (default: 0)"
    inputBinding:
      position: 101
      prefix: --outputFormat
  - id: read_assignment
    type:
      - 'null'
      - string
    doc: "output the read assignment to the file (default: no output)"
    inputBinding:
      position: 101
      prefix: --readAssignment
outputs:
  - id: annotation
    type: stdout
    doc: "Annotated assemblies (standard output)"
  - id: prefix_files
    type:
      type: array
      items: File
    doc: "Files written with the output prefix (prefix_cdr3.out, prefix_airr_align.tsv, ...)"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'trust') + '_*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
stdout: annotator_annot.out
