cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lambda2
  - searchn
label: lambda-align2_searchn
doc: "Perform a nucleotide search (BLASTN, MEGABLAST) against a Lambda index.\n\nTool homepage: http://seqan.github.io/lambda/"
inputs:
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Display more/less diagnostic output during operation: 0 [only errors]; 1 [default]; 2 [+run-time, options and statistics]. In range [0..2]. Default: 1.'
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: query
    type: File
    doc: 'Query sequences. Valid filetypes are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where * is any of the following extensions: gz, bz2, and bgzf for transparent (de)compression.'
    inputBinding:
      position: 101
      prefix: --query
  - id: index
    type: Directory
    doc: 'The database index (created by the ''lambda mkindexn'' command). Valid filetype is: .lambda.'
    inputBinding:
      position: 101
      prefix: --index
  - id: output
    type:
      - 'null'
      - string
    doc: 'File to hold reports on hits (.m* are blastall -m* formats; .m8 is tab-seperated, .m9 is tab-seperated with with comments, .m0 is pairwise format). Valid filetypes are: .sam[.*], .m9[.*], .m8[.*], .m0[.*], and .bam, where * is any of the following extensions: gz, bz2, and bgzf for transparent (de)compression. Default: output.m8.'
    default: output.m8
    inputBinding:
      position: 101
      prefix: --output
  - id: output_columns
    type:
      - 'null'
      - string
    doc: 'Print specified column combination and/or order (.m8 and .m9 outputs only); call -oc help for more details. Default: std.'
    inputBinding:
      position: 101
      prefix: --output-columns
  - id: percent_identity
    type:
      - 'null'
      - int
    doc: 'Output only matches above this threshold (checked before e-value check). In range [0..100]. Default: 0.'
    inputBinding:
      position: 101
      prefix: --percent-identity
  - id: e_value
    type:
      - 'null'
      - double
    doc: 'Output only matches that score below this threshold. In range [0..100]. Default: 1e-04.'
    inputBinding:
      position: 101
      prefix: --e-value
  - id: num_matches
    type:
      - 'null'
      - int
    doc: 'Print at most this number of matches per query. In range [1..10000]. Default: 256.'
    inputBinding:
      position: 101
      prefix: --num-matches
  - id: sam_with_refheader
    type:
      - 'null'
      - string
    doc: 'BAM files require all subject names to be written to the header. For SAM this is not required, so Lambda does not automatically do it to save space (especially for protein database this is a lot!). If you still want them with SAM, e.g. for better BAM compatibility, use this option. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: off.'
    inputBinding:
      position: 101
      prefix: --sam-with-refheader
  - id: sam_bam_seq
    type:
      - 'null'
      - string
    doc: 'Write matching DNA subsequence into SAM/BAM file. If set to uniq than the sequence is omitted iff it is identical to the previous match''s subsequence. One of always, uniq, and never. Default: uniq.'
    inputBinding:
      position: 101
      prefix: --sam-bam-seq
  - id: sam_bam_tags
    type:
      - 'null'
      - string
    doc: 'Write the specified optional columns to the SAM/BAM file. Call --sam-bam-tags help for more details. Default: AS NM ae ai qf.'
    inputBinding:
      position: 101
      prefix: --sam-bam-tags
  - id: sam_bam_clip
    type:
      - 'null'
      - string
    doc: 'Whether to hard-clip or soft-clip the regions beyond the local match. Soft-clipping retains the full sequence in the output file, but obviously uses more space. One of hard and soft. Default: hard.'
    inputBinding:
      position: 101
      prefix: --sam-bam-clip
  - id: threads
    type:
      - 'null'
      - int
    doc: 'number of threads to run concurrently. In range [1..200]. Default: 20.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: adaptive_seeding
    type:
      - 'null'
      - string
    doc: 'Grow the seed if it has too many hits (low complexity filter). One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: off.'
    inputBinding:
      position: 101
      prefix: --adaptive-seeding
  - id: seed_length
    type:
      - 'null'
      - int
    doc: 'Length of the seeds. In range [3..50]. Default: 14.'
    inputBinding:
      position: 101
      prefix: --seed-length
  - id: seed_offset
    type:
      - 'null'
      - int
    doc: 'Offset for seeding (if unset = seed-length/2). In range [1..50]. Default: 7.'
    inputBinding:
      position: 101
      prefix: --seed-offset
  - id: seed_delta
    type:
      - 'null'
      - int
    doc: 'maximum seed distance. In range [0..1]. Default: 1.'
    inputBinding:
      position: 101
      prefix: --seed-delta
  - id: seed_delta_increases_length
    type:
      - 'null'
      - string
    doc: 'Seed delta increases the min. seed length (for affected seeds). One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: off.'
    inputBinding:
      position: 101
      prefix: --seed-delta-increases-length
  - id: seed_half_exact
    type:
      - 'null'
      - string
    doc: 'Allow errors only in second half of seed. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.'
    inputBinding:
      position: 101
      prefix: --seed-half-exact
  - id: pre_scoring
    type:
      - 'null'
      - int
    doc: 'evaluate score of a region NUM times the size of the seed before extension (0 -> no pre-scoring, 1 -> evaluate seed, n-> area around seed, as well; default = 1 if no reduction is used). In range [1..10]. Default: 2.'
    inputBinding:
      position: 101
      prefix: --pre-scoring
  - id: pre_scoring_threshold
    type:
      - 'null'
      - double
    doc: 'minimum average score per position in pre-scoring region. In range [0..20]. Default: 2.'
    inputBinding:
      position: 101
      prefix: --pre-scoring-threshold
  - id: filter_putative_duplicates
    type:
      - 'null'
      - string
    doc: 'filter hits that will likely duplicate a match already found. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.'
    inputBinding:
      position: 101
      prefix: --filter-putative-duplicates
  - id: filter_putative_abundant
    type:
      - 'null'
      - string
    doc: 'If the maximum number of matches per query are found already, stop searching if the remaining realm looks unfeasible. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.'
    inputBinding:
      position: 101
      prefix: --filter-putative-abundant
  - id: merge_putative_siblings
    type:
      - 'null'
      - string
    doc: 'Merge seed from one region, stop searching if the remaining realm looks unfeasable. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO. Default: on.'
    inputBinding:
      position: 101
      prefix: --merge-putative-siblings
  - id: score_gap
    type:
      - 'null'
      - int
    doc: 'Score per gap character. In range [-1000..1000]. Default: -2.'
    inputBinding:
      position: 101
      prefix: --score-gap
  - id: score_gap_open
    type:
      - 'null'
      - int
    doc: 'Additional cost for opening gap. In range [-1000..1000]. Default: -5.'
    inputBinding:
      position: 101
      prefix: --score-gap-open
  - id: score_match
    type:
      - 'null'
      - int
    doc: 'Match score [only BLASTN]) In range [-1000..1000]. Default: 2.'
    inputBinding:
      position: 101
      prefix: --score-match
  - id: score_mismatch
    type:
      - 'null'
      - int
    doc: 'Mismatch score [only BLASTN] In range [-1000..1000]. Default: -3.'
    inputBinding:
      position: 101
      prefix: --score-mismatch
  - id: x_drop
    type:
      - 'null'
      - int
    doc: 'Stop Banded extension if score x below the maximum seen (-1 means no xdrop). In range [-1..1000]. Default: 30.'
    inputBinding:
      position: 101
      prefix: --x-drop
  - id: band
    type:
      - 'null'
      - int
    doc: 'Size of the DP-band used in extension (-3 means log2 of query length; -2 means sqrt of query length; -1 means full dp; n means band of size 2n+1) In range [-3..1000]. Default: -3.'
    inputBinding:
      position: 101
      prefix: --band
  - id: extension_mode
    type:
      - 'null'
      - string
    doc: 'Choice of extension algorithms. One of auto, xdrop, fullSerial, and fullSIMD. Default: auto.'
    inputBinding:
      position: 101
      prefix: --extension-mode
outputs:
  - id: output_file
    type: File
    doc: Search hits
    outputBinding:
      glob: $(inputs.output)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/lambda-align2:v2.0.0-6-deb_cv1
stdout: lambda-align2_searchn.out
