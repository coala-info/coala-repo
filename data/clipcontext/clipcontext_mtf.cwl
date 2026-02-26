cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext mtf
label: clipcontext_mtf
doc: "Search for motifs in genomic or transcript sequences.\n\nTool homepage: https://github.com/BackofenLab/CLIPcontext"
inputs:
  - id: data_id
    type:
      - 'null'
      - string
    doc: Data ID (column 1) for --stats-out output table to store motif search 
      results (requires --stats-out to be set)
    inputBinding:
      position: 101
      prefix: --data-id
  - id: gen
    type:
      - 'null'
      - File
    doc: Genomic sequences (hg38) .2bit file. Required for --in type (2) or (3)
    inputBinding:
      position: 101
      prefix: --gen
  - id: gtf
    type:
      - 'null'
      - File
    doc: Genomic annotations (hg38) GTF file (.gtf or .gtf.gz). Required for 
      --in type (2) or (3)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: input
    type: string
    doc: 'Three different inputs possible: (1) output folder of clipcontext g2t or
      clipcontext t2g with genomic and transcript context sequence sets in which to
      look for given --motif. (2) BED file (genomic or transcript regions) in which
      to look for given --motif. (3) Transcript list file, to search for --motif in
      the respective transcript sequences. Note that (2)+(3) need --gtf and --gen'
    inputBinding:
      position: 101
      prefix: --in
  - id: motif
    type: string
    doc: Motif or regular expression (RNA letters!) to search for in --in folder
      context sequences (e.g. --motif '[AC]UGCUAA')
    inputBinding:
      position: 101
      prefix: --motif
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output results folder, to store motif hit regions in BED files
    outputBinding:
      glob: $(inputs.out)
  - id: stats_out
    type:
      - 'null'
      - File
    doc: Output table to store motif search results in (for --in type (1) 
      (requires --data-id to be set). If table exists, append results row to 
      table
    outputBinding:
      glob: $(inputs.stats_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
