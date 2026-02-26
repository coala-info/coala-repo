# peaks2utr CWL Generation Report

## peaks2utr

### Tool Description
Use MACS to build forward and reverse peaks files for given .bam file. Iterate peaks through set of criteria to determine UTR viability, before annotating in .gff file.

### Metadata
- **Docker Image**: quay.io/biocontainers/peaks2utr:1.4.1--pyhdfd78af_0
- **Homepage**: https://github.com/haessar/peaks2utr
- **Package**: https://anaconda.org/channels/bioconda/packages/peaks2utr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peaks2utr/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/haessar/peaks2utr
- **Stars**: N/A
### Original Help Text
```text
usage: peaks2utr [-h] [--max-distance MAX_DISTANCE] [--override-utr]
                 [--extend-utr] [--five-prime-ext FIVE_PRIME_EXT]
                 [--skip-soft-clip] [--min-pileups MIN_PILEUPS]
                 [--min-poly-tail MIN_POLY_TAIL] [--do-pseudo]
                 [--no-strand-overlap] [-p PROCESSORS] [-f] [-o OUTPUT]
                 [--gtf] [--skip-validation] [--keep-cache] [--version]
                 GFF_IN BAM_IN

        ____________________________________________________________________
                                                  __
                                   /            /    )
        ------__-----__-----__----/-__----__-----___/------------_/_----)__-
            /   )  /___)  /   )  /(      (_ `  /         /   /   /     /   )
        ___/___/__(___ __(___(__/___\___(__)__/____/____(___(___(_ ___/_____
          /
         /

        Use MACS to build forward and reverse peaks files for given .bam
        file.
        Iterate peaks through set of criteria to determine UTR viability,
        before annotating in .gff file.
        

positional arguments:
  GFF_IN                input 'canonical' annotations file in gff or gtf
                        format
  BAM_IN                input reads file in bam format

options:
  -h, --help            show this help message and exit
  --max-distance MAX_DISTANCE
                        maximum distance in bases that UTR can be from a
                        transcript. Default: 200
  --override-utr        ignore already annotated 3' UTRs in criteria
  --extend-utr          extend previously existing 3' UTR annotations where
                        possible
  --five-prime-ext FIVE_PRIME_EXT
                        a peak within this many bases of a gene's 5'-end
                        should be assumed to belong to it. Default: 0
  --skip-soft-clip      skip the resource-intensive logic to pileup soft-
                        clipped read edges
  --min-pileups MIN_PILEUPS
                        minimum number of piled-up mapped reads for UTR cut-
                        off. Default: 10
  --min-poly-tail MIN_POLY_TAIL
                        minimum length of poly-A/T tail considered in soft-
                        clipped reads. Default: 10
  --do-pseudo           annotate 3' UTR also for pseudogenic transcripts.
  --no-strand-overlap   Prevent overlapping of new UTR feature with any
                        feature on other strand (truncating if necessary).
  -p PROCESSORS, --processors PROCESSORS
                        how many processor cores to use. Default: 1
  -f, -force, --force   overwrite outputs if they exist
  -o OUTPUT, --output OUTPUT
                        output filename. Defaults to <GFF_IN
                        basename>.new.<ext>
  --gtf                 output in GTF format (rather than default GFF3)
  --skip-validation     skip validation of input files
  --keep-cache          keep cached files on run completion
  --version             show program's version number and exit
```

