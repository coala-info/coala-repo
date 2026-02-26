# mimeo CWL Generation Report

## mimeo_self

### Tool Description
Internal repeat finder. Mimeo-self aligns a genome to itself and extracts high-identity segments above an coverage threshold.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/mimeo
- **Package**: https://anaconda.org/channels/bioconda/packages/mimeo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mimeo/overview
- **Total Downloads**: 8.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Adamtaranto/mimeo
- **Stars**: N/A
### Original Help Text
```text
usage: mimeo-self [-h] [--version] [--adir ADIR] [--afasta AFASTA] [-r]
                  [-d OUTDIR] [--gffout GFFOUT] [--outfile OUTFILE]
                  [--verbose] [--label LABEL] [--prefix PREFIX] [--keeptemp]
                  [--lzpath LZPATH] [--bedtools BEDTOOLS] [--minIdt MINIDT]
                  [--minLen MINLEN] [--minCov MINCOV] [--hspthresh HSPTHRESH]
                  [--intraCov INTRACOV] [--strictSelf]
                  [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Internal repeat finder. Mimeo-self aligns a genome to itself and extracts
high-identity segments above an coverage threshold.

optional arguments:
  -h, --help            show this help message and exit
  --version             Show program version and exit.
  --adir ADIR           Name of directory containing sequences from genome.
                        Write split files here if providing genome as
                        multifasta.
  --afasta AFASTA       Genome as multifasta.
  -r, --recycle         Use existing alignment "--outfile" if found.
  -d OUTDIR, --outdir OUTDIR
                        Write output files to this directory. (Default: cwd)
  --gffout GFFOUT       Name of GFF3 annotation file.
  --outfile OUTFILE     Name of alignment result file.
  --verbose             If set report LASTZ progress.
  --label LABEL         Set annotation TYPE field in gff.
  --prefix PREFIX       ID prefix for internal repeats.
  --keeptemp            If set do not remove temp files.
  --lzpath LZPATH       Custom path to LASTZ executable if not in $PATH.
  --bedtools BEDTOOLS   Custom path to bedtools executable if not in $PATH.
  --minIdt MINIDT       Minimum alignment identity to report.
  --minLen MINLEN       Minimum alignment length to report.
  --minCov MINCOV       Minimum depth of aligned segments to report repeat
                        feature.
  --hspthresh HSPTHRESH
                        Set HSP min score threshold for LASTZ.
  --intraCov INTRACOV   Minimum depth of aligned segments from same scaffold
                        to report feature. Used if "--strictSelf" mode is
                        selected.
  --strictSelf          If set process same-scaffold alignments separately
                        with option to use higher "--intraCov" threshold.
                        Sometime useful to avoid false repeat calls from
                        staggered alignments over SSRs or short tandem
                        duplication.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging level.
```


## mimeo_map

### Tool Description
Find all high-identity segments shared between genomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/mimeo
- **Package**: https://anaconda.org/channels/bioconda/packages/mimeo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mimeo-map [-h] [--version] [--adir ADIR] [--bdir BDIR]
                 [--afasta AFASTA] [--bfasta BFASTA] [-r] [-d OUTDIR]
                 [--gffout GFFOUT] [--outfile OUTFILE] [--verbose]
                 [--label LABEL] [--prefix PREFIX] [--keeptemp]
                 [--lzpath LZPATH] [--minIdt MINIDT] [--minLen MINLEN]
                 [--hspthresh HSPTHRESH] [--TRFpath TRFPATH] [--tmatch TMATCH]
                 [--tmismatch TMISMATCH] [--tdelta TDELTA] [--tPM TPM]
                 [--tPI TPI] [--tminscore TMINSCORE] [--tmaxperiod TMAXPERIOD]
                 [--maxtandem MAXTANDEM] [--writeTRF]
                 [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Find all high-identity segments shared between genomes.

optional arguments:
  -h, --help            show this help message and exit
  --version             Show program version and exit.
  --adir ADIR           Name of directory containing sequences from A genome.
  --bdir BDIR           Name of directory containing sequences from B genome.
  --afasta AFASTA       A genome as multifasta.
  --bfasta BFASTA       B genome as multifasta.
  -r, --recycle         Use existing alignment "--outfile" if found.
  -d OUTDIR, --outdir OUTDIR
                        Write output files to this directory. (Default: cwd)
  --gffout GFFOUT       Name of GFF3 annotation file. If not set, suppress
                        output.
  --outfile OUTFILE     Name of alignment result file.
  --verbose             If set report LASTZ progress.
  --label LABEL         Set annotation TYPE field in gff.
  --prefix PREFIX       ID prefix for B-genome hits annotated in A-genome.
  --keeptemp            If set do not remove temp files.
  --lzpath LZPATH       Custom path to LASTZ executable if not in $PATH.
  --minIdt MINIDT       Minimum alignment identity to report.
  --minLen MINLEN       Minimum alignment length to report.
  --hspthresh HSPTHRESH
                        Set HSP min score threshold for LASTZ.
  --TRFpath TRFPATH     Custom path to TRF executable if not in $PATH.
  --tmatch TMATCH       TRF matching weight
  --tmismatch TMISMATCH
                        TRF mismatching penalty
  --tdelta TDELTA       TRF indel penalty
  --tPM TPM             TRF match probability
  --tPI TPI             TRF indel probability
  --tminscore TMINSCORE
                        TRF minimum alignment score to report
  --tmaxperiod TMAXPERIOD
                        TRF maximum period size to report
  --maxtandem MAXTANDEM
                        Max percentage of an A-genome alignment which may be
                        masked by TRF. If exceeded, alignment will be
                        discarded.
  --writeTRF            If set write TRF filtered alignment file for use with
                        other mimeo modules.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging level.
```


## mimeo_filter

### Tool Description
Filter SSR containing sequences from fasta library of repeats.

### Metadata
- **Docker Image**: quay.io/biocontainers/mimeo:1.2.1--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/mimeo
- **Package**: https://anaconda.org/channels/bioconda/packages/mimeo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: mimeo-filter [-h] [--version] --infile INFILE [-d OUTDIR]
                    [--outfile OUTFILE] [--keeptemp] [--verbose]
                    [--TRFpath TRFPATH] [--tmatch TMATCH]
                    [--tmismatch TMISMATCH] [--tdelta TDELTA] [--tPM TPM]
                    [--tPI TPI] [--tminscore TMINSCORE]
                    [--tmaxperiod TMAXPERIOD] [--maxtandem MAXTANDEM]
                    [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]

Filter SSR containing sequences from fasta library of repeats.

optional arguments:
  -h, --help            show this help message and exit
  --version             Show program version and exit.
  --infile INFILE       Name of directory containing sequences from A genome.
  -d OUTDIR, --outdir OUTDIR
                        Write output files to this directory. (Default: cwd)
  --outfile OUTFILE     Name of alignment result file.
  --keeptemp            If set do not remove temp files.
  --verbose             If set report LASTZ progress.
  --TRFpath TRFPATH     Custom path to TRF executable if not in $PATH.
  --tmatch TMATCH       TRF matching weight
  --tmismatch TMISMATCH
                        TRF mismatching penalty
  --tdelta TDELTA       TRF indel penalty
  --tPM TPM             TRF match probability
  --tPI TPI             TRF indel probability
  --tminscore TMINSCORE
                        TRF minimum alignment score to report
  --tmaxperiod TMAXPERIOD
                        TRF maximum period size to report. Note: Setting this
                        score too high may exclude some LTR retrotransposons.
                        Optimal len to exclude only SSRs is 10-50bp.
  --maxtandem MAXTANDEM
                        Max percentage of a sequence which may be masked by
                        TRF. If exceeded, element will be discarded.
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set the logging level.
```

