cwlVersion: v1.2
class: CommandLineTool
baseCommand: abra2
label: abra2
doc: "ABRA2 is a realigner for next generation sequencing data. It uses localized
  assembly and genetic algorithms to improve the accuracy of indel detection.\n\n\
  Tool homepage: https://github.com/mozack/abra2"
inputs:
  - id: amq
    type:
      - 'null'
      - int
    doc: Set mapq for alignments that map equally well to reference and an ABRA 
      generated contig. default of -1 disables
    default: -1
    inputBinding:
      position: 101
      prefix: --amq
  - id: compression_level
    type:
      - 'null'
      - int
    doc: Compression level of output bam file(s)
    default: 5
    inputBinding:
      position: 101
      prefix: --cl
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Use positional consensus sequence when aligning high quality soft 
      clipping
    inputBinding:
      position: 101
      prefix: --cons
  - id: contig_anchor
    type:
      - 'null'
      - string
    doc: Contig anchor [M_bases_at_contig_edge, max_mismatches_near_edge]
    default: 10,2
    inputBinding:
      position: 101
      prefix: --ca
  - id: dist
    type:
      - 'null'
      - int
    doc: Max read move distance
    default: 1000
    inputBinding:
      position: 101
      prefix: --dist
  - id: gc
    type:
      - 'null'
      - boolean
    doc: If specified, only reprocess regions that contain at least one contig 
      containing an indel or splice (experimental)
    inputBinding:
      position: 101
      prefix: --gc
  - id: gkl
    type:
      - 'null'
      - boolean
    doc: If specified, use the GKL Intel Deflater.
    inputBinding:
      position: 101
      prefix: --gkl
  - id: gtf
    type:
      - 'null'
      - File
    doc: GTF file defining exons and transcripts
    inputBinding:
      position: 101
      prefix: --gtf
  - id: in_vcf
    type:
      - 'null'
      - File
    doc: VCF containing known (or suspected) variant sites. Very large files 
      should be avoided.
    inputBinding:
      position: 101
      prefix: --in-vcf
  - id: index
    type:
      - 'null'
      - boolean
    doc: Enable BAM index generation when outputting sorted alignments (may 
      require additonal memory)
    inputBinding:
      position: 101
      prefix: --index
  - id: input_files
    type:
      type: array
      items: File
    doc: Required list of input sam or bam file(s) separated by comma
    inputBinding:
      position: 101
      prefix: --in
  - id: junctions
    type:
      - 'null'
      - File
    doc: Splice junctions definition file
    inputBinding:
      position: 101
      prefix: --junctions
  - id: keep_tmp
    type:
      - 'null'
      - boolean
    doc: Do not delete the temporary directory
    inputBinding:
      position: 101
      prefix: --keep-tmp
  - id: kmer
    type:
      - 'null'
      - type: array
        items: string
    doc: Optional assembly kmer size (delimit with commas if multiple sizes 
      specified)
    inputBinding:
      position: 101
      prefix: --kmer
  - id: log_level
    type:
      - 'null'
      - string
    doc: Logging level (trace,debug,info,warn,error)
    default: info
    inputBinding:
      position: 101
      prefix: --log
  - id: max_assembled_contigs
    type:
      - 'null'
      - int
    doc: Max assembled contigs
    default: 64
    inputBinding:
      position: 101
      prefix: --mac
  - id: max_average_depth
    type:
      - 'null'
      - int
    doc: Regions with average depth exceeding this value will be downsampled
    default: 1000
    inputBinding:
      position: 101
      prefix: --mad
  - id: max_cached_reads
    type:
      - 'null'
      - int
    doc: Max number of cached reads per sample per thread
    default: 1000000
    inputBinding:
      position: 101
      prefix: --mcr
  - id: max_mismatch_rate
    type:
      - 'null'
      - float
    doc: Max allowed mismatch rate when mapping reads back to contigs
    default: 0.05
    inputBinding:
      position: 101
      prefix: --mmr
  - id: max_nodes
    type:
      - 'null'
      - int
    doc: Maximum pre-pruned nodes in regional assembly
    default: 150000
    inputBinding:
      position: 101
      prefix: --maxn
  - id: max_read_noise
    type:
      - 'null'
      - float
    doc: Reads with noise score exceeding this value are not remapped.
    default: 0.1
    inputBinding:
      position: 101
      prefix: --mrn
  - id: max_region_reads
    type:
      - 'null'
      - int
    doc: Regions containing more reads than this value are not processed. Use -1
      to disable.
    default: 1000000
    inputBinding:
      position: 101
      prefix: --mrr
  - id: max_sort_reads
    type:
      - 'null'
      - int
    doc: Max reads to keep in memory per sample during the sort phase. When this
      value is exceeded, sort spills to disk
    default: 1000000
    inputBinding:
      position: 101
      prefix: --msr
  - id: min_base_quality
    type:
      - 'null'
      - int
    doc: Minimum base quality for inclusion in assembly. This value is compared 
      against the sum of base qualities per kmer position
    default: 20
    inputBinding:
      position: 101
      prefix: --mbq
  - id: min_contig_length
    type:
      - 'null'
      - int
    doc: Assembly minimum contig length
    default: -1
    inputBinding:
      position: 101
      prefix: --mcl
  - id: min_edge_ratio
    type:
      - 'null'
      - float
    doc: Min edge pruning ratio.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --mer
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality for a read to be used in assembly and be 
      eligible for realignment
    default: 20
    inputBinding:
      position: 101
      prefix: --mapq
  - id: min_node_frequency
    type:
      - 'null'
      - int
    doc: Assembly minimum node frequency
    default: 1
    inputBinding:
      position: 101
      prefix: --mnf
  - id: no_edge_ci
    type:
      - 'null'
      - boolean
    doc: If specified, do not update alignments for reads that have a complex 
      indel at the read edge.
    inputBinding:
      position: 101
      prefix: --no-edge-ci
  - id: no_ndn
    type:
      - 'null'
      - boolean
    doc: If specified, do not allow adjacent N-D-N cigar elements
    inputBinding:
      position: 101
      prefix: --no-ndn
  - id: nosort
    type:
      - 'null'
      - boolean
    doc: Do not attempt to sort final output
    inputBinding:
      position: 101
      prefix: --nosort
  - id: read_candidate_fraction
    type:
      - 'null'
      - float
    doc: Minimum read candidate fraction for triggering assembly
    default: 0.01
    inputBinding:
      position: 101
      prefix: --rcf
  - id: reference
    type:
      - 'null'
      - File
    doc: Genome reference location
    inputBinding:
      position: 101
      prefix: --ref
  - id: scoring_contig_alignments
    type:
      - 'null'
      - string
    doc: Scoring used for contig alignments (match, mismatch_penalty, 
      gap_open_penalty, gap_extend_penalty)
    default: 8,32,48,1
    inputBinding:
      position: 101
      prefix: --sga
  - id: single_end
    type:
      - 'null'
      - boolean
    doc: Input is single end
    inputBinding:
      position: 101
      prefix: --single
  - id: skip_assembly
    type:
      - 'null'
      - boolean
    doc: Skip assembly
    inputBinding:
      position: 101
      prefix: --sa
  - id: skip_observed_indels
    type:
      - 'null'
      - boolean
    doc: Do not use observed indels in original alignments to generate contigs
    inputBinding:
      position: 101
      prefix: --sobs
  - id: skip_regex
    type:
      - 'null'
      - string
    doc: If no target specified, skip realignment of chromosomes matching 
      specified regex.
    default: 
      GL.*|hs37d5|chr.*random|chrUn.*|chrEBV|CMV|HBV|HCV.*|HIV.*|KSHV|HTLV.*|MCV|SV40|HPV.*
    inputBinding:
      position: 101
      prefix: --skip
  - id: skip_soft_clipped
    type:
      - 'null'
      - boolean
    doc: Skip usage of soft clipped sequences as putative contigs
    inputBinding:
      position: 101
      prefix: --ssc
  - id: skip_unmapped_anchored
    type:
      - 'null'
      - boolean
    doc: Do not use unmapped reads anchored by mate to trigger assembly.
    inputBinding:
      position: 101
      prefix: --sua
  - id: soft_clip_contig_args
    type:
      - 'null'
      - string
    doc: Soft clip contig args [max_contigs, min_base_qual, 
      frac_high_qual_bases, min_soft_clip_len]
    default: 16,13,80,15
    inputBinding:
      position: 101
      prefix: --sc
  - id: target_kmers
    type:
      - 'null'
      - File
    doc: BED-like file containing target regions with per region kmer sizes in 
      4th column
    inputBinding:
      position: 101
      prefix: --target-kmers
  - id: targets
    type:
      - 'null'
      - File
    doc: BED file containing target regions
    inputBinding:
      position: 101
      prefix: --targets
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: Set the temp directory (overrides java.io.tmpdir)
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: unset_duplicate_flag
    type:
      - 'null'
      - boolean
    doc: Unset duplicate flag
    inputBinding:
      position: 101
      prefix: --undup
  - id: use_junction_permutations
    type:
      - 'null'
      - boolean
    doc: If specified, use junction permuations as contigs (Experimental)
    inputBinding:
      position: 101
      prefix: --ujac
  - id: window_size
    type:
      - 'null'
      - string
    doc: Processing window size and overlap (size,overlap)
    default: 400,200
    inputBinding:
      position: 101
      prefix: --ws
outputs:
  - id: contigs_output
    type:
      - 'null'
      - File
    doc: Optional file to which assembled contigs are written
    outputBinding:
      glob: $(inputs.contigs_output)
  - id: output_files
    type: File
    doc: Required list of output sam or bam file(s) separated by comma
    outputBinding:
      glob: $(inputs.output_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/abra2:2.24--hdcf5f25_3
