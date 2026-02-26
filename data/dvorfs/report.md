# dvorfs CWL Generation Report

## dvorfs

### Tool Description
DVORFS v1.0.1

### Metadata
- **Docker Image**: quay.io/biocontainers/dvorfs:1.0.1--pyhdfd78af_0
- **Homepage**: https://github.com/ilevantis/dvorfs
- **Package**: https://anaconda.org/channels/bioconda/packages/dvorfs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dvorfs/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ilevantis/dvorfs
- **Stars**: N/A
### Original Help Text
```text
usage: dvorfs [-h] -f FASTA [-i FAI] (--hmm2 HMM2 | --hmm3 HMM3 | --seed SEED)
              [--presearch-slop PRESEARCH_SLOP] [-b BED] [--full-search]
              [-p PROCS] [-o OUTDIR] [--prefix PREFIX] [-d WORKDIR] [-k]
              [--nuc-tsv] [--full-tsv] [--noali] [--nomerge]
              [--merge-distance MERGE_DISTANCE]
              [--filter {all,no-overlap,best-per}] [--hit-mask HIT_MASK]
              [--bit-cutoff BIT_CUTOFF] [--length-cutoff LENGTH_CUTOFF] [-v]

DVORFS v1.0.1

optional arguments:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit

Input target sequence:
  -f FASTA, --fasta FASTA
                        Input fasta file.
  -i FAI, --fai FAI     Input fasta index file (default: <input.fasta>.fai).

Input query profiles:
  --hmm2 HMM2           Input query hmm file (HMMER2 file format).
  --hmm3 HMM3           Input query hmm file (HMMER3 file format).
  --seed SEED           Input query seed alignment file (stockholm or fasta
                        format).

Presearch:
  --presearch-slop PRESEARCH_SLOP
                        Size of flanking regions next to presearch hits in
                        which to search (default: 3000).
  -b BED, --bed BED     Skip presearch step and use a bed file to limit search
                        regions.
  --full-search         Skip presearch step and run genewise on the whole
                        input fasta. WARNING: this can take a very long time.

Runtime/output:
  -p PROCS, --procs PROCS
                        Number of processor threads to use for running HMMER
                        and GeneWise.
  -o OUTDIR, --outdir OUTDIR
                        Output directory. Defaults to current working
                        directory.
  --prefix PREFIX       Prefix for output files (default: "dvorfs").
  -d WORKDIR, --workdir WORKDIR
                        Directory in which DVORFS will save files during a run
                        (default: <outdir>/dvorfs.tmp).
  -k, --keep-workdir    Do not delete the temporary working directory after
                        DVORFS has finished.
  --nuc-tsv             Nucleotide sequences with comma seperated codons are
                        inlcuded in the output tsv.
  --full-tsv            Extra columns containing postprocessing details are
                        included in the output tsv.
  --noali               Do not output explicit codon alignments of hits.

Hit postprocessing and filtering:
  --nomerge             Adjacent GeneWise hits will not be merged.
  --merge-distance MERGE_DISTANCE
                        Maximum allowed distance between GeneWise hits to be
                        merged.
  --filter {all,no-overlap,best-per}
                        all: All hits are kept (default). no_overlap: Hits are
                        removed if they are overlapped by a better hit from a
                        different query. best_per: Only the highest scoring
                        hit per contig is kept.
  --hit-mask HIT_MASK   Three column TSV file for filtering out hits based on
                        query regions.
  --bit-cutoff BIT_CUTOFF
                        Bit score threshold for reported hits (default: 15.0).
  --length-cutoff LENGTH_CUTOFF
                        Length threshold (no. of codons) for reported hits
                        (default: 30).
```

