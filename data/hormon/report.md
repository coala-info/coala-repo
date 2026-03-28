# hormon CWL Generation Report

## hormon_monomer_inference

### Tool Description
Monomer Inference Problem: complement monomers set

### Metadata
- **Docker Image**: quay.io/biocontainers/hormon:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ablab/HORmon
- **Package**: https://anaconda.org/channels/bioconda/packages/hormon/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hormon/overview
- **Total Downloads**: 2.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ablab/HORmon
- **Stars**: N/A
### Original Help Text
```text
Start Monomer Inference
usage: monomer_inference [-h] [-seq SEQUENCES] [-mon MONOMERS] [-o OUTDIR]
                         [--continue] [-t THREADS] [--resDiv RESDIV]
                         [--maxDiv MAXDIV] [--min-cluster-size MIN_CLST]

Monomer Inference Problem: complement monomers set

optional arguments:
  -h, --help            show this help message and exit
  -seq SEQUENCES, --sequences SEQUENCES
                        fasta-file with long reads or genomic sequences
  -mon MONOMERS, --monomers MONOMERS
                        fasta-file with monomers
  -o OUTDIR, --out-dir OUTDIR
                        output directory [default='.']
  --continue            continue run from output dir
  -t THREADS, --threads THREADS
                        number of threads [default=1]
  --resDiv RESDIV, --max-resolved-divergence RESDIV
                        max divergence in identity for resolve block
                        [default=5]
  --maxDiv MAXDIV, --max-divergence MAXDIV
                        max divergence in identity for monomeric-block
                        [default=25]
  --min-cluster-size MIN_CLST
                        When maximum size of cluster will be less MIN_CLST the
                        monomer inferense will finished [default=2]
```


## hormon_HORmon

### Tool Description
updating monomers to make it consistent with CE postulate, and canonical HOR inferencing

### Metadata
- **Docker Image**: quay.io/biocontainers/hormon:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/ablab/HORmon
- **Package**: https://anaconda.org/channels/bioconda/packages/hormon/overview
- **Validation**: PASS

### Original Help Text
```text
usage: HORmon [-h] --mon MON --seq SEQ [--cen-id CENID]
              [--monomer-thr VERTTHR] [--min-edge-multiplicity EDGETHR]
              [--min-count-fraction EDGEFRTHR]
              [--min-traversals MINTRAVERSALS] [--original_mn IAMN]
              [--monorun] [-t THREADS] -o OUTDIR

HORmon: updating monomers to make it consistent with CE postulate, and
canonical HOR inferencing

optional arguments:
  -h, --help            show this help message and exit
  --mon MON             path to initial monomers
  --seq SEQ             path to centromere sequence
  --cen-id CENID        chromosome id
  --monomer-thr VERTTHR
                        Minimum weight for valuable monomers
  --min-edge-multiplicity EDGETHR, --edge-thr EDGETHR
                        MinEdgeMultiplicite. Remove edges in monomer-graph
                        with multiplicite below min(MinEdgeMultiplicite,
                        minCountFraction * (min occurrence of valuable
                        monomer))
  --min-count-fraction EDGEFRTHR, --edgeFr-thr EDGEFRTHR
                        minCountFraction. Remove edges in monomer-graph with
                        multiplicite below min(MinEdgeMultiplicite,
                        minCountFraction * (min occurrence of valuable
                        monomer))
  --min-traversals MINTRAVERSALS
                        minimum HOR(or monocycle) occurance
  --original_mn IAMN    path to original monomer only for comparing
  --monorun             build and show monorun graphs
  -t THREADS            number of threads(default=1)
  -o OUTDIR             path to output directore
```


## Metadata
- **Skill**: generated
