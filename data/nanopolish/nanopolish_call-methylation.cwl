cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - call-methylation
label: nanopolish_call-methylation
doc: "Classify nucleotides as methylated or not.\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: the reads aligned to the genome assembly are in bam FILE
    inputBinding:
      position: 101
      prefix: --bam
  - id: batchsize
    type:
      - 'null'
      - int
    doc: 'the batch size (default: 512)'
    inputBinding:
      position: 101
      prefix: --batchsize
  - id: genome
    type: File
    secondaryFiles:
      - .fai
    doc: the genome we are calling methylation for is in fasta FILE
    inputBinding:
      position: 101
      prefix: --genome
  - id: methylation
    type: string
    doc: the type of methylation (cpg,gpc,dam,dcm)
    inputBinding:
      position: 101
      prefix: --methylation
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: 'only use reads with mapQ >= NUM (default: 20)'
    inputBinding:
      position: 101
      prefix: --min-mapping-quality
  - id: modbam_style
    type:
      - 'null'
      - string
    doc: "modbam output style either 'reference' or 'read' (default: read)\n     \
      \                                  when this is set to reference the SEQ field
      in the output will be the reference\n                                      \
      \ sequence spanned by the read"
    inputBinding:
      position: 101
      prefix: --modbam-style
  - id: progress
    type:
      - 'null'
      - boolean
    doc: print out a progress message
    inputBinding:
      position: 101
      prefix: --progress
  - id: reads
    type: File
    secondaryFiles:
      - .index
      - .index.fai
      - .index.gzi
      - .index.readdb
    doc: the ONT reads are in fasta/fastq FILE
    inputBinding:
      position: 101
      prefix: --reads
  - id: threads
    type:
      - 'null'
      - int
    doc: 'use NUM threads (default: 1)'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: display verbose output
    inputBinding:
      position: 101
      prefix: --verbose
  - id: watch
    type:
      - 'null'
      - Directory
    doc: watch the sequencing run directory DIR and call methylation as data is 
      generated
    inputBinding:
      position: 101
      prefix: --watch
  - id: watch_process_index
    type:
      - 'null'
      - int
    doc: "in watch mode, the index of this process is IDX\n                      \
      \                 the previous two options allow you to run multiple independent
      methylation\n                                       calling processes against
      a single directory. Each process will only call\n                          \
      \             files when X mod TOTAL == IDX, where X is the suffix of the fast5
      file."
    inputBinding:
      position: 101
      prefix: --watch-process-index
  - id: watch_process_total
    type:
      - 'null'
      - int
    doc: in watch mode, there are TOTAL calling processes running against this 
      directory
    inputBinding:
      position: 101
      prefix: --watch-process-total
  - id: watch_write_bam
    type:
      - 'null'
      - boolean
    doc: in watch mode, write the alignments for each fastq
    inputBinding:
      position: 101
      prefix: --watch-write-bam
  - id: modbam_output_name_path
    type:
      - 'null'
      - string
    doc: 'write the results as tags in FILE (default: tsv output)'
    inputBinding:
      position: 102
      prefix: --modbam-output-name
  - id: raw_ont_signal_directory
    type:
      type: array
      items: Directory
    doc: Directories with the raw ONT signal (fast5) files that were given to
      nanopolish index. They are staged in the working directory under the
      same names, so the relative fast5 paths stored in the reads index
      (.index.readdb) resolve.
outputs:
  - id: stdout
    type: stdout
    doc: Methylation calls as a tab-separated table (default output)
  - id: modbam_output_name
    type:
      - 'null'
      - File
    doc: 'write the results as tags in FILE (default: tsv output)'
    outputBinding:
      glob: $(inputs.modbam_output_name_path)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.raw_ont_signal_directory)
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_call-methylation.out
