# glam2 CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| glam2 | PASS |  |
| glam2_glam2-purge | PASS |  |
| glam2_glam2format | PASS |  |
| glam2_glam2mask | PASS |  |
| glam2_glam2scan | PASS |  |

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


## glam2_glam2scan

### Tool Description
Scan a sequence database with a GLAM2 motif

### Metadata
- **Docker Image**: biocontainers/glam2:v1064-5-deb_cv1
- **Homepage**: https://github.com/LELEGOBOO/Glam2
- **Package**: https://anaconda.org/channels/bioconda/packages/glam2/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: glam2scan [options] alphabet my_motif.glam2 my_seqs.fa
Alphabets: p = proteins, n = nucleotides, other = alphabet file
Options (default settings):
-h: show all options and their default settings
-o: output file (stdout)
-n: number of alignments to report (25)
-2: examine both strands - forward and reverse complement
-D: deletion pseudocount (0.1)
-E: no-deletion pseudocount (2.0)
-I: insertion pseudocount (0.02)
-J: no-insertion pseudocount (1.0)
-d: Dirichlet mixture file
```

## glam2_glam2format

### Tool Description
Convert a GLAM2 motif alignment to FASTA or MSF format

### Metadata
- **Docker Image**: biocontainers/glam2:v1064-5-deb_cv1
- **Homepage**: https://github.com/LELEGOBOO/Glam2
- **Package**: https://anaconda.org/channels/bioconda/packages/glam2/overview
- **Validation**: PASS

### Original Help Text
```text
glam2format: invalid option -- 'h'
Usage: glam2format [options] my_format my_motif.glam2
Formats: fasta, msf
Options (default settings):
-o: output file (stdout)
-c: make a compact alignment
-f: sequence file for flanking sequences
```

## glam2_glam2mask

### Tool Description
Mask the aligned columns of a GLAM2 motif in a sequence file

### Metadata
- **Docker Image**: biocontainers/glam2:v1064-5-deb_cv1
- **Homepage**: https://github.com/LELEGOBOO/Glam2
- **Package**: https://anaconda.org/channels/bioconda/packages/glam2/overview
- **Validation**: PASS

### Original Help Text
```text
glam2mask: invalid option -- 'h'
Usage: glam2mask [options] my_motif.glam2 my_seqs.fa
Options (default settings):
-o: output file (stdout)
-x: mask character (x)
```

## glam2_glam2-purge

### Tool Description
Remove sequences from a set so that no two sequences have a local alignment score above a cutoff

### Metadata
- **Docker Image**: biocontainers/glam2:v1064-5-deb_cv1
- **Homepage**: https://github.com/LELEGOBOO/Glam2
- **Package**: https://anaconda.org/channels/bioconda/packages/glam2/overview
- **Validation**: PASS

### Original Help Text
```text

usage: purge file score <options>
  options:
     [-n]    - sequences are DNA (default: protein)
     [-b]    - use blast heuristic method (default for protein)
     [-e]    - use an exhaustive method (default for DNA)
     [-q]    - keep first sequence in the set
     [-x]    - use xnu to mask protein tandem repeats

  Purge creates an output file from the input file such that
  no two sequences have local alignment score greater than <score>.
  The output file is named <file>.<score>.
  Substitution matrices: BLOSUM62 (protein), +5/-1 (DNA).
```

## Metadata
- **Skill**: generated
