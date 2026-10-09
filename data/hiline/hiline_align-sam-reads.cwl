cwlVersion: v1.2
class: CommandLineTool
baseCommand: HiLine
label: hiline_align-sam-reads
doc: "Align Hi-C reads given as SAM/BAM/CRAM, classify the pairs and write them out. HiLine is a chained command line: this wrapper runs `params`, the
  `align-sam-reads` input command, the requested output commands and `save-stats` in one
  call.\n\nTool homepage: https://github.com/wtsi-hpag/HiLine"
inputs:
  - id: reference
    type: File
    doc: Reference genome in (gzipped) FASTA format. It is staged in the working
      directory because HiLine writes the alignment index beside it.
  - id: restriction_sites
    type: string
    doc: Restriction site specification, a comma-separated list of HiC kit names
      (Omni-C, Arima_v2, Arima, Dovetail, Phase, Qiagen), restriction enzyme
      names (for example DpnII, DNASE) or IUPAC site strings (for example ^GATC)
    inputBinding:
      position: 4
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use, must be at least 3. Default=4
    inputBinding:
      position: 2
      prefix: -t
  - id: minmapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality. Default=10
    inputBinding:
      position: 2
      prefix: -q
  - id: reads
    type: File
    doc: Hi-C reads in SAM/BAM/CRAM format
    inputBinding:
      position: 7
  - id: tag
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: --tag
    doc: SAM tag(s) to append to reads
    inputBinding:
      position: 6
  - id: rmdups
    type:
      - 'null'
      - boolean
    doc: Run samtools mark_dup pipeline on alignment. Default=rmdups
    inputBinding:
      position: 6
      prefix: --rmdups
  - id: no_rmdups
    type:
      - 'null'
      - boolean
    doc: Do not run the samtools mark_dup pipeline on alignment
    inputBinding:
      position: 6
      prefix: --no-rmdups
  - id: trim
    type:
      - 'null'
      - boolean
    doc: Run HiC read trimming, trim sections of reads that align past restriction sites. Default=trim
    inputBinding:
      position: 6
      prefix: --trim
  - id: no_trim
    type:
      - 'null'
      - boolean
    doc: Do not run HiC read trimming
    inputBinding:
      position: 6
      prefix: --no-trim
  - id: bwa1
    type:
      - 'null'
      - boolean
    doc: Use bwa mem. Default=False
    inputBinding:
      position: 6
      prefix: --bwa1
  - id: bwa2
    type:
      - 'null'
      - boolean
    doc: Use bwa-mem2. Default=True
    inputBinding:
      position: 6
      prefix: --bwa2
  - id: minimap2
    type:
      - 'null'
      - boolean
    doc: Use minimap2. Default=False
    inputBinding:
      position: 6
      prefix: --minimap2
  - id: all_reads
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for all-reads: alias for good-reads + bad-reads'
  - id: good_reads
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for good-reads: alias for valid-pairs + invalid-reads'
  - id: valid_pairs
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for valid-pairs: alias for valid-ff + valid-fr + valid-rf + valid-rr'
  - id: valid_ff
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for valid-ff: valid ff read pairs'
  - id: valid_fr
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for valid-fr: valid fr read pairs'
  - id: valid_rf
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for valid-rf: valid rf read pairs'
  - id: valid_rr
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for valid-rr: valid rr read pairs'
  - id: invalid_reads
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for invalid-reads: alias for invalid-pairs + dumped'
  - id: invalid_pairs
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for invalid-pairs: alias for self-circle + dangling-end + same-frag-and-strand + re-ligated'
  - id: self_circle
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for self-circle: self-circular read pairs'
  - id: dangling_end
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for dangling-end: dangling-end read pairs'
  - id: same_frag_and_strand
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for same-frag-and-strand: read pairs on the same restriction fragment and strand'
  - id: re_ligated
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for re-ligated: re-ligated read pairs'
  - id: dumped
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for dumped: dumped reads (good reads with a bad mate read)'
  - id: bad_reads
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for bad-reads: alias for low-mapq + too-far-from-restriction-site + bad-reference + unmapped + unpaired + supplementary + qc-fail + duplicate + secondary'
  - id: low_mapq
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for low-mapq: reads below the minimum mapping quality'
  - id: too_far_from_restriction_site
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for too-far-from-restriction-site: reads too far from a restriction site'
  - id: bad_reference
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for bad-reference: reads aligned to an invalid reference'
  - id: unmapped
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for unmapped: unmapped reads'
  - id: unpaired
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for unpaired: unpaired reads'
  - id: supplementary
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for supplementary: supplementary reads'
  - id: qc_fail
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for qc-fail: qc-failed reads'
  - id: duplicate
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for duplicate: duplicate reads'
  - id: secondary
    type:
      - 'null'
      - string
    doc: 'Output path (SAM/BAM/CRAM) for secondary: secondary reads'
  - id: stats_path
    type:
      - 'null'
      - string
    doc: Base path of the directory where alignment statistics are saved (save-stats)
outputs:
  - id: all_reads_file
    type:
      - 'null'
      - File
    doc: Reads written by all-reads
    outputBinding:
      glob: $(inputs.all_reads)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: good_reads_file
    type:
      - 'null'
      - File
    doc: Reads written by good-reads
    outputBinding:
      glob: $(inputs.good_reads)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: valid_pairs_file
    type:
      - 'null'
      - File
    doc: Reads written by valid-pairs
    outputBinding:
      glob: $(inputs.valid_pairs)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: valid_ff_file
    type:
      - 'null'
      - File
    doc: Reads written by valid-ff
    outputBinding:
      glob: $(inputs.valid_ff)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: valid_fr_file
    type:
      - 'null'
      - File
    doc: Reads written by valid-fr
    outputBinding:
      glob: $(inputs.valid_fr)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: valid_rf_file
    type:
      - 'null'
      - File
    doc: Reads written by valid-rf
    outputBinding:
      glob: $(inputs.valid_rf)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: valid_rr_file
    type:
      - 'null'
      - File
    doc: Reads written by valid-rr
    outputBinding:
      glob: $(inputs.valid_rr)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: invalid_reads_file
    type:
      - 'null'
      - File
    doc: Reads written by invalid-reads
    outputBinding:
      glob: $(inputs.invalid_reads)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: invalid_pairs_file
    type:
      - 'null'
      - File
    doc: Reads written by invalid-pairs
    outputBinding:
      glob: $(inputs.invalid_pairs)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: self_circle_file
    type:
      - 'null'
      - File
    doc: Reads written by self-circle
    outputBinding:
      glob: $(inputs.self_circle)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: dangling_end_file
    type:
      - 'null'
      - File
    doc: Reads written by dangling-end
    outputBinding:
      glob: $(inputs.dangling_end)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: same_frag_and_strand_file
    type:
      - 'null'
      - File
    doc: Reads written by same-frag-and-strand
    outputBinding:
      glob: $(inputs.same_frag_and_strand)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: re_ligated_file
    type:
      - 'null'
      - File
    doc: Reads written by re-ligated
    outputBinding:
      glob: $(inputs.re_ligated)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: dumped_file
    type:
      - 'null'
      - File
    doc: Reads written by dumped
    outputBinding:
      glob: $(inputs.dumped)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: bad_reads_file
    type:
      - 'null'
      - File
    doc: Reads written by bad-reads
    outputBinding:
      glob: $(inputs.bad_reads)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: low_mapq_file
    type:
      - 'null'
      - File
    doc: Reads written by low-mapq
    outputBinding:
      glob: $(inputs.low_mapq)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: too_far_from_restriction_site_file
    type:
      - 'null'
      - File
    doc: Reads written by too-far-from-restriction-site
    outputBinding:
      glob: $(inputs.too_far_from_restriction_site)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: bad_reference_file
    type:
      - 'null'
      - File
    doc: Reads written by bad-reference
    outputBinding:
      glob: $(inputs.bad_reference)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: unmapped_file
    type:
      - 'null'
      - File
    doc: Reads written by unmapped
    outputBinding:
      glob: $(inputs.unmapped)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: unpaired_file
    type:
      - 'null'
      - File
    doc: Reads written by unpaired
    outputBinding:
      glob: $(inputs.unpaired)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: supplementary_file
    type:
      - 'null'
      - File
    doc: Reads written by supplementary
    outputBinding:
      glob: $(inputs.supplementary)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: qc_fail_file
    type:
      - 'null'
      - File
    doc: Reads written by qc-fail
    outputBinding:
      glob: $(inputs.qc_fail)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: duplicate_file
    type:
      - 'null'
      - File
    doc: Reads written by duplicate
    outputBinding:
      glob: $(inputs.duplicate)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: secondary_file
    type:
      - 'null'
      - File
    doc: Reads written by secondary
    outputBinding:
      glob: $(inputs.secondary)
    secondaryFiles:
      - pattern: .csi
        required: false
      - pattern: .bai
        required: false
      - pattern: .crai
        required: false
  - id: stats_dir
    type:
      - 'null'
      - Directory
    doc: Alignment statistics written by save-stats
    outputBinding:
      glob: $(inputs.stats_path)
  - id: stdout
    type: stdout
    doc: Standard output
arguments:
  - position: 1
    valueFrom: params
  - position: 3
    valueFrom: $(inputs.reference.basename)
  - position: 5
    valueFrom: align-sam-reads
  - position: 10
    valueFrom: |
      ${
        var m = [["all_reads","all-reads"],["good_reads","good-reads"],["valid_pairs","valid-pairs"],["valid_ff","valid-ff"],["valid_fr","valid-fr"],["valid_rf","valid-rf"],["valid_rr","valid-rr"],["invalid_reads","invalid-reads"],["invalid_pairs","invalid-pairs"],["self_circle","self-circle"],["dangling_end","dangling-end"],["same_frag_and_strand","same-frag-and-strand"],["re_ligated","re-ligated"],["dumped","dumped"],["bad_reads","bad-reads"],["low_mapq","low-mapq"],["too_far_from_restriction_site","too-far-from-restriction-site"],["bad_reference","bad-reference"],["unmapped","unmapped"],["unpaired","unpaired"],["supplementary","supplementary"],["qc_fail","qc-fail"],["duplicate","duplicate"],["secondary","secondary"]];
        var r = [];
        for (var i = 0; i < m.length; i++) {
          if (inputs[m[i][0]]) { r.push(m[i][1]); r.push(inputs[m[i][0]]); }
        }
        if (inputs.stats_path) { r.push("save-stats"); r.push(inputs.stats_path); }
        return r;
      }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hiline:0.2.4--py39h8aee962_0
stdout: hiline_align-sam-reads.out
