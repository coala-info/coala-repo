cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmmsearch
label: hmmer_hmmsearch
doc: "search profile(s) against a sequence database\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmfile
    type: File
    doc: HMM profile file
    inputBinding:
      position: 1
  - id: seqdb
    type: File
    doc: Sequence database file
    inputBinding:
      position: 2
  - id: acc
    type:
      - 'null'
      - boolean
    doc: prefer accessions over names in output
    inputBinding:
      position: 103
      prefix: --acc
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel CPU workers to use for multithreads
    inputBinding:
      position: 103
      prefix: --cpu
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: use profile's GA gathering cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_ga
  - id: cut_nc
    type:
      - 'null'
      - boolean
    doc: use profile's NC noise cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_nc
  - id: cut_tc
    type:
      - 'null'
      - boolean
    doc: use profile's TC trusted cutoffs to set all thresholding
    inputBinding:
      position: 103
      prefix: --cut_tc
  - id: dom_e_threshold
    type:
      - 'null'
      - float
    doc: report domains <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: --domE
  - id: dom_t_threshold
    type:
      - 'null'
      - float
    doc: report domains >= this score cutoff in output
    inputBinding:
      position: 103
      prefix: --domT
  - id: dom_z_seqs
    type:
      - 'null'
      - float
    doc: 'set # of significant seqs, for domain E-value calculation'
    inputBinding:
      position: 103
      prefix: --domZ
  - id: e_value_threshold
    type:
      - 'null'
      - float
    doc: report sequences <= this E-value threshold in output
    inputBinding:
      position: 103
      prefix: -E
  - id: f1_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 1 (MSV) threshold: promote hits w/ P <= F1'
    inputBinding:
      position: 103
      prefix: --F1
  - id: f2_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 2 (Vit) threshold: promote hits w/ P <= F2'
    inputBinding:
      position: 103
      prefix: --F2
  - id: f3_threshold
    type:
      - 'null'
      - float
    doc: 'Stage 3 (Fwd) threshold: promote hits w/ P <= F3'
    inputBinding:
      position: 103
      prefix: --F3
  - id: inc_e_threshold
    type:
      - 'null'
      - float
    doc: consider sequences <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: --incE
  - id: inc_t_threshold
    type:
      - 'null'
      - float
    doc: consider sequences >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: --incT
  - id: incdom_e_threshold
    type:
      - 'null'
      - float
    doc: consider domains <= this E-value threshold as significant
    inputBinding:
      position: 103
      prefix: --incdomE
  - id: incdom_t_threshold
    type:
      - 'null'
      - float
    doc: consider domains >= this score threshold as significant
    inputBinding:
      position: 103
      prefix: --incdomT
  - id: max
    type:
      - 'null'
      - boolean
    doc: Turn all heuristic filters off (less speed, more power)
    inputBinding:
      position: 103
      prefix: --max
  - id: mpi
    type:
      - 'null'
      - boolean
    doc: run as an MPI parallel program
    inputBinding:
      position: 103
      prefix: --mpi
  - id: noali
    type:
      - 'null'
      - boolean
    doc: don't output alignments, so output is smaller
    inputBinding:
      position: 103
      prefix: --noali
  - id: nobias
    type:
      - 'null'
      - boolean
    doc: turn off composition bias filter
    inputBinding:
      position: 103
      prefix: --nobias
  - id: nonull2
    type:
      - 'null'
      - boolean
    doc: turn off biased composition score corrections
    inputBinding:
      position: 103
      prefix: --nonull2
  - id: notextw
    type:
      - 'null'
      - boolean
    doc: unlimit ASCII text output line width
    inputBinding:
      position: 103
      prefix: --notextw
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: report sequences >= this score threshold in output
    inputBinding:
      position: 103
      prefix: -T
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 103
      prefix: --seed
  - id: stall
    type:
      - 'null'
      - boolean
    doc: 'arrest after start: for debugging MPI under gdb'
    inputBinding:
      position: 103
      prefix: --stall
  - id: textw
    type:
      - 'null'
      - int
    doc: set max width of ASCII text output lines
    inputBinding:
      position: 103
      prefix: --textw
  - id: tformat
    type:
      - 'null'
      - string
    doc: 'assert target <seqfile> is in format <s>: no autodetection'
    inputBinding:
      position: 103
      prefix: --tformat
  - id: z_comparisons
    type:
      - 'null'
      - float
    doc: 'set # of comparisons done, for E-value calculation'
    inputBinding:
      position: 103
      prefix: -Z
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: direct output to file, not stdout
    outputBinding:
      glob: $(inputs.output_file)
  - id: alignment_output
    type:
      - 'null'
      - File
    doc: save multiple alignment of all hits to file
    outputBinding:
      glob: $(inputs.alignment_output)
  - id: tblout
    type:
      - 'null'
      - File
    doc: save parseable table of per-sequence hits to file
    outputBinding:
      glob: $(inputs.tblout)
  - id: domtblout
    type:
      - 'null'
      - File
    doc: save parseable table of per-domain hits to file
    outputBinding:
      glob: $(inputs.domtblout)
  - id: pfamtblout
    type:
      - 'null'
      - File
    doc: save table of hits and domains to file, in Pfam format
    outputBinding:
      glob: $(inputs.pfamtblout)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
