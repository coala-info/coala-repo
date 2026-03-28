# kmercamel CWL Generation Report

## kmercamel_compute

### Tool Description
Compute k-mer based superstrings.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
- **Homepage**: https://github.com/OndrejSladky/kmercamel/
- **Package**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Total Downloads**: 3.2K
- **Last updated**: 2025-08-25
- **GitHub**: https://github.com/OndrejSladky/kmercamel
- **Stars**: N/A
### Original Help Text
```text
Required positional parameter path to the file not set.

Usage:   kmercamel compute [options] <fasta>

Options:
  -k INT   - k-mer size [required; up to 127]
  -a STR   - the algorithm to be run [global (default), streaming, local, globalAC (experimental), localAC (experimental)]
  -o FILE  - output for the (minone) masked superstring; if not specified, printed to stdout
  -M FILE  - if given, print also ms with mask maximizing ones (only with global)
  -S       - optimize for the input being correctly computed simplitigs (only with global)
  -d INT   - d_max for local algorithm; default 5
  -u       - treat k-mer and its reverse complement as distinct
  -z INT   - minimum frequency to represent a k-mer; default 1
  -h       - print help
```


## kmercamel_maskopt

### Tool Description
Masks a superstring using k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
- **Homepage**: https://github.com/OndrejSladky/kmercamel/
- **Package**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Validation**: PASS

### Original Help Text
```text
Required positional parameter path to the file not set.

Usage:   kmercamel maskopt [options] <ms>

Options:
  -k INT   - k-mer size [required; up to 127]
  -t STR   - the target mask type to be run [maxone (default), minone, minrun, approxminrun]
  -o FILE  - output for the (minone) masked superstring; if not specified, printed to stdout
  -u       - treat k-mer and its reverse complement as distinct
  -h       - print help
```


## kmercamel_ms2mssep

### Tool Description
Converts MS/MS spectra to MS2 format.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
- **Homepage**: https://github.com/OndrejSladky/kmercamel/
- **Package**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Validation**: PASS

### Original Help Text
```text
Cannot have both superstring and mask redirected to stdout.

Usage:   kmercamel ms2mssep [options] <ms>

Options:
  -m FILE  - output file with mask
  -s FILE  - output file with superstring
  -h       - print help
```


## kmercamel_mssep2ms

### Tool Description
Cannot have both superstring and mask redirected from stdin.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
- **Homepage**: https://github.com/OndrejSladky/kmercamel/
- **Package**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Validation**: PASS

### Original Help Text
```text
Cannot have both superstring and mask redirected from stdin.

Usage:   kmercamel mssep2ms [options]

Options:
  -o FILE  - output for the (minone) masked superstring; if not specified, printed to stdout
  -m FILE  - input file with mask
  -s FILE  - input file with superstring
  -h       - print help
```


## kmercamel_ms2spss

### Tool Description
Converts a masked superstring to a set of k-mers.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
- **Homepage**: https://github.com/OndrejSladky/kmercamel/
- **Package**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Validation**: PASS

### Original Help Text
```text
Required positional parameter path to the file not set.

Usage:   kmercamel ms2spss [options] <ms>

Options:
  -k INT   - k-mer size [required; up to 127]
  -o FILE  - output for the (minone) masked superstring; if not specified, printed to stdout
  -h       - print help
```


## kmercamel_spss2ms

### Tool Description
Converts a FASTA file to a masked superstring format.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
- **Homepage**: https://github.com/OndrejSladky/kmercamel/
- **Package**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Validation**: PASS

### Original Help Text
```text
Required positional parameter path to the file not set.

Usage:   kmercamel spss2ms [options] <fasta>

Options:
  -k INT   - k-mer size [required; up to 127]
  -o FILE  - output for the (minone) masked superstring; if not specified, printed to stdout
  -h       - print help
```


## kmercamel_lowerbound

### Tool Description
Calculates the lower bound of the number of unique k-mers in a FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
- **Homepage**: https://github.com/OndrejSladky/kmercamel/
- **Package**: https://anaconda.org/channels/bioconda/packages/kmercamel/overview
- **Validation**: PASS

### Original Help Text
```text
Required positional parameter path to the file not set.

Usage:   kmercamel lowerbound [options] <fasta>

Options:
  -k INT   - k-mer size [required; up to 127]
  -u       - treat k-mer and its reverse complement as distinct
  -h       - print help
```


## Metadata
- **Skill**: generated
