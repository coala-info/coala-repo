# foldcomp CWL Generation Report

## foldcomp_compress

### Tool Description
Compresses and decompresses biological structure files.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
- **Homepage**: https://github.com/steineggerlab/foldcomp
- **Package**: https://anaconda.org/channels/bioconda/packages/foldcomp/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/foldcomp/overview
- **Total Downloads**: 6.5K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/steineggerlab/foldcomp
- **Stars**: N/A
### Original Help Text
```text
Usage: foldcomp compress <pdb|cif> [<fcz>]
       foldcomp compress [-t number] <dir|tar(.gz)> [<dir|tar|db>]
       foldcomp decompress <fcz|tar> [<pdb>]
       foldcomp decompress [-t number] <dir|tar(.gz)|db> [<dir|tar>]
       foldcomp extract [--plddt|--amino-acid] <fcz> [<fasta>]
       foldcomp extract [--plddt|--amino-acid] [-t number] <dir|tar(.gz)|db> [<fasta_out>]
       foldcomp check <fcz>
       foldcomp check [-t number] <dir|tar(.gz)|db>
       foldcomp rmsd <pdb|cif> <pdb|cif>
 -h, --help               print this help message
 -v, --version            print version
 -t, --threads            threads for (de)compression of folders/tar files [default=1]
 -r, --recursive          recursively look for files in directory [default=0]
 -f, --file               input is a list of files [default=0]
 -a, --alt                use alternative atom order [default=false]
 -b, --break              interval size to save absolute atom coordinates [default=25]
 -z, --tar                save as tar file [default=false]
 -d, --db                 save as database [default=false]
 -y, --overwrite          overwrite existing files [default=false]
 -l, --id-list            a file of id list to be processed (only for database input)
 -m, --id-mode            id mode for database input. 0: database keys, 1: names (.lookup) [default=1]
 --skip-discontinuous     skip PDB with with discontinuous residues (only batch compression)
 --check                  check FCZ before and skip entries with error (only for batch decompression)
 --plddt                  extract pLDDT score (only for extraction mode)
 -p, --plddt-digits       extract pLDDT score with specified number of digits (only for extraction mode)
                          - 1: single digit (fasta-like format), 2: 2-digit(00-99; tsv), 3: 3-digit, 4: 4-digit (max)
 --fasta, --amino-acid    extract amino acid sequence (only for extraction mode)
 --no-merge               do not merge output files (only for extraction mode)
 --use-title              use TITLE as the output file name (only for extraction mode)
 --time                   measure time for compression/decompression
 --use-cache              use cached index for database input [default=false]
```


## foldcomp_decompress

### Tool Description
Command-line tool for compressing and decompressing protein structure files.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
- **Homepage**: https://github.com/steineggerlab/foldcomp
- **Package**: https://anaconda.org/channels/bioconda/packages/foldcomp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: foldcomp compress <pdb|cif> [<fcz>]
       foldcomp compress [-t number] <dir|tar(.gz)> [<dir|tar|db>]
       foldcomp decompress <fcz|tar> [<pdb>]
       foldcomp decompress [-t number] <dir|tar(.gz)|db> [<dir|tar>]
       foldcomp extract [--plddt|--amino-acid] <fcz> [<fasta>]
       foldcomp extract [--plddt|--amino-acid] [-t number] <dir|tar(.gz)|db> [<fasta_out>]
       foldcomp check <fcz>
       foldcomp check [-t number] <dir|tar(.gz)|db>
       foldcomp rmsd <pdb|cif> <pdb|cif>
 -h, --help               print this help message
 -v, --version            print version
 -t, --threads            threads for (de)compression of folders/tar files [default=1]
 -r, --recursive          recursively look for files in directory [default=0]
 -f, --file               input is a list of files [default=0]
 -a, --alt                use alternative atom order [default=false]
 -b, --break              interval size to save absolute atom coordinates [default=25]
 -z, --tar                save as tar file [default=false]
 -d, --db                 save as database [default=false]
 -y, --overwrite          overwrite existing files [default=false]
 -l, --id-list            a file of id list to be processed (only for database input)
 -m, --id-mode            id mode for database input. 0: database keys, 1: names (.lookup) [default=1]
 --skip-discontinuous     skip PDB with with discontinuous residues (only batch compression)
 --check                  check FCZ before and skip entries with error (only for batch decompression)
 --plddt                  extract pLDDT score (only for extraction mode)
 -p, --plddt-digits       extract pLDDT score with specified number of digits (only for extraction mode)
                          - 1: single digit (fasta-like format), 2: 2-digit(00-99; tsv), 3: 3-digit, 4: 4-digit (max)
 --fasta, --amino-acid    extract amino acid sequence (only for extraction mode)
 --no-merge               do not merge output files (only for extraction mode)
 --use-title              use TITLE as the output file name (only for extraction mode)
 --time                   measure time for compression/decompression
 --use-cache              use cached index for database input [default=false]
```


## foldcomp_extract

### Tool Description
Command-line tool for manipulating PDB/CIF files, including compression, decompression, extraction, and comparison.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
- **Homepage**: https://github.com/steineggerlab/foldcomp
- **Package**: https://anaconda.org/channels/bioconda/packages/foldcomp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: foldcomp compress <pdb|cif> [<fcz>]
       foldcomp compress [-t number] <dir|tar(.gz)> [<dir|tar|db>]
       foldcomp decompress <fcz|tar> [<pdb>]
       foldcomp decompress [-t number] <dir|tar(.gz)|db> [<dir|tar>]
       foldcomp extract [--plddt|--amino-acid] <fcz> [<fasta>]
       foldcomp extract [--plddt|--amino-acid] [-t number] <dir|tar(.gz)|db> [<fasta_out>]
       foldcomp check <fcz>
       foldcomp check [-t number] <dir|tar(.gz)|db>
       foldcomp rmsd <pdb|cif> <pdb|cif>
 -h, --help               print this help message
 -v, --version            print version
 -t, --threads            threads for (de)compression of folders/tar files [default=1]
 -r, --recursive          recursively look for files in directory [default=0]
 -f, --file               input is a list of files [default=0]
 -a, --alt                use alternative atom order [default=false]
 -b, --break              interval size to save absolute atom coordinates [default=25]
 -z, --tar                save as tar file [default=false]
 -d, --db                 save as database [default=false]
 -y, --overwrite          overwrite existing files [default=false]
 -l, --id-list            a file of id list to be processed (only for database input)
 -m, --id-mode            id mode for database input. 0: database keys, 1: names (.lookup) [default=1]
 --skip-discontinuous     skip PDB with with discontinuous residues (only batch compression)
 --check                  check FCZ before and skip entries with error (only for batch decompression)
 --plddt                  extract pLDDT score (only for extraction mode)
 -p, --plddt-digits       extract pLDDT score with specified number of digits (only for extraction mode)
                          - 1: single digit (fasta-like format), 2: 2-digit(00-99; tsv), 3: 3-digit, 4: 4-digit (max)
 --fasta, --amino-acid    extract amino acid sequence (only for extraction mode)
 --no-merge               do not merge output files (only for extraction mode)
 --use-title              use TITLE as the output file name (only for extraction mode)
 --time                   measure time for compression/decompression
 --use-cache              use cached index for database input [default=false]
```


## foldcomp_check

### Tool Description
Command-line tool for compressing, decompressing, checking, and comparing protein structure files.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
- **Homepage**: https://github.com/steineggerlab/foldcomp
- **Package**: https://anaconda.org/channels/bioconda/packages/foldcomp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: foldcomp compress <pdb|cif> [<fcz>]
       foldcomp compress [-t number] <dir|tar(.gz)> [<dir|tar|db>]
       foldcomp decompress <fcz|tar> [<pdb>]
       foldcomp decompress [-t number] <dir|tar(.gz)|db> [<dir|tar>]
       foldcomp extract [--plddt|--amino-acid] <fcz> [<fasta>]
       foldcomp extract [--plddt|--amino-acid] [-t number] <dir|tar(.gz)|db> [<fasta_out>]
       foldcomp check <fcz>
       foldcomp check [-t number] <dir|tar(.gz)|db>
       foldcomp rmsd <pdb|cif> <pdb|cif>
 -h, --help               print this help message
 -v, --version            print version
 -t, --threads            threads for (de)compression of folders/tar files [default=1]
 -r, --recursive          recursively look for files in directory [default=0]
 -f, --file               input is a list of files [default=0]
 -a, --alt                use alternative atom order [default=false]
 -b, --break              interval size to save absolute atom coordinates [default=25]
 -z, --tar                save as tar file [default=false]
 -d, --db                 save as database [default=false]
 -y, --overwrite          overwrite existing files [default=false]
 -l, --id-list            a file of id list to be processed (only for database input)
 -m, --id-mode            id mode for database input. 0: database keys, 1: names (.lookup) [default=1]
 --skip-discontinuous     skip PDB with with discontinuous residues (only batch compression)
 --check                  check FCZ before and skip entries with error (only for batch decompression)
 --plddt                  extract pLDDT score (only for extraction mode)
 -p, --plddt-digits       extract pLDDT score with specified number of digits (only for extraction mode)
                          - 1: single digit (fasta-like format), 2: 2-digit(00-99; tsv), 3: 3-digit, 4: 4-digit (max)
 --fasta, --amino-acid    extract amino acid sequence (only for extraction mode)
 --no-merge               do not merge output files (only for extraction mode)
 --use-title              use TITLE as the output file name (only for extraction mode)
 --time                   measure time for compression/decompression
 --use-cache              use cached index for database input [default=false]
```


## foldcomp_rmsd

### Tool Description
Compress and decompress protein structure files (PDB, CIF) and calculate RMSD.

### Metadata
- **Docker Image**: quay.io/biocontainers/foldcomp:1.0.0--h7f5d12c_0
- **Homepage**: https://github.com/steineggerlab/foldcomp
- **Package**: https://anaconda.org/channels/bioconda/packages/foldcomp/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: foldcomp compress <pdb|cif> [<fcz>]
       foldcomp compress [-t number] <dir|tar(.gz)> [<dir|tar|db>]
       foldcomp decompress <fcz|tar> [<pdb>]
       foldcomp decompress [-t number] <dir|tar(.gz)|db> [<dir|tar>]
       foldcomp extract [--plddt|--amino-acid] <fcz> [<fasta>]
       foldcomp extract [--plddt|--amino-acid] [-t number] <dir|tar(.gz)|db> [<fasta_out>]
       foldcomp check <fcz>
       foldcomp check [-t number] <dir|tar(.gz)|db>
       foldcomp rmsd <pdb|cif> <pdb|cif>
 -h, --help               print this help message
 -v, --version            print version
 -t, --threads            threads for (de)compression of folders/tar files [default=1]
 -r, --recursive          recursively look for files in directory [default=0]
 -f, --file               input is a list of files [default=0]
 -a, --alt                use alternative atom order [default=false]
 -b, --break              interval size to save absolute atom coordinates [default=25]
 -z, --tar                save as tar file [default=false]
 -d, --db                 save as database [default=false]
 -y, --overwrite          overwrite existing files [default=false]
 -l, --id-list            a file of id list to be processed (only for database input)
 -m, --id-mode            id mode for database input. 0: database keys, 1: names (.lookup) [default=1]
 --skip-discontinuous     skip PDB with with discontinuous residues (only batch compression)
 --check                  check FCZ before and skip entries with error (only for batch decompression)
 --plddt                  extract pLDDT score (only for extraction mode)
 -p, --plddt-digits       extract pLDDT score with specified number of digits (only for extraction mode)
                          - 1: single digit (fasta-like format), 2: 2-digit(00-99; tsv), 3: 3-digit, 4: 4-digit (max)
 --fasta, --amino-acid    extract amino acid sequence (only for extraction mode)
 --no-merge               do not merge output files (only for extraction mode)
 --use-title              use TITLE as the output file name (only for extraction mode)
 --time                   measure time for compression/decompression
 --use-cache              use cached index for database input [default=false]
```


## Metadata
- **Skill**: generated
