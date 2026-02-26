# repaq CWL Generation Report

## repaq

### Tool Description
repack FASTQ to a smaller binary file (.rfq)

### Metadata
- **Docker Image**: quay.io/biocontainers/repaq:0.5.1--hcb620b3_1
- **Homepage**: https://github.com/OpenGene/repaq
- **Package**: https://anaconda.org/channels/bioconda/packages/repaq/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/repaq/overview
- **Total Downloads**: 7.1K
- **Last updated**: 2025-11-19
- **GitHub**: https://github.com/OpenGene/repaq
- **Stars**: N/A
### Original Help Text
```text
repaq: repack FASTQ to a smaller binary file (.rfq)
version 0.5.1
usage: repaq [options] ... 
options:
  -i, --in1                    input file name (string [=])
  -o, --out1                   output file name (string [=])
  -I, --in2                    read2 input file name when encoding paired-end FASTQ files (string [=])
  -O, --out2                   read2 output file name when decoding to paired-end FASTQ files (string [=])
  -c, --compress               compress input to output
  -d, --decompress             decompress input to output
  -k, --chunk                  the chunk size (kilo bases) for encoding, default 1000=1000kb. (int [=1000])
      --stdin                  input from STDIN. If the STDIN is interleaved paired-end FASTQ, please also add --interleaved_in.
      --stdout                 write to STDOUT. When decompressing PE data, this option will result in interleaved FASTQ output for paired-end input. Disabled by defaut.
      --interleaved_in         indicate that <in1> is an interleaved paired-end FASTQ which contains both read1 and read2. Disabled by defaut.
  -v, --verify                 verify the output stream to ensure compression is correct.
  -f, --fast_verify            only verify part (10%) of the output stream to save time.
  -p, --compare                compare the files read by read to check the compression consistency. <rfq_to_compare> should be specified in this mode.
  -r, --rfq_to_compare         the RFQ file to be compared with the input. This option is only used in compare mode. (string [=])
  -j, --json_compare_result    the file to store the comparison result. This is optional since the result is also printed on STDOUT. (string [=])
  -t, --thread                 thread number for xz compression. Higher thread num means higher speed and lower compression ratio (1~16), default 1. (int [=1])
  -z, --compression            compression level. Higher level means higher compression ratio, and more RAM usage (1~9), default 4. (int [=4])
  -?, --help                   print this message
```

