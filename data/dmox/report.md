# dmox CWL Generation Report

## dmox

### Tool Description
Demultiplex reads based on their sequenced index barcodes for haplotagging.
Supposed to match the `demultiplex` step of Harpy's pipeline:
    https://pdimens.github.io/harpy/workflows/demultiplex/

### Metadata
- **Docker Image**: quay.io/biocontainers/dmox:0.2.1--h3ab6199_0
- **Homepage**: https://gitlab.mbb.cnrs.fr/ibonnici/dmox
- **Package**: https://anaconda.org/channels/bioconda/packages/dmox/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dmox/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-05-14
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Demultiplex reads based on their sequenced index barcodes for haplotagging.
Supposed to match the `demultiplex` step of Harpy's pipeline:
    https://pdimens.github.io/harpy/workflows/demultiplex/


Usage: dmox [OPTIONS] --i1 <I1> --i2 <I2> --r1 <R1> --r2 <R2> --ref-a <REF_A> --ref-b <REF_B> --ref-c <REF_C> --ref-d <REF_D> --schema <SCHEMA> --samples <SAMPLES> --barcodes-table <BARCODES_TABLE>

Options:
      --i1 <I1>
          Forward indexes .fastq.gz file
      --i2 <I2>
          Reverse indexes .fastq.gz file
      --r1 <R1>
          Forward reads .fastq.gz file
      --r2 <R2>
          Reverse reads .fastq.gz file
      --ref-a <REF_A>
          Reference 'A' barcode modules
      --ref-b <REF_B>
          Reference 'B' barcode modules
      --ref-c <REF_C>
          Reference 'C' barcode modules
      --ref-d <REF_D>
          Reference 'D' barcode modules
      --distance <DISTANCE>
          Distance metric to use when matching modules against references [default: levenshtein] [possible values: hamming, levenshtein]
      --max-distance <MAX_DISTANCE>
          If set, reject modules matching references with a distance higher than this threshold
      --schema <SCHEMA>
          Schema file mapping sample ids to barcode sample modules with the same letter
      --samples <SAMPLES>
          Desired output folder for the resulting sample files. Created if missing
      --undetermined-barcodes <UNDETERMINED_BARCODES>
          Optional output filename stub to collect reads with undetermined barcode. For example `--undetermined-barcode nomatch` will produce `./nomatch.R1.fq.gz` and `./nomatch.R2.fq.gz`
      --undetermined-samples <UNDETERMINED_SAMPLES>
          Optional output filename stub to collect reads with determined barcodes but undetermined samples, because the barcodes where missing from the schema
      --bx [<BX>]
          Raise to output BX codes as part of demultiplexed fastq identifiers [default: true] [possible values: true, false]
      --rx [<RX>]
          Raise to output RX codes as part of demultiplexed fastq identifiers [default: false] [possible values: true, false]
      --qx [<QX>]
          Raise to output QX codes as part of demultiplexed fastq identifiers [default: false] [possible values: true, false]
      --id-tail [<ID_TAIL>]
          Raise to output the last part of original fastq identifiers [default: false] [possible values: true, false]
      --barcodes-table <BARCODES_TABLE>
          Where to write the file summarizing assigned / unassigned barcodes
      --n-modules <N_MODULES>
          Total number of reference barcode modules for each letter [default: 96]
      --module-size <MODULE_SIZE>
          Size of one barcode module [default: 6]
      --multiple-samples-per-barcode
          Raise to allow that a sample be fed from several different barcodes. (So it appears several times in the schema file.)
      --zlevel <ZLEVEL>
          Desired output compression level (defaults to gzip's default) [default: 6]
      --n-writers <N_WRITERS>
          Number of threads to spawn for zipping + writing output sample files. Defaults to the number of available cores on the machine
      --writers-capacity <WRITERS_CAPACITY>
          Size of memory buffers for accumulation before writing to disk [default: 1048576]
      --max-queued-blocks <MAX_QUEUED_BLOCKS>
          Stop reading input files if this number of fastq blocks are queued in memory, still waiting for a writer to pick them up. Increase to improve performance *provided you have enough RAM* [default: 65536]
      --readers-channel-capacity <READERS_CHANNEL_CAPACITY>
          Number of fastq blocks to read before blocking when the above limit is hit. Don't tweak without profiling performances [default: 256]
  -h, --help
          Print help
  -V, --version
          Print version
```

