cwlVersion: v1.2
class: CommandLineTool
baseCommand: circlator_assemble
label: circlator_assemble
doc: "Assemble reads using SPAdes/Canu\n\nTool homepage: https://github.com/sanger-pathogens/circlator"
inputs:
  - id: in_reads_fasta
    type: File
    doc: Name of input reads FASTA file
    inputBinding:
      position: 1
  - id: out_dir
    type: Directory
    doc: Output directory (must not already exist)
    inputBinding:
      position: 2
  - id: assembler
    type:
      - 'null'
      - string
    doc: Assembler to use for reassemblies
    inputBinding:
      position: 103
      prefix: --assembler
  - id: data_type
    type:
      - 'null'
      - string
    doc: String representing one of the 4 type of data analysed (only used for 
      Canu)
    inputBinding:
      position: 103
      prefix: --data_type
  - id: not_careful
    type:
      - 'null'
      - boolean
    doc: Do not use the --careful option with SPAdes (used by default)
    inputBinding:
      position: 103
      prefix: --not_careful
  - id: not_only_assembler
    type:
      - 'null'
      - boolean
    doc: Do not use the --assemble-only option with SPAdes (used by default)
    inputBinding:
      position: 103
      prefix: --not_only_assembler
  - id: spades_k
    type:
      - 'null'
      - string
    doc: Comma separated list of kmers to use when running SPAdes. Max kmer is 
      127 and each kmer should be an odd integer
    inputBinding:
      position: 103
      prefix: --spades_k
  - id: spades_use_first
    type:
      - 'null'
      - boolean
    doc: Use the first successful SPAdes assembly. Default is to try all kmers 
      and use the assembly with the largest N50
    inputBinding:
      position: 103
      prefix: --spades_use_first
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/circlator:v1.5.5-3-deb_cv1
stdout: circlator_assemble.out
