cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitcode
label: splitcode
doc: "Sequence identification and read modification tool for FASTQ files.\n\nTool
  homepage: https://github.com/pachterlab/splitcode"
inputs:
  - id: fastq_files
    type:
      type: array
      items: File
    doc: Input FASTQ files
    inputBinding:
      position: 1
  - id: append
    type:
      - 'null'
      - File
    doc: An existing mapping file that will be added on to
    inputBinding:
      position: 102
      prefix: --append
  - id: assign
    type:
      - 'null'
      - boolean
    doc: Assign reads to a final barcode sequence identifier based on tags 
      present
    inputBinding:
      position: 102
      prefix: --assign
  - id: barcode_encode
    type:
      - 'null'
      - boolean
    doc: Optimize barcode assignment using a sequence of group names (e.g. 
      group1,group2,group3)
    inputBinding:
      position: 102
      prefix: --barcode-encode
  - id: bc_names
    type:
      - 'null'
      - boolean
    doc: Modify names of outputted sequences to include final barcode sequence 
      string
    inputBinding:
      position: 102
      prefix: --bc-names
  - id: bclen
    type:
      - 'null'
      - int
    doc: 'The length of the final barcode sequence identifier (default: 16)'
    default: 16
    inputBinding:
      position: 102
      prefix: --bclen
  - id: cite
    type:
      - 'null'
      - boolean
    doc: Prints citation information
    inputBinding:
      position: 102
      prefix: --cite
  - id: com_names
    type:
      - 'null'
      - boolean
    doc: Modify names of outputted sequences to include final barcode sequence 
      ID
    inputBinding:
      position: 102
      prefix: --com-names
  - id: compress
    type:
      - 'null'
      - int
    doc: 'Set the gzip compression level (default: 1) (range: 1-9)'
    default: 1
    inputBinding:
      position: 102
      prefix: --compress
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file
    inputBinding:
      position: 102
      prefix: --config
  - id: distances
    type:
      - 'null'
      - string
    doc: List of error distance (mismatch:indel:total) thresholds 
      (comma-separated)
    inputBinding:
      position: 102
      prefix: --distances
  - id: empty
    type:
      - 'null'
      - string
    doc: 'Sequence to fill in empty reads in output FASTQ files (default: no sequence
      is used to fill in those reads)'
    inputBinding:
      position: 102
      prefix: --empty
  - id: empty_remove
    type:
      - 'null'
      - boolean
    doc: Empty reads are stripped in output FASTQ files (don't even output an 
      empty sequence)
    inputBinding:
      position: 102
      prefix: --empty-remove
  - id: exclude
    type:
      - 'null'
      - string
    doc: List of what to exclude from final barcode (comma-separated; 1 = 
      exclude, 0 = include)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: extract
    type:
      - 'null'
      - string
    doc: Pattern(s) describing how to extract UMI and UMI-like sequences from 
      reads
    inputBinding:
      position: 102
      prefix: --extract
  - id: filter_len
    type:
      - 'null'
      - string
    doc: Filter reads based on length (min_length:max_length)
    inputBinding:
      position: 102
      prefix: --filter-len
  - id: from_name
    type:
      - 'null'
      - string
    doc: 'Extract sequences from FASTQ header comments. Format: fastq_number,output_file_number,output_position,pattern.'
    inputBinding:
      position: 102
      prefix: --from-name
  - id: groups
    type:
      - 'null'
      - string
    doc: List of tag group names (comma-separated)
    inputBinding:
      position: 102
      prefix: --groups
  - id: gzip
    type:
      - 'null'
      - boolean
    doc: Output compressed gzip'ed FASTQ files
    inputBinding:
      position: 102
      prefix: --gzip
  - id: ids
    type:
      - 'null'
      - string
    doc: List of tag names/identifiers (comma-separated)
    inputBinding:
      position: 102
      prefix: --ids
  - id: inleaved
    type:
      - 'null'
      - boolean
    doc: Specifies that input is an interleaved FASTQ file
    inputBinding:
      position: 102
      prefix: --inleaved
  - id: keep
    type:
      - 'null'
      - File
    doc: File containing a list of arrangements of tag names to keep
    inputBinding:
      position: 102
      prefix: --keep
  - id: keep_com
    type:
      - 'null'
      - boolean
    doc: Preserve the comments of the read names of the input FASTQ file(s)
    inputBinding:
      position: 102
      prefix: --keep-com
  - id: keep_grp
    type:
      - 'null'
      - File
    doc: File containing a list of arrangements of tag groups to keep
    inputBinding:
      position: 102
      prefix: --keep-grp
  - id: keep_r1_r2
    type:
      - 'null'
      - boolean
    doc: Use R1.fastq, R2.fastq, etc. file name formats when demultiplexing 
      using --keep or --keep-grp
    inputBinding:
      position: 102
      prefix: --keep-r1-r2
  - id: left
    type:
      - 'null'
      - string
    doc: List of what tags to include when trimming from the left 
      (comma-separated; 1 = include, 0 = exclude)
    inputBinding:
      position: 102
      prefix: --left
  - id: lift
    type:
      - 'null'
      - boolean
    doc: Turn lift mode (make variant genomes from VCF files)
    inputBinding:
      position: 102
      prefix: --lift
  - id: loc_names
    type:
      - 'null'
      - boolean
    doc: Modify names of outputted sequences to include found tag names and 
      locations
    inputBinding:
      position: 102
      prefix: --loc-names
  - id: locations
    type:
      - 'null'
      - string
    doc: List of locations (file:pos1:pos2) (comma-separated)
    inputBinding:
      position: 102
      prefix: --locations
  - id: mapping
    type:
      - 'null'
      - File
    doc: Output file where the mapping between final barcode sequences and names
      will be written
    inputBinding:
      position: 102
      prefix: --mapping
  - id: max_finds
    type:
      - 'null'
      - string
    doc: List of maximum times a tag can be found in a read (comma-separated)
    inputBinding:
      position: 102
      prefix: --maxFinds
  - id: max_finds_group
    type:
      - 'null'
      - string
    doc: List of maximum times tags in a group can be found in a read 
      (comma-separated group_name:max_times)
    inputBinding:
      position: 102
      prefix: --maxFindsG
  - id: min_delta
    type:
      - 'null'
      - string
    doc: When matching tags error-tolerantly, specifies how much worse the next 
      best match must be than the best match
    inputBinding:
      position: 102
      prefix: --min-delta
  - id: min_finds
    type:
      - 'null'
      - string
    doc: List of minimum times a tag must be found in a read (comma-separated)
    inputBinding:
      position: 102
      prefix: --minFinds
  - id: min_finds_group
    type:
      - 'null'
      - string
    doc: List of minimum times tags in a group must be found in a read 
      (comma-separated group_name:min_times)
    inputBinding:
      position: 102
      prefix: --minFindsG
  - id: mod_names
    type:
      - 'null'
      - boolean
    doc: Modify names of outputted sequences to include identified tag names
    inputBinding:
      position: 102
      prefix: --mod-names
  - id: n_fastqs
    type:
      - 'null'
      - int
    doc: 'Number of FASTQ file(s) per run (default: 1) (specify 2 for paired-end)'
    default: 1
    inputBinding:
      position: 102
      prefix: --nFastqs
  - id: next
    type:
      - 'null'
      - string
    doc: List of what tag names must come immediately after each tag 
      (comma-separated)
    inputBinding:
      position: 102
      prefix: --next
  - id: no_chain
    type:
      - 'null'
      - boolean
    doc: If an extraction pattern for a UMI/UMI-like sequence is matched 
      multiple times, only extract based on the first match
    inputBinding:
      position: 102
      prefix: --no-chain
  - id: no_outb
    type:
      - 'null'
      - boolean
    doc: Don't output final barcode sequences
    inputBinding:
      position: 102
      prefix: --no-outb
  - id: no_output
    type:
      - 'null'
      - boolean
    doc: Don't output any sequences
    inputBinding:
      position: 102
      prefix: --no-output
  - id: no_x_out
    type:
      - 'null'
      - boolean
    doc: Don't output extracted UMI-like sequences (should be used with 
      --x-names)
    inputBinding:
      position: 102
      prefix: --no-x-out
  - id: num_reads
    type:
      - 'null'
      - int
    doc: Maximum number of reads to process from supplied input
    inputBinding:
      position: 102
      prefix: --numReads
  - id: out_bam
    type:
      - 'null'
      - boolean
    doc: Output a BAM file rather than FASTQ files (enter the output BAM file 
      name to -o or --output)
    inputBinding:
      position: 102
      prefix: --out-bam
  - id: out_fasta
    type:
      - 'null'
      - boolean
    doc: Output in FASTA format rather than FASTQ format
    inputBinding:
      position: 102
      prefix: --out-fasta
  - id: partial3
    type:
      - 'null'
      - string
    doc: Specifies tag may be truncated at the 3′ end (comma-separated 
      min_match:mismatch_freq)
    inputBinding:
      position: 102
      prefix: --partial3
  - id: partial5
    type:
      - 'null'
      - string
    doc: Specifies tag may be truncated at the 5′ end (comma-separated 
      min_match:mismatch_freq)
    inputBinding:
      position: 102
      prefix: --partial5
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: Use phred+64 encoded quality scores
    inputBinding:
      position: 102
      prefix: --phred64
  - id: pipe
    type:
      - 'null'
      - boolean
    doc: Write to standard output (instead of output FASTQ files)
    inputBinding:
      position: 102
      prefix: --pipe
  - id: prefix
    type:
      - 'null'
      - string
    doc: Bases that will prefix each final barcode sequence (useful for merging 
      separate experiments)
    inputBinding:
      position: 102
      prefix: --prefix
  - id: previous
    type:
      - 'null'
      - string
    doc: List of what tag names must come immediately before each tag 
      (comma-separated)
    inputBinding:
      position: 102
      prefix: --previous
  - id: qtrim
    type:
      - 'null'
      - string
    doc: Quality trimming threshold
    inputBinding:
      position: 102
      prefix: --qtrim
  - id: qtrim_3
    type:
      - 'null'
      - boolean
    doc: Perform quality trimming from the 3′-end of reads of each FASTQ file
    inputBinding:
      position: 102
      prefix: --qtrim-3
  - id: qtrim_5
    type:
      - 'null'
      - boolean
    doc: Perform quality trimming from the 5′-end of reads of each FASTQ file
    inputBinding:
      position: 102
      prefix: --qtrim-5
  - id: qtrim_naive
    type:
      - 'null'
      - boolean
    doc: Perform quality trimming using a naive algorithm (i.e. trim until a 
      base that meets the quality threshold is encountered)
    inputBinding:
      position: 102
      prefix: --qtrim-naive
  - id: qtrim_pre
    type:
      - 'null'
      - boolean
    doc: Perform quality trimming before sequence identification operations
    inputBinding:
      position: 102
      prefix: --qtrim-pre
  - id: random
    type:
      - 'null'
      - string
    doc: 'Insert a random sequence. Format: output_file_number,output_position,length.'
    inputBinding:
      position: 102
      prefix: --random
  - id: remove
    type:
      - 'null'
      - File
    doc: File containing a list of arrangements of tag names to remove/discard
    inputBinding:
      position: 102
      prefix: --remove
  - id: remove_grp
    type:
      - 'null'
      - File
    doc: File containing a list of arrangements of tag groups to remove/discard
    inputBinding:
      position: 102
      prefix: --remove-grp
  - id: remultiplex
    type:
      - 'null'
      - boolean
    doc: Turn on remultiplexing mode
    inputBinding:
      position: 102
      prefix: --remultiplex
  - id: revcomp
    type:
      - 'null'
      - boolean
    doc: Specifies tag may be reverse complemented
    inputBinding:
      position: 102
      prefix: --revcomp
  - id: right
    type:
      - 'null'
      - string
    doc: List of what tags to include when trimming from the right 
      (comma-separated; 1 = include, 0 = exclude)
    inputBinding:
      position: 102
      prefix: --right
  - id: sam_tags
    type:
      - 'null'
      - string
    doc: Modify the default SAM tags
    default: 'CB:Z:,RX:Z:,BI:i:,SI:i:,BC:Z:,LX:Z:,YM:Z:'
    inputBinding:
      position: 102
      prefix: --sam-tags
  - id: select
    type:
      - 'null'
      - string
    doc: 'Select which FASTQ files to output (comma-separated) (e.g. 0,1,3 = Output
      files #0, #1, #3)'
    inputBinding:
      position: 102
      prefix: --select
  - id: seq_names
    type:
      - 'null'
      - boolean
    doc: Modify names of outputted sequences to include the sequences of 
      identified tags
    inputBinding:
      position: 102
      prefix: --seq-names
  - id: sub_assign
    type:
      - 'null'
      - string
    doc: Assign reads to a secondary sequence ID based on a subset of tags 
      present (must be used with --assign)
    inputBinding:
      position: 102
      prefix: --sub-assign
  - id: subs
    type:
      - 'null'
      - string
    doc: Specifies sequence to substitute tag with when found in read (. = 
      original sequence) (comma-separated)
    inputBinding:
      position: 102
      prefix: --subs
  - id: summary
    type:
      - 'null'
      - File
    doc: File where summary statistics will be written to
    inputBinding:
      position: 102
      prefix: --summary
  - id: tags
    type:
      - 'null'
      - string
    doc: List of tag sequences (comma-separated)
    inputBinding:
      position: 102
      prefix: --tags
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: trim_3
    type:
      - 'null'
      - string
    doc: Number of base pairs to trim from the 3′-end of reads (comma-separated;
      one number per each FASTQ file in a run)
    inputBinding:
      position: 102
      prefix: --trim-3
  - id: trim_5
    type:
      - 'null'
      - string
    doc: Number of base pairs to trim from the 5′-end of reads (comma-separated;
      one number per each FASTQ file in a run)
    inputBinding:
      position: 102
      prefix: --trim-5
  - id: unmask
    type:
      - 'null'
      - boolean
    doc: Turn on unmasking mode (extract differences from a masked vs. unmasked 
      FASTA)
    inputBinding:
      position: 102
      prefix: --unmask
  - id: x_names
    type:
      - 'null'
      - boolean
    doc: Modify names of outputted sequences to include extracted UMI-like 
      sequences
    inputBinding:
      position: 102
      prefix: --x-names
  - id: x_only
    type:
      - 'null'
      - boolean
    doc: Only output extracted UMI-like sequences
    inputBinding:
      position: 102
      prefix: --x-only
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: FASTQ file(s) where output will be written (comma-separated)
    outputBinding:
      glob: $(inputs.output)
  - id: outb
    type:
      - 'null'
      - File
    doc: FASTQ file where final barcodes will be written
    outputBinding:
      glob: $(inputs.outb)
  - id: unassigned
    type:
      - 'null'
      - File
    doc: FASTQ file(s) where output of unassigned reads will be written 
      (comma-separated)
    outputBinding:
      glob: $(inputs.unassigned)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/splitcode:0.31.6--h077b44d_0
