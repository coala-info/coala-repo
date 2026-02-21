cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - peakhood
  - motif
label: peakhood_motif
doc: "Search for motifs or regular expressions in genomic or transcript sequences
  based on peakhood extract output, BED files, or transcript lists.\n\nTool homepage:
  https://github.com/BackofenLab/Peakhood"
inputs:
  - id: data_id
    type:
      - 'null'
      - string
    doc: Data ID (column 1) for --stats-out output table to store motif search results
      (requires --stats-out to be set)
    inputBinding:
      position: 101
      prefix: --data-id
  - id: gen
    type:
      - 'null'
      - File
    doc: Genomic sequences .2bit file. Required for --in type (2) or (3)
    inputBinding:
      position: 101
      prefix: --gen
  - id: gtf
    type:
      - 'null'
      - File
    doc: Genomic annotations GTF file (.gtf or .gtf.gz). Required for --in type (2)
      or (3)
    inputBinding:
      position: 101
      prefix: --gtf
  - id: in
    type: string
    doc: 'Three different inputs possible: (1) output folder of peakhood extract with
      genomic and transcript context sequence sets in which to look for given --motif.
      (2) BED file (genomic or transcript regions) in which to look for given --motif.
      (3) Transcript list file, to search for --motif in the respective transcript
      sequences. Note that (2)+(3) need --gtf and --gen.'
    inputBinding:
      position: 101
      prefix: --in
  - id: motif
    type: string
    doc: Motif or regular expression (RNA letters!) to search for in --in folder context
      sequences (e.g. --motif '[AC]UGCUAA')
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
    doc: Output table to store motif search results in (for --in type (1) (requires
      --data-id to be set). If table exists, append results row to table
    outputBinding:
      glob: $(inputs.stats_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/peakhood:0.3--pyhdfd78af_0
