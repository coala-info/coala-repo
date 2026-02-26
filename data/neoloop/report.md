# neoloop CWL Generation Report

## neoloop_calculate-cnv

### Tool Description
Calculate the copy number variation profile from Hi-C map using a generalized additive model with the Poisson link function

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Total Downloads**: 1.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Stars**: N/A
### Original Help Text
```text
usage: calculate-cnv [-h] [-v] [-H HIC] [-g {hg19,hg38,mm9,mm10}]
                     [-e {HindIII,MboI,DpnII,Arima,BglII,uniform}]
                     [--output OUTPUT] [--cachefolder CACHEFOLDER]
                     [--logFile LOGFILE]

Calculate the copy number variation profile from Hi-C map using a generalized
additive model with the Poisson link function

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -H HIC, --hic HIC     Cool URI. (default: None)
  -g {hg19,hg38,mm9,mm10}, --genome {hg19,hg38,mm9,mm10}
                        Reference genome name. (default: hg38)
  -e {HindIII,MboI,DpnII,Arima,BglII,uniform}, --enzyme {HindIII,MboI,DpnII,Arima,BglII,uniform}
                        The restriction enzyme name used in the Hi-C
                        experiment. If the genome was cutted using a sequence-
                        independent/uniform-cutting enzyme, please consider
                        setting this parameter to "uniform". (default: MboI)
  --output OUTPUT       Output file path. (default: None)
  --cachefolder CACHEFOLDER
                        Cache folder. We suggest keep this setting the same
                        between different runs. (default: .cache)
  --logFile LOGFILE     Logging file name. (default: cnv-calculation.log)
```


## neoloop_segment-cnv

### Tool Description
Perform HMM segmentation on a pre-calculated copy number variation profile.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: segment-cnv [-h] [-v] [--cnv-file CNV_FILE] [--ploidy PLOIDY]
                   [--binsize BINSIZE] [--num-of-states NUM_OF_STATES]
                   [--cbs-pvalue CBS_PVALUE] [--max-dist MAX_DIST]
                   [--min-diff MIN_DIFF] [--min-segment-size MIN_SEGMENT_SIZE]
                   [--output OUTPUT] [--nproc NPROC] [--logFile LOGFILE]

Perform HMM segmentation on a pre-calculated copy number variation profile.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  --cnv-file CNV_FILE   Copy number profile in bedGraph format. (default:
                        None)
  --ploidy PLOIDY       Ploidy of the cell. (default: 2)
  --binsize BINSIZE     Bin size in base pairs. (default: None)
  --num-of-states NUM_OF_STATES
                        The number of states to initialize. By default, this
                        number is estimated using a Gaussian Mixture model and
                        the AIC criterion. (default: None)
  --cbs-pvalue CBS_PVALUE
                        The P-value cutoff used in the circular binary
                        segmentation (CBS) algorithm. (default: 1e-05)
  --max-dist MAX_DIST   Maximum allowed distance between HMM and CBS
                        breakpoints. (default: 4)
  --min-diff MIN_DIFF   Minimum copy number difference between neighboring
                        segments. Two neighboring segments will be merged
                        together if the difference of their copy number ratio
                        is less than this value. (default: 0.4)
  --min-segment-size MIN_SEGMENT_SIZE
                        Minimum segment size. Small segments with a size less
                        than this number of bins will be merged with nearby
                        larger segments. (default: 3)
  --output OUTPUT       Output file path. (default: None)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: cnv-seg.log)
```


## neoloop_assemble-complexSVs

### Tool Description
Assemble complex SVs given an individual SV list.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: assemble-complexSVs [-h] [-v] [-O OUTPUT] [-B BREAK_POINTS]
                           [-H HIC [HIC ...]] [-R REGION_SIZE]
                           [--minimum-size MINIMUM_SIZE]
                           [--balance-type {CNV,ICE}]
                           [--protocol {insitu,dilution}] [--nproc NPROC]
                           [--logFile LOGFILE]

Assemble complex SVs given an individual SV list.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -O OUTPUT, --output OUTPUT
                        Output prefix. (default: None)
  -B BREAK_POINTS, --break-points BREAK_POINTS
                        Path to a TXT file containing pairs of break points.
                        (default: None)
  -H HIC [HIC ...], --hic HIC [HIC ...]
                        List of cooler URIs. If URIs at multiple resolutions
                        are provided, the program will first detect complex
                        SVs from each individual resolution, and then combine
                        results from all resolutions in a non-redundant way.
                        (default: None)
  -R REGION_SIZE, --region-size REGION_SIZE
                        The extended genomic span of SV break points.(bp)
                        (default: 5000000)
  --minimum-size MINIMUM_SIZE
                        For intra-chromosomal SVs, only SVs that are larger
                        than this size will be considered by the pipeline.
                        (default: 500000)
  --balance-type {CNV,ICE}
                        Normalization method. (default: CNV)
  --protocol {insitu,dilution}
                        Experimental protocol of your Hi-C. (default: insitu)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: assembleSVs.log)
```


## neoloop_neoloop-caller

### Tool Description
Identify novel loop interactions across SV points.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neoloop-caller [-h] [-v] [-O OUTPUT] [-H HIC [HIC ...]]
                      [--assembly ASSEMBLY] [--cachefolder CACHEFOLDER]
                      [-R REGION_SIZE] [--balance-type {CNV,ICE}]
                      [--protocol {insitu,dilution}] [--prob PROB]
                      [--no-clustering]
                      [--min-marginal-peaks MIN_MARGINAL_PEAKS]
                      [--nproc NPROC] [--logFile LOGFILE]

Identify novel loop interactions across SV points.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -O OUTPUT, --output OUTPUT
                        Path to the output file. (default: None)
  -H HIC [HIC ...], --hic HIC [HIC ...]
                        List of cooler URIs. If URIs at multiple resolutions
                        are provided, the program will first detect neo-loops
                        from each individual resolution, and then combine
                        results from all resolutions in a non-redundant way.
                        If an interaction is detected as a loop in multiple
                        resolutions, only the one with the highest resolution
                        will be recorded. (default: None)
  --assembly ASSEMBLY   The assembled SV list outputed by assemble-complexSVs.
                        (default: None)
  --cachefolder CACHEFOLDER
                        Path to a folder to place the pre-trained Peakachu
                        models. This command will automatically download
                        appropriate models according to the sequencing depths
                        and resolutions of your input Hi-C matrices. (default:
                        .cache)
  -R REGION_SIZE, --region-size REGION_SIZE
                        The extended genomic span of SV break points.(bp)
                        (default: 3000000)
  --balance-type {CNV,ICE}
                        Normalization method. (default: CNV)
  --protocol {insitu,dilution}
                        Experimental protocol of your Hi-C. (default: insitu)
  --prob PROB           Probability threshold. (default: 0.9)
  --no-clustering       No pooling will be performed if specified. (default:
                        False)
  --min-marginal-peaks MIN_MARGINAL_PEAKS
                        Minimum marginal number of loops when detecting loop
                        anchors. (default: 2)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: neoloop.log)
```


## neoloop_neotad-caller

### Tool Description
Identify neo-TADs.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: neotad-caller [-h] [-v] [-O OUTPUT] [-H HIC] [--assembly ASSEMBLY]
                     [-R REGION_SIZE] [--balance-type {CNV,ICE}]
                     [--protocol {insitu,dilution}]
                     [--window-size WINDOW_SIZE] [--nproc NPROC]
                     [--logFile LOGFILE]

Identify neo-TADs.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -O OUTPUT, --output OUTPUT
                        Output path. (default: None)
  -H HIC, --hic HIC     Cooler URI. (default: None)
  --assembly ASSEMBLY   The assembled SV list outputed by assemble-complexSVs.
                        (default: None)
  -R REGION_SIZE, --region-size REGION_SIZE
                        The extended genomic span of SV break points.(bp)
                        (default: 3000000)
  --balance-type {CNV,ICE}
                        Normalization method. (default: CNV)
  --protocol {insitu,dilution}
                        Experimental protocol of your Hi-C. (default: insitu)
  --window-size WINDOW_SIZE
                        Window size for calculating DI. (default: 2000000)
  --nproc NPROC         Number of worker processes. (default: 1)
  --logFile LOGFILE     Logging file name. (default: neotad.log)
```


## neoloop_add_prefix_to_cool.py

### Tool Description
Adds a prefix to the chromosome names in a .cool file.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/add_prefix_to_cool.py", line 7, in <module>
    clr = cooler.Cooler(in_cool)
  File "/usr/local/lib/python3.10/site-packages/cooler/api.py", line 85, in __init__
    self._refresh()
  File "/usr/local/lib/python3.10/site-packages/cooler/api.py", line 89, in _refresh
    with open_hdf5(self.store, **self.open_kws) as h5:
  File "/usr/local/lib/python3.10/contextlib.py", line 135, in __enter__
    return next(self.gen)
  File "/usr/local/lib/python3.10/site-packages/cooler/util.py", line 525, in open_hdf5
    fh = h5py.File(fp, mode, *args, **kwargs)
  File "/usr/local/lib/python3.10/site-packages/h5py/_hl/files.py", line 562, in __init__
    fid = make_fid(name, mode, userblock_size, fapl, fcpl, swmr=swmr)
  File "/usr/local/lib/python3.10/site-packages/h5py/_hl/files.py", line 235, in make_fid
    fid = h5f.open(name, flags, fapl=fapl)
  File "h5py/_objects.pyx", line 54, in h5py._objects.with_phil.wrapper
  File "h5py/_objects.pyx", line 55, in h5py._objects.with_phil.wrapper
  File "h5py/h5f.pyx", line 102, in h5py.h5f.open
FileNotFoundError: [Errno 2] Unable to synchronously open file (unable to open file: name = '--help', errno = 2, error message = 'No such file or directory', flags = 0, o_flags = 0)
```


## neoloop_searchSVbyGene

### Tool Description
Search matched SV regions by gene.

### Metadata
- **Docker Image**: quay.io/biocontainers/neoloop:0.4.3.post2--pyhdfd78af_0
- **Homepage**: https://github.com/XiaoTaoWang/NeoLoopFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/neoloop/overview
- **Validation**: PASS

### Original Help Text
```text
usage: searchSVbyGene [-h] [-v] [-L LOOP_FILE] [-G GENE_NAME]
                      [--ensembl-release ENSEMBL_RELEASE] [--species SPECIES]

Search matched SV regions by gene.

options:
  -h, --help            show this help message and exit
  -v, --version         Print version number and exit.
  -L LOOP_FILE, --loop-file LOOP_FILE
                        Path to the loop file generated by neoloop-caller.
                        (default: None)
  -G GENE_NAME, --gene-name GENE_NAME
                        Gene name. (default: None)
  --ensembl-release ENSEMBL_RELEASE
                        Release number of the Ensembl database. The reference
                        genome assembly should be consistent with your Hi-C
                        data used in neoloop-caller. (default: 93)
  --species SPECIES     Species name of your cell line. (default: human)
```

