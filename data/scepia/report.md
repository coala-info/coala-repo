# scepia CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scepia_area27 | Failed | image problem: scepia crashes at import (numba SystemError: initialization of _internal failed) |
| scepia_infer_motifs | Failed | image problem: scepia crashes at import (numba SystemError: initialization of _internal failed) |

## scepia_area27

### Tool Description
Determine the enhancer-based regulatory potential (ERP) score per gene from H3K27ac signal.

### Metadata
- **Docker Image**: quay.io/biocontainers/scepia:0.5.1--pyhdfd78af_1
- **Homepage**: https://github.com/vanheeringen-lab/scepia
- **Package**: https://anaconda.org/channels/bioconda/packages/scepia/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scepia area27 [OPTIONS] BAMFILE OUTFILE

  Determine the enhancer-based regulatory potential (ERP) score per gene.
  This approach is based on the method developed by Wang et al., 2016.
  There is one difference. In this implementation the score is calculated
  based only on H3K27ac signal in enhancers. We use log-transformed, z-score
  normalized H3K27ac read counts in 2kb windows centered at enhancer
  locations.

Options:
  -w, --window TEXT    window
  -N, --nthreads TEXT  Number of threads.
  -h, --help           Show this message and exit.

(Reconstructed from the scepia source code: the image crashes at import, so the
program cannot print its own help.)
```

## scepia_infer_motifs

### Tool Description
Run SCEPIA motif inference on any scanpy-compatible file.

### Metadata
- **Docker Image**: quay.io/biocontainers/scepia:0.5.1--pyhdfd78af_1
- **Homepage**: https://github.com/vanheeringen-lab/scepia
- **Package**: https://anaconda.org/channels/bioconda/packages/scepia/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: scepia infer_motifs [OPTIONS] INFILE OUTDIR

  Infer motifs.

Options:
  --transpose              Transpose matrix.
  -c, --cluster TEXT       cluster name (default checks for 'louvain' or 'leiden').
  -d, --dataset TEXT       Reference dataset (ENCODE.H3K27ac.human).
  -n, --n_top_genes INTEGER  Maximum number of variable genes that is used (2000).
  -p, --pfmfile TEXT       Name of motif PFM file or GimmeMotifs database name.
  -a, --min_annotated INTEGER  Minimum number of cells per cell type (50).
  -e, --num_enhancers INTEGER  Number of enhancers to use for motif activity (10000).
  -h, --help               Show this message and exit.

(Reconstructed from the scepia source code: the image crashes at import, so the
program cannot print its own help.)
```

