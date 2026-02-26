cwlVersion: v1.2
class: CommandLineTool
baseCommand: svim-asm haploid
label: svim-asm_haploid
doc: "SVIM-ASM is a tool for structural variant detection in assemblies. This is the
  haploid mode.\n\nTool homepage: https://github.com/eldariont/svim-asm"
inputs:
  - id: working_dir
    type: Directory
    doc: Working and output directory. Existing files in the directory are 
      overwritten. If the directory does not exist, it is created.
    inputBinding:
      position: 1
  - id: bam_file
    type: File
    doc: SAM/BAM file with alignment of query assembly to reference assembly 
      (needs to be coordinate-sorted and indexed)
    inputBinding:
      position: 2
  - id: genome
    type: File
    doc: Reference genome file that the assembly was aligned to (FASTA)
    inputBinding:
      position: 3
  - id: interspersed_duplications_as_insertions
    type:
      - 'null'
      - boolean
    doc: Represent interspersed duplications as insertions in output VCF. By 
      default, interspersed duplications are represented by the SVTYPE=DUP:INT 
      and the genomic source is given by the POS and END tags. When enabling 
      this option, duplications are instead represented by the SVTYPE=INS and 
      POS and END both give the insertion point of the duplication.
    default: false
    inputBinding:
      position: 104
      prefix: --interspersed_duplications_as_insertions
  - id: max_sv_size
    type:
      - 'null'
      - int
    doc: Maximum SV size to detect. This parameter is used to distinguish long 
      deletions (and inversions) from translocations which cannot be 
      distinguished from the alignment alone. Split read segments mapping far 
      apart on the reference could either indicate a very long deletion 
      (inversion) or a translocation breakpoint. SVIM calls a translocation 
      breakpoint if the mapping distance is larger than this parameter and a 
      deletion (or inversion) if it is smaller or equal.
    default: 100000
    inputBinding:
      position: 104
      prefix: --max_sv_size
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: Minimum mapping quality of alignments to consider. Alignments with a 
      lower mapping quality are ignored.
    default: 20
    inputBinding:
      position: 104
      prefix: --min_mapq
  - id: min_sv_size
    type:
      - 'null'
      - int
    doc: Minimum SV size to detect. SVIM can potentially detect events of any 
      size but is limited by the signal-to-noise ratio in the input alignments. 
      That means that more accurate assemblies and alignments enable the 
      detection of smaller events.
    default: 40
    inputBinding:
      position: 104
      prefix: --min_sv_size
  - id: query_gap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated gap between adjacent alignment segments on the query.
      Example: Deletions are detected from two subsequent segments of a split query
      sequence that are mapped far apart from each other on the reference. The query
      gap tolerance determines the maximum tolerated length of the query gap between
      both segments. If there is an unaligned query segment larger than this value
      between the two segments, no deletion is called.'
    default: 50
    inputBinding:
      position: 104
      prefix: --query_gap_tolerance
  - id: query_names
    type:
      - 'null'
      - boolean
    doc: Output names of supporting query sequences in INFO tag of VCF. If 
      enabled, the INFO/READS tag contains the list of names of the supporting 
      query sequences.
    default: false
    inputBinding:
      position: 104
      prefix: --query_names
  - id: query_overlap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated overlap between adjacent alignment segments on the query.
      Example: Deletions are detected from two subsequent segments of a split query
      sequence that are mapped far apart from each other on the reference. The query
      overlap tolerance determines the maximum tolerated length of an overlap between
      both segments in the query. If the overlap between the two segments in the query
      is larger than this value, no deletion is called.'
    default: 50
    inputBinding:
      position: 104
      prefix: --query_overlap_tolerance
  - id: reference_gap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated gap between adjacent alignment segments on the reference.
      Example: Insertions are detected from two segments of a split query sequence
      that are mapped right next to each other on the reference but with unaligned
      sequence between them on the query. The reference gap tolerance determines the
      maximum tolerated length of the reference gap between both segments. If there
      is a reference gap larger than this value between the two segments, no insertion
      is called.'
    default: 50
    inputBinding:
      position: 104
      prefix: --reference_gap_tolerance
  - id: reference_overlap_tolerance
    type:
      - 'null'
      - int
    doc: 'Maximum tolerated overlap between adjacent alignment segments on the reference.
      Example: Insertions are detected from two segments of a split query sequence
      that are mapped right next to each other on the reference but with unaligned
      sequence between them on the query. The reference overlap tolerance determines
      the maximum tolerated length of an overlap between both segments on the reference.
      If there is a reference gap larger than this value between the two segments,
      no insertion is called.'
    default: 50
    inputBinding:
      position: 104
      prefix: --reference_overlap_tolerance
  - id: sample
    type:
      - 'null'
      - string
    doc: Sample ID to include in output vcf file
    default: Sample
    inputBinding:
      position: 104
      prefix: --sample
  - id: symbolic_alleles
    type:
      - 'null'
      - boolean
    doc: Use symbolic alleles, such as <DEL> or <INV> in the VCF output. By 
      default, deletions, insertions, and inversions are represented by their 
      nucleotide sequence in the output VCF.
    default: false
    inputBinding:
      position: 104
      prefix: --symbolic_alleles
  - id: tandem_duplications_as_insertions
    type:
      - 'null'
      - boolean
    doc: Represent tandem duplications as insertions in output VCF. By default, 
      tandem duplications are represented by the SVTYPE=DUP:TANDEM and the 
      genomic source is given by the POS and END tags. When enabling this 
      option, duplications are instead represented by the SVTYPE=INS and POS and
      END both give the insertion point of the duplication.
    default: false
    inputBinding:
      position: 104
      prefix: --tandem_duplications_as_insertions
  - id: types
    type:
      - 'null'
      - string
    doc: 'SV types to include in output VCF. Give a comma-separated list of SV types.
      The possible SV types are: DEL (deletions), INS (novel insertions), INV (inversions),
      DUP:TANDEM (tandem duplications), DUP:INT (interspersed duplications), BND (breakends).'
    default: DEL,INS,INV,DUP:TANDEM,DUP:INT,BND
    inputBinding:
      position: 104
      prefix: --types
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable more verbose logging
    default: false
    inputBinding:
      position: 104
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svim-asm:1.0.3--pyhdfd78af_0
stdout: svim-asm_haploid.out
