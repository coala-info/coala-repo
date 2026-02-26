# spring CWL Generation Report

## spring

### Tool Description
Exactly one of compress or decompress needs to be specified

### Metadata
- **Docker Image**: quay.io/biocontainers/spring:1.1.1--h4ac6f70_3
- **Homepage**: https://github.com/shubhamchandak94/Spring
- **Package**: https://anaconda.org/channels/bioconda/packages/spring/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/spring/overview
- **Total Downloads**: 13.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/shubhamchandak94/Spring
- **Stars**: N/A
### Original Help Text
```text
Exactly one of compress or decompress needs to be specified 
Allowed options:
  -h [ --help ]                   produce help message
  -c [ --compress ]               compress
  -d [ --decompress ]             decompress
  --decompress-range arg          --decompress-range start end
                                  (optional) decompress only reads (or read 
                                  pairs for PE datasets) from start to end 
                                  (both inclusive) (1 <= start <= end <= 
                                  num_reads (or num_read_pairs for PE)). If -r 
                                  was specified during compression, the range 
                                  of reads does not correspond to the original 
                                  order of reads in the FASTQ file.
  -i [ --input-file ] arg         input file name (two files for paired end)
  -o [ --output-file ] arg        output file name (for paired end 
                                  decompression, if only one file is specified,
                                  two output files will be created by suffixing
                                  .1 and .2.)
  -w [ --working-dir ] arg (=.)   directory to create temporary files (default 
                                  current directory)
  -t [ --num-threads ] arg (=8)   number of threads (default 8)
  -r [ --allow-read-reordering ]  do not retain read order during compression 
                                  (paired reads still remain paired)
  --no-quality                    do not retain quality values during 
                                  compression
  --no-ids                        do not retain read identifiers during 
                                  compression
  -q [ --quality-opts ] arg       quality mode: possible modes are
                                  1. -q lossless (default)
                                  2. -q qvz qv_ratio (QVZ lossy compression, 
                                  parameter qv_ratio roughly corresponds to 
                                  bits used per quality value)
                                  3. -q ill_bin (Illumina 8-level binning)
                                  4. -q binary thr high low (binary (2-level) 
                                  thresholding, quality binned to high if >= 
                                  thr and to low if < thr)
  -l [ --long ]                   Use for compression of arbitrarily long read 
                                  lengths. Can also provide better compression 
                                  for reads with significant number of indels. 
                                  -r disabled in this mode. For Illumina short 
                                  reads, compression is better without -l flag.
  -g [ --gzipped-fastq ]          enable if compression input is gzipped fastq 
                                  or to output gzipped fastq during 
                                  decompression
  --gzip-level arg (=6)           gzip level (0-9) to use during decompression 
                                  if -g flag is specified (default: 6)
  --fasta-input                   enable if compression input is fasta file 
                                  (i.e., no qualities)
```

