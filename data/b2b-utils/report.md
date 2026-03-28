# b2b-utils CWL Generation Report

## b2b-utils_minimeta

### Tool Description
Produces a polished consensus assembly from long-read sequencing data using miniasm, racon, and medaka. Software settings are tuned for metagenomic/metatranscriptomic assemblies of variable, sometimes low, coverage.

### Metadata
- **Docker Image**: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
- **Homepage**: https://github.com/jvolkening/b2b-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/b2b-utils/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/b2b-utils/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jvolkening/b2b-utils
- **Stars**: N/A
### Original Help Text
```text
NAME
    minimeta - assembler for long-read metagenomic/metatranscriptomic data
    sets

SYNOPSIS
    minimeta --in <reads.fq> --out <consensus.fasta>

DESCRIPTION
    Produces a polished consensus assembly from long-read sequencing data
    using miniasm, racon, and medaka. Software settings are tuned for
    metagenomic/metatranscriptomic assemblies of variable, sometimes low,
    coverage.

PREREQUISITES
    Requires the following non-core Perl libraries:

    BioX::Seq

    Additionally, the following external programs are required for one or
    more of the optional processing modules (errors will be thrown for
    missing programs only if that module is requested). All optional
    dependencies are available in Bioconda.

    minimap2
    miniasm
    racon
    medaka
    samtools
    bedtools
    seqkit
    redundans
    cutadapt
    homopolish

OPTIONS
  Input
    --in *filename*
        Path to input reads in FASTx format (required)

    --assembly *filename*
        Path to existing assembly. If provided, assembly is skipped and only
        polishing is performed (default: none).

    --homopolish *filename*
        Path to reference FASTA file used by homopolish. Providing this
        filename also triggers polishing using homopolish (default: none).

  Output
    --out *filename*
        Path to write consensus sequence to (as FASTA) [default: STDOUT]

  Configuration
    --min_cov *integer*
        Minimum read coverage required by assembler to keep position
        (default: 2)

    --min_len *integer*
        Minimum contig length to keep (default: 1)

    --mask_below *integer*
        If given, final assembly positions with coverage depth below this
        value will be hard masked with 'N' (default: off)

    --split *float*
        If given in conjunction with "--mask_below", splits contigs at
        masked regions into smaller pieces. (default: off)

    --only_split_at_hp
        If given in conjuction with "--split", only splits low coverage
        regions if one or both junctions is at a homopolymer stretch
        (default: off)

    --threads *integer*
        Number of processsing threads to use for mapping and polishing
        (default: 1)

    --n_racon *integer*
        Number of Racon polishing rounds to perform (default: 3)

    --n_medaka *integer*
        Number of Medaka polishing rounds to perform (default: 1)

    --medaka_model *string*
        Name of model to be used by medaka_consensus (based on basecalling
        model used for data) (default: depends on medaka version)

    --medaka_batch_size *integer*
        Batch size (medaka_consensus parameter -b) for medaka to use; using
        a smaller value should reduce memory consumption (default: 100)

    --shred_len *integer*
        For re-assemblies, the maximum length of pseudo-reads to generate as
        an absolute value; the actual value will be the minimum of this and
        the value of --shred_max_frac times the actual contig length
        (default: 2000)

    --shred_max_frac *float*
        For re-assemblies, the maximum length of pseudo-reads to generate as
        a fraction of the contig length; the actual value will be the
        minimum of this and the value of --shred_len (default: 0.66)

    --shred_tgt_depth *integer*
        For re-assemblies, the target depth of the pseudoreads on each
        contig; this is used to calculate how many reads to generate
        (default: 10)

    --hp_model *string*
        Name of model to be used by homopolish. Has no effect if
        --homopolish not used. (default: R9.4.pkl)

    --noshuffle
        Don't randomly shuffle input reads prior to assembly (default:
        shuffle)

    --trim_polyN
        Trim long poly-N stretches from reads prior to assembly (default:
        off)

    --reassemblies *integer*
        Perform one or more rounds of pseudo-assembly in order to minimize
        redundancy. For each round, the existing assembly is shredded into
        pseudoreads and reassembled.

    --chunk_size *integer*
        If this option is given, input reads will be split into chunks of
        --chunk_size reads and each chunk will be assembled independently.
        The resulting assemblies will be combined, shredded into
        pseudoreads, and reassembled.

    --deterministic
        Use a fixed seed for random processes such as shuffling (default:
        off)

    --reduce
        Apply a reduction algorithm to the pre-final assembly to remove
        redundant contigs (i.e. contigs mostly or completely overlapping
        with identity above a cutoff specified by --min_ident. Currently
        this is done using Redundans, which is required to be installed.
        (default: off)

    --min_ident *float*
        Minimum identity (0 to 1) between contigs required to remove shorter
        contig during redundancy reduction. (default: 0.8)

    --minimizer_cutoff *integer*
        During all-vs-all mapping, discard minimizers occurring above this
        frequency. This is the -f parameter to minimap2, and can be useful
        with high-coverage input datasets that may otherwise consume very
        large amounts of memory and time. A value between 1000 and 10,000
        may be useful in these cases. (default: off)

    --quiet
        Don't write status messages to STDERR

    --help
        Print usage description and exit

    --version
        Print software version and exit

CAVEATS AND BUGS
    Please submit bug reports to the issue tracker in the distribution
    repository.

AUTHOR
    Jeremy Volkening (jeremy.volkening@base2bio.com)

LICENSE AND COPYRIGHT
    Copyright 2021-23 Jeremy Volkening

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
    Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program. If not, see <http://www.gnu.org/licenses/>.
```


## b2b-utils_fq_interleave

### Tool Description
A simple script to interleave two paired FASTQ files (alternate forward/reverse reads in a single output file). This requires that the two files correspond exactly in terms of number and order of the paired reads ('--check' will make sure of this and throw an error otherwise). Interleaved FASTQ is sent to STDOUT.

### Metadata
- **Docker Image**: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
- **Homepage**: https://github.com/jvolkening/b2b-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/b2b-utils/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    fq_interleave - interleave paired FASTQ files

VERSION
    This documentation refers to v0.202

SYNOPSIS
    fq_interleave [--check --rename] *reads1* *reads2* > *interleaved_reads*

DESCRIPTION
    A simple script to interleave two paired FASTQ files (alternate
    forward/reverse reads in a single output file). This requires that the
    two files correspond exactly in terms of number and order of the paired
    reads ('--check' will make sure of this and throw an error otherwise).
    Interleaved FASTQ is sent to STDOUT.

OPTIONS
    --1     Name of input file for forward reads (required)

    --2     Name of input file for reverse reads (required)

    --check Check each pair of input reads to make sure names match (slower
            but more rigorous)

    --rename
            Renames forward and reverse reads to follow the ".../1" and
            .../2" naming convention (required for some programs).
            Everything at and after the first whitespace or end-of-line is
            replaced with the corresponding tag above.

    --out   Name of output file to write to (instead of the default STDOUT)

    --force Force overwrite of output file even if it exists

CAVEATS AND BUGS
    As yet undiscovered. Please reports bugs to the GitHub repository issue
    tracker.

AUTHOR
    Jeremy Volkening (jeremy.volkening@base2bio.com)

COPYRIGHT AND LICENSE
    Copyright 2014-2023 Jeremy Volkening

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
    Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program. If not, see <http://www.gnu.org/licenses/>.
```


## b2b-utils_bam2consensus

### Tool Description
Re-calls a consensus sequence based on a BAM alignment to reference, with various knobs and optional output formats

### Metadata
- **Docker Image**: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
- **Homepage**: https://github.com/jvolkening/b2b-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/b2b-utils/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    bam2consensus - consensus calling (etc) from BAM alignment

SYNOPSIS
    bam2consensus --bam <in.bam> --ref <in.fasta> [options] --consensus
    <out.fasta>

DESCRIPTION
    Re-calls a consensus sequence based on a BAM alignment to reference,
    with various knobs and optional output formats

PREREQUISITES
    Requires the following non-core Perl libraries:

    *
     BioX::Seq

    as well as the following binaries:

    *
     samtools (>= 1.3.1)

    *
     mafft

OPTIONS
  Input (required)
    --bam *filename*
        Path to input BAM alignments

    --ref *filename*
        Path to reference sequence used to generate BAM alignments

  Output (at least one is required, can specify more than one)
    --consensus
        Path to write consensus sequence to (as FASTA)

    --bedgraph
        Path to write coverage file to (as bedgraph)

    --table
        Path to write coverage file to (as tab-separated table)

  Configuration
    --min_qual
        Minimum quality for a base to be considered in consensus calling.
        Default: 10.

    --min_depth
        Minimum read depth for consensus to be called (otherwise called as
        "N"). Default: 3.

    --trim
        Fraction to trim from each end when calculating trimmed mean of
        error window. Default: 0.2.

    --window
        Size of sliding window used to calculate local error rates. Default:
        30.

    --bg_bin_figs <integer>
        If greater than zero, the number of significant figures used to bin
        depths in bedgraph output. If zero, no binning is applied. This
        option is useful to reduce the size of bedgraph output by binning
        similar depth values when high resolution is not important. Default:
        0 (disabled).

CAVEATS AND BUGS
    Please submit bug reports to the issue tracker in the distribution
    repository.

AUTHOR
    Jeremy Volkening (jeremy.volkening@base2bio.com)

LICENSE AND COPYRIGHT
    Copyright 2014-23 Jeremy Volkening

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
    Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program. If not, see <http://www.gnu.org/licenses/>.
```


## b2b-utils_shrink_bedgraph

### Tool Description
reduce resolution/size of bedgraph files

### Metadata
- **Docker Image**: quay.io/biocontainers/b2b-utils:0.020--pl5321h9ee0642_0
- **Homepage**: https://github.com/jvolkening/b2b-utils
- **Package**: https://anaconda.org/channels/bioconda/packages/b2b-utils/overview
- **Validation**: PASS

### Original Help Text
```text
NAME
    shrink_bedgraph - reduce resolution/size of bedgraph files

SYNOPSIS
    shrink_bedgraph --fa *fasta* --bg *in_bedgraph* --out *out_bedgraph* ...

DESCRIPTION
    shrink_bedgraph reduces the resolution of a bedgraph file in order to
    reduce file size and simplify plotting. This is done by binning depth
    values and applying a summary function to each bin, utilizing samtools
    and bedtools under the hood. Adjacent entries with identical depths are
    also merged. A separate optimum bin width is calculated for each contig
    in the input.

OPTIONS
    --bg *file_path*
      Path to the input bedgraph file

    --fa *file_path*
      Path to the input FASTA file corresponding to the input bedgraph

    --out *file_path*
      Path to which to write the output bedgraph file

    --n_bins *integer*
      Number of bins into which to divide each contig (default: 500)

    --operation *string*
      Summarization operation to apply to each bin. This is passed through
      directly to the *bedtools map* call. (default: 'max')

    --help
      Show documentation and exit

    --version
      Print version string and exit

CAVEATS AND BUGS
    Please report all bugs or suggestions on the software repository issues
    page.

AUTHOR
    Jeremy Volkening (jeremy.volkening@base2bio.com)

COPYRIGHT AND LICENSE
    Copyright 2021-2023 Jeremy Volkening

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation, either version 3 of the License, or (at your
    option) any later version.

    This program is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
    Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program. If not, see <http://www.gnu.org/licenses/>.
```


## Metadata
- **Skill**: generated
