cwlVersion: v1.2
class: CommandLineTool
baseCommand: prinseq-plus-plus
label: prinseq-plus-plus_prinseq++
doc: "PRINSEQ++ is a C++ implementation of the prinseq-lite.pl program. It can be
  used to filter, reformat or trim genomic and metagenomic sequence data. It is 5X
  faster than prinseq-lite.pl and uses less RAM thanks to the use of multi-threading
  and the cboost libraries. It can read and write compressed (gzip) files, drastically
  reducing the use of hard drive.\n\nTool homepage: https://github.com/Adrian-Cantu/PRINSEQ-plus-plus"
inputs:
  - id: derep
    type:
      - 'null'
      - boolean
    doc: Filter duplicated sequences. This only remove exact duplicates.
    inputBinding:
      position: 101
      prefix: -derep
  - id: fasta_input
    type:
      - 'null'
      - boolean
    doc: Input is in fasta format (no quality). Note that the output format is 
      still fastq by default. Quality will be treated as 31 (A) for all bases.
    inputBinding:
      position: 101
      prefix: -FASTA
  - id: fastq
    type:
      - 'null'
      - File
    doc: Input file in FASTQ format. Can also read a compressed (.gz) file.
    inputBinding:
      position: 101
      prefix: -fastq
  - id: fastq2
    type:
      - 'null'
      - File
    doc: Input file in FASTQ format for pair-end reads. Can also read a 
      compressed (.gz) file.
    inputBinding:
      position: 101
      prefix: -fastq2
  - id: lc_dust
    type:
      - 'null'
      - float
    doc: Filter sequences with dust_score lower than [float]. [float] should be 
      in the 0-1 interval.
    default: 0.5
    inputBinding:
      position: 101
      prefix: -lc_dust
  - id: lc_entropy
    type:
      - 'null'
      - float
    doc: Filter sequences with entropy lower than [float]. [float] should be in 
      the 0-1 interval.
    default: 0.5
    inputBinding:
      position: 101
      prefix: -lc_entropy
  - id: max_gc
    type:
      - 'null'
      - float
    doc: Filter sequence with GC percent content above min_gc.
    inputBinding:
      position: 101
      prefix: -max_gc
  - id: max_len
    type:
      - 'null'
      - int
    doc: Filter sequence longer than max_len.
    inputBinding:
      position: 101
      prefix: -max_len
  - id: min_gc
    type:
      - 'null'
      - float
    doc: Filter sequence with GC percent content below min_gc.
    inputBinding:
      position: 101
      prefix: -min_gc
  - id: min_len
    type:
      - 'null'
      - int
    doc: Filter sequence shorter than min_len.
    inputBinding:
      position: 101
      prefix: -min_len
  - id: min_qual_mean
    type:
      - 'null'
      - int
    doc: Filter sequence with quality score mean below min_qual_mean.
    inputBinding:
      position: 101
      prefix: -min_qual_mean
  - id: min_qual_score
    type:
      - 'null'
      - int
    doc: Filter sequence with at least one base with quality score below 
      min_qual_score.
    inputBinding:
      position: 101
      prefix: -min_qual_score
  - id: noiupac
    type:
      - 'null'
      - boolean
    doc: Filter sequence with characters other than A, C, G, T or N.
    inputBinding:
      position: 101
      prefix: -noiupac
  - id: ns_max_n
    type:
      - 'null'
      - int
    doc: Filter sequence with more than ns_max_n Ns.
    inputBinding:
      position: 101
      prefix: -ns_max_n
  - id: out_format
    type:
      - 'null'
      - int
    doc: Set output format. 0 FASTQ, 1 FASTA.
    default: 0
    inputBinding:
      position: 101
      prefix: -out_format
  - id: out_gz
    type:
      - 'null'
      - boolean
    doc: Write the output to a compressed file (WARNING this can be really SLOW)
    inputBinding:
      position: 101
      prefix: -out_gz
  - id: out_name
    type:
      - 'null'
      - string
    doc: For pair-end sequences, the output files are <string>_good_out_R1 and 
      <string>_good_out_R2 for pairs where both reads pass quality control, 
      <string>_single_out_R1 and <string>_single_out_R2 for read that passed 
      quality control but mate didn't. <string>_bad_out_R1 and 
      <string>_bad_out_R2 for reads that fail quality controls. [Default = 
      random size 6 string]
    inputBinding:
      position: 101
      prefix: -out_name
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Input quality is in phred64 format. This is for older Illumina/Solexa 
      reads.
    inputBinding:
      position: 101
      prefix: -phred64
  - id: rm_header
    type:
      - 'null'
      - boolean
    doc: Remove the header in the 3rd line of the fastq (+header -> +). This 
      does not change the header in the 1st line (@header).
    inputBinding:
      position: 101
      prefix: -rm_header
  - id: threads
    type:
      - 'null'
      - int
    doc: Nuber of threads to use. Note that if more than one thread is used, 
      output sequences might not be in the same order as input sequences.
    default: 1
    inputBinding:
      position: 101
      prefix: -threads
  - id: trim_left
    type:
      - 'null'
      - int
    doc: Trim <integer> bases from the left (5'->3').
    inputBinding:
      position: 101
      prefix: -trim_left
  - id: trim_qual_left
    type:
      - 'null'
      - float
    doc: Trim recursively from the 3'-end chunks of length -trim_qual_step if 
      the mean quality of the first -trim_qual_window bases is less than 
      [float].
    default: 20
    inputBinding:
      position: 101
      prefix: -trim_qual_left
  - id: trim_qual_right
    type:
      - 'null'
      - float
    doc: Trim recursively from the 5'-end chunks of length -trim_qual_step if 
      the mean quality of the last -trim_qual_window bases is less than [float].
    default: 20
    inputBinding:
      position: 101
      prefix: -trim_qual_right
  - id: trim_qual_rule
    type:
      - 'null'
      - string
    doc: Rule to use to compare quality score to calculated value. Allowed 
      options are lt (less than), gt (greater than) and et (equal to).
    default: lt
    inputBinding:
      position: 101
      prefix: -trim_qual_rule
  - id: trim_qual_step
    type:
      - 'null'
      - int
    doc: Step size used by trim_qual_left and trim_qual_right
    default: 2
    inputBinding:
      position: 101
      prefix: -trim_qual_step
  - id: trim_qual_type
    type:
      - 'null'
      - string
    doc: Type of quality score calculation to use. Allowed options are min, 
      mean, max and sum.
    default: min
    inputBinding:
      position: 101
      prefix: -trim_qual_type
  - id: trim_qual_window
    type:
      - 'null'
      - int
    doc: Size of the window used by trim_qual_left and trim_qual_right
    default: 5
    inputBinding:
      position: 101
      prefix: -trim_qual_window
  - id: trim_right
    type:
      - 'null'
      - int
    doc: Trim <integer> bases from the right (3'->5').
    inputBinding:
      position: 101
      prefix: -trim_right
  - id: trim_tail_left
    type:
      - 'null'
      - int
    doc: Trim poly-A/T tail with a minimum length of <integer> at the 5'-end.
    inputBinding:
      position: 101
      prefix: -trim_tail_left
  - id: trim_tail_right
    type:
      - 'null'
      - int
    doc: Trim poly-A/T tail with a minimum length of <integer> at the 3'-end.
    inputBinding:
      position: 101
      prefix: -trim_tail_right
  - id: verbose
    type:
      - 'null'
      - int
    doc: Format of the report of filtered reads, VERBOSE=1 prints information 
      only on the filters that removed sequences. VERBOSE=2 prints numbers for 
      filters in order (min_len, max_len, min_cg, max_cg, min_qual_score, 
      min_qual_mean, ns_max_n, noiupac, derep, lc_entropy, lc_dust, 
      trim_tail_left, trim_tail_right, trim_qual_left, trim_qual_right, 
      trim_left, trim_right) to compare stats of diferent files. VERBOSE=0 
      prints nothing.
    default: 1
    inputBinding:
      position: 101
      prefix: -VERBOSE
outputs:
  - id: out_good
    type:
      - 'null'
      - File
    doc: "Rename the output files idividually, this overwrites the names given by
      -out_name only for the selected files. File extension won't be added automatically.
      (TIP: if you don't need a file, set its name to /dev/null)"
    outputBinding:
      glob: $(inputs.out_good)
  - id: out_single
    type:
      - 'null'
      - File
    doc: "Rename the output files idividually, this overwrites the names given by
      -out_name only for the selected files. File extension won't be added automatically.
      (TIP: if you don't need a file, set its name to /dev/null)"
    outputBinding:
      glob: $(inputs.out_single)
  - id: out_bad
    type:
      - 'null'
      - File
    doc: "Rename the output files idividually, this overwrites the names given by
      -out_name only for the selected files. File extension won't be added automatically.
      (TIP: if you don't need a file, set its name to /dev/null)"
    outputBinding:
      glob: $(inputs.out_bad)
  - id: out_good2
    type:
      - 'null'
      - File
    doc: "Rename the output files idividually, this overwrites the names given by
      -out_name only for the selected files. File extension won't be added automatically.
      (TIP: if you don't need a file, set its name to /dev/null)"
    outputBinding:
      glob: $(inputs.out_good2)
  - id: out_single2
    type:
      - 'null'
      - File
    doc: "Rename the output files idividually, this overwrites the names given by
      -out_name only for the selected files. File extension won't be added automatically.
      (TIP: if you don't need a file, set its name to /dev/null)"
    outputBinding:
      glob: $(inputs.out_single2)
  - id: out_bad2
    type:
      - 'null'
      - File
    doc: "Rename the output files idividually, this overwrites the names given by
      -out_name only for the selected files. File extension won't be added automatically.
      (TIP: if you don't need a file, set its name to /dev/null)"
    outputBinding:
      glob: $(inputs.out_bad2)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prinseq-plus-plus:1.2.4--h7ff8a90_1
