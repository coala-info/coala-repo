cwlVersion: v1.2
class: CommandLineTool
baseCommand: pytransaln
label: pytransaln_stats
doc: "Report summary statistics on reading frames of coding sequences (stop codons per frame, optional HMM screening).\n\nTool homepage: https://github.com/monagrland/pytransaln"
arguments:
  - position: 10
    valueFrom: stats
inputs:
  - id: input
    type: File
    doc: 'Path to input file with unaligned nt sequences, Fasta format'
    inputBinding:
      position: 1
      prefix: --input
  - id: code
    type:
      - 'null'
      - int
    doc: 'Genetic code to use for all sequences, NCBI translation table number (except stopless codes 27, 28, 31)'
    inputBinding:
      position: 2
      prefix: --code
  - id: hmm
    type:
      - 'null'
      - File
    doc: Optional HMM to screen translated sequences; only first model will be read from file
    inputBinding:
      position: 3
      prefix: --hmm
  - id: ignore_terminal_stop
    type:
      - 'null'
      - boolean
    doc: Do not include terminal stop codon in translations
    inputBinding:
      position: 4
      prefix: --ignore_terminal_stop
  - id: out_hmmsearch_path
    type:
      - 'null'
      - string
    default: test.hmmsearch_tblout.txt
    doc: Path to write tabular output from hmmsearch
    inputBinding:
      position: 5
      prefix: --out_hmmsearch
  - id: out_hist_hmm_path
    type:
      - 'null'
      - string
    default: test.hist_hmm_scores.png
    doc: Path to plot histogram of HMM bit scores
    inputBinding:
      position: 12
      prefix: --out_hist_hmm
  - id: out_mqc_hmm_path
    type:
      - 'null'
      - string
    default: test.hist_hmm_scores_mqc.json
    doc: Path to write histogram of HMM bit scores in JSON format for MultiQC
    inputBinding:
      position: 12
      prefix: --out_mqc_hmm
  - id: out_screened_path
    type:
      - 'null'
      - string
    default: test.screened_ok.fasta
    doc: 'Path to write sequences that passed screening, Fasta format'
    inputBinding:
      position: 12
      prefix: --out_screened
  - id: out_stats_path
    type:
      - 'null'
      - string
    default: test.stopcodon_stats.tsv
    doc: Path to write per-frame stop codon statistics
    inputBinding:
      position: 12
      prefix: --out_stats
  - id: out_hist_spf_path
    type:
      - 'null'
      - string
    default: test.hist_stops_per_frame.png
    doc: Path to plot histogram of stops per reading frame
    inputBinding:
      position: 12
      prefix: --out_hist_spf
  - id: out_mqc_spf_path
    type:
      - 'null'
      - string
    default: test.hist_stops_per_frame_mqc.json
    doc: Path to write counts of stops per reading frame in JSON format for MultiQC
    inputBinding:
      position: 12
      prefix: --out_mqc_spf
  - id: out_hist_mins_path
    type:
      - 'null'
      - string
    default: test.hist_min_stops.png
    doc: Path to plot histogram of minimum stop codons per sequence
    inputBinding:
      position: 12
      prefix: --out_hist_mins
  - id: out_mqc_mins_path
    type:
      - 'null'
      - string
    default: test.hist_min_stops_mqc.json
    doc: Path to write counts of minimum stop codons per sequence in JSON format for MultiQC
    inputBinding:
      position: 12
      prefix: --out_mqc_mins
outputs:
  - id: out_hist_hmm
    type:
      - 'null'
      - File
    doc: Path to plot histogram of HMM bit scores
    outputBinding:
      glob: $(inputs.out_hist_hmm_path)
  - id: out_mqc_hmm
    type:
      - 'null'
      - File
    doc: Path to write histogram of HMM bit scores in JSON format for MultiQC
    outputBinding:
      glob: $(inputs.out_mqc_hmm_path)
  - id: out_screened
    type:
      - 'null'
      - File
    doc: 'Path to write sequences that passed screening, Fasta format'
    outputBinding:
      glob: $(inputs.out_screened_path)
  - id: out_stats
    type:
      - 'null'
      - File
    doc: Path to write per-frame stop codon statistics
    outputBinding:
      glob: $(inputs.out_stats_path)
  - id: out_hist_spf
    type:
      - 'null'
      - File
    doc: Path to plot histogram of stops per reading frame
    outputBinding:
      glob: $(inputs.out_hist_spf_path)
  - id: out_mqc_spf
    type:
      - 'null'
      - File
    doc: Path to write counts of stops per reading frame in JSON format for MultiQC
    outputBinding:
      glob: $(inputs.out_mqc_spf_path)
  - id: out_hist_mins
    type:
      - 'null'
      - File
    doc: Path to plot histogram of minimum stop codons per sequence
    outputBinding:
      glob: $(inputs.out_hist_mins_path)
  - id: out_mqc_mins
    type:
      - 'null'
      - File
    doc: Path to write counts of minimum stop codons per sequence in JSON format for MultiQC
    outputBinding:
      glob: $(inputs.out_mqc_mins_path)
  - id: out_hmmsearch
    type:
      - 'null'
      - File
    doc: Path to write tabular output from hmmsearch
    outputBinding:
      glob: $(inputs.out_hmmsearch_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pytransaln:0.2.2--pyh7e72e81_0
