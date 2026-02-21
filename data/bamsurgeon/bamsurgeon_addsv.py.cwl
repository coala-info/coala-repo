cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamsurgeon_addsv.py
label: bamsurgeon_addsv.py
doc: "Add structural variants to existing BAM files\n\nTool homepage: https://github.com/adamewing/bamsurgeon"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: Aligner to use (e.g., mem, backtrace)
    default: mem
    inputBinding:
      position: 101
      prefix: --aligner
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --bam
  - id: min_shared
    type:
      - 'null'
      - float
    doc: Minimum fraction of shared reads
    default: 0.25
    inputBinding:
      position: 101
      prefix: --minshared
  - id: picard_jar
    type: File
    doc: Path to Picard tools .jar file
    inputBinding:
      position: 101
      prefix: --picardjar
  - id: reference_fasta
    type: File
    doc: Reference genome FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: seed
    type:
      - 'null'
      - int
    doc: Random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of processes to use
    default: 1
    inputBinding:
      position: 101
      prefix: --procs
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for intermediate files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: vcf_file
    type: File
    doc: VCF file containing structural variants to add
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output_bam
    type:
      - 'null'
      - File
    doc: Name of the output BAM file
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
