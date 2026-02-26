cwlVersion: v1.2
class: CommandLineTool
baseCommand: mitohifi
label: mitohifi
doc: "MitoHiFi is a tool for assembling mitochondrial genomes.\n\nTool homepage: https://github.com/marcelauliano/MitoHiFi"
inputs:
  - id: input_reads
    type: File
    doc: Input FASTQ file(s) containing reads.
    inputBinding:
      position: 1
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Assume the mitochondrial genome is circular.
    inputBinding:
      position: 102
      prefix: --circular
  - id: coverage
    type:
      - 'null'
      - int
    doc: Expected coverage of the mitochondrial genome.
    inputBinding:
      position: 102
      prefix: --coverage
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: K-mer size for assembly.
    inputBinding:
      position: 102
      prefix: --kmer-size
  - id: max_length
    type:
      - 'null'
      - int
    doc: Maximum length of assembled contigs.
    default: 20000
    inputBinding:
      position: 102
      prefix: --max-length
  - id: min_length
    type:
      - 'null'
      - int
    doc: Minimum length of assembled contigs.
    default: 1000
    inputBinding:
      position: 102
      prefix: --min-length
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix for output files.
    default: mitohifi
    inputBinding:
      position: 102
      prefix: --output-prefix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 102
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mitohifi:2.2_cv1
stdout: mitohifi.out
