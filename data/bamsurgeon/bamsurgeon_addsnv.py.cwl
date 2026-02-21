cwlVersion: v1.2
class: CommandLineTool
baseCommand: addsnv.py
label: bamsurgeon_addsnv.py
doc: "Add SNVs to a BAM file to create a synthetic dataset.\n\nTool homepage: https://github.com/adamewing/bamsurgeon"
inputs:
  - id: aligner
    type:
      - 'null'
      - string
    doc: Aligner to use (e.g., mem, backtrack)
    default: mem
    inputBinding:
      position: 101
      prefix: --aligner
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 101
      prefix: --config
  - id: input_bam
    type: File
    doc: Input BAM file
    inputBinding:
      position: 101
      prefix: --bamfile
  - id: maxdepth
    type:
      - 'null'
      - int
    doc: Maximum depth to attempt mutation
    inputBinding:
      position: 101
      prefix: --maxdepth
  - id: mindepth
    type:
      - 'null'
      - int
    doc: Minimum depth to attempt mutation
    inputBinding:
      position: 101
      prefix: --mindepth
  - id: mutation_rate
    type:
      - 'null'
      - float
    doc: Mutation rate
    inputBinding:
      position: 101
      prefix: --mutrate
  - id: picard_jar
    type:
      - 'null'
      - File
    doc: Path to Picard jar file
    inputBinding:
      position: 101
      prefix: --picardjar
  - id: processes
    type:
      - 'null'
      - int
    doc: Number of processes to use
    default: 1
    inputBinding:
      position: 101
      prefix: --procs
  - id: reference_fasta
    type: File
    doc: Reference FASTA file
    inputBinding:
      position: 101
      prefix: --reference
  - id: snv_fraction
    type:
      - 'null'
      - float
    doc: Fraction of reads to mutate
    default: 1.0
    inputBinding:
      position: 101
      prefix: --snvfrac
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Temporary directory for intermediate files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: vcf_file
    type: File
    doc: VCF file containing SNVs to add
    inputBinding:
      position: 101
      prefix: --vcf
outputs:
  - id: output_bam
    type: File
    doc: Name of the output BAM file
    outputBinding:
      glob: $(inputs.output_bam)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamsurgeon:1.4.1--pyhdfd78af_0
