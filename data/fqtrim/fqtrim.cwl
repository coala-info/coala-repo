cwlVersion: v1.2
class: CommandLineTool
baseCommand: fqtrim
label: fqtrim
doc: "Trim low quality bases at the 3' end and can trim adapter sequence(s), filter\
  \ for low complexity and collapse duplicate reads.\n\nTool homepage: https://ccb.jhu.edu/software/fqtrim/"
inputs:
  - id: input_fq
    type: File
    doc: Input FASTQ/FASTA file (or file name of the first read file of a pair)
    inputBinding:
      position: 1
      valueFrom: '$(inputs.input_mates_fq ? self.path + "," + inputs.input_mates_fq.path
        : self.path)'
  - id: input_mates_fq
    type:
      - 'null'
      - File
    doc: Mate FASTQ file for paired reads; joined to the first file with a comma so
      the pair is trimmed together
  - id: adapter_3
    type:
      - 'null'
      - string
    doc: Trim the given adapter sequence at the 3' end of each read
    inputBinding:
      position: 103
      prefix: '-3'
  - id: adapter_5
    type:
      - 'null'
      - string
    doc: Trim the given adapter or primer sequence at the 5' end of each read
    inputBinding:
      position: 103
      prefix: '-5'
  - id: adapters_file
    type:
      - 'null'
      - File
    doc: 'File with adapter sequences to trim, each line having this format: [<5_adapter_sequence>][
      <3_adapter_sequence>]'
    inputBinding:
      position: 103
      prefix: -f
  - id: add_trim_info
    type:
      - 'null'
      - boolean
    doc: Write the number of bases trimmed at 5' and 3' ends after the read names
      in the FASTA/FASTQ output file(s)
    inputBinding:
      position: 103
      prefix: -T
  - id: aidx_encoding
    type:
      - 'null'
      - boolean
    doc: Encode vector/adapter trimming operations as a,b,c,.. instead of V, corresponding
      to the order of adapter sequences in the -f file
    inputBinding:
      position: 103
      prefix: --aidx
  - id: collapse_duplicates
    type:
      - 'null'
      - boolean
    doc: Collapse duplicate reads and append a _x<N>count suffix to the read name
      (where <N> is the duplication count)
    inputBinding:
      position: 103
      prefix: -C
  - id: convert_quality
    type:
      - 'null'
      - boolean
    doc: Convert quality values to the other Phred qv type
    inputBinding:
      position: 103
      prefix: -Q
  - id: disable_polyAT_trimming
    type:
      - 'null'
      - boolean
    doc: Disable polyA/T trimming (enabled by default)
    inputBinding:
      position: 103
      prefix: -A
  - id: disable_read_name_consistency_check
    type:
      - 'null'
      - boolean
    doc: Disable read name consistency check for paired reads
    inputBinding:
      position: 103
      prefix: -M
  - id: low_complexity_filter
    type:
      - 'null'
      - boolean
    doc: Pass reads through a low-complexity (dust) filter and discard any read that
      has over 50% of its length masked as low complexity
    inputBinding:
      position: 103
      prefix: -D
  - id: mask_low_complexity
    type:
      - 'null'
      - boolean
    doc: Same as -D, but mask the low complexity regions with Ns in the output sequence
      instead of discarding reads
    inputBinding:
      position: 103
      prefix: --dmask
  - id: match_reward
    type:
      - 'null'
      - int
    doc: Match reward for scoring the adapter alignment
    inputBinding:
      position: 103
      prefix: --match
  - id: max_perc_n
    type:
      - 'null'
      - float
    doc: Maximum percentage of Ns allowed in a read after trimming
    inputBinding:
      position: 103
      prefix: -m
  - id: min_match
    type:
      - 'null'
      - int
    doc: Minimum length of exact suffix-prefix match with adapter sequence that can
      be trimmed at either end of the read
    inputBinding:
      position: 103
      prefix: -a
  - id: min_percent_identity_3
    type:
      - 'null'
      - float
    doc: Minimum percent identity for adapter match at 3' end
    inputBinding:
      position: 103
      prefix: --pid3
  - id: min_percent_identity_5
    type:
      - 'null'
      - float
    doc: Minimum percent identity for adapter match at 5' end
    inputBinding:
      position: 103
      prefix: --pid5
  - id: min_poly
    type:
      - 'null'
      - int
    doc: Minimum length of poly-A/T run to remove
    inputBinding:
      position: 103
      prefix: -y
  - id: min_quality
    type:
      - 'null'
      - int
    doc: Trim read ends where the quality value drops below <minq>
    inputBinding:
      position: 103
      prefix: -q
  - id: minlen
    type:
      - 'null'
      - int
    doc: Minimum read length after trimming (if the remaining sequence is shorter
      than this, the read will be discarded)
    inputBinding:
      position: 103
      prefix: -l
  - id: mismatch_penalty
    type:
      - 'null'
      - int
    doc: Mismatch penalty for scoring the adapter alignment
    inputBinding:
      position: 103
      prefix: --mism
  - id: ntrimdist
    type:
      - 'null'
      - int
    doc: Maximum distance for N trimming
    inputBinding:
      position: 103
      prefix: --ntrimdist=
      separate: false
  - id: numcpus
    type:
      - 'null'
      - int
    doc: Use <numcpus> CPUs (threads) on the local machine
    inputBinding:
      position: 103
      prefix: -p
  - id: output_affected_only
    type:
      - 'null'
      - boolean
    doc: Output only reads affected by trimming (discard clean reads!)
    inputBinding:
      position: 103
      prefix: -O
  - id: output_suffix
    type:
      - 'null'
      - string
    doc: 'Write the trimmed/filtered reads to file(s) named <input>.<outsuffix> which
      will be created in the current (working) directory (unless --outdir is used);
      this suffix should include the file extension; if this extension is .gz, .gzip
      or .bz2 then the output will be compressed accordingly. NOTE: if the input file
      is ''-'' (stdin) then this is the full name of the output file, not just the
      suffix.'
    inputBinding:
      position: 103
      prefix: -o
  - id: phred_type
    type:
      - 'null'
      - string
    doc: 'Input quality encoding: 64 or 33 (passed as -P64 or -P33)'
    inputBinding:
      position: 103
      prefix: -P
      separate: false
  - id: rename_prefix
    type:
      - 'null'
      - string
    doc: Rename the reads using the <prefix> followed by a read counter; if -C option
      was also provided, the suffix "_x<N>" is appended (where <N> is the read duplication
      count)
    inputBinding:
      position: 103
      prefix: -n
  - id: reverse_complement_adapter
    type:
      - 'null'
      - boolean
    doc: Also look for terminal alignments with the reverse complement of the adapter
      sequence(s)
    inputBinding:
      position: 103
      prefix: -R
  - id: trim_max_len
    type:
      - 'null'
      - int
    doc: For -q, limit maximum trimming at either end to <trim_max_len>
    inputBinding:
      position: 103
      prefix: -t
  - id: trim_polyAT_both_ends
    type:
      - 'null'
      - boolean
    doc: 'Trim polyA/T at both ends (default: only poly-A at 3'' end, poly-T at 5'')'
    inputBinding:
      position: 103
      prefix: -B
  - id: trim_report
    type:
      - 'null'
      - string
    doc: Name of a "trimming report" file to write, listing the affected reads with
      their trimming operations
    inputBinding:
      position: 103
      prefix: -r
  - id: verbose_trimming_summary
    type:
      - 'null'
      - boolean
    doc: Show verbose trimming summary
    inputBinding:
      position: 103
      prefix: -V
  - id: window_size
    type:
      - 'null'
      - int
    doc: For -q, sliding window size for calculating avg. quality
    inputBinding:
      position: 103
      prefix: -w
  - id: outdir_path
    type:
      - 'null'
      - string
    inputBinding:
      position: 104
      prefix: --outdir
    doc: For -o, write the output file(s) to this directory instead of the working
      directory. The directory is created before the run.
  - id: skip_read1
    type:
      - 'null'
      - boolean
    doc: For paired reads, do not trim read 1; the pair is still discarded if read
      2 is trashed
    inputBinding:
      position: 103
      prefix: -s1
  - id: skip_read2
    type:
      - 'null'
      - boolean
    doc: For paired reads, do not trim read 2; the pair is still discarded if read
      1 is trashed
    inputBinding:
      position: 103
      prefix: -s2
outputs:
  - id: trimmed_reads
    type:
      type: array
      items: File
    doc: Trimmed/filtered reads written with -o (<input>.<outsuffix>)
    outputBinding:
      glob: '${ var s = inputs.output_suffix; if (!s) { return []; } var dir = inputs.outdir_path
        ? inputs.outdir_path + "/" : ""; return [dir + "*." + s]; }'
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Directory given with --outdir
    outputBinding:
      glob: $(inputs.outdir_path)
  - id: trim_report_file
    type:
      - 'null'
      - File
    doc: Trimming report written with -r
    outputBinding:
      glob: $(inputs.trim_report)
  - id: summary
    type: File
    doc: Trimming summary printed by fqtrim (standard error)
    outputBinding:
      glob: fqtrim_summary.txt
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '${ if (inputs.outdir_path) { return [{"entryname": inputs.outdir_path,
      "entry": {"class": "Directory", "basename": inputs.outdir_path, "listing": []},
      "writable": true}]; } return []; }'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fqtrim:0.9.7--h077b44d_7
stderr: fqtrim_summary.txt
