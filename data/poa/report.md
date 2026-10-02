# poa CWL Generation Report

## poa

### Tool Description
Align a set of sequences or alignments using the scores in MATRIXFILE.

### Metadata
- **Docker Image**: biocontainers/poa:v2.020060928-7-deb_cv1
- **Homepage**: https://github.com/jakecreps/poastal
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/poa/overview
- **Total Downloads**: 206.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jakecreps/poastal
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/bin/poa [OPTIONS] MATRIXFILE
Align a set of sequences or alignments using the scores in MATRIXFILE.
Example: /usr/bin/poa -read_fasta multidom.seq -clustal m.aln blosum80.mat

INPUT:
  -read_fasta FILE       Read in FASTA sequence file.
  -read_msa FILE         Read in MSA alignment file.
  -read_msa2 FILE        Read in second MSA file. 
  -subset FILE           Filter MSA to include list of seqs in file.
  -subset2 FILE          Filter second MSA to include list of seqs in file.
  -remove FILE           Filter MSA to exclude list of seqs in file.
  -remove2 FILE          Filter second MSA to exclude list of seqs in file.
  -read_msa_list FILE    Read an MSA from each filename listed in file.
  -tolower               Force FASTA/MSA sequences to lowercase
                           (nucleotides in our matrix files)
  -toupper               Force FASTA/MSA sequences to UPPERCASE
                           (amino acids in our matrix files)

ALIGNMENT:
  -do_global             Do global alignment.
  -do_progressive        Perform progressive alignment using a guide tree
                           built by neighbor joining from a set of
                           sequence-sequence similarity scores.
  -read_pairscores FILE  Read tab-delimited file of similarity scores.
                           (If not provided, scores are constructed
                           using pairwise sequence alignment.)
  -fuse_all              Fuse identical letters on align rings.

ANALYSIS:
  -hb                    Perform heaviest bundling to generate consensi.
  -hbmin VALUE           Include in heaviest bundle sequences with
                           percent ID (as a fraction) >= value.

OUTPUT:
  -pir FILE              Write out MSA in PIR format.
  -clustal FILE          Write out MSA in CLUSTAL format.
  -po FILE               Write out MSA in PO format.
  -preserve_seqorder     Write out MSA with sequences in their input order.
  -printmatrix LETTERS   Print score matrix to stdout.
  -best                  Restrict MSA output to heaviest bundles (PIR only).
  -v                     Run in verbose mode (e.g. output gap penalties).

  NOTE:  One of the -read_fasta, -read_msa, or -read_msa_list arguments
         must be used, since a sequence or alignment file is required.

For more information, see http://www.bioinformatics.ucla.edu/poa.
```
