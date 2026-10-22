cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsv2bam
label: stacks_tsv2bam
doc: "Converts STACKS tsv files to BAM format.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: in_dir
    type: Directory
    doc: input directory.
    inputBinding:
      position: 101
      prefix: --in-dir
  - id: pe_reads_dir
    type:
      - 'null'
      - Directory
    doc: directory where to find the paired-end reads files (in fastq/fasta/bam 
      (gz) format).
    inputBinding:
      position: 101
      prefix: --pe-reads-dir
  - id: popmap
    type:
      - 'null'
      - File
    doc: population map.
    inputBinding:
      position: 101
      prefix: --popmap
  - id: sample
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --sample
    doc: name of one sample.
    inputBinding:
      position: 101
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: in_dir_out
    type: Directory
    doc: input directory with the .matches.bam files written into it
    outputBinding:
      glob: $(inputs.in_dir.basename)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.in_dir)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_tsv2bam.out
