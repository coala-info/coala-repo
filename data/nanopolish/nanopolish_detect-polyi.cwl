cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nanopolish
  - detect-polyi
label: nanopolish_detect-polyi
doc: "Detect presence of poly(I) tails and estimate length of tails in direct RNA
  reads\n\nTool homepage: https://github.com/jts/nanopolish"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - .bai
    doc: the reads aligned to the genome assembly are in bam FILE
    inputBinding:
      position: 101
      prefix: --bam
  - id: genome
    type: File
    secondaryFiles:
      - .fai
    doc: the reference genome assembly for the reads is in FILE
    inputBinding:
      position: 101
      prefix: --genome
  - id: reads
    type: File
    secondaryFiles:
      - .index
      - .index.fai
      - .index.gzi
      - .index.readdb
    doc: the 1D ONT direct RNA reads are in fasta FILE
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
  - id: window
    type:
      - 'null'
      - string
    doc: 'only compute the poly-A lengths for reads in window STR (format: ctg:start_id-end_id)'
    inputBinding:
      position: 101
      prefix: --window
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
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.raw_ont_signal_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanopolish:0.14.0--h773013f_3
stdout: nanopolish_detect-polyi.out
