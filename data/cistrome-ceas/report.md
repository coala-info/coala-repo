# cistrome-ceas CWL Generation Report

## cistrome-ceas_ceas

### Tool Description
CEAS (Cis-regulatory Element Annotation System)

### Metadata
- **Docker Image**: quay.io/biocontainers/cistrome-ceas:1.0.2b1--py27_1
- **Homepage**: https://bitbucket.org/cistrome/cistrome-applications-harvard/overview
- **Package**: https://anaconda.org/channels/bioconda/packages/cistrome-ceas/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cistrome-ceas/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Usage: ceas < input files > [options]

CEAS (Cis-regulatory Element Annotation System)

Options:
  --version             show program's version number and exit
  -h, --help            Show this help message and exit.
  -b BED, --bed=BED     BED file of ChIP regions.
  -w WIG, --wig=WIG     WIG file for either wig profiling or genome background
                        annotation. WARNING: --bg flag must be set for genome
                        background re-annotation.
  -e EBED, --ebed=EBED  BED file of extra regions of interest (eg, non-coding
                        regions)
  -g GDB, --gt=GDB      Gene annotation table (eg, a refGene table in sqlite3
                        db format provided through the CEAS web,
                        http://liulab.dfci.harvard.edu/CEAS/download.html).
  --name=NAME           Experiment name. This will be used to name the output
                        files. If an experiment name is not given, the stem of
                        the input BED file name will be used instead (eg, if
                        'peaks.bed', 'peaks' will be used as a name.)
  --sizes=SIZES         Promoter (also dowsntream) sizes for ChIP region
                        annotation. Comma-separated three values or a single
                        value can be given. If a single value is given, it
                        will be segmented into three equal fractions (ie, 3000
                        is equivalent to 1000,2000,3000), DEFAULT:
                        1000,2000,3000. WARNING: Values > 10000bp are
                        automatically set to 10000bp.
  --bisizes=BISIZES     Bidirectional-promoter sizes for ChIP region
                        annotation Comma-separated two values or a single
                        value can be given. If a single value is given, it
                        will be segmented into two equal fractions (ie, 5000
                        is equivalent to 2500,5000) DEFAULT: 2500,5000bp.
                        WARNING: Values > 20000bp are automatically set to
                        20000bp.
  --bg                  Run genome BG annotation again. WARNING: This flag is
                        effective only if a WIG file is given through -w
                        (--wig). Otherwise, ignored.
  --span=SPAN           Span from TSS and TTS in the gene-centered annotation.
                        ChIP regions within this range from TSS and TTS are
                        considered when calculating the coverage rates in
                        promoter and downstream, DEFAULT=3000bp
  --pf-res=PF_RES       Wig profiling resolution, DEFAULT: 50bp. WARNING:
                        Value smaller than the wig interval (resolution) may
                        cause aliasing error.
  --rel-dist=REL_DIST   Relative distance to TSS/TTS in wig profiling,
                        DEFAULT: 3000bp
  --gn-groups=GN_GROUPS
                        Gene-groups of particular interest in wig profiling.
                        Each gene group file must have gene names in the 1st
                        column. The file names are separated by commas w/ no
                        space (eg, --gn-groups=top10.txt,bottom10.txt)
  --gn-group-names=GN_NAMES
                        The names of the gene groups in --gn-groups. The gene
                        group names are separated by commas. (eg, --gn-group-
                        names='top 10%,bottom 10%'). These group names appear
                        in the legends of the wig profiling plots. If no group
                        names given, the groups are represented as 'Group 1,
                        Group2,...Group n'.
  --gname2              Whether or not use the 'name2' column of the gene
                        annotation table when reading the gene IDs in the
                        files given through --gn-groups. This flag is
                        meaningful only with --gn-groups.
  --dump                Whether to save the raw profiles of near TSS, TTS, and
                        gene body. The file names have a suffix of 'TSS',
                        'TTS', and 'gene' after the name.
```

