# nanospring CWL Generation Report

## nanospring_NanoSpring

### Tool Description
No input file specified

### Metadata
- **Docker Image**: quay.io/biocontainers/nanospring:0.2--h43eeafb_2
- **Homepage**: https://github.com/qm2/NanoSpring
- **Package**: https://anaconda.org/channels/bioconda/packages/nanospring/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/nanospring/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/qm2/NanoSpring
- **Stars**: N/A
### Original Help Text
```text
No input file specified
Allowed options:
  -h [ --help ]                   produce help message
  -c [ --compress ]               compress
  -d [ --decompress ]             decompress
  -i [ --input-file ] arg         input file name
  -o [ --output-file ] arg        output file name
  -t [ --num-threads ] arg (=20)  number of threads (default 20)
  -k [ --kmer ] arg (=23)         kmer size for the minhash (default 23)
  -n [ --num-hash ] arg (=60)     number of hash functions for minhash (default
                                  60)
  --overlap-sketch-thr arg (=6)   the overlap sketch threshold for minhash 
                                  (default 6)
  --minimap-k arg (=20)           kmer size for the minimap2 (default 20)
  --minimap-w arg (=50)           window size for the minimap2 (default 50)
  --max-chain-iter arg (=400)     the max number of partial chains during 
                                  chaining for minimap2 (default 400)
  --edge-thr arg (=4000000)       the max number of edges allowed in a 
                                  consensus graph (default 4000000)
  -w [ --working-dir ] arg (=.)   directory to create temporary files (default 
                                  current directory)
  --decompression-memory arg (=5) attempt to set peak memory usage for 
                                  decompression in GB (default 5 GB) by using 
                                  disk-based sort for writing reads in the 
                                  correct order. This is only approximate and 
                                  might have no effect at very low settings or 
                                  with large number of threads when another 
                                  decompressor stage is the biggest memory 
                                  contributor. Very low values might lead to 
                                  slight reduction in speed.
```

