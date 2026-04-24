cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccsmeth_call_freqb
label: ccsmeth_call_freqb
doc: "call frequency of modifications at genome level from modbam.bam file\n\nTool
  homepage: https://github.com/PengNi/ccsmeth"
inputs:
  - id: aggre_model
    type:
      - 'null'
      - File
    doc: file path of the aggregate model (.ckpt)
    inputBinding:
      position: 101
      prefix: --aggre_model
  - id: base_clip
    type:
      - 'null'
      - int
    doc: number of base clipped in each read, default 0
    inputBinding:
      position: 101
      prefix: --base_clip
  - id: bed
    type:
      - 'null'
      - boolean
    doc: save the result in bedMethyl format
    inputBinding:
      position: 101
      prefix: --bed
  - id: bin_size
    type:
      - 'null'
      - int
    doc: histogram bin size, default 20
    inputBinding:
      position: 101
      prefix: --bin_size
  - id: call_mode
    type:
      - 'null'
      - string
    doc: 'call mode: count, aggregate. default count.'
    inputBinding:
      position: 101
      prefix: --call_mode
  - id: chunk_len
    type:
      - 'null'
      - int
    doc: chunk length
    inputBinding:
      position: 101
      prefix: --chunk_len
  - id: class_num
    type:
      - 'null'
      - int
    inputBinding:
      position: 101
      prefix: --class_num
  - id: contigs
    type:
      - 'null'
      - string
    doc: path of a file containing chromosome/contig names, one name each line; 
      or a string contains multiple chromosome names splited by comma.default 
      None, which means all chromosomes will be processed.
    inputBinding:
      position: 101
      prefix: --contigs
  - id: cov_cf
    type:
      - 'null'
      - int
    doc: coverage cutoff, to consider if use aggregate model to re-predict the 
      modstate of the site
    inputBinding:
      position: 101
      prefix: --cov_cf
  - id: discrete
    type:
      - 'null'
      - boolean
    doc: '[EXPERIMENTAL]'
    inputBinding:
      position: 101
      prefix: --discrete
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: if compressing the output using gzip
    inputBinding:
      position: 101
      prefix: --gzip
  - id: hap_tag
    type:
      - 'null'
      - string
    doc: haplotype tag, default HP
    inputBinding:
      position: 101
      prefix: --hap_tag
  - id: hid_rnn
    type:
      - 'null'
      - int
    doc: BiRNN hidden_size, default 32
    inputBinding:
      position: 101
      prefix: --hid_rnn
  - id: identity
    type:
      - 'null'
      - float
    doc: identity cutoff for selecting alignment items, [0.0, 1.0], default 0.0
    inputBinding:
      position: 101
      prefix: --identity
  - id: input_bam
    type: File
    doc: input bam, should be aligned and sorted
    inputBinding:
      position: 101
      prefix: --input_bam
  - id: layer_rnn
    type:
      - 'null'
      - int
    doc: BiRNN layer num, default 1
    inputBinding:
      position: 101
      prefix: --layer_rnn
  - id: mapq
    type:
      - 'null'
      - int
    doc: MAPping Quality cutoff for selecting alignment items, default 1
    inputBinding:
      position: 101
      prefix: --mapq
  - id: mod_loc
    type:
      - 'null'
      - int
    doc: 0-based location of the targeted base in the motif, default 0
    inputBinding:
      position: 101
      prefix: --mod_loc
  - id: model_type
    type:
      - 'null'
      - string
    doc: "type of model to use, 'attbigru', 'attbilstm', default: attbigru"
    inputBinding:
      position: 101
      prefix: --model_type
  - id: modtype
    type:
      - 'null'
      - string
    doc: modification type, default 5mC.
    inputBinding:
      position: 101
      prefix: --modtype
  - id: motifs
    type:
      - 'null'
      - string
    doc: 'motif seq to be extracted, default: CG. can be multi motifs splited by comma
      (no space allowed in the input str), or use IUPAC alphabet, the mod_loc of all
      motifs must be the same'
    inputBinding:
      position: 101
      prefix: --motifs
  - id: no_amb_cov
    type:
      - 'null'
      - boolean
    doc: when using prob_cf>0, DO NOT count ambiguous calls for calculating 
      reads coverage
    inputBinding:
      position: 101
      prefix: --no_amb_cov
  - id: no_comb
    type:
      - 'null'
      - boolean
    doc: don't combine fwd/rev reads of one CG. [Only works when motifs is CG]
    inputBinding:
      position: 101
      prefix: --no_comb
  - id: no_hap
    type:
      - 'null'
      - boolean
    doc: don't call_freq on haplotypes
    inputBinding:
      position: 101
      prefix: --no_hap
  - id: no_supplementary
    type:
      - 'null'
      - boolean
    doc: not use supplementary alignment
    inputBinding:
      position: 101
      prefix: --no_supplementary
  - id: only_close
    type:
      - 'null'
      - boolean
    doc: '[EXPERIMENTAL]'
    inputBinding:
      position: 101
      prefix: --only_close
  - id: prob_cf
    type:
      - 'null'
      - float
    doc: this is to remove ambiguous calls (only for count-mode now). if 
      abs(prob1-prob0)>=prob_cf, then we use the call. e.g., proc_cf=0 means use
      all calls. range [0, 1], default 0.0.
    inputBinding:
      position: 101
      prefix: --prob_cf
  - id: ref
    type: File
    doc: path to genome reference, in fasta/fa format.
    inputBinding:
      position: 101
      prefix: --ref
  - id: refsites_all
    type:
      - 'null'
      - boolean
    doc: output all covered sites which are target motifs in reference. 
      --refsites_all is True, also means we do not output sites which are target
      motifs only in reads.
    inputBinding:
      position: 101
      prefix: --refsites_all
  - id: refsites_only
    type:
      - 'null'
      - boolean
    doc: only keep sites which are target motifs in both reference and reads
    inputBinding:
      position: 101
      prefix: --refsites_only
  - id: seq_len
    type:
      - 'null'
      - int
    doc: len of sites used. default 11
    inputBinding:
      position: 101
      prefix: --seq_len
  - id: sort
    type:
      - 'null'
      - boolean
    doc: sort items in the result
    inputBinding:
      position: 101
      prefix: --sort
  - id: threads
    type:
      - 'null'
      - int
    doc: number of subprocesses used.
    inputBinding:
      position: 101
      prefix: --threads
  - id: tseed
    type:
      - 'null'
      - int
    doc: random seed for torch
    inputBinding:
      position: 101
      prefix: --tseed
outputs:
  - id: output
    type: File
    doc: prefix of output file to save the results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccsmeth:0.5.0--pyhdfd78af_0
