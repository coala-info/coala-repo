# prank CWL Generation Report

## prank

### Tool Description
Minimal usage: 'prank sequence_file'

### Metadata
- **Docker Image**: quay.io/biocontainers/prank:170427--h4ac6f70_0
- **Homepage**: https://github.com/n0xa/m5stick-nemo
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/prank/overview
- **Total Downloads**: 161.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/n0xa/m5stick-nemo
- **Stars**: N/A
### Original Help Text
```text
prank v.170427. Minimal usage: 'prank sequence_file'

Advanced usage: 'prank [optional parameters] -d=sequence_file [optional parameters]'

 input/output parameters:
  -d=sequence_file (in FASTA format)
  -t=tree_file [default: no tree, generate approximate NJ tree]
  -tree="tree_string" [tree in newick format; in double quotes]
  -o=output_file [default: 'output']
  -f=output_format ['fasta' (default), 'phylipi', 'phylips', 'paml', 'nexus']
  -showxml [output xml-files]
  -showtree [output dnd-files]
  -showanc [output ancestral sequences]
  -showevents [output evolutioanry events]
  -showall [output all of these]
  -noanchors [no Exonerate anchoring]
  -nomafft [no MAFFT guide tree]
  -scoremafft [score also MAFFT alignment]
  -support [compute posterior support]
  -njtree [estimate tree from input alignment (and realign)]
  -treeonly [estimate tree only]
  -quiet

 alignment merge parameters:
  -d1=sequence_file_1 (in FASTA format)
  -d2=sequence_file-2 (in FASTA format)
  -t1=tree_file_1 [if not provided, generate NJ tree]
  -t2=tree_file_2 [if not provided, generate NJ tree]
  -mergedist=# [if no tree provided; default: 0.1]

 model parameters:
  +F or -F [force insertions to be always skipped]
  -dots [show insertion gaps as dots]
  -m=model_file [default: HKY2/WAG]
  -gaprate=# [gap opening rate; default: dna 0.025 / prot 0.005]
  -gapext=# [gap extension probability; default: dna 0.75 / prot 0.5]
  -dnafreqs=#,#,#,# [ACGT; default: empirical]
  -kappa=# [ts/tv rate ratio; default:2]
  -rho=# [pur/pyr rate ratio; default:1]
  -indelscore=#,#,#,# [1,2,3,>3; indel penalties for alignment score]
  -codon [for coding DNA: use empirical codon model]
  -DNA / -protein [no autodetection: use dna or protein model]
  -termgap [penalise terminal gaps normally]
  -nomissing [no missing data, use -F for terminal gaps ]

 other parameters:
  -keep [keep alignment "as is" (e.g. for ancestor inference)]
  -pwdist=# [expected pairwise distance for computing guide tree; default: dna 0.25 / prot 0.5]
  -iterate=# [rounds of re-alignment iteration]
  -once [run only once; same as -iterate=1]
  -prunetree [prune guide tree branches with no sequence data]
  -prunedata [prune sequence data with no guide tree leaves]
  -skipins [skip insertions in posterior support]
  -uselogs [slower but should work for a greater number of sequences]
  -shortnames [truncate names at first space]
  -anchorskip=# [min. sequence length for anchoring; default 200]
  -scalebranches=# [scale branch lengths; default: dna 1 / prot 1]
  -fixedbranches=# [use fixed branch lengths]
  -maxbranches=# [set maximum branch length]
  -realbranches [disable branch length truncation]
  -seed=# [set random number seed]
  -translate [translate to protein]
  -mttranslate [translate to protein using mt table]

 other:
  -convert [no alignment, just convert to another format]
  -dna=dna_sequence_file [DNA sequence file for backtranslation of protein alignment]
  -version [check for updates]
  -verbose [print progress etc. during runtime]

  -help [show more options]
```

