cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu-prep
label: ssu-align_ssu-prep
doc: "Split a sequence file into smaller files and write a shell script that runs ssu-align jobs in parallel on them.

Tool homepage: http://eddylab.org/software/ssu-align/"
inputs:
  - id: no_script_prefix
    type:
      - 'null'
      - boolean
    doc: "do not specify <prefix/suffix file>; output shell script runs all <num jobs> jobs in parallel on one machine"
    inputBinding:
      position: 101
      prefix: -x
  - id: manual_prefix
    type:
      - 'null'
      - boolean
    doc: "do not specify <prefix/suffix file>; user adds the desired prefix/suffix to ssu-align commands after ssu-prep finishes"
    inputBinding:
      position: 101
      prefix: -y
  - id: force
    type:
      - 'null'
      - boolean
    doc: "force; if dir named <output dir> already exists, empty it first"
    inputBinding:
      position: 101
      prefix: -f
  - id: seqs_per_job
    type:
      - 'null'
      - boolean
    doc: "third command line arg is number of seqs per job, not number of jobs"
    inputBinding:
      position: 101
      prefix: -q
  - id: equal_seqs
    type:
      - 'null'
      - boolean
    doc: "split seqs so each job has an equal number of seqs, not nucleotides"
    inputBinding:
      position: 101
      prefix: -e
  - id: no_bash
    type:
      - 'null'
      - boolean
    doc: "write generic shell script instead of a bash-specific one"
    inputBinding:
      position: 101
      prefix: --no-bash
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: "do not have final ssu-align job automatically merge all jobs"
    inputBinding:
      position: 101
      prefix: --no-merge
  - id: keep_merge
    type:
      - 'null'
      - boolean
    doc: "have final ssu-align job not remove small files as they are merged"
    inputBinding:
      position: 101
      prefix: --keep-merge
  - id: cm_file
    type:
      - 'null'
      - File
    doc: "use CM file <f> instead of the default CM file"
    inputBinding:
      position: 101
      prefix: -m
  - id: min_bit_score
    type:
      - 'null'
      - float
    doc: "set minimum bit score of a surviving subsequence as <x> [default: 50]"
    inputBinding:
      position: 101
      prefix: -b
  - id: min_length
    type:
      - 'null'
      - int
    doc: "set minimum length of a surviving subsequence as <n> [default: 1]"
    inputBinding:
      position: 101
      prefix: -l
  - id: interleaved
    type:
      - 'null'
      - boolean
    doc: "output alignments in interleaved Stockholm format (not 1 line/seq)"
    inputBinding:
      position: 101
      prefix: -i
  - id: single_cm_name
    type:
      - 'null'
      - string
    doc: "only search with and align to single CM named <s> in CM file"
    inputBinding:
      position: 101
      prefix: -n
  - id: dna
    type:
      - 'null'
      - boolean
    doc: "output alignments as DNA, default is RNA (even if input is DNA)"
    inputBinding:
      position: 101
      prefix: --dna
  - id: rfonly
    type:
      - 'null'
      - boolean
    doc: "discard inserts, only keep consensus (nongap RF) columns in alignments"
    inputBinding:
      position: 101
      prefix: --rfonly
  - id: no_align
    type:
      - 'null'
      - boolean
    doc: "only search target sequence file for hits, skip alignment step"
    inputBinding:
      position: 101
      prefix: --no-align
  - id: no_search
    type:
      - 'null'
      - boolean
    doc: "only align target sequence file, skip initial search step"
    inputBinding:
      position: 101
      prefix: --no-search
  - id: toponly
    type:
      - 'null'
      - boolean
    doc: "only search the top strand [default: search both strands]"
    inputBinding:
      position: 101
      prefix: --toponly
  - id: forward
    type:
      - 'null'
      - boolean
    doc: "use the HMM forward algorithm for searching, not HMM viterbi"
    inputBinding:
      position: 101
      prefix: --forward
  - id: global
    type:
      - 'null'
      - boolean
    doc: "search with globally configured HMM [default: local]"
    inputBinding:
      position: 101
      prefix: --global
  - id: keep_int
    type:
      - 'null'
      - boolean
    doc: "keep intermediate files which are normally removed"
    inputBinding:
      position: 101
      prefix: --keep-int
  - id: aln_one
    type:
      - 'null'
      - string
    doc: "only align best-matching sequences to the CM named <s> in CM file"
    inputBinding:
      position: 101
      prefix: --aln-one
  - id: no_trunc
    type:
      - 'null'
      - boolean
    doc: "do not truncate seqs to HMM predicted start/end, align full seqs"
    inputBinding:
      position: 101
      prefix: --no-trunc
  - id: no_prob
    type:
      - 'null'
      - boolean
    doc: "do not append posterior probabilities to alignments"
    inputBinding:
      position: 101
      prefix: --no-prob
  - id: mxsize
    type:
      - 'null'
      - float
    doc: "increase mx size for cmalign to <f> Mb [default: 4096]"
    inputBinding:
      position: 101
      prefix: --mxsize
  - id: seqfile
    type: File
    doc: "sequence file to split"
    inputBinding:
      position: 201
  - id: output_dir
    type: string
    doc: "output directory"
    inputBinding:
      position: 202
  - id: num_jobs
    type: int
    doc: "number of jobs (number of seqs per job with -q)"
    inputBinding:
      position: 203
  - id: prefix_suffix_file
    type:
      - 'null'
      - File
    doc: "file with the prefix (first line) and suffix (second line) for the ssu-align jobs in the output shell script (not used with -x or -y)"
    inputBinding:
      position: 204
outputs:
  - id: output_dir_out
    type: Directory
    doc: Directory with the split sequence files and the shell script that runs the ssu-align jobs
    outputBinding:
      glob: $(inputs.output_dir)
  - id: job_script
    type:
      - 'null'
      - File
    doc: Shell script that runs the ssu-align jobs
    outputBinding:
      glob: $(inputs.output_dir).ssu-align.sh
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ssu-align:0.1.1--h7b50bb2_7
stdout: ssu-prep.out
