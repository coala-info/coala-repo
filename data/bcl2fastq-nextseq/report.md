# bcl2fastq-nextseq CWL Generation Report

## bcl2fastq-nextseq_bcl_to_fastq

### Tool Description
Runs bcl2fastq2, creating fastqs and concatenating fastqs across lanes.
  Undetermined files are deleted by default.

  Any arguments not matching those outlined below will be sent to the
  `bcl2fastq` call.

### Metadata
- **Docker Image**: quay.io/biocontainers/bcl2fastq-nextseq:1.3.0--pyh5e36f6f_0
- **Homepage**: https://github.com/brwnj/bcl2fastq
- **Package**: https://anaconda.org/channels/bioconda/packages/bcl2fastq-nextseq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/bcl2fastq-nextseq/overview
- **Total Downloads**: 19.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brwnj/bcl2fastq
- **Stars**: N/A
### Original Help Text
```text
Usage: bcl_to_fastq [OPTIONS] [BCL2FASTQ_ARGS]...

  Runs bcl2fastq2, creating fastqs and concatenating fastqs across lanes.
  Undetermined files are deleted by default.

  Any arguments not matching those outlined below will be sent to the
  `bcl2fastq` call.

Options:
  -i, --input-dir TEXT          path to input directory; default is RUNFOLDER-
                                DIR/Data/Intensities/BaseCalls
  -R, --runfolder-dir TEXT      path to directory containing run data
                                [default: /]
  -o, --output-dir TEXT         path to demultiplexed output; default is same
                                as INPUT-DIR
  --sample-sheet TEXT           file path to sample sheet; default is
                                RUNFOLDER-DIR/SampleSheet.csv
  --loading INTEGER             number of threads used for loading BCL data
                                [default: 12]
  --processing INTEGER          number of threads used for processing
                                demultiplexed data  [default: 24]
  --writing INTEGER             number of threads used for writing FASTQ data
                                [default: 12]
  --barcode-mismatches INTEGER  number of allowed mismatches per index
                                [default: 0]
  --keep-tmp                    save Undetermined reads  [default: False]
  --reverse-complement          reverse complement index 2 of the sample sheet
                                [default: False]
  --no-wait                     process the run without checking its
                                completion status  [default: False]
  --overwrite                   overwrite existing fastq files in the output
                                directory  [default: False]
  --determine                   use barcodes in samplesheet as well as the
                                reverse complement of index 2, then
                                demultiplex with best  [default: False]
  --no-cleanup                  skip all cleaning up -- do not rename fastq
                                output and do not delete undetermined files
                                [default: False]
  --delay INTEGER               number of seconds to sleep after finding
                                RTAComplete.txt -- applies only when waiting
                                for a run to complete  [default: 14400]
  -h, --help                    Show this message and exit.
```

