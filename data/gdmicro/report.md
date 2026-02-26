# gdmicro CWL Generation Report

## gdmicro

### Tool Description
Use GCN and domain adaptation to predict disease based on microbiome data.

### Metadata
- **Docker Image**: quay.io/biocontainers/gdmicro:1.0.10--pyhdfd78af_0
- **Homepage**: https://github.com/liaoherui/GDmicro
- **Package**: https://anaconda.org/channels/bioconda/packages/gdmicro/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gdmicro/overview
- **Total Downloads**: 5.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/liaoherui/GDmicro
- **Stars**: N/A
### Original Help Text
```text
usage: GDmicro.py [-h] [-i INPUT_FILE] [-t TRAIN_MODE] [-d DISEASE]
                  [-k KNEIGHBOR] [-b BSIZE] [-e ANODE] [-n NNUM] [-f FNUM]
                  [-c CVFOLD] [-s RSEED] [-a DOADPT] [-r RFI] [-o OUTDIR]

GDmicro - Use GCN and domain adaptation to predict disease based on microbiome
data.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT_FILE, --input_file INPUT_FILE
                        The directory of the input csv file.
  -t TRAIN_MODE, --train_mode TRAIN_MODE
                        If set to 1, then will apply k-fold cross validation
                        to all input datasets. This mode can only be used when
                        input datasets all have labels and set as "train" in
                        input file.
  -d DISEASE, --disease DISEASE
                        The name of the disease.
  -k KNEIGHBOR, --kneighbor KNEIGHBOR
                        The number of neighborhoods in the knn graph.
                        (default: 5)
  -b BSIZE, --batchsize BSIZE
                        The batch size during the training process. (default:
                        64)
  -e ANODE, --apply_node ANODE
                        If set to 1, then will apply node importance
                        calculation, which may take a long time. (default: not
                        use).
  -n NNUM, --node_num NNUM
                        How many nodes will be output during the node
                        importance calculation process. (default:20).
  -f FNUM, --feature_num FNUM
                        How many features (top x features) will be analyzed
                        during the feature influence score calculation
                        process. (default: x=10)
  -c CVFOLD, --cvfold CVFOLD
                        The value of k in k-fold cross validation. (default:
                        10)
  -s RSEED, --randomseed RSEED
                        The random seed used to reproduce the result.
                        (default: not use)
  -a DOADPT, --domain_adapt DOADPT
                        Whether apply domain adaptation to the test dataset.
                        If set to 0, then will use MLP rather than domain
                        adaptation. (default: use)
  -r RFI, --run_fi RFI  Whether run feature importance calculation process. If
                        set to 0, then will not calculate the feature
                        importance and contribution score. (default: 1)
  -o OUTDIR, --outdir OUTDIR
                        Output directory of test results. (Default:
                        GDmicro_res)
```

