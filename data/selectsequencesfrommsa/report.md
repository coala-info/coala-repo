# selectsequencesfrommsa CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| selectsequencesfrommsa | PASS |  |

## selectsequencesfrommsa

### Tool Description
Selects a representative subset of sequences from a multiple sequence alignment in Clustal format.

### Metadata
- **Docker Image**: quay.io/biocontainers/selectsequencesfrommsa:1.0.5--pl526h9ebf644_0
- **Homepage**: https://github.com/eggzilla/SelectSequencesFromMSA
- **Package**: https://anaconda.org/channels/bioconda/packages/selectsequencesfrommsa/overview
- **Validation**: PASS

### Original Help Text
```text
SelectSequences

options [OPTIONS]
  Florian Eggenhofer 2016-2018

Common flags:
  -c --inputclustalpath=ITEM          Path to input clustal file
  -o --outputpath=ITEM                Path to output directory. Default:
                                      current working directory
  -f --outputfilename=ITEM            Output filename. Default:
                                      results.selected
  -e --toogleexternalselectsequences  Use only replacement of alignment
                                      characters and external
                                      'selectSequence.pl'. Default: False
  -n --seqencenumber=INT              Number of sequences in the output
                                      alignment. (Default: 6)
  -i --optimalidentity=NUM            Optimize for this percentage of mean
                                      pairwise identity (Default: 80)
  -m --maximalidenity=NUM             Sequences with a higher percentage of
                                      pairwise Identity will be removed.
                                      (Default: 95)
  -x --referencesequence              The first sequence (=reference
                                      sequence) is always present in the output
                                      alignment per default. Default: True
  -d --distancematrixpath=ITEM        Path to distance matrix output file,
                                      only internal for interal sequence
                                      selection, e.g. /home/user/distmat
                                      (Default: )
  -r --reformatidoption=ITEM          Defines how sequence id is reformated,
                                      e.g. fitting for RNAcode or not (Default:
                                      RNAcode)
  -? --help                           Display help message
  -V --version                        Print version information
  -v --verbose                        Loud verbosity
  -q --quiet                          Quiet verbosity
```

## Metadata
- **Skill**: not generated
