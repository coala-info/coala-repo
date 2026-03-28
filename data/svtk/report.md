# svtk CWL Generation Report

## svtk_standardize

### Tool Description
Standardize a VCF of SV calls.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-30
- **GitHub**: https://github.com/talkowski-lab/svtk
- **Stars**: N/A
### Original Help Text
```text
usage: svtk standardize [-h] [-p PREFIX] [--include-reference-sites]
                        [--standardizer STANDARDIZER] [--contigs CONTIGS]
                        [--min-size MIN_SIZE] [--call-null-sites]
                        vcf fout source

Standardize a VCF of SV calls.

Each record corresponds to a single SV breakpoint and will have the following
INFO fields, with specified constraints:
  SVTYPE:  SV type [DEL,DUP,INV,BND]
  CHR2:    Secondary chromosome [Must be lexicographically greater than CHROM]
  END:     SV end position (or position on CHR2 in translocations)
  STRANDS: Breakpoint strandedness [++,+-,-+,--]
  SVLEN:   SV length (-1 if translocation)
  ALGORITHMS:  Source algorithm

positional arguments:
  vcf                   Raw VCF.
  fout                  Standardized VCF.
  source                Source algorithm. [delly,lumpy,manta,wham,melt]

optional arguments:
  -h, --help            show this help message and exit
  -p PREFIX, --prefix PREFIX
                        If provided, variant names will be overwritten with
                        this prefix.
  --include-reference-sites
                        Include records where all samples are called 0/0 or
                        ./.
  --standardizer STANDARDIZER
                        Path to python file with custom standardizer
                        definition. (Not yet supported.)
  --contigs CONTIGS     Reference fasta index (.fai). If provided, contigs in
                        index will be used in VCF header. Otherwise all GRCh37
                        contigs will be used in header. Variants on contigs
                        not in provided list will be removed.
  --min-size MIN_SIZE   Minimum SV size to report [50].
  --call-null-sites     Call sites with null genotypes (./.). Generally useful
                        when an algorithm has been run on a single sample and
                        has only reported variant sites.
```


## svtk_rdtest2vcf

### Tool Description
Convert an RdTest-formatted bed to the standard VCF format.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk rdtest2vcf [-h] [--contigs CONTIGS] bed samples fout

Convert an RdTest-formatted bed to the standard VCF format.

Each record corresponds to a single CNV interval and will have the following
INFO fields, with specified constraints:
  SVTYPE:  SV type [DEL,DUP]
  CHR2:    Secondary chromosome; set to same as CHROM
  END:     SV end position
  STRANDS: Breakpoint strandedness [DEL:+-,DUP:-+]
  SVLEN:   SV length
  ALGORITHMS:  Tagged with "depth"

positional arguments:
  bed                RdTest-formatted bed file. (chrom, start, end, name,
                     samples, svtype)
  samples            List of all samples present in variant callset.
  fout               Standardized VCF. Will be compressed with bgzip and tabix
                     indexed if filename ends with .gz

optional arguments:
  -h, --help         show this help message and exit
  --contigs CONTIGS  Reference fasta index (.fai). If provided, contigs in
                     index will be used in VCF header. Otherwise all GRCh37
                     contigs will be used in header.
```


## svtk_vcf2bed

### Tool Description
Convert a VCF to a BED.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk [-h] [--no-samples] [-i INFO] [--include-filters] [--split-bnd]
            [--split-cpx] [--no-header] [--no-sort-coords] [--no-unresolved]
            [--simple-sinks]
            vcf bed

Convert a VCF to a BED.

positional arguments:
  vcf                   VCF to convert.
  bed                   Converted bed. Specify `-` or `stdout` to write to
                        stdout.

optional arguments:
  -h, --help            show this help message and exit
  --no-samples          Don't include comma-delimited list of called samples
                        for each variant.
  -i INFO, --info INFO  INFO field to include as column in output. May be
                        specified more than once. To include all INFO fields,
                        specify `--info ALL`. INFO fields are reported in the
                        order in which they are requested. If ALL INFO fields
                        are requested, they are reported in the order in which
                        they appear in the VCF header.
  --include-filters     Include FILTER status in output, with the same
                        behavior an INFO field.
  --split-bnd           Report two entries in bed file for each BND.
  --split-cpx           Report entries for each CPX rearrangement interval.
  --no-header           Suppress header.
  --no-sort-coords      Do not sort start/end coordinates per record before
                        writing to bed.
  --no-unresolved       Do not output unresolved variants.
  --simple-sinks        Report all INS sinks as 1bp intervals.
```


## svtk_vcfcluster

### Tool Description
Intersect SV called by PE/SR-based algorithms.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk vcfcluster [-h] [-r REGION] [-d DIST] [-f FRAC] [-x BED.GZ]
                       [-z SVSIZE] [-p PREFIX] [-t SVTYPES] [--ignore-svtypes]
                       [-o SAMPLE_OVERLAP] [--preserve-ids]
                       [--preserve-genotypes] [--preserve-header]
                       filelist fout

Intersect SV called by PE/SR-based algorithms.

Paired-end and split-read callers provide a reasonably precise estimation of
an SV breakpoint. This program identifies variant calls that fall within
the expected margin of error made by these programs and clusters them together.
The cluster distance defaults to 500 bp but it is recommended to use the
maximum individual clustering distance across the libraries being analyzed.
(Generally median + 7 * MAD)

positional arguments:
  filelist              List of paths to standardized VCFS
  fout                  Clustered VCF.

optional arguments:
  -h, --help            show this help message and exit
  -r REGION, --region REGION
                        Restrict clustering to genomic region.
  -d DIST, --dist DIST  Maximum clustering distance. Suggested to use max of
                        median + 7*MAD over samples. [500]
  -f FRAC, --frac FRAC  Minimum reciprocal overlap between variants. [0.1]
  -x BED.GZ, --blacklist BED.GZ
                        Tabix indexed bed of blacklisted regions. Any SV with
                        a breakpoint falling inside one of these regions is
                        filtered from output.
  -z SVSIZE, --svsize SVSIZE
                        Minimum SV size to report for intrachromosomal events.
                        [0]
  -p PREFIX, --prefix PREFIX
                        Prefix for merged variant IDs. [MERGED]
  -t SVTYPES, --svtypes SVTYPES
                        Comma delimited list of svtypes to cluster
                        [DEL,DUP,INV,BND]
  --ignore-svtypes      Ignore svtypes when clustering.
  -o SAMPLE_OVERLAP, --sample-overlap SAMPLE_OVERLAP
                        Minimum sample overlap for two variants to be
                        clustered together.
  --preserve-ids        Include list of IDs of constituent records in each
                        cluster.
  --preserve-genotypes  In a set of clustered variants, report best (highest
                        GQ) non-reference genotype when available.
  --preserve-header     Use header from clustering VCFs
```


## svtk_bedcluster

### Tool Description
Cluster a bed of structural variants based on reciprocal overlap.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk bedcluster [-h] [-f FRAC] [-r REGION] [-p PREFIX] [-m] [-T TMPDIR]
                       [-s INTERSECTION]
                       bed [fout]

Cluster a bed of structural variants based on reciprocal overlap.

Variants are clustered with the single-linkage algorithm, using a minimum
reciprocal overlap to determine whether two variants are linked. If multiple
variants from the same sample are clustered together, they are merged into a
single spanning variant. Cluster compactness, calculated as the
root-mean-square standard deviation, is reported for each cluster. Optionally,
the median coordinates for each cluster are reported rather than the original
individual coordinates.

positional arguments:
  bed                   SV calls to cluster. Columns: #chr, start, end, name,
                        sample, svtype
  fout                  Clustered bed.

optional arguments:
  -h, --help            show this help message and exit
  -f FRAC, --frac FRAC  Minimum reciprocal overlap fraction to link variants.
                        [0.8]
  -r REGION, --region REGION
                        Region to cluster (chrom:start-end). Requires tabixed
                        bed.
  -p PREFIX, --prefix PREFIX
                        Cluster ID prefix
  -m, --merge-coordinates
                        Report median of start and end positions in each
                        cluster as final coordinates of cluster.
  -T TMPDIR, --tmpdir TMPDIR
                        Temporary directory [/tmp]
  -s INTERSECTION, --intersection INTERSECTION
                        Pre-computed self-intersection of bed.
```


## svtk_count-svtypes

### Tool Description
Count the instances of each SVTYPE observed in each sample in a VCF.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk count-svtypes [-h] [--no-header] [--total-obs] [--total-variants]
                          vcf [fout]

Count the instances of each SVTYPE observed in each sample in a VCF.

A record is only counted towards a sample's total if the sample received a
non-reference (0/0) or a non-null (./.) call. Records without an annotated
SVTYPE in the INFO field are counted as "NO_SVTYPE".

Counts are reported in a three column table (sample, svtype, count).

positional arguments:
  vcf
  fout              Output file [stdout]

optional arguments:
  -h, --help        show this help message and exit
  --no-header       Don't include header in output
  --total-obs       Sum variant counts across samples
  --total-variants  Sum variant counts across samples
```


## svtk_bincov

### Tool Description
Calculates non-duplicate primary-aligned binned coverage of a chromosome from
an input BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk bincov [-h] [-n NORM_OUT] [-b BINSIZE] [-m {nucleotide,physical}]
                   [-x BLACKLIST] [-z] [-p] [-v OVERLAP] [--oldBT]
                   bam chr cov_out

Calculates non-duplicate primary-aligned binned coverage of a chromosome from
an input BAM file

positional arguments:
  bam                   Input bam
  chr                   Contig to evaluate
  cov_out               Output bed file of raw coverage

optional arguments:
  -h, --help            show this help message and exit
  -n NORM_OUT, --norm_out NORM_OUT
                        Output bed file of normalized coverage
  -b BINSIZE, --binsize BINSIZE
                        Bin size (bp) [1000]
  -m {nucleotide,physical}, --mode {nucleotide,physical}
                        Type of coverage to calculate [nucleotide]
  -x BLACKLIST, --blacklist BLACKLIST
                        BED file of regions to exclude
  -z, --gzip            Compress output bed files
  -p, --presubsetted    Input bam is already subsetted to desired chr
  -v OVERLAP, --overlap OVERLAP
                        Maximum fraction of each bin permitted to overlap with
                        blacklist regions. [0.05]
  --oldBT               Using a bedtools version pre-2.24.0
```


## svtk_collect-pesr

### Tool Description
Collect split read and discordant pair data from a bam alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk collect-pesr [-h] [--index-dir INDEX_DIR] [-r REGION] [-z]
                         bam sample splitfile discfile

Collect split read and discordant pair data from a bam alignment.

Split reads: The tool counts the number of reads soft-clipped in each direction
(30S121M = left-clipped, 121M30S = right-clipped) at each position in the
genome.  The position of a right-clipped read is shifted by the length of its
alignment.

Discordant pairs: The tool reduces discordant pairs to (chrA, posA, strandA,
chrB, posB, strandB).

Unmapped reads, reads with unmapped mates, secondary and supplementary
alignments, and duplicates are excluded (SAM flag 3340).

Collection can be performed on an S3-hosted bam. The tool will attempt to find
a local copy of the bam index in the working directory, or the directory
specified with `--index-dir`, otherwise the index will be downloaded.

positional arguments:
  bam                   Local or S3 path to bam
  sample                ID to append to each line of output files.
  splitfile             Output split counts.
  discfile              Output discordant pairs.

optional arguments:
  -h, --help            show this help message and exit
  --index-dir INDEX_DIR
                        Directory of local BAM indexes if accessing a remote
                        S3 bam.
  -r REGION, --region REGION
                        Tabix-formatted region to parse
  -z, --bgzip           bgzip and tabix index output
```


## svtk_sr-test

### Tool Description
Calculate enrichment of clipped reads at SV breakpoints.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk sr-test [-h] [-w WINDOW] [-b BACKGROUND] [-s SAMPLES]
                    [--index INDEX] [--medianfile MEDIANFILE] [--log]
                    vcf countfile fout

Calculate enrichment of clipped reads at SV breakpoints.

positional arguments:
  vcf                   VCF of variant calls. Standardized to include CHR2,
                        END, SVTYPE, STRANDS in INFO.
  countfile             Tabix indexed file of split counts. Columns:
                        chrom,pos,clip,count,sample
  fout                  Output table of most significant start/endpositions.

optional arguments:
  -h, --help            show this help message and exit
  -w WINDOW, --window WINDOW
                        Window around variant start/end to consider for split
                        read support. [100]
  -b BACKGROUND, --background BACKGROUND
                        Number of background samples to choose for comparison
                        in t-test. [160]
  -s SAMPLES, --samples SAMPLES
                        Whitelist of samples to restrict testing to.
  --index INDEX         Tabix index of discordant pair file. Required if
                        discordant pair file is hosted remotely.
  --medianfile MEDIANFILE
                        Median coverage statistics for each library
                        (optional). If provided, each sample's split counts
                        will be normalized accordingly. Same format as RdTest,
                        one column per sample.
  --log                 Print progress log to stderr.
```


## svtk_pe-test

### Tool Description
Calculate enrichment of discordant pairs at SV breakpoints.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk pe-test [-h] [-o WINDOW_OUT] [-i WINDOW_IN] [-b BACKGROUND]
                    [-s SAMPLES] [--index INDEX] [--medianfile MEDIANFILE]
                    [--log]
                    vcf disc fout

Calculate enrichment of discordant pairs at SV breakpoints.

positional arguments:
  vcf                   Variants.
  disc                  Table of discordant pair coordinates.
  fout                  Output table of PE counts.

optional arguments:
  -h, --help            show this help message and exit
  -o WINDOW_OUT, --window-out WINDOW_OUT
                        Window outside breakpoint to query for discordant
                        pairs. [500]
  -i WINDOW_IN, --window-in WINDOW_IN
                        Window inside breakpoint to query for discordant
                        pairs. [50]
  -b BACKGROUND, --background BACKGROUND
                        Number of background samples to sample for PE
                        evidence. [160]
  -s SAMPLES, --samples SAMPLES
                        Whitelist of samples to restrict testing to.
  --index INDEX         Tabix index of discordant pair file. Required if
                        discordant pair file is hosted remotely.
  --medianfile MEDIANFILE
                        Median coverage statistics for each library
                        (optional). If provided, each sample's split counts
                        will be normalized accordingly. Same format as RdTest,
                        one column per sample.
  --log                 Print progress log to stderr.
```


## svtk_resolve

### Tool Description
Resolve complex SV from inversion/translocation breakpoints and CNV intervals.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk resolve [-h] (--discfile DISCFILE | --discfile-list DISCFILE_LIST)
                    --mei-bed MEI_BED --cytobands CYTOBANDS
                    [--min-rescan-pe-support MIN_RESCAN_PE_SUPPORT]
                    [-x BED.GZ] [-u UNRESOLVED] [-p PREFIX] [-q QUIET]
                    raw resolved

Resolve complex SV from inversion/translocation breakpoints and CNV intervals.

positional arguments:
  raw                   Filtered breakpoints and CNV intervals.
  resolved              Resolved simple and complex variants.

optional arguments:
  -h, --help            show this help message and exit
  --discfile DISCFILE   Scraped discordant pairs. Required to attempt to
                        resolve single-ender inversions.
  --discfile-list DISCFILE_LIST
                        Tab-delimited list of discordant pair files and
                        indices
  --mei-bed MEI_BED     Mobile element insertion bed. Required to classify
                        inverted insertions.
  --cytobands CYTOBANDS
                        Cytoband file. Required to correctly classify
                        interchromosomal events.
  --min-rescan-pe-support MIN_RESCAN_PE_SUPPORT
                        Minumum discordant pairs required during single-ender
                        rescan.
  -x BED.GZ, --pe-blacklist BED.GZ
                        Tabix indexed bed of blacklisted regions. Any
                        anomalous pair falling inside one of these regions is
                        excluded from PE rescanning.
  -u UNRESOLVED, --unresolved UNRESOLVED
                        Unresolved complex breakpoints and CNV.
  -p PREFIX, --prefix PREFIX
                        Variant prefix [CPX_]
  -q QUIET, --quiet QUIET
                        Disable progress logging to stderr.
```


## svtk_annotate

### Tool Description
Annotate resolved SV with genic effects and noncoding hits.

### Metadata
- **Docker Image**: quay.io/biocontainers/svtk:0.0.20190615--py39hbcbf7aa_7
- **Homepage**: https://github.com/talkowski-lab/svtk
- **Package**: https://anaconda.org/channels/bioconda/packages/svtk/overview
- **Validation**: PASS

### Original Help Text
```text
usage: svtk [-h] [--gencode GENCODE] [--noncoding NONCODING] vcf annotated_vcf

Annotate resolved SV with genic effects and noncoding hits.

This tool permits the user to provide a GTF of Gencode gene annotations, a BED
of noncoding elements, or both. The BED of noncoding elements must contain four
columns: (chrom, start, end, element_class).

The following classes of genic effects are annotated as new VCF INFO fields if
the SV meets the defined criteria:
    1) LOF (and DUP_LOF) - Loss of function.
        * Deletions are annotated LOF if they overlap any exon.
        * Duplications are annotated DUP_LOF if they reside entirely within
        a gene boundary and overlap any exon.
        * Inversions are annotated LOF if reside entirely within an exon, if
        one breakpoint falls within an exon, if they reside entirely within a
        gene boundary and overlap an exon, or if only one breakpoint falls
        within a gene boundary.
        * Translocations are annotated LOF If they fall within a gene boundary.
    2) COPY_GAIN
        * Duplications are annotated COPY_GAIN if they span the entirety of a
        gene boundary.
    3) INTRONIC
        * Deletions, duplications, and inversions are annotated INTRONIC if
        they are localized to an intron.
    4) DUP_PARTIAL
        * Duplications are annotated DUP_PARTIAL if they overlap the start or
        end of a gene boundary but not its entirety, such that a whole copy of
        the gene is preserved.
    5) INV_SPAN
        * Inversions are annotated INV_SPAN if they overlap the entirety of a
        gene boundary without disrupting it.
    6) NEAREST_TSS
        * Intragenic events are annotated with the nearest transcription start
        site.

An SV is annotated with a new NONCODING INFO field containing all classes of
noncoding elements which the variant overlaps.

positional arguments:
  vcf                   Structural variants.
  annotated_vcf         Annotated variants.

optional arguments:
  -h, --help            show this help message and exit
  --gencode GENCODE     Gencode gene annotations (GTF).
  --noncoding NONCODING
                        Noncoding elements (bed). Columns =
                        chr,start,end,element_class,element_name
```


## Metadata
- **Skill**: generated
