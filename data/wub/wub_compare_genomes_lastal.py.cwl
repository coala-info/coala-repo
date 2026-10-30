cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - compare_genomes_lastal.py
label: wub_compare_genomes_lastal.py
doc: 'Compare a set of reference sequences (genome) to another set (target assembly)
  using lastal alignment. Accuracy is the total number of matched bases divided by
  total alignment length. Coverage is total reference covered by alignment divided
  by total length of reference. Caveats: - The lastal alignments are filtered by default
  (use -f to disable) so only the best scoring alignment is kept per query. Hence
  some shorter valid alignments might be discarded causing an underestimation of coverage.
  - The estimated accuracy is dependent on the scoring of gaps and mismatches. By
  default gap open and gap extend penalties are set to equal.


  Tool homepage: https://github.com/nanoporetech/wub'
inputs:
  - id: reference_fasta
    type: File
    doc: Reference fasta.
    inputBinding:
      position: 1
  - id: target_fasta
    type: File
    doc: Target fasta.
    inputBinding:
      position: 2
  - id: results_pickle
    type:
      - 'null'
      - string
    doc: Save pickled results in this file (None).
    inputBinding:
      position: 103
      prefix: -p
  - id: lastal_args
    type:
      - 'null'
      - string
    doc: Parameters passed to lastal in the <arg>:value,... format (a:1,b:1).
    inputBinding:
      position: 103
      prefix: -l
  - id: details_tsv
    type:
      - 'null'
      - string
    doc: Save details of lastal alignment in this tab-separated file (None).
    inputBinding:
      position: 103
      prefix: -t
  - id: no_filter
    type:
      - 'null'
      - boolean
    doc: Do *not* filter for best alignment per query.
    inputBinding:
      position: 103
      prefix: -f
  - id: report_pdf
    type:
      - 'null'
      - string
    doc: Report with alignment details plot (None).
    inputBinding:
      position: 103
      prefix: -r
outputs:
  - id: lastal_txt
    type: File
    doc: Comparison results printed to stdout.
    outputBinding:
      glob: lastal.out.txt
  - id: pickle
    type:
      - 'null'
      - File
    doc: Pickled results.
    outputBinding:
      glob: $(inputs.results_pickle)
  - id: details
    type:
      - 'null'
      - File
    doc: Details of the lastal alignment.
    outputBinding:
      glob: $(inputs.details_tsv)
  - id: report
    type:
      - 'null'
      - File
    doc: Alignment details report (PDF).
    outputBinding:
      glob: $(inputs.report_pdf)
requirements:
  - class: EnvVarRequirement
    envDef:
      MPLBACKEND: Agg
stdout: lastal.out.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wub:0.5.1--pyh3252c3a_0
