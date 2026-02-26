# dartunifrac-gpu CWL Generation Report

## dartunifrac-gpu_dartunifrac-cuda

### Tool Description
Approximate UniFrac via Weighted MinHash 🎯🎯🎯

### Metadata
- **Docker Image**: quay.io/biocontainers/dartunifrac-gpu:0.3.0--hd7384ae_0
- **Homepage**: https://github.com/jianshu93/DartUniFrac
- **Package**: https://anaconda.org/channels/bioconda/packages/dartunifrac-gpu/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dartunifrac-gpu/overview
- **Total Downloads**: 597
- **Last updated**: 2026-02-04
- **GitHub**: https://github.com/jianshu93/DartUniFrac
- **Stars**: N/A
### Original Help Text
```text
************** initializing logger *****************

DartUniFrac: Approximate UniFrac via Weighted MinHash 🎯🎯🎯

Usage: dartunifrac-cuda [OPTIONS] --tree <tree> <--input <input>|--biom <biom>>

Options:
  -t, --tree <tree>
          Input tree in Newick format

  -i, --input <input>
          OTU/Feature table in TSV format

  -b, --biom <biom>
          OTU/Feature table in BIOM (HDF5) format

  -o, --output <output>
          Output distance matrix in TSV format
          
          [default: unifrac.tsv]

      --weighted
          Weighted UniFrac (normalized)

      --succ
          Use succparen balanced-parentheses tree representation

  -s, --sketch <sketch-size>
          Sketch size for Weighted MinHash (DartMinHash or ERS)
          
          [default: 2048]

  -m, --method <method>
          Sketching method: dmh (DartMinHash) or ers (Efficient Rejection Sampling)
          
          [default: dmh]
          [possible values: dmh, ers]

      --bbits <bbits>
          Extract lower bits from hashes. Supported: 16 (default), 32, 64.
          
          [default: 16]

  -l, --length <seq-length>
          Per-hash independent random sequence length for ERS, must be >= 512
          
          [default: 2048]

  -T, --threads <threads>
          Number of threads, default all logical cores

      --seed <seed>
          Random seed for reproducibility
          
          [default: 1337]

      --compress
          Compress output with zstd, .zst suffix will be added to the output file name

      --pcoa
          Fast Principal Coordinate Analysis based on Randomized SVD (subspace iteration), output saved to pcoa.txt/ordination.txt

      --streaming
          Streaming the distance matrix while computing (zstd-compressed)

      --block <block>
          Number of rows per chunk, streaming mode only

      --gpu-streaming
          Streaming the distance matrix to disk block by block (multi-GPU support); available only with the 'cuda' feature

      --tile-cols <tile-cols>
          Number of columns per GPU tile in gpu-streaming mode
          
          [default: 1024]

      --tile-rows <tile-rows>
          Number of rows per GPU tile in gpu-streaming mode
          
          [default: 1024]

  -h, --help
          Print help (see a summary with '-h')

  -V, --version
          Print version


Citations:
  For DartUniFrac, please see:
  Zhao J. et.al., 2025, DOI:
```

