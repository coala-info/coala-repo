cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - SeqSero2_package.py
label: seqsero2
doc: "SeqSero2: Salmonella serotyping from genome sequencing data\n\nTool homepage:
  https://github.com/denglab/SeqSero2"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Path to input data (reads or assembly)
    inputBinding:
      position: 1
      prefix: -i
  - id: input_type
    type: int
    doc: "Input type: 1 for interleaved paired-end reads, 2 for separated paired-end
      reads, 3 for single reads, 4 for genome assembly, 5 for nanopore reads (fasta/fastq)"
    inputBinding:
      position: 2
      prefix: -t
  - id: bwa_algorithm
    type:
      - 'null'
      - string
    doc: "Algorithm for bwa mapping for allele mode: 'mem' or 'sam' (samse/sampe);
      default mem"
    inputBinding:
      position: 3
      prefix: -b
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for allele mode; if more than 4, only 4 are used for assembly
      (default 1)
    inputBinding:
      position: 3
      prefix: -p
  - id: workflow_mode
    type:
      - 'null'
      - string
    doc: "Which workflow to apply: 'a' (raw reads allele micro-assembly) or 'k' (raw
      reads and genome assembly k-mer); default a"
    inputBinding:
      position: 3
      prefix: -m
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name in the report output
    inputBinding:
      position: 3
      prefix: -n
  - id: output_directory_path
    type:
      - 'null'
      - string
    doc: Output directory name; if not set, SeqSero_result_ plus a time stamp and
      a random number
    inputBinding:
      position: 3
      prefix: -d
  - id: no_log_directory
    type:
      - 'null'
      - boolean
    doc: Only output the serotype prediction, without the directory containing log
      files
    inputBinding:
      position: 3
      prefix: -c
  - id: no_header
    type:
      - 'null'
      - boolean
    doc: Do not output a header in SeqSero_result.tsv
    inputBinding:
      position: 3
      prefix: -s
  - id: phred_offset
    type:
      - 'null'
      - string
    doc: Offset for FASTQ file quality scores (33, 64 or auto); default auto
    inputBinding:
      position: 3
      prefix: --phred_offset
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check the required dependencies
    inputBinding:
      position: 3
      prefix: --check
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Result directory (SeqSero_result.tsv, SeqSero_result.txt, logs)
    outputBinding:
      glob: $(inputs.output_directory_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsero2:1.3.2--pyhdfd78af_0
stdout: seqsero2.out
