cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bleties
  - milraa
label: bleties_milraa
doc: "MILRAA - Method of Identification by Long Read Alignment Anomalies\n\nTool homepage:
  https://github.com/Swart-lab/bleties"
inputs:
  - id: bam_file
    type:
      - 'null'
      - File
    doc: BAM file containing mapping, must be sorted and indexed
    default: None
    inputBinding:
      position: 101
      prefix: --bam
  - id: cluster_dist
    type:
      - 'null'
      - float
    doc: "Sequence identity distance limit for clustering putative IESs together.
      Recommended settings: 0.05 for PacBio CCS reads. Only used for --type='ccs'.
      Not yet tested extensively."
    default: 0.05
    inputBinding:
      position: 101
      prefix: --cluster_dist
  - id: contig
    type:
      - 'null'
      - string
    doc: Only process alignments from this contig
    default: None
    inputBinding:
      position: 101
      prefix: --contig
  - id: dump
    type:
      - 'null'
      - boolean
    doc: Dump contents of dict for troubleshooting
    default: false
    inputBinding:
      position: 101
      prefix: --dump
  - id: fuzzy_ies
    type:
      - 'null'
      - boolean
    doc: Allow lengths of inserts to differ slightly when defining putative IES,
      otherwise insert lengths must be exactly the same. Only used when --type 
      is 'ccs', because subreads are handled separately.
    default: false
    inputBinding:
      position: 101
      prefix: --fuzzy_ies
  - id: junction_flank
    type:
      - 'null'
      - int
    doc: Length of flanking sequence to report to junction report
    default: 5
    inputBinding:
      position: 101
      prefix: --junction_flank
  - id: min_break_coverage
    type:
      - 'null'
      - int
    doc: Minimum number of partially aligned reads to define a putative IES 
      insertion breakpoint
    default: 10
    inputBinding:
      position: 101
      prefix: --min_break_coverage
  - id: min_del_coverage
    type:
      - 'null'
      - int
    doc: Minimum number of partially aligned reads to define a deletion relative
      to reference
    default: 10
    inputBinding:
      position: 101
      prefix: --min_del_coverage
  - id: min_ies_length
    type:
      - 'null'
      - int
    doc: Minimum length of candidate IES
    default: 15
    inputBinding:
      position: 101
      prefix: --min_ies_length
  - id: output_file
    type:
      - 'null'
      - string
    doc: Output filename prefix
    default: milraa.test
    inputBinding:
      position: 101
      prefix: --out
  - id: ref_file
    type:
      - 'null'
      - File
    doc: FASTA file containing genomic contigs used as reference for the mapping
    default: None
    inputBinding:
      position: 101
      prefix: --ref
  - id: start
    type:
      - 'null'
      - int
    doc: Start coordinate (1-based, inclusive) from contig to process
    default: None
    inputBinding:
      position: 101
      prefix: --start
  - id: stop
    type:
      - 'null'
      - int
    doc: Stop coordinate (1-based, inclusive) from contig to process
    default: None
    inputBinding:
      position: 101
      prefix: --stop
  - id: subreads_cons_len_threshold
    type:
      - 'null'
      - float
    doc: In subreads mode, max proportional difference in length of extracted 
      sequences in a cluster from median length to accept for sequences to 
      generate consensus
    default: 0.25
    inputBinding:
      position: 101
      prefix: --subreads_cons_len_threshold
  - id: subreads_flank_len
    type:
      - 'null'
      - int
    doc: Length of flanking regions to extract on sides of insert from subreads,
      before taking consensus of flanking + insert to realign to reference.
    default: 100
    inputBinding:
      position: 101
      prefix: --subreads_flank_len
  - id: subreads_pos_max_cluster_dist
    type:
      - 'null'
      - int
    doc: In subreads mode, max distance (bp) between inserts reported by the 
      mapper to report as a single cluster
    default: 5
    inputBinding:
      position: 101
      prefix: --subreads_pos_max_cluster_dist
  - id: type
    type:
      - 'null'
      - string
    doc: Type of reads used for mapping, either 'subreads' or 'ccs'
    default: subreads
    inputBinding:
      position: 101
      prefix: --type
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
stdout: bleties_milraa.out
