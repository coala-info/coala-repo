cwlVersion: v1.2
class: CommandLineTool
baseCommand: blast_top_hits
label: seer_blast_top_hits
doc: "Reduces a blast or blat output file to the top hit for each query sequence only\n\nTool homepage: https://github.com/johnlees/seer"
inputs:
  - id: input
    type: File
    doc: "BLAST output file in -m 6/-outfmt 6 or BLAT .psl file"
    inputBinding:
      position: 1
      prefix: --input
  - id: mode
    type: string
    doc: "Either blast or blat"
    inputBinding:
      position: 1
      prefix: --mode
  - id: full_query
    type: ['null', boolean]
    doc: "The entire query must be reported as a match to appear in the output"
    inputBinding:
      position: 1
      prefix: --full_query
outputs:
  - id: output
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/seer:v1.1.4-2b2-deb_cv1
stdout: seer_blast_top_hits.out
