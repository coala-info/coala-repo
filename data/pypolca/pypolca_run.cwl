cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypolca
  - run
label: pypolca_run
doc: "Python implementation of the POLCA polisher from MaSuRCA\n\nTool homepage: https://github.com/gbouras13/pypolca"
inputs:
  - id: assembly
    type: File
    doc: Path to assembly contigs or scaffolds.
    inputBinding:
      position: 101
      prefix: --assembly
  - id: careful
    type:
      - 'null'
      - boolean
    doc: Equivalent to --min_alt 4 --min_ratio 3
    inputBinding:
      position: 101
      prefix: --careful
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrites the output directory
    inputBinding:
      position: 101
      prefix: --force
  - id: homopolymers
    type:
      - 'null'
      - int
    doc: Ignore all changes except for homopolymer-length changes, with 
      homopolymers defined by this length
    inputBinding:
      position: 101
      prefix: --homopolymers
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: Memory per thread to use in samtools sort, set to 2G or more for large 
      genomes
    inputBinding:
      position: 101
      prefix: --memory_limit
  - id: min_alt
    type:
      - 'null'
      - int
    doc: Minimum alt allele count to make a change
    inputBinding:
      position: 101
      prefix: --min_alt
  - id: min_ratio
    type:
      - 'null'
      - float
    doc: Minimum alt allele to ref allele ratio to make a change
    inputBinding:
      position: 101
      prefix: --min_ratio
  - id: no_polish
    type:
      - 'null'
      - boolean
    doc: do not polish, just create vcf file, evaluate the assembly and exit
    inputBinding:
      position: 101
      prefix: --no_polish
  - id: prefix
    type:
      - 'null'
      - string
    doc: prefix for output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: reads1
    type: File
    doc: Path to polishing reads R1 FASTQ. Can be FASTQ or FASTQ gzipped. 
      Required.
    inputBinding:
      position: 101
      prefix: --reads1
  - id: reads2
    type:
      - 'null'
      - File
    doc: Path to polishing reads R2 FASTQ. Can be FASTQ or FASTQ gzipped. 
      Optional. Only use -1 if you have single end reads.
    inputBinding:
      position: 101
      prefix: --reads2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: Output directory path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypolca:0.4.0--pyhdfd78af_0
