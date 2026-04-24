cwlVersion: v1.2
class: CommandLineTool
baseCommand: svim-asm diploid
label: svim-asm_diploid
doc: "SVIM-ASM is a tool for structural variant detection in diploid genomes.\n\n\
  Tool homepage: https://github.com/eldariont/svim-asm"
inputs:
  - id: working_dir
    type: Directory
    doc: Working and output directory. Existing files in the directory are 
      overwritten. If the directory does not exist, it is created.
    inputBinding:
      position: 1
  - id: bam_file1
    type: File
    doc: SAM/BAM file with alignment of query assembly's first haplotype to 
      reference assembly (needs to be coordinate-sorted and indexed)
    inputBinding:
      position: 2
  - id: bam_file2
    type: File
    doc: SAM/BAM file with alignment of query assembly's second haplotype to 
      reference assembly (needs to be coordinate-sorted and indexed)
    inputBinding:
      position: 3
  - id: genome
    type: File
    doc: Reference genome file that the assembly was aligned to (FASTA)
    inputBinding:
      position: 4
  - id: interspersed_duplications_as_insertions
    type:
      - 'null'
      - boolean
    doc: 'Represent interspersed duplications as insertions in output VCF (default:
      False). By default, interspersed duplications are represented by the SVTYPE=DUP:INT
      and the genomic source is given by the POS and END tags. When enabling this
      option, duplications are instead represented by the SVTYPE=INS and POS and END
      both give the insertion point of the duplication.'
    inputBinding:
      position: 105
      prefix: --interspersed_duplications_as_insertions
  - id: max_edit_distance
    type:
      - 'null'
      - int
    doc: 'Maximum edit distance between both alleles to be paired up into a homozygous
      call (default: 200).'
    inputBinding:
      position: 105
      prefix: --max_edit_distance
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: 'Maximum SV size to detect (default: 100000). This parameter is used to distinguish
      long deletions (and inversions) from translocations which cannot be distinguished
      from the alignment alone. Split read segments mapping far apart on the reference
      could either indicate a very long deletion (inversion) or a translocation breakpoint.
      SVIM calls a translocation breakpoint if the mapping distance is larger than
      this parameter and a deletion (or inversion) if it is smaller or equal.'
    inputBinding:
      position: 105
      prefix: --max_sv_size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: 'Minimum mapping quality of alignments to consider (default: 20). Alignments
      with a lower mapping quality are ignored.'
    inputBinding:
      position: 105
      prefix: --min_mapq
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: 'Minimum SV size to detect (default: 40). SVIM can potentially detect events
      of any size but is limited by the signal-to-noise ratio in the input alignments.
      That means that more accurate assemblies and alignments enable the detection
      of smaller events.'
    inputBinding:
      position: 105
      prefix: --min_sv_size
  - id: partition_max_distance
    type:
      - 'null'
      - int
    doc: 'Maximum distance in bp between SVs in a partition (default: 1000). Before
      pairing, the SV signatures are divided into coarse partitions. This parameter
      determines the maximum distance between two subsequent signatures in the same
      partition. If the distance between two subsequent signatures is larger than
      this parameter, they are distributed into separate partitions.'
    inputBinding:
      position: 105
      prefix: --partition_max_distance
  - id: query_gap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated gap between adjacent alignment segments on the query (default:
      50). Example: Deletions are detected from two subsequent segments of a split
      query sequence that are mapped far apart from each other on the reference. The
      query gap tolerance determines the maximum tolerated length of the query gap
      between both segments. If there is an unaligned query segment larger than this
      value between the two segments, no deletion is called.'
    inputBinding:
      position: 105
      prefix: --query_gap_tolerance
  - id: query_names
    type:
      - 'null'
      - boolean
    doc: 'Output names of supporting query sequences in INFO tag of VCF (default:
      False). If enabled, the INFO/READS tag contains the list of names of the supporting
      query sequences.'
    inputBinding:
      position: 105
      prefix: --query_names
  - id: query_overlap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated overlap between adjacent alignment segments on the query
      (default: 50). Example: Deletions are detected from two subsequent segments
      of a split query sequence that are mapped far apart from each other on the reference.
      The query overlap tolerance determines the maximum tolerated length of an overlap
      between both segments in the query. If the overlap between the two segments
      in the query is larger than this value, no deletion is called.'
    inputBinding:
      position: 105
      prefix: --query_overlap_tolerance
  - id: reference_gap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated gap between adjacent alignment segments on the reference
      (default: 50). Example: Insertions are detected from two segments of a split
      query sequence that are mapped right next to each other on the reference but
      with unaligned sequence between them on the query. The reference gap tolerance
      determines the maximum tolerated length of the reference gap between both segments.
      If there is a reference gap larger than this value between the two segments,
      no insertion is called.'
    inputBinding:
      position: 105
      prefix: --reference_gap_tolerance
  - id: reference_overlap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated overlap between adjacent alignment segments on the reference
      (default: 50). Example: Insertions are detected from two segments of a split
      query sequence that are mapped right next to each other on the reference but
      with unaligned sequence between them on the query. The reference overlap tolerance
      determines the maximum tolerated length of an overlap between both segments
      on the reference. If there is a reference gap larger than this value between
      the two segments, no insertion is called.'
    inputBinding:
      position: 105
      prefix: --reference_overlap_tolerance
  - id: sample
    type:
      - 'null'
      - string
    doc: 'Sample ID to include in output vcf file (default: Sample)'
    inputBinding:
      position: 105
      prefix: --sample
  - id: symbolic_alleles
    type:
      - 'null'
      - boolean
    doc: 'Use symbolic alleles, such as <DEL> or <INV> in the VCF output (default:
      False). By default, deletions, insertions, and inversions are represented by
      their nucleotide sequence in the output VCF.'
    inputBinding:
      position: 105
      prefix: --symbolic_alleles
  - id: tandem_duplications_as_insertions
    type:
      - 'null'
      - boolean
    doc: 'Represent tandem duplications as insertions in output VCF (default: False).
      By default, tandem duplications are represented by the SVTYPE=DUP:TANDEM and
      the genomic source is given by the POS and END tags. When enabling this option,
      duplications are instead represented by the SVTYPE=INS and POS and END both
      give the insertion point of the duplication.'
    inputBinding:
      position: 105
      prefix: --tandem_duplications_as_insertions
  - id: types
    type:
      - 'null'
      - string
    doc: 'SV types to include in output VCF (default: DEL,INS,INV,DUP:TANDEM,DUP:INT,BND).
      Give a comma-separated list of SV types. The possible SV types are: DEL (deletions),
      INS (novel insertions), INV (inversions), DUP:TANDEM (tandem duplications),
      DUP:INT (interspersed duplications), BND (breakends).'
    inputBinding:
      position: 105
      prefix: --types
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'Enable more verbose logging (default: False)'
    inputBinding:
      position: 105
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svim-asm:1.0.3--pyhdfd78af_0
stdout: svim-asm_diploid.out
