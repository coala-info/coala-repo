# yamda CWL Generation Report

## yamda_erase_annoying_sequences.py

### Tool Description
Train model.

### Metadata
- **Docker Image**: quay.io/biocontainers/yamda:0.1.00e9c9d--py_0
- **Homepage**: https://github.com/daquang/YAMDA
- **Package**: https://anaconda.org/channels/bioconda/packages/yamda/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yamda/overview
- **Total Downloads**: 3.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/daquang/YAMDA
- **Stars**: N/A
### Original Help Text
```text
usage: erase_annoying_sequences.py [-h] -i INPUT [-o OUTPUT]

Train model.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input FASTA file
  -o OUTPUT, --output OUTPUT
                        Output FASTA file of negative sequences

Use `erase_annoying_sequences.py -h` to see an auto-generated description of advanced options.
```


## yamda_run_em.py

### Tool Description
Train model.

### Metadata
- **Docker Image**: quay.io/biocontainers/yamda:0.1.00e9c9d--py_0
- **Homepage**: https://github.com/daquang/YAMDA
- **Package**: https://anaconda.org/channels/bioconda/packages/yamda/overview
- **Validation**: PASS

### Original Help Text
```text
usage: run_em.py [-h] -i INPUT [-j INPUT2] [-b BATCHSIZE]
                 [-a {dna,rna,protein}] [-r] [-m {tcm,zoops,oops}] [-e]
                 [-f FUDGE] [-w WIDTH] [-k HALFLENGTH] [-n NMOTIFS]
                 [-mins MINSITES] [-maxs MAXSITES] [-ns NSEEDS]
                 [-maxiter MAXITER] [-t TOLERANCE] [--no_cuda] [-s SEED]
                 (-o OUTPUTDIR | -oc OUTPUTDIRC)

Train model.

optional arguments:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Input FASTA file
  -j INPUT2, --input2 INPUT2
                        Input FASTA file of negative sequences
  -b BATCHSIZE, --batchsize BATCHSIZE
                        Input batch size for training (default: 1000)
  -a {dna,rna,protein}, --alpha {dna,rna,protein}
                        Alphabet (default: dna)
  -r, --revcomp         Consider both the given strand and the reverse complement strand when searching for motifs in a complementable alphabet (default: consider given strand only).
  -m {tcm,zoops,oops}, --model {tcm,zoops,oops}
                        Model (default: tcm)
  -e, --erasewhole      Erase an entire sequence if it contains a discovered motif (default: erase individual motif occurrences).
  -f FUDGE, --fudge FUDGE
                        Fudge factor to help with extremely rare motifs. Should be >0 and <=1 (default: 0.1).
  -w WIDTH, --width WIDTH
                        Motif width (default: 20).
  -k HALFLENGTH, --halflength HALFLENGTH
                        k-mer half-length for gapped k-mer search seeding (default: 6).
  -n NMOTIFS, --nmotifs NMOTIFS
                        Number of motifs to find (default: 1).
  -mins MINSITES, --minsites MINSITES
                        Minimum number of motif occurrences (default: 100).
  -maxs MAXSITES, --maxsites MAXSITES
                        Maximum number of motif occurrences. If left unspecified, will default to number ofsequences.
  -ns NSEEDS, --nseeds NSEEDS
                        Number of motif seeds to try. If left unspecified, will default to 100 (for gapped k-mersearch) or 1000 (for randomly sampled subsequence method).
  -maxiter MAXITER, --maxiter MAXITER
                        Maximum number of refining iterations of batch EM to run from any starting point. Batch EM is run for maxiter iterations or until convergence (see -tolerance, below) from each starting point for refining (default: 20)
  -t TOLERANCE, --tolerance TOLERANCE
                        Stop iterating refining batch/on-line EM when the change in the motif probability matrix is less than tolerance. Change is defined as the euclidean distance between two successive frequency matrices (default: 1e-3).
  --no_cuda             Disable the default CUDA training.
  -s SEED, --seed SEED  Random seed for reproducibility (default: 1337).
  -o OUTPUTDIR, --outputdir OUTPUTDIR
                        The output directory. Causes error if the directory already exists.
  -oc OUTPUTDIRC, --outputdirc OUTPUTDIRC
                        The output directory. Will overwrite if directory already exists.

Use `run_em.py -h` to see an auto-generated description of advanced options.
```

