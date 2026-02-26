cwlVersion: v1.2
class: CommandLineTool
baseCommand: ReadSeqMain
label: rdp-readseq
doc: Main entry point for ReadSeq operations. Use with a subcommand.
inputs:
  - id: subcommand
    type: string
    doc: The subcommand to execute (e.g., random-sample, reverse-comp, 
      rm-dupseq, select-seqs, split, to-fasta, to-fastq, to-stk)
    inputBinding:
      position: 1
  - id: subcommand_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified subcommand
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/rdp-readseq:v2.0.2-6-deb_cv1
stdout: rdp-readseq.out
