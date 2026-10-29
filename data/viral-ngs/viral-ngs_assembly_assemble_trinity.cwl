cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - assemble_trinity
label: viral-ngs_assembly_assemble_trinity
doc: "This step runs the Trinity assembler. First trim reads with trimmomatic, rmdup with prinseq, and random subsample to no more than 100k reads.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_bam
    type: File
    doc: "Input unaligned reads, BAM format."
    inputBinding:
      position: 1
  - id: clip_db
    type: File
    doc: "Trimmomatic clip DB."
    inputBinding:
      position: 2
  - id: out_fasta
    type: string
    doc: "Output assembly."
    inputBinding:
      position: 3
  - id: n_reads
    type:
      - 'null'
      - int
    doc: "Subsample reads to no more than this many pairs. (default 100000)"
    inputBinding:
      position: 20
      prefix: --n_reads
  - id: out_reads
    type:
      - 'null'
      - string
    doc: "Save the trimmomatic/prinseq/subsamp reads to a BAM file"
    inputBinding:
      position: 20
      prefix: --outReads
  - id: always_succeed
    type:
      - 'null'
      - boolean
    doc: "If Trinity fails (usually because insufficient reads to assemble), emit an empty fasta file as output. Default is to throw a DenovoAssemblyError."
    inputBinding:
      position: 20
      prefix: --always_succeed
  - id: jvm_memory
    type:
      - 'null'
      - string
    doc: "JVM virtual memory size (default: 4g)"
    inputBinding:
      position: 20
      prefix: --JVMmemory
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (default: 1)"
    inputBinding:
      position: 20
      prefix: --threads
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "Base directory for temp files. [default: /tmp]"
    inputBinding:
      position: 20
      prefix: --tmp_dir
  - id: tmp_dir_keep
    type:
      - 'null'
      - boolean
    doc: "Keep the tmp_dir if an exception occurs while running. Default is to delete all temp files at the end, even if there's a failure."
    inputBinding:
      position: 20
      prefix: --tmp_dirKeep
outputs:
  - id: out_fasta_file
    type: File
    doc: "Output file written to out_fasta"
    outputBinding:
      glob: $(inputs.out_fasta)
  - id: out_reads_file
    type:
      - 'null'
      - File
    doc: "Output file written to out_reads"
    outputBinding:
      glob: $(inputs.out_reads)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
