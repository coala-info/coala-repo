cwlVersion: v1.2
class: CommandLineTool
baseCommand: SeqSero2_package.py
label: seqsero2
doc: "SeqSero2: Salmonella serotyping from genome sequencing data\n\nTool homepage:
  https://github.com/denglab/SeqSero2"
inputs:
  - id: bwa_path
    type:
      - 'null'
      - string
    doc: Path to bwa executable
    inputBinding:
      position: 101
      prefix: -b
  - id: input_files
    type:
      type: array
      items: File
    doc: 'Input file(s): fastq or fasta (e.g., -i R1.fastq R2.fastq or -i genome.fasta)'
    inputBinding:
      position: 101
      prefix: -i
  - id: input_type
    type: int
    doc: 'Input type: 1 for interleaved paired-end reads, 2 for separate paired-end
      reads, 3 for single-end reads or genome assembly, 4 for Nanopore reads'
    inputBinding:
      position: 101
      prefix: -t
  - id: sample_name
    type:
      - 'null'
      - string
    doc: Sample name for the output files
    inputBinding:
      position: 101
      prefix: -n
  - id: samtools_path
    type:
      - 'null'
      - string
    doc: Path to samtools executable
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 101
      prefix: -p
  - id: workflow_mode
    type: string
    doc: "Workflow mode: 'k' for k-mer based (fast), 'a' for allele micro-assembly
      based (more accurate)"
    inputBinding:
      position: 101
      prefix: -m
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: Directory to write output files
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqsero2:1.3.2--pyhdfd78af_0
