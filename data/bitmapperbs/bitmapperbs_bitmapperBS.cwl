cwlVersion: v1.2
class: CommandLineTool
baseCommand: bitmapperBS
label: bitmapperbs_bitmapperBS
doc: "A fast and accurate read aligner for whole-genome bisulfite sequencing.\n\n\
  \ Tool homepage: https://github.com/chhylp123/BitMapperBS"
inputs:
  - id: ambiguous_out
    type:
      - 'null'
      - boolean
    doc: Random report one of hit of each ambiguous mapped read.
    inputBinding:
      position: 101
      prefix: --ambiguous_out
  - id: bam
    type:
      - 'null'
      - boolean
    doc: Output mapping results in BAM format.
    inputBinding:
      position: 101
      prefix: --bam
  - id: edit_distance_rate
    type:
      - 'null'
      - float
    doc: 'Set the edit distance rate of read length. This value is between 0 and 1
      (default: 0.08 = 8% of read length).'
    inputBinding:
      position: 101
      prefix: -e
  - id: fast
    type:
      - 'null'
      - boolean
    doc: Set bitmapperBS in fast mode (default). This option is only available 
      in paired-end mode.
    inputBinding:
      position: 101
      prefix: --fast
  - id: gap_extension
    type:
      - 'null'
      - int
    doc: 'Gap extension penalty (default: 3).'
    inputBinding:
      position: 101
      prefix: --gap_extension
  - id: gap_open
    type:
      - 'null'
      - int
    doc: 'Gap open penalty (default: 5).'
    inputBinding:
      position: 101
      prefix: --gap_open
  - id: index
    type:
      - 'null'
      - File
    doc: Generate an index from the specified fasta file.
    inputBinding:
      position: 101
      prefix: --index
  - id: index_folder
    type:
      - 'null'
      - string
    doc: Set the folder that stores the genome indexes. If this option is not 
      set, the indexes would be stores in the same folder of genome (input fasta
      file).
    inputBinding:
      position: 101
      prefix: --index_folder
  - id: max_template_length
    type:
      - 'null'
      - int
    doc: 'Max observed template length between a pair of end sequences (default: 500).'
    inputBinding:
      position: 101
      prefix: --max
  - id: min_template_length
    type:
      - 'null'
      - int
    doc: 'Min observed template length between a pair of end sequences (default: 0).'
    inputBinding:
      position: 101
      prefix: --min
  - id: mp_max
    type:
      - 'null'
      - int
    doc: 'Maximum mismatch penalty (default: 6).'
    inputBinding:
      position: 101
      prefix: --mp_max
  - id: mp_min
    type:
      - 'null'
      - int
    doc: 'Minimum mismatch penalty (default: 2).'
    inputBinding:
      position: 101
      prefix: --mp_min
  - id: np
    type:
      - 'null'
      - int
    doc: 'Ambiguous character (e.g., N) penalty (default: 1).'
    inputBinding:
      position: 101
      prefix: --np
  - id: pbat
    type:
      - 'null'
      - boolean
    doc: Mapping the BS-seq from pbat protocol.
    inputBinding:
      position: 101
      prefix: --pbat
  - id: paired_end
    type:
      - 'null'
      - boolean
    doc: Map paired-end reads (--seq1/--seq2). Not in the help text; documented in
      the README examples and the option table of Process_CommandLines.cpp.
    inputBinding:
      position: 101
      prefix: --pe
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: Input read qualities are encoded by Phred33 (default).
    inputBinding:
      position: 101
      prefix: --phred33
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Input read qualities are encoded by Phred64.
    inputBinding:
      position: 101
      prefix: --phred64
  - id: sam
    type:
      - 'null'
      - boolean
    doc: Output mapping results in SAM format (default).
    inputBinding:
      position: 101
      prefix: --sam
  - id: search
    type:
      - 'null'
      - Directory
      - File
    doc: Search in the specified genome. Provide the index folder (built with 
      --index_folder), or the fasta file when its index files sit beside it.
    inputBinding:
      position: 101
      prefix: --search
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: Set bitmapperBS in sensitive mode. This option is only available in 
      paired-end mode.
    inputBinding:
      position: 101
      prefix: --sensitive
  - id: seq
    type:
      - 'null'
      - File
    doc: Input sequences in fastq/fastq.gz format [file]. This option is used 
      for single-end reads.
    inputBinding:
      position: 101
      prefix: --seq
  - id: seq1
    type:
      - 'null'
      - File
    doc: Input sequences in fastq/fastq.gz format [file] (First file). Use this 
      option to indicate the first file of paired-end reads.
    inputBinding:
      position: 101
      prefix: --seq1
  - id: seq2
    type:
      - 'null'
      - File
    doc: Input sequences in fastq/fastq.gz format [file] (Second file). Use this
      option to indicate the second file of paired-end reads.
    inputBinding:
      position: 101
      prefix: --seq2
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of CPU threads (default: 1).'
    inputBinding:
      position: 101
      prefix: --threads
  - id: output_path
    type:
      - 'null'
      - string
    doc: "[file]\t\tOutput of the mapped sequences in SAM or BAM format. The default
      is \"stdout\" (standard output) in SAM format."
    inputBinding:
      position: 104
      prefix: -o
  - id: mapstats_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 105
      prefix: --mapstats
  - id: methy_out
    type:
      - 'null'
      - boolean
    doc: Output the intermediate methylation result files, instead of SAM or BAM
      files. The result goes to the -o file.
    inputBinding:
      position: 106
      prefix: --methy_out
  - id: unmapped_out
    type:
      - 'null'
      - boolean
    doc: Report unmapped reads.
    inputBinding:
      position: 107
      prefix: --unmapped_out
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output of the mapped sequences in SAM or BAM format. The default is 
      "stdout" (standard output) in SAM format.
    outputBinding:
      glob: $(inputs.output_path)
  - id: index_dir
    type:
      - 'null'
      - Directory
    doc: Index folder written by --index with --index_folder.
    outputBinding:
      glob: $(inputs.index_folder)
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files written beside the genome by --index without --index_folder.
    outputBinding:
      glob: "$(inputs.index && !inputs.index_folder ? inputs.index.basename + '.index*' : [])"
  - id: mapstats
    type:
      - 'null'
      - File
    doc: Output the statistical information of read alignment into file.
    outputBinding:
      glob: $(inputs.mapstats_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.index)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bitmapperbs:1.0.2.3--hf5e1c6e_5
