# pbfusion CWL Generation Report

## pbfusion_discover

### Tool Description
Identify fusion genes in aligned PacBio Iso-Seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/pbfusion:0.5.1--hdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/pbfusion
- **Package**: https://anaconda.org/channels/bioconda/packages/pbfusion/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pbfusion/overview
- **Total Downloads**: 9.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/pbfusion
- **Stars**: N/A
### Original Help Text
```text
Identify fusion genes in aligned PacBio Iso-Seq data

Usage: pbfusion discover [OPTIONS] --gtf <REF> --output-prefix <OUTPUT> [FILE]...

Arguments:
  [FILE]...
          

Options:
  -b <ADDITIONAL_BAMS>
          Aligned Iso-Seq data in BAM format. Accepts a path to a bam, a url (if compiled with curl support), or a fofn (file-of-filenames) file with one filename or url per line

  -g, --gtf <REF>
          Reference gene annotations in GTF format. We also accept `gtf.bin` files as built by `pbfusion gff-cache`. This file must have `bin` as its suffix to be recognized. We also support gtf.bin.xz and gtf.bin.gz, compressed by xz and gzip, respectively. Recognition is based entirely on filename.
          
          Warning: the binary cached format has been altered since 0.3.3. You may need to re-generate your binary annotations.

  -o, --output-prefix <OUTPUT>
          Output prefix
          
          [default: none]

  -Q, --min-fusion-quality <MIN_FUSION_QUALITY>
          Determine the minimum fusion quality to emit. Choices: must be LOW or MEDIUM
          
          [default: MEDIUM]

  -t, --threads <THREADS>
          Number of threads. Defaults to available parallelism
          
          [default: 0]

  -c, --min-coverage <MIN_COVERAGE>
          Real-cell filtering for single-cell data. Iso-Seq reads annotated with zero "rc" tag value will be filtered. Assigns "low confidence" to fusion calls with read coverage below the minimum coverage threshold
          
          [default: 2]

  -i, --min-mean-identity <MIN_MEAN_IDENTITY>
          Assigns "low confidence" to fusion calls where the mean alignment identity is below the threshold
          
          [default: 0.93]

  -p, --min-mean-mapq <MIN_MEAN_MAPQ>
          Assigns "low confidence" to fusion calls where the mean mapq is below the threshold
          
          [default: 10]

  -M, --min-fusion-read-fraction <MIN_FUSION_READ_FRACTION>
          Remove breakpoint pairs from groups if they have gene alignments which fewer than \[arg\] reads in group have
          
          [default: 0.25]

  -s, --max-variability <MAX_VARIABILITY>
          Assigns "low confidence" to fusion calls with the mean breakpoint distance is above the threshold
          
          [default: 1000]

  -a, --max-readthrough <MAX_READTHROUGH>
          Assigns "low confidence" to fusion calls spanning two genes below the readthrough threshold.
          
          [default: 100000]

  -m, --max-genes-in-event <MAX_GENES_IN_EVENT>
          Mark fusion groups involving > \[arg\] genes as low quality. This is a common source of false positives
          
          [default: 3]

  -r, --real-cell-filtering
          

      --allow-immune
          Permit fusion events identified involving primarily immunological genes and their pseudogenes.
          These are a common source of false positives and we mark them low-quality by default.

      --allow-mito
          Permit fusion events identified involving mitochondrial genes.
          These are a common source of false positives and we mark them low-quality by default.

      --prom-filter <PROM_FILTER>
          Filter rarer events involving genes with high numbers of fusion partners.
          These are a common source of false positives.
          Disable by setting `--prom-filter 0`.
          
          [default: 8]

      --gtf-transcript-allow-lncRNA
          Allow fusion partners to contain lncRNA annotations

      --min-fusion-fraction <MIN_FUSION_FRACTION>
          Minimum fusion fraction relative to transcript count
          
          [default: 0.01]

  -v, --verbose...
          Enable verbose output

      --log-level <LOG_LEVEL>
          Alternative to repeated -v/--verbose: set log level via key.
          Values: "error", "warn" (default), "info", "debug", "trace".
          Enabling any level higher than "warn" also emits verbose output, including extra output files.
          If -v/--verbose is set, this option is ignored.
          Equivalence to -v/--verbose:
                => "WARN"
             -v => "INFO"
            -vv => "DEBUG"
           -vvv => "TRACE"
          
          There is no equivalent to --log-level ERROR
          
          [default: error]

  -h, --help
          Print help information (use `-h` for a summary)

  -V, --version
          Print version information

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## pbfusion_gff-cache

### Tool Description
Cache exonic information from a gtf/gff file in binary format for faster `pbfusion discover` invocations.

### Metadata
- **Docker Image**: quay.io/biocontainers/pbfusion:0.5.1--hdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/pbfusion
- **Package**: https://anaconda.org/channels/bioconda/packages/pbfusion/overview
- **Validation**: PASS

### Original Help Text
```text
Cache exonic information from a gtf/gff file in binary format for faster `pbfusion discover` invocations.

Usage: pbfusion gff-cache [OPTIONS] --gtf <ReferenceAnnotation>

Options:
  -g, --gtf <ReferenceAnnotation>
          Input GTF file

  -b, --gtf-out <BinaryReferenceAnnotation>
          Output binary GTF file
          
          [default: *]

      --gtf-transcript-allow-lncRNA
          Allow fusion partners to contain lncRNA annotations

  -v, --verbose...
          Enable verbose output

      --log-level <LOG_LEVEL>
          Alternative to repeated -v/--verbose: set log level via key.
          Values: "error", "warn" (default), "info", "debug", "trace".
          Enabling any level higher than "warn" also emits verbose output, including extra output files.
          If -v/--verbose is set, this option is ignored.
          Equivalence to -v/--verbose:
                => "warn"
             -v => "info"
            -vv => "debug"
           -vvv => "trace"
          
          There is no equivalent to --log-level error
          
          [default: error]

  -h, --help
          Print help information (use `-h` for a summary)

  -V, --version
          Print version information

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated
