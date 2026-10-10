# methyldackel CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| methyldackel_extract | PASS | real bismark BAM (nf-core SARS-CoV-2); 438 CpG sites with counts, merged CpG and CHG outputs written |
| methyldackel_mbias | PASS | real bismark BAM; OT and OB methylation bias SVG plots written |
| methyldackel_mergeContext | PASS | extract output of the real BAM merged into per-CpG metrics; identical to extract --mergeContext |
| methyldackel_perRead | PASS | real bismark BAM; 17447 per-read CpG methylation lines written |

## methyldackel_extract

### Tool Description
Extract methylation metrics from an alignment file in BAM/CRAM format.

### Metadata
- **Docker Image**: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
- **Homepage**: https://github.com/dpryan79/MethylDackel
- **Package**: https://anaconda.org/channels/bioconda/packages/methyldackel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MethylDackel extract [OPTIONS] <ref.fa> <sorted_alignments.bam>

Options:
 -q INT           Minimum MAPQ threshold to include an alignment (default 10)
 -p INT           Minimum Phred threshold to include a base (default 5). This
                  must be >0.
 -D INT           Ignored, kept only for backward compatibility.
 -d INT           Minimum per-base depth for reporting output. If you use
                  --mergeContext, this then applies to the merged CpG/CHG.
                  (default 1)
 -r STR           Region string in which to extract methylation
 -l FILE          A BED file listing regions for inclusion.
 --keepStrand     If a BED file is specified, then this option will cause the
                  strand column (column 6) to be utilized, if present. Thus, if
                  a region has a '+' in this column, then only metrics from the
                  top strand will be output. Note that the -r option can be used
                  to limit the regions of -l.
 -M, --mappability FILE    A bigWig file containing mappability data for
                  filtering reads.
 -t, --mappabilityThreshold FLOAT    If a bigWig file is provided, this sets the
                  threshold mappability value above which a base is considered
                  mappable (default 0.01).
 -b, --minMappableBases INT    If a bigWig file is provided, this sets the
                  number of mappable bases needed for a read to be considered
                  mappable (default 15).
 -O, --outputBBMFile    If this is specified, a Binary Bismap (.bbm) file will
                  be written with the same base name as the provided bigWig file,
                  but with the .bbm extension. Neither this option nor -N have any
                  effect if a bigWig is not specified with -M.
 -N, --outputBBMFileName FILE    If this is specified, a Binary Bismap (.bbm) file will
                  be written at the provided filename. Neither this option nor -O
                  have any effect if a bigWig is not specified with -M.
 -B, --mappabilityBB FILE    A .bbm file containing mappability data for
                  filtering reads.
 -@ nThreads      The number of threads to use, the default 1
 --chunkSize INT  The size of the genome processed by a single thread at a time.
                  The default is 1000000 bases. This value MUST be at least 1.
 --mergeContext   Merge per-Cytosine metrics from CpG and CHG contexts into
                  per-CPG or per-CHG metrics.
 -o, --opref STR  Output filename prefix. CpG/CHG/CHH context metrics will be
                  output to STR_CpG.bedGraph and so on.
 --keepDupes      By default, any alignment marked as a duplicate is ignored.
                  This option causes them to be incorporated. This will unset
                  bit 0x400 in --ignoreFlags.
 --keepSingleton  By default, if only one read in a pair aligns (a singleton)
                  then it's ignored.
 --keepDiscordant By default, paired-end alignments with the properly-paired bit
                  unset in the FLAG field are ignored. Note that the definition
                  of concordant and discordant is based on your aligner
                  settings.
 -F, --ignoreFlags    By default, any alignment marked as secondary (bit 0x100),
                  failing QC (bit 0x200), a PCR/optical duplicate (0x400) or
                  supplemental (0x800) is ignored. This equates to a value of
                  0xF00 or 3840 in decimal. If you would like to change that,
                  you can specify a new value here.
                  ignored. Specifying this causes them to be included.
 -R, --requireFlags   Require each alignment to have all bits in this value
                  present, or else the alignment is ignored. This is equivalent
                  to the -f option in samtools. The default is 0, which
                  includes all alignments.
 --noCpG          Do not output CpG context methylation metrics
 --CHG            Output CHG context methylation metrics
 --CHH            Output CHH context methylation metrics
 --fraction       Extract fractional methylation (only) at each position. This
                  produces a file with a .meth.bedGraph extension.
 --counts         Extract base counts (only) at each position. This produces a
                  file with a .counts.bedGraph extension.
 --logit          Extract logit(M/(M+U)) (only) at each position. This produces
                  a file with a .logit.bedGraph extension.
 --ignoreNH       Ignore NH auxiliary tags. By default, if an NH tag is present
                  and its value is >1 then an entry is ignored as a
                  multimapper.
 --minOppositeDepth   If you would like to exclude sites that likely contain
                  SNPs, then specifying a value greater than 0 here will
                  indicate the minimum depth required on the strand opposite of
                  a C to look for A/T/C bases. The fraction of these necessary
                  to exclude a position from methylation extraction is specified
                  by the --maxVariantFrac parameter. The default is 0, which
                  means that no positions will be excluded. Note that the -p and
                  -q apply here as well. Note further that if you use
                  --mergeContext that a merged site will be excluded if either
                  of its individual Cs would be excluded.
 --minConversionEfficiency  The minimum non-CpG conversion efficiency observed
                  in a read to include it in the output. The default is 0.0 and
                  the maximum is 1.0 (100% conversion). You are strongly
                  encouraged to NOT use this option without an EXTREMELY
                  compelling reason!
 --maxVariantFrac The maximum fraction of A/T/C base calls on the strand
                  opposite of a C to allow before a position is declared a
                  variant (thereby being excluded from output). The default is
                  0.0. See also --minOppositeDepth.
 --methylKit      Output in the format required by methylKit. Note that this is
                  incompatible with --mergeContext, --fraction and --counts.
 --cytosine_report  A per-base exhaustive report comparable to that produced
                  with the same option in Bismark's methylation extractor. The
                  output is a tab-separated file with the following columns:
                  chromosome, position (1-based), strand, number of alignments
                  supporting methylation, number of alignments supporting
                  unmethylation, CG/CHG/CHH, trinucleotide context. This is not
                  compatible with --fraction, --counts, --methylKit, or
                  --mergeContext. The produces a single file with a
                  .cytosine_report.txt extension. Note that even bases with no
                  coverage will be included in the output.
 --OT INT,INT,INT,INT Inclusion bounds for methylation calls from reads/pairs
                  originating from the original top strand. Suggested values can
                  be obtained from the MBias program. Each integer represents a
                  1-based position on a read. For example --OT A,B,C,D
                  translates to, "Include calls at positions from A through B
                  on read #1 and C through D on read #2". If a 0 is used a any
                  position then that is translated to mean start/end of the
                  alignment, as appropriate. For example, --OT 5,0,0,0 would
                  include all but the first 4 bases on read #1. Users are
                  strongly advised to consult a methylation bias plot, for
                  example by using the MBias program.
 --OB INT,INT,INT,INT
 --CTOT INT,INT,INT,INT
 --CTOB INT,INT,INT,INT As with --OT, but for the original bottom, complementary
                  to the original top, and complementary to the original bottom
                  strands, respectively.
 --nOT INT,INT,INT,INT Like --OT, but always exclude INT bases from a given end
                  from inclusion,regardless of the length of an alignment. This
                  is useful in cases where reads may have already been trimmed
                  to different lengths, but still none-the-less contain a
                  certain length bias at one or more ends.
 --nOB INT,INT,INT,INT
 --nCTOT INT,INT,INT,INT
 --nCTOB INT,INT,INT,INT As with --nOT, but for the original bottom,
                  complementary to the original top, and complementary to the
                  original bottom strands, respectively.
 --version        Print version and then quit.

Note that --fraction, --counts, and --logit are mutually exclusive!
```

## methyldackel_mbias

### Tool Description
Determine the position-dependent methylation bias in a dataset, producing diagnostic SVG images.

### Metadata
- **Docker Image**: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
- **Homepage**: https://github.com/dpryan79/MethylDackel
- **Package**: https://anaconda.org/channels/bioconda/packages/methyldackel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MethylDackel mbias [OPTIONS] <ref.fa> <sorted_alignments.bam> <output.prefix>

Options:
 -q INT           Minimum MAPQ threshold to include an alignment (default 10)
 -p INT           Minimum Phred threshold to include a base (default 5). This
                  must be >0.
 -D INT           Maximum per-base depth (default 2000)
 -r STR           Region string in which to extract methylation
 -l FILE          A BED file listing regions for inclusion.
 --keepStrand     If a BED file is specified, then this option will cause the
                  strand column (column 6) to be utilized, if present. Thus, if
                  a region has a '+' in this column, then only metrics from the
                  top strand will be output. Note that the -r option can be used
                  to limit the regions of -l.
 -@ nThreads      The number of threads to use, the default 1
 --chunkSize INT  The size of the genome processed by a single thread at a time.
                  The default is 1000000 bases. This value MUST be at least 1.
 --keepDupes      By default, any alignment marked as a duplicate is ignored.
                  This option causes them to be incorporated.
 --keepSingleton  By default, if only one read in a pair aligns (a singleton)
                  then it's ignored.
 --keepDiscordant By default, paired-end alignments with the properly-paired bit
                  unset in the FLAG field are ignored. Note that the definition
                  of concordant and discordant is based on your aligner
                  settings.
 -F, --ignoreFlags    By deault, any alignment marked as secondary (bit 0x100),
                  failing QC (bit 0x200), a PCR/optical duplicate (0x400) or
                  supplemental (0x800) is ignored. This equates to a value of
                  0xF00 or 3840 in decimal. If you would like to change that,
                  you can specify a new value here.
                  ignored. Specifying this causes them to be included.
 -R, --requireFlags   Require each alignment to have all bits in this value
                  present, or else the alignment is ignored. This is equivalent
                  to the -f option in samtools. The default is 0, which
                  includes all alignments.
 --ignoreNH       Ignore NH auxiliary tags. By default, if an NH tag is present
                  and its value is >1 then an entry is ignored as a
                  multimapper.
 --minConversionEfficiency  The minimum non-CpG conversion efficiency observed
                  in a read to include it in the output. The default is 0.0 and
                  the maximum is 1.0 (100% conversion). You are strongly
                  encouraged to NOT use this option without an EXTREMELY
                  compelling reason!
 --txt            Output tab separated metrics to the screen. These can be
                  imported into R or another program for manual plotting and
                  analysis. Note that coordinates are 1-based.
 --noSVG          Don't produce the SVG files. This option implies --txt. Note
                  that an output prefix is no longer required with this option.
 --noCpG          Do not output CpG methylation metrics
 --CHG            Output CHG methylation metrics
 --CHH            Output CHH methylation metrics
 --nOT INT,INT,INT,INT Inclusion bound for methylation calls from reads/pairs
                  originating from the original top strand. Each integer
                  represents a 1-based position from the end of a read. For
                  example "--nOT A,B,C,D" translates to, "Include calls from
                  position A through the Bth read from the end on read #1 and
                  Cth through the Dth from the end base on read #2". In other
                  words "--nOT 5,10,0,0" for a 100 base long read would result
                  in bases 5 through 90 being used. If a 0 is used in any
                  position then that is translated to mean start/end of the
                  alignment, as appropriate. For example, --nOT 5,0,0,0 would
                  include all but the first 4 bases on read #1.
 --nOB INT,INT,INT,INT
 --nCTOT INT,INT,INT,INT
 --nCTOB INT,INT,INT,INT As with --nOT, but for the original bottom, complementary
                  to the original top, and complementary to the original bottom
                  strands, respectively.
 --version        Print version and the quit
```

## methyldackel_mergeContext

### Tool Description
Merge single Cytosine methylation metrics into per-CpG/CHG metrics.

### Metadata
- **Docker Image**: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
- **Homepage**: https://github.com/dpryan79/MethylDackel
- **Package**: https://anaconda.org/channels/bioconda/packages/methyldackel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MethylDackel mergeContext [OPTIONS] <ref.fa> <input>

This program will merge single Cytosine methylation metrics into per-CpG/CHG
metrics. The input file must be coordinate sorted but is not required to contain
only a single sequence context, though not doing so may result in an unsorted
result.

  ref.fa    Reference genome in fasta format. This must be indexed with
            samtools faidx
  input     An input file such as that produced by MethylDackel extract. Specifying
            - allows reading from a pipe.

Options:
  -o STR    Output file name [stdout]
  --version Print version and quit
```

## methyldackel_perRead

### Tool Description
Compute the average CpG methylation level of each read.

### Metadata
- **Docker Image**: quay.io/biocontainers/methyldackel:0.6.1--h577a1d6_9
- **Homepage**: https://github.com/dpryan79/MethylDackel
- **Package**: https://anaconda.org/channels/bioconda/packages/methyldackel/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: MethylDackel perRead [OPTIONS] <ref.fa> <input>

This program will compute the average CpG methylation level of a given read.
The output is a tab-separated file with the following columns:
 - read name
 - chromosome
 - position
 - CpG methylation (%)
 - number of informative bases

Arguments:
  ref.fa    Reference genome in fasta format. This must be indexed with
            samtools faidx
  input     An input BAM or CRAM file. This MUST be sorted and should be indexed.

Options:
 -q INT     Minimum MAPQ threshold to include an alignment (default 10)
 -p INT     Minimum Phred threshold to include a base (default 5). This must             be >0.
 -r STR     Region string in which to extract methylation
 -l FILE    A BED file listing regions for inclusion.
 --keepStrand  If a BED file is specified, then this option will cause the
            strand column (column 6) to be utilized, if present. Thus, if
            a region has a '+' in this column, then only metrics from the
            top strand will be output. Note that the -r option can be used
            to limit the regions of -l.
 -o STR     Output file name [stdout]
 -F, --ignoreFlags    By default, all reads are output. If you would like to
            ignore certain classes of reads then simply give a value for their
            flags here. Note that an alignment will be logically anded with this
            flag, so a single bit overlap will lead to exclusion. The default
            for this is 0.
 -R, --requireFlags   Require each alignment to have all bits in this value
            present, or else the alignment is ignored. This is equivalent to the
            -f option in samtools. The default is 0, which includes all
            alignments.
 --ignoreNH Ignore NH auxiliary tags. By default, if an NH tag is present
            and its value is >1 then an entry is ignored as a
            multimapper.
 -@ INT     The number of threads to use, the default 1
 --chunkSize INT  The size of the genome processed by a single thread at a time.
            The default is 1000000 bases. This value MUST be at least 1.
 --version  Print version and quit

Note that this program will produce incorrect values for alignments spanning
more than 10kb.
```
