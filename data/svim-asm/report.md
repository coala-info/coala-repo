# svim-asm CWL Generation Report

## svim-asm_haploid

### Tool Description
SVIM-ASM is a tool for structural variant detection in assemblies. This is the haploid mode.

### Metadata
- **Docker Image**: quay.io/biocontainers/svim-asm:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/eldariont/svim-asm
- **Package**: https://anaconda.org/channels/bioconda/packages/svim-asm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svim-asm/overview
- **Total Downloads**: 15.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/eldariont/svim-asm
- **Stars**: N/A
### Original Help Text
```text
usage: svim-asm haploid [-h] [--verbose] [--min_mapq MIN_MAPQ]
                        [--min_sv_size MIN_SV_SIZE]
                        [--max_sv_size MAX_SV_SIZE]
                        [--query_gap_tolerance QUERY_GAP_TOLERANCE]
                        [--query_overlap_tolerance QUERY_OVERLAP_TOLERANCE]
                        [--reference_gap_tolerance REFERENCE_GAP_TOLERANCE]
                        [--reference_overlap_tolerance REFERENCE_OVERLAP_TOLERANCE]
                        [--sample SAMPLE] [--types TYPES] [--symbolic_alleles]
                        [--tandem_duplications_as_insertions]
                        [--interspersed_duplications_as_insertions]
                        [--query_names]
                        working_dir bam_file genome

positional arguments:
  working_dir           Working and output directory. Existing files in the
                        directory are overwritten. If the directory does not
                        exist, it is created.
  bam_file              SAM/BAM file with alignment of query assembly to
                        reference assembly (needs to be coordinate-sorted and
                        indexed)
  genome                Reference genome file that the assembly was aligned to
                        (FASTA)

options:
  -h, --help            show this help message and exit
  --verbose             Enable more verbose logging (default: False)

COLLECT:
  --min_mapq MIN_MAPQ   Minimum mapping quality of alignments to consider
                        (default: 20). Alignments with a lower mapping quality
                        are ignored.
  --min_sv_size MIN_SV_SIZE
                        Minimum SV size to detect (default: 40). SVIM can
                        potentially detect events of any size but is limited
                        by the signal-to-noise ratio in the input alignments.
                        That means that more accurate assemblies and
                        alignments enable the detection of smaller events.
  --max_sv_size MAX_SV_SIZE
                        Maximum SV size to detect (default: 100000). This
                        parameter is used to distinguish long deletions (and
                        inversions) from translocations which cannot be
                        distinguished from the alignment alone. Split read
                        segments mapping far apart on the reference could
                        either indicate a very long deletion (inversion) or a
                        translocation breakpoint. SVIM calls a translocation
                        breakpoint if the mapping distance is larger than this
                        parameter and a deletion (or inversion) if it is
                        smaller or equal.
  --query_gap_tolerance QUERY_GAP_TOLERANCE
                        Maximum tolerated gap between adjacent alignment
                        segments on the query (default: 50). Example:
                        Deletions are detected from two subsequent segments of
                        a split query sequence that are mapped far apart from
                        each other on the reference. The query gap tolerance
                        determines the maximum tolerated length of the query
                        gap between both segments. If there is an unaligned
                        query segment larger than this value between the two
                        segments, no deletion is called.
  --query_overlap_tolerance QUERY_OVERLAP_TOLERANCE
                        Maximum tolerated overlap between adjacent alignment
                        segments on the query (default: 50). Example:
                        Deletions are detected from two subsequent segments of
                        a split query sequence that are mapped far apart from
                        each other on the reference. The query overlap
                        tolerance determines the maximum tolerated length of
                        an overlap between both segments in the query. If the
                        overlap between the two segments in the query is
                        larger than this value, no deletion is called.
  --reference_gap_tolerance REFERENCE_GAP_TOLERANCE
                        Maximum tolerated gap between adjacent alignment
                        segments on the reference (default: 50). Example:
                        Insertions are detected from two segments of a split
                        query sequence that are mapped right next to each
                        other on the reference but with unaligned sequence
                        between them on the query. The reference gap tolerance
                        determines the maximum tolerated length of the
                        reference gap between both segments. If there is a
                        reference gap larger than this value between the two
                        segments, no insertion is called.
  --reference_overlap_tolerance REFERENCE_OVERLAP_TOLERANCE
                        Maximum tolerated overlap between adjacent alignment
                        segments on the reference (default: 50). Example:
                        Insertions are detected from two segments of a split
                        query sequence that are mapped right next to each
                        other on the reference but with unaligned sequence
                        between them on the query. The reference overlap
                        tolerance determines the maximum tolerated length of
                        an overlap between both segments on the reference. If
                        there is a reference gap larger than this value
                        between the two segments, no insertion is called.

OUTPUT:
  --sample SAMPLE       Sample ID to include in output vcf file (default:
                        Sample)
  --types TYPES         SV types to include in output VCF (default:
                        DEL,INS,INV,DUP:TANDEM,DUP:INT,BND). Give a comma-
                        separated list of SV types. The possible SV types are:
                        DEL (deletions), INS (novel insertions), INV
                        (inversions), DUP:TANDEM (tandem duplications),
                        DUP:INT (interspersed duplications), BND (breakends).
  --symbolic_alleles    Use symbolic alleles, such as <DEL> or <INV> in the
                        VCF output (default: False). By default, deletions,
                        insertions, and inversions are represented by their
                        nucleotide sequence in the output VCF.
  --tandem_duplications_as_insertions
                        Represent tandem duplications as insertions in output
                        VCF (default: False). By default, tandem duplications
                        are represented by the SVTYPE=DUP:TANDEM and the
                        genomic source is given by the POS and END tags. When
                        enabling this option, duplications are instead
                        represented by the SVTYPE=INS and POS and END both
                        give the insertion point of the duplication.
  --interspersed_duplications_as_insertions
                        Represent interspersed duplications as insertions in
                        output VCF (default: False). By default, interspersed
                        duplications are represented by the SVTYPE=DUP:INT and
                        the genomic source is given by the POS and END tags.
                        When enabling this option, duplications are instead
                        represented by the SVTYPE=INS and POS and END both
                        give the insertion point of the duplication.
  --query_names         Output names of supporting query sequences in INFO tag
                        of VCF (default: False). If enabled, the INFO/READS
                        tag contains the list of names of the supporting query
                        sequences.
```


## svim-asm_diploid

### Tool Description
SVIM-ASM is a tool for structural variant detection in diploid genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/svim-asm:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/eldariont/svim-asm
- **Package**: https://anaconda.org/channels/bioconda/packages/svim-asm/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svim-asm diploid [-h] [--verbose] [--min_mapq MIN_MAPQ]
                        [--min_sv_size MIN_SV_SIZE]
                        [--max_sv_size MAX_SV_SIZE]
                        [--query_gap_tolerance QUERY_GAP_TOLERANCE]
                        [--query_overlap_tolerance QUERY_OVERLAP_TOLERANCE]
                        [--reference_gap_tolerance REFERENCE_GAP_TOLERANCE]
                        [--reference_overlap_tolerance REFERENCE_OVERLAP_TOLERANCE]
                        [--partition_max_distance PARTITION_MAX_DISTANCE]
                        [--max_edit_distance MAX_EDIT_DISTANCE]
                        [--sample SAMPLE] [--types TYPES] [--symbolic_alleles]
                        [--tandem_duplications_as_insertions]
                        [--interspersed_duplications_as_insertions]
                        [--query_names]
                        working_dir bam_file1 bam_file2 genome

positional arguments:
  working_dir           Working and output directory. Existing files in the
                        directory are overwritten. If the directory does not
                        exist, it is created.
  bam_file1             SAM/BAM file with alignment of query assembly's first
                        haplotype to reference assembly (needs to be
                        coordinate-sorted and indexed)
  bam_file2             SAM/BAM file with alignment of query assembly's second
                        haplotype to reference assembly (needs to be
                        coordinate-sorted and indexed)
  genome                Reference genome file that the assembly was aligned to
                        (FASTA)

options:
  -h, --help            show this help message and exit
  --verbose             Enable more verbose logging (default: False)

COLLECT:
  --min_mapq MIN_MAPQ   Minimum mapping quality of alignments to consider
                        (default: 20). Alignments with a lower mapping quality
                        are ignored.
  --min_sv_size MIN_SV_SIZE
                        Minimum SV size to detect (default: 40). SVIM can
                        potentially detect events of any size but is limited
                        by the signal-to-noise ratio in the input alignments.
                        That means that more accurate assemblies and
                        alignments enable the detection of smaller events.
  --max_sv_size MAX_SV_SIZE
                        Maximum SV size to detect (default: 100000). This
                        parameter is used to distinguish long deletions (and
                        inversions) from translocations which cannot be
                        distinguished from the alignment alone. Split read
                        segments mapping far apart on the reference could
                        either indicate a very long deletion (inversion) or a
                        translocation breakpoint. SVIM calls a translocation
                        breakpoint if the mapping distance is larger than this
                        parameter and a deletion (or inversion) if it is
                        smaller or equal.
  --query_gap_tolerance QUERY_GAP_TOLERANCE
                        Maximum tolerated gap between adjacent alignment
                        segments on the query (default: 50). Example:
                        Deletions are detected from two subsequent segments of
                        a split query sequence that are mapped far apart from
                        each other on the reference. The query gap tolerance
                        determines the maximum tolerated length of the query
                        gap between both segments. If there is an unaligned
                        query segment larger than this value between the two
                        segments, no deletion is called.
  --query_overlap_tolerance QUERY_OVERLAP_TOLERANCE
                        Maximum tolerated overlap between adjacent alignment
                        segments on the query (default: 50). Example:
                        Deletions are detected from two subsequent segments of
                        a split query sequence that are mapped far apart from
                        each other on the reference. The query overlap
                        tolerance determines the maximum tolerated length of
                        an overlap between both segments in the query. If the
                        overlap between the two segments in the query is
                        larger than this value, no deletion is called.
  --reference_gap_tolerance REFERENCE_GAP_TOLERANCE
                        Maximum tolerated gap between adjacent alignment
                        segments on the reference (default: 50). Example:
                        Insertions are detected from two segments of a split
                        query sequence that are mapped right next to each
                        other on the reference but with unaligned sequence
                        between them on the query. The reference gap tolerance
                        determines the maximum tolerated length of the
                        reference gap between both segments. If there is a
                        reference gap larger than this value between the two
                        segments, no insertion is called.
  --reference_overlap_tolerance REFERENCE_OVERLAP_TOLERANCE
                        Maximum tolerated overlap between adjacent alignment
                        segments on the reference (default: 50). Example:
                        Insertions are detected from two segments of a split
                        query sequence that are mapped right next to each
                        other on the reference but with unaligned sequence
                        between them on the query. The reference overlap
                        tolerance determines the maximum tolerated length of
                        an overlap between both segments on the reference. If
                        there is a reference gap larger than this value
                        between the two segments, no insertion is called.

PAIR:
  --partition_max_distance PARTITION_MAX_DISTANCE
                        Maximum distance in bp between SVs in a partition
                        (default: 1000). Before pairing, the SV signatures are
                        divided into coarse partitions. This parameter
                        determines the maximum distance between two subsequent
                        signatures in the same partition. If the distance
                        between two subsequent signatures is larger than this
                        parameter, they are distributed into separate
                        partitions.
  --max_edit_distance MAX_EDIT_DISTANCE
                        Maximum edit distance between both alleles to be
                        paired up into a homozygous call (default: 200).

OUTPUT:
  --sample SAMPLE       Sample ID to include in output vcf file (default:
                        Sample)
  --types TYPES         SV types to include in output VCF (default:
                        DEL,INS,INV,DUP:TANDEM,DUP:INT,BND). Give a comma-
                        separated list of SV types. The possible SV types are:
                        DEL (deletions), INS (novel insertions), INV
                        (inversions), DUP:TANDEM (tandem duplications),
                        DUP:INT (interspersed duplications), BND (breakends).
  --symbolic_alleles    Use symbolic alleles, such as <DEL> or <INV> in the
                        VCF output (default: False). By default, deletions,
                        insertions, and inversions are represented by their
                        nucleotide sequence in the output VCF.
  --tandem_duplications_as_insertions
                        Represent tandem duplications as insertions in output
                        VCF (default: False). By default, tandem duplications
                        are represented by the SVTYPE=DUP:TANDEM and the
                        genomic source is given by the POS and END tags. When
                        enabling this option, duplications are instead
                        represented by the SVTYPE=INS and POS and END both
                        give the insertion point of the duplication.
  --interspersed_duplications_as_insertions
                        Represent interspersed duplications as insertions in
                        output VCF (default: False). By default, interspersed
                        duplications are represented by the SVTYPE=DUP:INT and
                        the genomic source is given by the POS and END tags.
                        When enabling this option, duplications are instead
                        represented by the SVTYPE=INS and POS and END both
                        give the insertion point of the duplication.
  --query_names         Output names of supporting query sequences in INFO tag
                        of VCF (default: False). If enabled, the INFO/READS
                        tag contains the list of names of the supporting query
                        sequences.
```


## Metadata
- **Skill**: generated
