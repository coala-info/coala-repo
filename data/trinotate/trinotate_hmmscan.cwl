cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmscan
label: trinotate_hmmscan
doc: "search sequence(s) against a profile database\n\nTool homepage: https://trinotate.github.io/"
inputs:
  - id: hmmdb
    type: string
    doc: HMM profile database
    inputBinding:
      position: 1
  - id: seqfile
    type: File
    doc: Sequence file to search
    inputBinding:
      position: 2
  - id: cpu_workers
    type:
      - 'null'
      - int
    doc: number of parallel CPU workers to use for multithreads
    inputBinding:
      position: 103
      prefix: --cpu
  - id: disable_composition_bias_filter
    type:
      - 'null'
      - boolean
    doc: turn off composition bias filter
    inputBinding:
      position: 103
      prefix: --nobias
  - id: disable_heuristic_filters
    type:
      - 'null'
      - boolean
    doc: Turn all heuristic filters off (less speed, more power)
    inputBinding:
      position: 103
      prefix: --max
  - id: disable_null2_corrections
    type:
      - 'null'
      - boolean
    doc: turn off biased composition score corrections
    inputBinding:
      position: 103
      prefix: --nonull2
  - id: dom_num_significant_seqs
    type:
      - 'null'
      - float
    doc: 'set # of significant seqs, for domain E-value calculation'
    inputBinding:
      position: 103
      prefix: --domZ
  - id: fwd_threshold
    type:
      - 'null'
      - float
    doc: 'Fwd threshold: promote hits w/ P <= F3'
    inputBinding:
      position: 103
      prefix: --F3
  - id: inc_dom_eval
    type:
      - 'null'
      - float
    doc: consider domains <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: --incdomE
  - id: inc_dom_score
    type:
      - 'null'
      - float
    doc: consider domains >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: --incdomT
  - id: inc_eval
    type:
      - 'null'
      - float
    doc: consider models <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: --incE
  - id: inc_score
    type:
      - 'null'
      - float
    doc: consider models >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: --incT
  - id: msv_threshold
    type:
      - 'null'
      - float
    doc: 'MSV threshold: promote hits w/ P <= F1'
    inputBinding:
      position: 103
      prefix: --F1
  - id: no_alignments
    type:
      - 'null'
      - boolean
    doc: don't output alignments, so output is smaller
    inputBinding:
      position: 103
      prefix: --noali
  - id: num_comparisons
    type:
      - 'null'
      - float
    doc: 'set # of comparisons done, for E-value calculation'
    inputBinding:
      position: 103
      prefix: -Z
  - id: prefer_accessions
    type:
      - 'null'
      - boolean
    doc: prefer accessions over names in output
    inputBinding:
      position: 103
      prefix: --acc
  - id: report_dom_eval
    type:
      - 'null'
      - float
    doc: report domains <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: --domE
  - id: report_dom_score
    type:
      - 'null'
      - float
    doc: report domains >= this score cutoff in output
    inputBinding:
      position: 103
      prefix: --domT
  - id: report_eval
    type:
      - 'null'
      - float
    doc: report models <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: -E
  - id: report_score
    type:
      - 'null'
      - float
    doc: report models >= this score threshold in output
    inputBinding:
      position: 103
      prefix: -T
  - id: rng_seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 103
      prefix: --seed
  - id: seqfile_format
    type:
      - 'null'
      - string
    doc: 'assert input <seqfile> is in format <s>: no autodetection'
    inputBinding:
      position: 103
      prefix: --qformat
  - id: text_width
    type:
      - 'null'
      - int
    doc: set max width of ASCII text output lines
    inputBinding:
      position: 103
      prefix: --textw
  - id: unlimit_text_width
    type:
      - 'null'
      - boolean
    doc: unlimit ASCII text output line width
    inputBinding:
      position: 103
      prefix: --notextw
  - id: use_ga_cutoffs
    type:
      - 'null'
      - boolean
    doc: use profile's GA gathering cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_ga
  - id: use_nc_cutoffs
    type:
      - 'null'
      - boolean
    doc: use profile's NC noise cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_nc
  - id: use_tc_cutoffs
    type:
      - 'null'
      - boolean
    doc: use profile's TC trusted cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_tc
  - id: vit_threshold
    type:
      - 'null'
      - float
    doc: 'Vit threshold: promote hits w/ P <= F2'
    inputBinding:
      position: 103
      prefix: --F2
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: direct output to file <f>, not stdout
    outputBinding:
      glob: $(inputs.output_file)
  - id: tblout
    type:
      - 'null'
      - File
    doc: save parseable table of per-sequence hits to file <f>
    outputBinding:
      glob: $(inputs.tblout)
  - id: domtblout
    type:
      - 'null'
      - File
    doc: save parseable table of per-domain hits to file <f>
    outputBinding:
      glob: $(inputs.domtblout)
  - id: pfamtblout
    type:
      - 'null'
      - File
    doc: save table of hits and domains to file, in Pfam format <f>
    outputBinding:
      glob: $(inputs.pfamtblout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trinotate:4.0.2--pl5321hdfd78af_0
