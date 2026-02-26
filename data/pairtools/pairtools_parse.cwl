cwlVersion: v1.2
class: CommandLineTool
baseCommand: pairtools parse
label: pairtools_parse
doc: "Find ligation pairs in .sam data, make .pairs. SAM_PATH : an input .sam/.bam
  file with paired-end sequence alignments of Hi-C molecules. If the path ends with
  .bam, the input is decompressed from bam with samtools. By default, the input is
  read from stdin.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: sam_path
    type:
      - 'null'
      - File
    doc: an input .sam/.bam file with paired-end sequence alignments of Hi-C 
      molecules. If the path ends with .bam, the input is decompressed from bam 
      with samtools. By default, the input is read from stdin.
    inputBinding:
      position: 1
  - id: add_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Report extra columns describing alignments Possible values (can take multiple
      values as a comma-separated list): a SAM tag (any pair of uppercase letters)
      or mapq, pos5, pos3, cigar, read_len, matched_bp, algn_ref_span, algn_read_span,
      dist_to_5, dist_to_3, seq, mismatches, read_side, algn_idx, same_side_algn_count.'
    inputBinding:
      position: 102
      prefix: --add-columns
  - id: add_pair_index
    type:
      - 'null'
      - boolean
    doc: If specified, each pair will have pair index in the molecule
    inputBinding:
      position: 102
      prefix: --add-pair-index
  - id: assembly
    type:
      - 'null'
      - string
    doc: Name of genome assembly (e.g. hg19, mm10) to store in the pairs header.
    inputBinding:
      position: 102
      prefix: --assembly
  - id: chroms_path
    type: File
    doc: 'Chromosome order used to flip interchromosomal mates: path to a chromosomes
      file (e.g. UCSC chrom.sizes or similar) whose first column lists scaffold names.
      Any scaffolds not listed will be ordered lexicographically following the names
      provided.'
    inputBinding:
      position: 102
      prefix: --chroms-path
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: 'A command to decompress the input file. If provided, fully overrides the
      auto-guessed command. Does not work with stdin and pairtools parse. Must read
      input from stdin and print output into stdout. EXAMPLE: pbgzip -dc -n 3'
    inputBinding:
      position: 102
      prefix: --cmd-in
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: 'A command to compress the output file. If provided, fully overrides the
      auto-guessed command. Does not work with stdout. Must read input from stdin
      and print output into stdout. EXAMPLE: pbgzip -c -n 8'
    inputBinding:
      position: 102
      prefix: --cmd-out
  - id: drop_readid
    type:
      - 'null'
      - boolean
    doc: If specified, do not add read ids to the output
    inputBinding:
      position: 102
      prefix: --drop-readid
  - id: drop_sam
    type:
      - 'null'
      - boolean
    doc: If specified, do not add sams to the output
    inputBinding:
      position: 102
      prefix: --drop-sam
  - id: drop_seq
    type:
      - 'null'
      - boolean
    doc: If specified, remove sequences and PHREDs from the sam fields
    inputBinding:
      position: 102
      prefix: --drop-seq
  - id: flip
    type:
      - 'null'
      - boolean
    doc: If specified, do not flip pairs in genomic order and instead preserve 
      the order in which they were sequenced.
    inputBinding:
      position: 102
      prefix: --flip
  - id: max_inter_align_gap
    type:
      - 'null'
      - int
    doc: read segments that are not covered by any alignment and longer than the
      specified value are treated as "null" alignments. These null alignments 
      convert otherwise linear alignments into walks, and affect how they get 
      reported as a Hi-C pair (see --walks-policy).
    default: 20
    inputBinding:
      position: 102
      prefix: --max-inter-align-gap
  - id: max_molecule_size
    type:
      - 'null'
      - int
    doc: The maximal size of a Hi-C molecule; used to rescue single 
      ligations(from molecules with three alignments) and to rescue complex 
      ligations.The default is based on oriented P(s) at short ranges of 
      multiple Hi-C.Not used with walks-policy all.
    default: 750
    inputBinding:
      position: 102
      prefix: --max-molecule-size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: The minimal MAPQ score to consider a read as uniquely mapped
    default: 1
    inputBinding:
      position: 102
      prefix: --min-mapq
  - id: no_flip
    type:
      - 'null'
      - boolean
    doc: If specified, do not flip pairs in genomic order and instead preserve 
      the order in which they were sequenced.
    inputBinding:
      position: 102
      prefix: --no-flip
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed input decompressing 
      command.
    default: 3
    inputBinding:
      position: 102
      prefix: --nproc-in
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: Number of processes used by the auto-guessed output compressing 
      command.
    default: 8
    inputBinding:
      position: 102
      prefix: --nproc-out
  - id: readid_transform
    type:
      - 'null'
      - string
    doc: A Python expression to modify read IDs. Useful when read IDs differ 
      between the two reads of a pair. Must be a valid Python expression that 
      uses variables called readID and/or i (the 0-based index of the read pair 
      in the bam file) and returns a new value, e.g. "readID[:-2]+'_'+str(i)". 
      Make sure that transformed readIDs remain unique!
    inputBinding:
      position: 102
      prefix: --readid-transform
  - id: report_alignment_end
    type:
      - 'null'
      - string
    doc: specifies whether the 5' or 3' end of the alignment is reported as the 
      position of the Hi-C read.
    inputBinding:
      position: 102
      prefix: --report-alignment-end
  - id: walks_policy
    type:
      - 'null'
      - string
    doc: the policy for reporting unrescuable walks (reads containing more than 
      one alignment on one or both sides, that can not be explained by a single 
      ligation between two mappable DNA fragments). "mask" - mask walks 
      (chrom="!", pos=0, strand="-"); "5any" - report the 5'-most alignment on 
      each side; "5unique" - report the 5'-most unique alignment on each side, 
      if present; "3any" - report the 3'-most alignment on each side; "3unique" 
      - report the 3'-most unique alignment on each side, if present; "all" - 
      report all available unique alignments on each side.
    default: 5unique
    inputBinding:
      position: 102
      prefix: --walks-policy
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: output file. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4-compressed.By default, the output is printed into stdout.
    outputBinding:
      glob: $(inputs.output)
  - id: output_parsed_alignments
    type:
      - 'null'
      - File
    doc: output file for all parsed alignments, including walks. Useful for 
      debugging and rnalysis of walks. If file exists, it will be open in the 
      append mode. If the path ends with .gz or .lz4, the output is 
      bgzip-/lz4-compressed. By default, not used.
    outputBinding:
      glob: $(inputs.output_parsed_alignments)
  - id: output_stats
    type:
      - 'null'
      - File
    doc: output file for various statistics of pairs file. By default, 
      statistics is not generated.
    outputBinding:
      glob: $(inputs.output_stats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
