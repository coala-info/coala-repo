# ls-gkm CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| ls-gkm_gkmpredict | PASS |  |
| ls-gkm_gkmtrain | PASS |  |
| ls-gkm_gkmtrain-svr | PASS | scores in the test table are synthetic (GC fraction) on real training sequences; the model file is written and parses |

## Metadata
- **Skill**: generated

## ls-gkm_gkmtrain

### Tool Description
Train a gapped k-mer support vector machine (gkm-SVM) model from positive and negative FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
- **Homepage**: https://github.com/Dongwon-Lee/lsgkm
- **Package**: https://anaconda.org/channels/bioconda/packages/ls-gkm/overview
- **Validation**: PASS

### Original Help Text
```text
Program: gkmtrain (lsgkm program for SVM model training)
Version: v0.1.1

Usage: gkmtrain [options] <posfile> <negfile> <outprefix>

 train gkm-SVM using libSVM

Arguments:
 posfile: positive sequence file (FASTA format)
 negfile: negative sequence file (FASTA format)
 outprefix: prefix of output file(s) <outprefix>.model.txt or
            <outprefix>.cvpred.txt

Options:
 -t <0 ~ 5>   set kernel function (default: 2 gkm)
              NOTE: RBF kernels (3 and 5) work best with -c 10 -g 2
                0 -- gapped-kmer
                1 -- estimated l-mer with full filter
                2 -- estimated l-mer with truncated filter (gkm)
                3 -- gkm + RBF (gkmrbf)
                4 -- gkm + center weighted (wgkm)
                     [weight = max(M, floor(M*exp(-ln(2)*D/H)+1))]
                5 -- gkm + center weighted + RBF (wgkmrbf)
 -l <int>     set word length, 3<=l<=12 (default: 11)
 -k <int>     set number of informative column, k<=l (default: 7)
 -d <int>     set maximum number of mismatches to consider, d<=4 (default: 3)
 -g <float>   set gamma for RBF kernel. -t 3 or 5 only (default: 1.0)
 -M <int>     set the initial value (M) of the exponential decay function
              for wgkm-kernels. max=255, -t 4 or 5 only (default: 50)
 -H <float>   set the half-life parameter (H) that is the distance (D) required
              to fall to half of its initial value in the exponential decay
              function for wgkm-kernels. -t 4 or 5 only (default: 50)
 -R           if set, reverse-complement is not considered as the same feature
 -c <float>   set the regularization parameter SVM-C (default: 1.0)
 -e <float>   set the precision parameter epsilon (default: 0.001)
 -w <float>   set the parameter SVM-C to w*C for the positive set (default: 1.0)
 -m <float>   set cache memory size in MB (default: 100.0)
              NOTE: Large cache signifcantly reduces runtime. >4Gb is recommended
 -s           if set, use the shrinking heuristics
 -x <int>     set N-fold cross validation mode (default: no cross validation)
 -i <int>     run i-th cross validation only 1<=i<=ncv (default: all)
 -r <int>     set random seed for shuffling in cross validation mode (default: 1)
 -v <0 ~ 4>   set the level of verbosity (default: 2)
                0 -- error msgs only (ERROR)
                1 -- warning msgs (WARN)
                2 -- progress msgs at coarse-grained level (INFO)
                3 -- progress msgs at fine-grained level (DEBUG)
                4 -- progress msgs at finer-grained level (TRACE)
-T <1|4|16>   set the number of threads for parallel calculation, 1, 4, or 16
                 (default: 1)
```

## ls-gkm_gkmpredict

### Tool Description
Score test sequences using a gkm-SVM model trained with gkmtrain.

### Metadata
- **Docker Image**: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
- **Homepage**: https://github.com/Dongwon-Lee/lsgkm
- **Package**: https://anaconda.org/channels/bioconda/packages/ls-gkm/overview
- **Validation**: PASS

### Original Help Text
```text
Program: gkmpredict (lsgkm program for scoring sequences using a trained model)
Version: v0.1.1

Usage: gkmpredict [options] <test_seqfile> <model_file> <output_file>

 score test sequences using trained gkm-SVM

Arguments:
 test_seqfile: sequence file for test (fasta format)
 model_file: output of gkmtrain
 output_file: name of output file

Options:
 -v <0|1|2|3|4>  set the level of verbosity (default: 2)
                   0 -- error msgs only (ERROR)
                   1 -- warning msgs (WARN)
                   2 -- progress msgs at coarse-grained level (INFO)
                   3 -- progress msgs at fine-grained level (DEBUG)
                   4 -- progress msgs at finer-grained level (TRACE)
-T <1|4|16>      set the number of threads for parallel calculation, 1, 4, or 16
                 (default: 1)
```

## ls-gkm_gkmtrain-svr

### Tool Description
Train a support vector regression (SVR) model with the gapped k-mer kernel from a table of sequences and scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
- **Homepage**: https://github.com/Dongwon-Lee/lsgkm
- **Package**: https://anaconda.org/channels/bioconda/packages/ls-gkm/overview
- **Validation**: PASS

### Original Help Text
```text
[help] gkmtrain-svr: ok via gkmtrain-svr (--help=ok, -h=ok, -help=ok, (no args)=ok)
Program: gkmtrain-svr (lsgkm program for SVR model training)
Version: v0.1.1

Usage: gkmtrain [options] <datafile> <outprefix>

 train support vector regression (SVR) using gkm-kenrel and libSVM

Arguments:
 datafile: tab-delimited data file. The 1st column is sequence and
           the 2nd column is score.
 outprefix: prefix of output file(s) <outprefix>.model.txt or
            <outprefix>.cvpred.txt

Options:
 -t <0 ~ 5>   set kernel function (default: 2 gkm)
              NOTE: RBF kernels (3 and 5) work best with -c 10 -g 2
                0 -- gapped-kmer
                1 -- estimated l-mer with full filter
                2 -- estimated l-mer with truncated filter (gkm)
                3 -- gkm + RBF (gkmrbf)
                4 -- gkm + center weighted (wgkm)
                     [weight = max(M, floor(M*exp(-ln(2)*D/H)+1))]
                5 -- gkm + center weighted + RBF (wgkmrbf)
 -l <int>     set word length, 3<=l<=12 (default: 11)
 -k <int>     set number of informative column, k<=l (default: 7)
 -d <int>     set maximum number of mismatches to consider, d<=4 (default: 3)
 -g <float>   set gamma for RBF kernel. -t 3 or 5 only (default: 1.0)
 -M <int>     set the initial value (M) of the exponential decay function
              for wgkm-kernels. max=255, -t 4 or 5 only (default: 50)
 -H <float>   set the half-life parameter (H) that is the distance (D) required
              to fall to half of its initial value in the exponential decay
              function for wgkm-kernels. -t 4 or 5 only (default: 50)
 -R           if set, reverse-complement is not considered as the same feature
 -c <float>   set the regularization parameter C (default: 0.1)
 -p <float>   set the epsilon parameter in loss function of SVR (default: 0.1)
 -e <float>   set the precision parameter (default: 0.001)
 -m <float>   set cache memory size in MB (default: 100.0)
              NOTE: Large cache signifcantly reduces runtime. >4Gb is recommended
 -s           if set, use the shrinking heuristics
 -x <int>     set N-fold cross validation mode (default: no cross validation)
 -i <int>     run i-th cross validation only 1<=i<=ncv (default: all)
 -r <int>     set random seed for shuffling in cross validation mode (default: 1)
 -v <0 ~ 4>   set the level of verbosity (default: 2)
                0 -- error msgs only (ERROR)
                1 -- warning msgs (WARN)
                2 -- progress msgs at coarse-grained level (INFO)
                3 -- progress msgs at fine-grained level (DEBUG)
                4 -- progress msgs at finer-grained level (TRACE)
-T <1|4|16>   set the number of threads for parallel calculation, 1, 4, or 16
                 (default: 1)
```

