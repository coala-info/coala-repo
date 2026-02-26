cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytransaln_stats
label: pytransaln_stats
doc: "Calculate statistics from translated alignments.\n\nTool homepage: https://github.com/monagrland/pytransaln"
inputs:
  - id: out_hist_hmm
    type:
      - 'null'
      - File
    doc: Path to plot histogram of HMM bit scores
    inputBinding:
      position: 101
      prefix: --out_hist_hmm
  - id: out_hist_mins
    type:
      - 'null'
      - File
    doc: Path to plot histogram of minimum stop codons per sequence
    inputBinding:
      position: 101
      prefix: --out_hist_mins
  - id: out_hist_spf
    type:
      - 'null'
      - File
    doc: Path to plot histogram of stops per reading frame
    inputBinding:
      position: 101
      prefix: --out_hist_spf
outputs:
  - id: out_mqc_hmm
    type:
      - 'null'
      - File
    doc: Path to write histogram of HMM bit scores in JSON format for MultiQC
    outputBinding:
      glob: $(inputs.out_mqc_hmm)
  - id: out_screened
    type:
      - 'null'
      - File
    doc: Path to write sequences that passed screening, Fasta format
    outputBinding:
      glob: $(inputs.out_screened)
  - id: out_stats
    type:
      - 'null'
      - File
    doc: Path to write per-frame stop codon statistics
    outputBinding:
      glob: $(inputs.out_stats)
  - id: out_mqc_spf
    type:
      - 'null'
      - File
    doc: Path to write counts of stops per reading frame in JSON format for 
      MultiQC
    outputBinding:
      glob: $(inputs.out_mqc_spf)
  - id: out_mqc_mins
    type:
      - 'null'
      - File
    doc: Path to write counts of minimum stop codons per sequence in JSON format
      for MultiQC
    outputBinding:
      glob: $(inputs.out_mqc_mins)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0
