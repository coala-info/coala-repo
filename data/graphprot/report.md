# graphprot CWL Generation Report

## graphprot_GraphProt.pl

### Tool Description
GraphProt.pl -mode {regression,classification} -action {ls,cv,train,predict,predict_profile,predict_has,motif}

### Metadata
- **Docker Image**: quay.io/biocontainers/graphprot:1.1.7--py36_0
- **Homepage**: https://github.com/dmaticzka/graphprot
- **Package**: https://anaconda.org/channels/bioconda/packages/graphprot/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphprot/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/dmaticzka/graphprot
- **Stars**: N/A
### Original Help Text
```text
Usage:
    GraphProt.pl -mode {regression,classification} -action
    {ls,cv,train,predict,predict_profile,predict_has,motif}

    Options:

        -mode        'regression' or 'classification'
                         default: classification
        -action      what should GraphProt do?
                         ls: optimize parameters
                         cv: run a crossvalidation
                         train: train a model
                         predict: predict binding for a whole site
                         predict_profile: predict binding profiles
                         predict_has: predict high-affinity sites
                         motif: create sequence and structure motifs given a model
        -onlyseq     use GraphProt sequence models
        -prefix      this prefix is used for all results
                         default: GraphProt
        -model       GraphProt model
        -fasta       fasta file containing binding sites
        -help        brief help message
        -man         full documentation

    Specify parameters as determined by -action ls:

        -params      parameter config file created by -action ls, alternatively
                     use the following options to manually enter the desired
                     parameters

    Graph and Feature options:

        -abstraction RNAshapes abstraction level [RNA structure graphs]
                         default: 3
        -R           GraphProt radius
                         default: 1
        -D           GraphProt distance
                         default: 4
        -bitsize     GraphProt bitsize used for feature encoding
                         default: 14

    Classification options:

        -negfasta    fasta file containing negative class sequences
        -lambda      SGD parameter lambda  [classification]
                         default: 10e-4
        -epochs      SGD parameter epochs  [classification]
                         default: 10

    Regression options:

        -affinities  list of affinities
                         one value per line, same order as binding sites (fasta)
        -c           SVR parameter c       [regression]
                         default: 1
        -epsilon     SVR parameter epsilon [regression]
                         default: 0.1

    Prediction options:

        -percentile  keep only regions with average score above a percentile
                     as high-affinity sites
                         default: 99

    Motif options:

        -motif_len   set length of motifs
                         (default: 12)
        -motif_top_n use use n top-scoring subsequences for motif creation
                         (default: 1000)
```

