# nohuman CWL Generation Report

## nohuman

### Tool Description
Remove human reads from a sequencing run

### Metadata
- **Docker Image**: quay.io/biocontainers/nohuman:0.5.0--hbbf5808_0
- **Homepage**: https://github.com/mbhall88/nohuman
- **Package**: https://anaconda.org/channels/bioconda/packages/nohuman/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nohuman/overview
- **Total Downloads**: 3.8K
- **Last updated**: 2025-11-21
- **GitHub**: https://github.com/mbhall88/nohuman
- **Stars**: N/A
### Original Help Text
```text
Remove human reads from a sequencing run

Usage: nohuman [OPTIONS] [INPUT]...

Arguments:
  [INPUT]...
          Input file(s) to remove human reads from

Options:
  -o, --out1 <OUTPUT_1>
          First output file.
          
          Defaults to the name of the first input file with the suffix "nohuman" appended.
          e.g. "input_1.fastq" -> "input_1.nohuman.fq".
          Compression of the output file is determined by the file extension of the output file name.
          Or by using the `--output-type` option. If no output path is given, the same compression
          as the input file will be used.

  -O, --out2 <OUTPUT_2>
          Second output file.
          
          Defaults to the name of the first input file with the suffix "nohuman" appended.
          e.g. "input_2.fastq" -> "input_2.nohuman.fq".
          Compression of the output file is determined by the file extension of the output file name.
          Or by using the `--output-type` option. If no output path is given, the same compression
          as the input file will be used.

  -c, --check
          Check that all required dependencies are available and exit

  -d, --download
          Download the database

  -D, --db <PATH>
          Path to the database
          
          [env: NOHUMAN_DB=]
          [default: /root/.nohuman/db]

      --db-version <VERSION>
          Name of the database version to use (defaults to the newest installed). When used with `--download`, passing `all` downloads every available version

      --list-db-versions
          List available database versions and exit

  -F, --output-type <FORMAT>
          Output compression format. u: uncompressed; b: Bzip2; g: Gzip; x: Xz (Lzma); z: Zstd
          
          If not provided, the format will be inferred from the given output file name(s), or the
          format of the input file(s) if no output file name(s) are given.

  -t, --threads <INT>
          Number of threads to use in kraken2 and optional output compression. Cannot be 0
          
          [default: 1]

  -H, --human
          Output human reads instead of removing them

  -C, --conf <[0, 1]>
          Kraken2 minimum confidence score
          
          [default: 0.0]

  -k, --kraken-output <FILE>
          Write the Kraken2 read classification output to a file

  -r, --kraken-report <FILE>
          Write the Kraken2 report with aggregate counts/clade to file

  -v, --verbose
          Set the logging level to verbose

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version
```

