# glam2 CWL Generation Report

## glam2

### Tool Description
Alphabets: p = proteins, n = nucleotides, other = alphabet file

### Metadata
- **Docker Image**: biocontainers/glam2:v1064-5-deb_cv1
- **Homepage**: https://github.com/LELEGOBOO/Glam2
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/glam2/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/LELEGOBOO/Glam2
- **Stars**: N/A
### Original Help Text
```text
Usage: glam2 [options] alphabet my_seqs.fa
Alphabets: p = proteins, n = nucleotides, other = alphabet file
Options (default settings):
-h: show all options and their default settings
-o: output file (stdout)
-r: number of alignment runs (10)
-n: end each run after this many iterations without improvement (10000)
-2: examine both strands - forward and reverse complement
-z: minimum number of sequences in the alignment (2)
-a: minimum number of aligned columns (2)
-b: maximum number of aligned columns (50)
-w: initial number of aligned columns (20)
-d: Dirichlet mixture file
-D: deletion pseudocount (0.1)
-E: no-deletion pseudocount (2.0)
-I: insertion pseudocount (0.02)
-J: no-insertion pseudocount (1.0)
-q: weight for generic versus sequence-set-specific residue abundances (1e+99)
-t: initial temperature (1.2)
-c: cooling factor per n iterations (1.44)
-u: temperature lower bound (0.1)
-p: print progress information at each iteration
-m: column-sampling moves per site-sampling move (1.0)
-x: site sampling algorithm: 0=FAST 1=SLOW 2=FFT (0)
-s: seed for pseudo-random numbers (1)
```


## Metadata
- **Skill**: generated
