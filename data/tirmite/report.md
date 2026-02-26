# tirmite CWL Generation Report

## tirmite_legacy

### Tool Description
Map HMM models of transposon termini to genomic sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/TIRmite
- **Package**: https://anaconda.org/channels/bioconda/packages/tirmite/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tirmite/overview
- **Total Downloads**: 22.9K
- **Last updated**: 2026-01-14
- **GitHub**: https://github.com/Adamtaranto/TIRmite
- **Stars**: N/A
### Original Help Text
```text
usage: tirmite legacy [-h] [--version]
                      [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                      --genome GENOME [--hmmDir HMMDIR] [--hmmFile HMMFILE]
                      [--alnDir ALNDIR] [--alnFile ALNFILE]
                      [--pairbed PAIRBED] [--stableReps STABLEREPS]
                      [--outdir OUTDIR] [--prefix PREFIX] [--nopairing]
                      [--gffOut] [--report {None,all,paired,unpaired}]
                      [--padlen PADLEN] [--keep-temp] [--threads THREADS]
                      [--maxeval MAXEVAL] [--maxdist MAXDIST] [--nobias]
                      [--matrix MATRIX] [--mincov MINCOV]
                      [--hmmpress HMMPRESS] [--nhmmer NHMMER]
                      [--hmmbuild HMMBUILD] [--orientation ORIENTATION]
                      [--leftModel LEFTMODEL] [--rightModel RIGHTMODEL]
                      [--tempdir TEMPDIR] [--nhmmerFile NHMMERFILE]
                      [--leftNhmmer LEFTNHMMER] [--rightNhmmer RIGHTNHMMER]

Map HMM models of transposon termini to genomic sequences

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set logging level. Default: 'DEBUG'
  --genome GENOME       Path to target genome that will be queried with HMMs.
  --hmmDir HMMDIR       Directory containing pre-prepared TIR-pHMMs.
  --hmmFile HMMFILE     Path to single HMM file. Incompatible with "--hmmDir".
  --alnDir ALNDIR       Path to directory containing only TIR alignments in
                        FASTA format to be converted to HMM.
  --alnFile ALNFILE     Provide a single TIR alignment in FASTA format to be
                        converted to HMM. Incompatible with "--alnDir".
  --pairbed PAIRBED     If set TIRmite will preform pairing on TIRs from
                        custom bedfile only.
  --stableReps STABLEREPS
                        Number of times to iterate pairing procedure when no
                        additional pairs are found AND remaining unpaired hits
                        > 0.
  --outdir OUTDIR       All output files will be written to this directory.
  --prefix PREFIX       Add prefix to all hits and paired elements detected in
                        this run. (Default = None)
  --nopairing           If set, only report HMM hits. Do not attempt pairing.
  --gffOut              If set report features as prefix.gff3. File saved to
                        outdir. Default: False
  --report {None,all,paired,unpaired}
                        Options for reporting model hits in GFF annotation
                        file.
  --padlen PADLEN       Extract x bases either side of model hit when writing
                        hits to fasta.
  --keep-temp           If set do not delete temp file directory.
  --threads THREADS     Set number of threads available to hmmer software.
  --maxeval MAXEVAL     Maximum e-value allowed for valid hit. Default = 0.001
  --maxdist MAXDIST     Maximum distance allowed between termini candidates to
                        consider valid pairing.
  --nobias              Turn OFF bias correction of scores in nhmmer.
  --matrix MATRIX       Use custom DNA substitution matrix with nhmmer.
  --mincov MINCOV       Minimum valid hit length as prop of model length.
                        Defaults to 0.5
  --hmmpress HMMPRESS   Set location of hmmpress if not in PATH.
  --nhmmer NHMMER       Set location of nhmmer if not in PATH.
  --hmmbuild HMMBUILD   Set location of hmmbuild if not in PATH.
  --orientation ORIENTATION
                        Orientation pattern for pairing hits. F=Forward,
                        R=Reverse. Options: F,R (TIR), F,F (LTR), R,R, R,F
  --leftModel LEFTMODEL
                        HMM model for left terminus. Use with --rightModel for
                        asymmetric elements.
  --rightModel RIGHTMODEL
                        HMM model for right terminus. Use with --leftModel for
                        asymmetric elements.
  --tempdir TEMPDIR     Base directory for temporary files. Uses system temp
                        if not specified.
  --nhmmerFile NHMMERFILE
                        Path to precomputed nhmmer output file. Requires
                        --hmmFile for model length calculation.
  --leftNhmmer LEFTNHMMER
                        Path to precomputed nhmmer output for left model. Use
                        with --rightNhmmer and --leftModel/--rightModel for
                        asymmetric elements.
  --rightNhmmer RIGHTNHMMER
                        Path to precomputed nhmmer output for right model. Use
                        with --leftNhmmer and --leftModel/--rightModel for
                        asymmetric elements.
```


## tirmite_seed

### Tool Description
Build HMM models from seed sequences for TIRmite

### Metadata
- **Docker Image**: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/TIRmite
- **Package**: https://anaconda.org/channels/bioconda/packages/tirmite/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tirmite seed [-h] --left-seed LEFT_SEED [--right-seed RIGHT_SEED]
                    --model-name MODEL_NAME [--outdir OUTDIR]
                    (--genome GENOME | --genome-list GENOME_LIST)
                    [--tempdir TEMPDIR] [--keep-temp]
                    [--min-coverage MIN_COVERAGE]
                    [--min-identity MIN_IDENTITY] [--save-blast-hits]
                    [--max-gap MAX_GAP] [--flank-size FLANK_SIZE]
                    [--loglevel {DEBUG,INFO,WARNING,ERROR}]
                    [--threads THREADS]

Build HMM models from seed sequences for TIRmite

options:
  -h, --help            show this help message and exit
  --left-seed LEFT_SEED
                        FASTA file containing left terminal seed sequence(s)
  --right-seed RIGHT_SEED
                        FASTA file containing right terminal seed sequence(s)
                        (optional for asymmetric elements)
  --model-name MODEL_NAME
                        Base name for the HMM model(s)
  --outdir OUTDIR       Output directory for results
  --genome GENOME       Single genome FASTA file to search
  --genome-list GENOME_LIST
                        File containing list of genome paths (one per line)
  --tempdir TEMPDIR     Directory for temporary files (default: system temp)
  --keep-temp           Keep temporary files after completion
  --min-coverage MIN_COVERAGE
                        Minimum query coverage threshold as fraction 0.0-1.0
                        (default: 0.7)
  --min-identity MIN_IDENTITY
                        Minimum sequence identity threshold as percentage
                        (default: 70.0)
  --save-blast-hits     Save all BLAST hits in tabular format
  --max-gap MAX_GAP     Maximum gap size for chaining fragmented hits
                        (default: 10)
  --flank-size FLANK_SIZE
                        Extract BLAST hits with flanking sequence of N bases
                        and create additional alignment (optional)
  --loglevel {DEBUG,INFO,WARNING,ERROR}
                        Set logging level
  --threads THREADS     Number of CPU threads to use for MAFFT alignment
                        (default: 1)
```


## tirmite_pair

### Tool Description
Pair precomputed nhmmer hits for transposon detection

### Metadata
- **Docker Image**: quay.io/biocontainers/tirmite:1.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/Adamtaranto/TIRmite
- **Package**: https://anaconda.org/channels/bioconda/packages/tirmite/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tirmite pair [-h] [--version]
                    [--loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}]
                    [--logfile] --genome GENOME (--nhmmerFile NHMMERFILE |
                    --leftNhmmer LEFTNHMMER) [--rightNhmmer RIGHTNHMMER]
                    [--hmmFile HMMFILE | --leftModel LEFTMODEL |
                    --lengthsFile LENGTHSFILE] [--rightModel RIGHTMODEL]
                    [--maxeval MAXEVAL] [--mincov MINCOV] [--maxdist MAXDIST]
                    [--orientation ORIENTATION] [--stableReps STABLEREPS]
                    [--outdir OUTDIR] [--prefix PREFIX] [--nopairing]
                    [--gffOut] [--report {all,paired,unpaired}]
                    [--padlen PADLEN] [--tempdir TEMPDIR] [--keep-temp]

Pair precomputed nhmmer hits for transposon detection

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --loglevel {DEBUG,INFO,WARNING,ERROR,CRITICAL}
                        Set logging level. Default: 'INFO'
  --logfile             Write log messages to file in output directory.
  --genome GENOME       Path to target genome FASTA file.
  --nhmmerFile NHMMERFILE
                        Path to single nhmmer output file (requires --hmmFile
                        or --lengthsFile).
  --leftNhmmer LEFTNHMMER
                        Path to nhmmer output for left model (use with
                        --rightNhmmer).
  --rightNhmmer RIGHTNHMMER
                        Path to nhmmer output for right model (use with
                        --leftNhmmer).
  --hmmFile HMMFILE     Path to HMM file for extracting model lengths (for
                        single model pairing).
  --leftModel LEFTMODEL
                        Path to left HMM model file (for asymmetric pairing).
  --lengthsFile LENGTHSFILE
                        Path to tab-delimited file with model_name and
                        model_length columns.
  --rightModel RIGHTMODEL
                        Path to right HMM model file (for asymmetric pairing).
  --maxeval MAXEVAL     Maximum e-value allowed for valid hit. Default: 0.001
  --mincov MINCOV       Minimum hit coverage as proportion of model length.
                        Default: 0.5
  --maxdist MAXDIST     Maximum distance allowed between termini for pairing.
  --orientation ORIENTATION
                        Orientation pattern for pairing. F=Forward(+),
                        R=Reverse(-). Options: F,R (TIR), F,F (LTR), R,R, R,F.
                        Default: F,R
  --stableReps STABLEREPS
                        Number of iterations when no new pairs found. Default:
                        0
  --outdir OUTDIR       Output directory. Default: current directory
  --prefix PREFIX       Prefix for output files.
  --nopairing           Only report individual hits, skip pairing.
  --gffOut              Generate GFF3 output file.
  --report {all,paired,unpaired}
                        Types of hits to include in GFF output.
  --padlen PADLEN       Extract N bases flanking each hit in FASTA output.
  --tempdir TEMPDIR     Base directory for temporary files.
  --keep-temp           Preserve temporary directory.
```

