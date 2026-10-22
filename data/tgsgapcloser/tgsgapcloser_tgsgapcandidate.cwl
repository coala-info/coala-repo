cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgsgapcandidate
label: tgsgapcloser_tgsgapcandidate
doc: "Choose candidate gap-filling sequences from long reads aligned to contigs (step 2 of TGS-GapCloser).\n\nTool homepage: https://github.com/BGI-Qingdao/TGS-GapCloser"
inputs:
  - id: scaff_infos
    type: File
    doc: original scaffold infos (prefix.orignial_scaff_infos), read from standard input
  - id: contig2ont_paf
    type: File
    doc: the paf file that map contig into ont reads.
    inputBinding:
      position: 101
      prefix: --contig2ont_paf
  - id: ont_reads_q
    type:
      - 'null'
      - File
    doc: the ont reads in fastq format.
    inputBinding:
      position: 101
      prefix: --ont_reads_q
  - id: ont_reads_a
    type:
      - 'null'
      - File
    doc: the ont reads in fasta format.
    inputBinding:
      position: 101
      prefix: --ont_reads_a
  - id: max_hang
    type:
      - 'null'
      - int
    doc: max hang for ont
    inputBinding:
      position: 101
      prefix: --max_hang
  - id: factor_a
    type:
      - 'null'
      - float
    doc: factor_a for ont aligned factor
    inputBinding:
      position: 101
      prefix: --factor_a
  - id: factor_b
    type:
      - 'null'
      - float
    doc: factor_b for ont idy factor
    inputBinding:
      position: 101
      prefix: --factor_b
  - id: min_match
    type:
      - 'null'
      - int
    doc: min match for ont
    inputBinding:
      position: 101
      prefix: --min_match
  - id: min_nread
    type:
      - 'null'
      - int
    doc: min read to cross the gap
    inputBinding:
      position: 101
      prefix: --min_nread
  - id: max_nread
    type:
      - 'null'
      - int
    doc: max read to cross the gap
    inputBinding:
      position: 101
      prefix: --max_nread
  - id: min_idy
    type:
      - 'null'
      - float
    doc: min idy for ont
    inputBinding:
      position: 101
      prefix: --min_idy
  - id: candidate_merge
    type:
      - 'null'
      - boolean
    doc: merge cadidates from same reads with overlaps
    inputBinding:
      position: 101
      prefix: --candidate_merge
  - id: candidate_shake_filter
    type:
      - 'null'
      - boolean
    doc: filter cadidates that overlaps with others
    inputBinding:
      position: 101
      prefix: --candidate_shake_filter
  - id: candidate_shake_factor
    type:
      - 'null'
      - float
    doc: factor to detect a overlaps
    inputBinding:
      position: 101
      prefix: --candidate_shake_factor
  - id: candidate_max
    type:
      - 'null'
      - int
    doc: max number of candidates that 1 reads can provide for 1 gap , -1 means all
    inputBinding:
      position: 101
      prefix: --candidate_max
outputs:
  - id: candidates
    type: File
    doc: candidate gap-filling sequences in fasta format
    outputBinding:
      glob: tgsgapcandidate.fasta
  - id: log
    type: stderr
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgsgapcloser:1.2.1--h6f25541_3
stdin: $(inputs.scaff_infos.path)
stdout: tgsgapcandidate.fasta
stderr: tgsgapcandidate.log
