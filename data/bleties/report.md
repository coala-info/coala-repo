# bleties CWL Generation Report

## bleties_milraa

### Tool Description
MILRAA - Method of Identification by Long Read Alignment Anomalies

### Metadata
- **Docker Image**: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
- **Homepage**: https://github.com/Swart-lab/bleties
- **Package**: https://anaconda.org/channels/bioconda/packages/bleties/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bleties/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Swart-lab/bleties
- **Stars**: N/A
### Original Help Text
```text
usage: bleties milraa [-h] [--bam BAM] [--ref REF] [--contig CONTIG]
                      [--start START] [--stop STOP] [--type TYPE] [--out OUT]
                      [--junction_flank JUNCTION_FLANK]
                      [--min_ies_length MIN_IES_LENGTH]
                      [--min_break_coverage MIN_BREAK_COVERAGE]
                      [--min_del_coverage MIN_DEL_COVERAGE] [--fuzzy_ies]
                      [--cluster_dist CLUSTER_DIST]
                      [--subreads_flank_len SUBREADS_FLANK_LEN]
                      [--subreads_pos_max_cluster_dist SUBREADS_POS_MAX_CLUSTER_DIST]
                      [--subreads_cons_len_threshold SUBREADS_CONS_LEN_THRESHOLD]
                      [--dump]

MILRAA - Method of Identification by Long Read Alignment Anomalies

optional arguments:
  -h, --help            show this help message and exit
  --bam BAM             BAM file containing mapping, must be sorted and
                        indexed (default: None)
  --ref REF             FASTA file containing genomic contigs used as
                        reference for the mapping (default: None)
  --contig CONTIG       Only process alignments from this contig (default:
                        None)
  --start START         Start coordinate (1-based, inclusive) from contig to
                        process (default: None)
  --stop STOP           Stop coordinate (1-based, inclusive) from contig to
                        process (default: None)
  --type TYPE           Type of reads used for mapping, either 'subreads' or
                        'ccs' (default: subreads)
  --out OUT, -o OUT     Output filename prefix (default: milraa.test)
  --junction_flank JUNCTION_FLANK
                        Length of flanking sequence to report to junction
                        report (default: 5)
  --min_ies_length MIN_IES_LENGTH
                        Minimum length of candidate IES (default: 15)
  --min_break_coverage MIN_BREAK_COVERAGE
                        Minimum number of partially aligned reads to define a
                        putative IES insertion breakpoint (default: 10)
  --min_del_coverage MIN_DEL_COVERAGE
                        Minimum number of partially aligned reads to define a
                        deletion relative to reference (default: 10)
  --fuzzy_ies           Allow lengths of inserts to differ slightly when
                        defining putative IES, otherwise insert lengths must
                        be exactly the same. Only used when --type is 'ccs',
                        because subreads are handled separately. (default:
                        False)
  --cluster_dist CLUSTER_DIST
                        Sequence identity distance limit for clustering
                        putative IESs together. Recommended settings: 0.05 for
                        PacBio CCS reads. Only used for --type='ccs'. Not yet
                        tested extensively. (default: 0.05)
  --subreads_flank_len SUBREADS_FLANK_LEN
                        Length of flanking regions to extract on sides of
                        insert from subreads, before taking consensus of
                        flanking + insert to realign to reference. (default:
                        100)
  --subreads_pos_max_cluster_dist SUBREADS_POS_MAX_CLUSTER_DIST
                        In subreads mode, max distance (bp) between inserts
                        reported by the mapper to report as a single cluster
                        (default: 5)
  --subreads_cons_len_threshold SUBREADS_CONS_LEN_THRESHOLD
                        In subreads mode, max proportional difference in
                        length of extracted sequences in a cluster from median
                        length to accept for sequences to generate consensus
                        (default: 0.25)
  --dump                Dump contents of dict for troubleshooting (default:
                        False)
```


## bleties_milcor

### Tool Description
MILCOR - Method of IES Long-read CORrelation

### Metadata
- **Docker Image**: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
- **Homepage**: https://github.com/Swart-lab/bleties
- **Package**: https://anaconda.org/channels/bioconda/packages/bleties/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bleties milcor [-h] [--bam BAM] [--ies IES] [--contig CONTIG]
                      [--start START] [--stop STOP] [--use_ies_lengths]
                      [--length_threshold LENGTH_THRESHOLD] [--bin]
                      [--bin_threshold BIN_THRESHOLD] [--out OUT] [--dump]

MILCOR - Method of IES Long-read CORrelation

optional arguments:
  -h, --help            show this help message and exit
  --bam BAM             BAM file containing mapping, must be sorted and
                        indexed (default: None)
  --ies IES             GFF3 file containing coordinates of IES junctions in
                        MAC genome (default: None)
  --contig CONTIG       Only process alignments from this contig (default:
                        None)
  --start START         Start coordinate (1-based, inclusive) from contig to
                        process (default: None)
  --stop STOP           Stop coordinate (1-based, inclusive) from contig to
                        process (default: None)
  --use_ies_lengths     Only count inserts that match IES lengths reported in
                        the input GFF file. This assumes that the input GFF
                        file is produced by BleTIES MILRAA (default: False)
  --length_threshold LENGTH_THRESHOLD
                        Length threshold to count matching IES length, if
                        option --use_ies_lengths is applied (default: 0.05)
  --bin                 Bin reads into likely MIC and MAC origin and output
                        Fasta files (default: False)
  --bin_threshold BIN_THRESHOLD
                        IES retention/excision threshold for binning to MIC or
                        MAC respecitvely (default: 0.9)
  --out OUT, -o OUT     Output filename prefix (default: milcor.test)
  --dump                Dump contents of IES correlation objects to JSON file,
                        for troubleshooting (default: False)
```


## bleties_miltel

### Tool Description
MILTEL - Method of Long-read Telomere detection

### Metadata
- **Docker Image**: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
- **Homepage**: https://github.com/Swart-lab/bleties
- **Package**: https://anaconda.org/channels/bioconda/packages/bleties/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bleties miltel [-h] [--bam BAM] [--ref REF] [--contig CONTIG]
                      [--start START] [--stop STOP] [--telomere TELOMERE]
                      [--min_telomere_length MIN_TELOMERE_LENGTH]
                      [--other_clips] [--min_clip_length MIN_CLIP_LENGTH]
                      [-o OUT] [--dump]

MILTEL - Method of Long-read Telomere detection

optional arguments:
  -h, --help            show this help message and exit
  --bam BAM             BAM file containing mapping, must be sorted and
                        indexed (default: None)
  --ref REF             FASTA file containing genomic contigs used as
                        reference for the mapping (default: None)
  --contig CONTIG       Only process alignments from this contig (default:
                        None)
  --start START         Start coordinate (1-based, inclusive) from contig to
                        process (default: None)
  --stop STOP           Stop coordinate (1-based, inclusive) from contig to
                        process (default: None)
  --telomere TELOMERE   Telomere sequence to search for (default: ACACCCTA)
  --min_telomere_length MIN_TELOMERE_LENGTH
                        Minimum length of telomere to call (default: 24)
  --other_clips         Count other clipped sequences (non-telomeric) and get
                        consensus of clipped segments (default: False)
  --min_clip_length MIN_CLIP_LENGTH
                        Minimum length of other clipped sequences (non-
                        telomeric) to count (default: 50)
  -o OUT, --out OUT     Output filename prefix (default: miltel.test)
  --dump                Dump internal data for troubleshooting (default:
                        False)
```


## bleties_insert

### Tool Description
Insert - Insert/Remove IESs to/from MAC reference sequence

### Metadata
- **Docker Image**: quay.io/biocontainers/bleties:0.1.11--pyhdfd78af_0
- **Homepage**: https://github.com/Swart-lab/bleties
- **Package**: https://anaconda.org/channels/bioconda/packages/bleties/overview
- **Validation**: PASS

### Original Help Text
```text
usage: bleties insert [-h] [--mode MODE] [--ref REF] [--ies IES]
                      [--iesfasta IESFASTA] [--featuregff FEATUREGFF]
                      [--addsuffix] [-o OUT]

Insert - Insert/Remove IESs to/from MAC reference sequence

optional arguments:
  -h, --help            show this help message and exit
  --mode MODE           Insert or delete mode? Options: 'insert', 'delete'
                        (default: insert)
  --ref REF             FASTA file of MAC genome containing reference to be
                        modified (default: None)
  --ies IES             GFF file of IES features to be added to reference
                        (default: None)
  --iesfasta IESFASTA   FASTA file containing sequences of IES features to be
                        added. Sequence IDs must correspond to IDs in GFF file
                        (default: None)
  --featuregff FEATUREGFF
                        Optional: GFF file of features annotated on the MAC
                        reference genome. Coordinates will be updated after
                        addition of IESs. Not applicable when run in delete
                        mode. (default: None)
  --addsuffix           Optional: If feature is split because IES is inserted
                        within it, number the segments with ID suffix .seg_0,
                        .seg_1, et seq. in the GFF output file. Only relevant
                        if --featuregff is specified. (default: False)
  -o OUT, --out OUT     Output filename prefix (default: insert.test)
```


## Metadata
- **Skill**: generated
