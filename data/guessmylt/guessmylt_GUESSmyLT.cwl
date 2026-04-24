cwlVersion: v1.2
class: CommandLineTool
baseCommand: GUESSmyLT
label: guessmylt_GUESSmyLT
doc: "GUESSmyLT, GUESS my Library Type. Can predict the library type used for RNA-Seq.
  The prediction is based on the orientaion of your read file(s) in .fastq/.fastq.gz/.bam
  format. Knowing the library type helps you with downstream analyses since it greatly
  improves the assembly.\n\nTool homepage: https://github.com/NBISweden/GUESSmyLT"
inputs:
  - id: annotation
    type:
      - 'null'
      - File
    doc: Annotation file in .gff format. Needs to contain genes.
    inputBinding:
      position: 101
      prefix: --annotation
  - id: dryrun_option
    type:
      - 'null'
      - boolean
    doc: (Snakemake dryrun option) Allows to see the scheduling plan including 
      the assigned priorities.
    inputBinding:
      position: 101
      prefix: -n
  - id: mapped
    type:
      - 'null'
      - File
    doc: Mapped file in .bam format (Will be sorted). Reference that reads have 
      been mapped to has to be provided.
    inputBinding:
      position: 101
      prefix: --mapped
  - id: memory
    type:
      - 'null'
      - string
    doc: Maximum memory that can be used by GUESSmyLT in GB. E.g. '10G'. Default
      value is 8G.
    inputBinding:
      position: 101
      prefix: --memory
  - id: mode
    type:
      - 'null'
      - string
    doc: Mode can be genome or transcriptome (default genome). It defines how 
      the reference fasta file will be handled by BUSCO. This option is used 
      when no annotation is provided (--annotation).
    inputBinding:
      position: 101
      prefix: --mode
  - id: organism
    type:
      - 'null'
      - string
    doc: Mandatory when no annotation provided. What organism are you dealing 
      with? prokaryote or eukaryote.
    inputBinding:
      position: 101
      prefix: --organism
  - id: output
    type:
      - 'null'
      - Directory
    doc: Full path to output directory. Default is working directory.
    inputBinding:
      position: 101
      prefix: --output
  - id: reads
    type:
      - 'null'
      - type: array
        items: File
    doc: One or two read files in .fastq or .fastq.gz format. Files can be 
      compressed or uncrompressed. Handles interleaved read files and any known 
      .fastq header format.
    inputBinding:
      position: 101
      prefix: --reads
  - id: reference
    type:
      - 'null'
      - File
    doc: Mandatory when --mapped used or when no reads provided (--reads). 
      Reference file in .fa/.fasta format. Reference can be either transcriptome
      or genome.
    inputBinding:
      position: 101
      prefix: --reference
  - id: subsample
    type:
      - 'null'
      - int
    doc: Number of subsampled reads that will be used for analysis. Must be an 
      even number.
    inputBinding:
      position: 101
      prefix: --subsample
  - id: threads
    type:
      - 'null'
      - int
    doc: The number of threads that can be used by GUESSmyLT. Needs to be an 
      integer. Defualt value is 2.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/guessmylt:0.2.5--py_0
stdout: guessmylt_GUESSmyLT.out
