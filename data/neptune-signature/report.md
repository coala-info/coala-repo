# neptune-signature CWL Generation Report

## neptune-signature_neptune

### Tool Description
Neptune identifies signatures using an exact k-mer matching strategy. Neptune locates sequence that is sufficiently present in many inclusion targets and sufficiently absent from exclusion targets.

### Metadata
- **Docker Image**: quay.io/biocontainers/neptune-signature:2.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/phac-nml/neptune
- **Package**: https://anaconda.org/channels/bioconda/packages/neptune-signature/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/neptune-signature/overview
- **Total Downloads**: 551
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/neptune
- **Stars**: N/A
### Original Help Text
```text
usage: neptune-conda -i INCLUSION [INCLUSION ...] -e EXCLUSION 
	     [EXCLUSION ...] -o OUTPUT

Neptune identifies signatures using an exact k-mer matching strategy. Neptune
locates sequence that is sufficiently present in many inclusion targets and
sufficiently absent from exclusion targets.

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit

REQUIRED:
  -i INCLUSION [INCLUSION ...], --inclusion INCLUSION [INCLUSION ...]
                        The inclusion targets in FASTA format.
  -e EXCLUSION [EXCLUSION ...], --exclusion EXCLUSION [EXCLUSION ...]
                        The exclusion targets in FASTA format.
  -o OUTPUT, --output OUTPUT
                        The directory to place all output.

KMERS:
  -k KMER, --kmer KMER  The size of the k-mers.
  --organization ORGANIZATION
                        The degree of k-mer organization in the output files.
                        This exploits the four-character alphabet of
                        nucleotides to produce several k-mer output files,
                        with all k-mers in a file beginning with the same
                        short sequence of nucleotides. This parameter
                        determines the number of nucleotides to use and will
                        produce 4^X output files, where X is the number of
                        nucleotides specified by this parameter. The number of
                        output files directly corresponds to the amount of
                        parallelization in the k-mer aggregation process.

FILTERING:
  --filter-percent FILTER-PERCENT
                        The maximum percent identity of a candidate signature
                        with an exclusion hit before discarding the signature.
                        When both the filtered percent and filtered length
                        limits are exceed, the signature is discarded.
  --filter-length FILTER-LENGTH
                        The maximum shared fractional length of an exclusion
                        target alignment with a candidate signature before
                        discarding the signature. When both the filtered
                        percent and filtered length limits are exceed, the
                        signature is discarded.
  --seed-size SEED-SIZE
                        The seed size used during alignment.

EXTRACTION:
  -r REFERENCE [REFERENCE ...], --reference REFERENCE [REFERENCE ...]
                        The FASTA reference from which to extract signatures.
  --reference-size REFERENCE-SIZE
                        The estimated total size in nucleotides of the
                        reference. This will be calculated if not specified.
  --rate RATE           The probability of a mutation or error at an arbitrary
                        position. The default value is 0.01.
  --inhits INHITS       The minimum number of inclusion targets that must
                        contain a k-mer observed in the reference to begin or
                        continue building candidate signatures. This will be
                        calculated if not specified.
  --exhits EXHITS       The maximum allowable number of exclusion targets that
                        may contain a k-mer observed in the reference before
                        terminating the construction of a candidate signature.
                        This will be calculated if not specified.
  --gap GAP             The maximum number of consecutive k-mers observed in
                        the reference during signature candidate construction
                        that fail to have enough inclusion hits before
                        terminating the construction of a candidate signature.
                        This will be calculated if not specified and is
                        determined from the size of k and the rate.
  --size SIZE           The minimum size of all reported candidate signatures.
                        Identified candidate signatures shorter than this
                        value will be discard.
  --gc-content GC-CONTENT
                        The average GC-content of all inclusion and exclusion
                        targets. This will be calculated from inclusion and
                        exclusion targets if not specified.
  --confidence CONFIDENCE
                        The statistical confidence level in decision making
                        involving probabilities when producing candidate
                        signatures.

PARALLELIZATION:
  -p PARALLELIZATION, --parallelization PARALLELIZATION
                        The number of processes to run simultaneously.
```

