# chromosomer CWL Generation Report

## chromosomer_assemble

### Tool Description
Get the FASTA file of assembled chromosomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/gtamazian/chromosomer
- **Stars**: N/A
### Original Help Text
```text
usage: chromosomer assemble [-h] [-s] map fragment_fasta output_fasta

Get the FASTA file of assembled chromosomes.

positional arguments:
  map                   a fragment map file
  fragment_fasta        a FASTA file of fragment sequences to be assembled
  output_fasta          the output FASTA file of the assembled chromosome
                        sequences

optional arguments:
  -h, --help            show this help message and exit
  -s, --save_soft_mask  keep soft masking from the original fragment sequences
                        (default: False)
```


## chromosomer_fragmentmap

### Tool Description
Construct a fragment map from fragment alignments to reference chromosomes.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosomer fragmentmap [-h] [-r RATIO_THRESHOLD] [-s]
                               alignment_file gap_size fragment_lengths
                               output_map

Construct a fragment map from fragment alignments to reference chromosomes.

positional arguments:
  alignment_file        a BLAST tabular file of fragment alignments to
                        reference chromosomes
  gap_size              a size of a gap inserted between mapped fragments
  fragment_lengths      a file containing lengths of fragment sequences; it
                        can be obtained using the 'chromosomer fastalength'
                        tool
  output_map            an output fragment map file name

optional arguments:
  -h, --help            show this help message and exit
  -r RATIO_THRESHOLD, --ratio_threshold RATIO_THRESHOLD
                        the least ratio of two greatest fragment alignment
                        scores to determine the fragment placed to a reference
                        genome (default: 1.2)
  -s, --shrink_gaps     shrink large interfragment gaps to the specified size
                        (default: False)
```


## chromosomer_fragmentmapstat

### Tool Description
Show statistics on a fragment map.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosomer fragmentmapstat [-h] map output

Show statistics on a fragment map.

positional arguments:
  map         a fragment map file
  output      an output file of fragment map statistics

optional arguments:
  -h, --help  show this help message and exit
```


## chromosomer_fragmentmapbed

### Tool Description
Convert a fragment map to the BED format.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosomer fragmentmapbed [-h] map output

Convert a fragment map to the BED format.

positional arguments:
  map         a fragment map file
  output      an output BED file representing the fragment map

optional arguments:
  -h, --help  show this help message and exit
```


## chromosomer_transfer

### Tool Description
Transfer annotated genomic features from fragments to their assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosomer transfer [-h] [-f {bed,gff3,vcf}] map annotation output

Transfer annotated genomic features from fragments to their assembly.

positional arguments:
  map                   a fragment map file
  annotation            a file of annotated genome features
  output                an output file of the transfered annotation

optional arguments:
  -h, --help            show this help message and exit
  -f {bed,gff3,vcf}, --format {bed,gff3,vcf}
                        the format of a file of annotated features (bed, gff3
                        or vcf) (default: bed)
```


## chromosomer_fastalength

### Tool Description
Get lengths of sequences in the specified FASTA file (required to build a fragment map).

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosomer fastalength [-h] fasta output

Get lengths of sequences in the specified FASTA file (required to build a
fragment map).

positional arguments:
  fasta       a FASTA file which sequence lengths are to be obtained
  output      an output file of sequence lengths

optional arguments:
  -h, --help  show this help message and exit
```


## chromosomer_simulator

### Tool Description
Simulate fragments and test assembly for testing purposes.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosomer simulator [-h] [-g GAP_SIZE] [-p UNPLACED]
                             [--prefix PREFIX]
                             fr_num fr_len chr_num output_dir

Simulate fragments and test assembly for testing purposes.

positional arguments:
  fr_num                the number of chromosome fragments
  fr_len                the length of fragments
  chr_num               the number of chromosomes
  output_dir            the directory for output files

optional arguments:
  -h, --help            show this help message and exit
  -g GAP_SIZE, --gap_size GAP_SIZE
                        the size of gaps between fragments on a chromosome
  -p UNPLACED, --unplaced UNPLACED
                        the number of unplaced fragments
  --prefix PREFIX       the prefix for output file names
```


## chromosomer_agp2map

### Tool Description
Convert an AGP file to the fragment map format.

### Metadata
- **Docker Image**: quay.io/biocontainers/chromosomer:0.1.4a--py27_1
- **Homepage**: https://github.com/gtamazian/chromosomer
- **Package**: https://anaconda.org/channels/bioconda/packages/chromosomer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: chromosomer agp2map [-h] agp_file output_file

Convert an AGP file to the fragment map format.

positional arguments:
  agp_file     an AGP file
  output_file  the output fragment map file

optional arguments:
  -h, --help   show this help message and exit
```


## Metadata
- **Skill**: generated
