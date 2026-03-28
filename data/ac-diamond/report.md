# ac-diamond CWL Generation Report

## ac-diamond_makedb

### Tool Description
Build AC-DIAMOND database from a FASTA file

### Metadata
- **Docker Image**: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
- **Homepage**: https://github.com/Maihj/AC-DIAMOND
- **Package**: https://anaconda.org/channels/bioconda/packages/ac-diamond/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ac-diamond/overview
- **Total Downloads**: 7.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Maihj/AC-DIAMOND
- **Stars**: N/A
### Original Help Text
```text
Syntax:
  ac-diamond COMMAND [OPTIONS]

Commands:
  makedb	Build AC-DIAMOND database from a FASTA file
  align	Align DNA query sequences against a protein reference database
  view	View AC-DIAMOND alignment archive (DAA) formatted file

General options:
  -h [ --help ]             produce help message
  -p [ --threads ] arg (=0) number of cpu threads
  -d [ --db ] arg           database file
  -a [ --daa ] arg          AC-DIAMOND alignment archive (DAA) file
  -v [ --verbose ]          enable verbose out
  --log                     enable debug log

Makedb options:
  --in arg                input reference file in FASTA format
  -b [ --block-size ] arg reference sequence block size in billions of letters 
                          (default=4)
  --sensitive             enable building index for sensitive mode 
                          (default:fast)

Aligner options:
  -z [ --query-block-size ] arg (=6) query sequence block size in billions of 
                                     letters (default=6)
  -q [ --query ] arg                 input query file
  -k [ --max-target-seqs ] arg (=25) maximum number of target sequences to 
                                     report alignments for
  --top arg (=100)                   report alignments within this percentage 
                                     range of top alignment score (overrides 
                                     --max-target-seqs)
  --compress arg (=0)                compression for output files (0=none, 
                                     1=gzip)
  -e [ --evalue ] arg (=0.001)       maximum e-value to report alignments
  --min-score arg (=0)               minimum bit score to report alignments 
                                     (overrides e-value setting)
  --id arg (=0)                      minimum identity% to report an alignment
  --sensitive                        enable sensitive mode (default: fast)
  -t [ --tmpdir ] arg (=/dev/shm)    directory for temporary files
  --gapopen arg (=-1)                gap open penalty, -1=default (11 for 
                                     protein)
  --gapextend arg (=-1)              gap extension penalty, -1=default (1 for 
                                     protein)
  --matrix arg (=blosum62)           score matrix for protein alignment
  --seg arg                          enable SEG masking of queries (yes/no)

Advanced options (0=auto):
  -w [ --window ] arg (=0)        window size for local hit search
  --xdrop arg (=20)               xdrop for ungapped alignment
  -X [ --gapped-xdrop ] arg (=20) xdrop for gapped alignment in bits
  --ungapped-score arg (=0)       minimum raw alignment score to continue local
                                  extension
  --hit-band arg (=0)             band for hit verification
  --hit-score arg (=0)            minimum score to keep a tentative alignment
  --band arg (=0)                 band for dynamic programming computation
  --index-mode arg (=0)           index mode (1=10x1, 2=10x8)
  --fetch-size arg (=4096)        trace point fetch size
  --single-domain                 Discard secondary domains within one target 
                                  sequence

View options:
  -o [ --out ] arg           output file
  -f [ --outfmt ] arg (=tab) output format (tab/sam)
  --forwardonly              only show alignments of forward strand
```


## ac-diamond_align

### Tool Description
Align DNA query sequences against a protein reference database

### Metadata
- **Docker Image**: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
- **Homepage**: https://github.com/Maihj/AC-DIAMOND
- **Package**: https://anaconda.org/channels/bioconda/packages/ac-diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Syntax:
  ac-diamond COMMAND [OPTIONS]

Commands:
  makedb	Build AC-DIAMOND database from a FASTA file
  align	Align DNA query sequences against a protein reference database
  view	View AC-DIAMOND alignment archive (DAA) formatted file

General options:
  -h [ --help ]             produce help message
  -p [ --threads ] arg (=0) number of cpu threads
  -d [ --db ] arg           database file
  -a [ --daa ] arg          AC-DIAMOND alignment archive (DAA) file
  -v [ --verbose ]          enable verbose out
  --log                     enable debug log

Makedb options:
  --in arg                input reference file in FASTA format
  -b [ --block-size ] arg reference sequence block size in billions of letters 
                          (default=4)
  --sensitive             enable building index for sensitive mode 
                          (default:fast)

Aligner options:
  -z [ --query-block-size ] arg (=6) query sequence block size in billions of 
                                     letters (default=6)
  -q [ --query ] arg                 input query file
  -k [ --max-target-seqs ] arg (=25) maximum number of target sequences to 
                                     report alignments for
  --top arg (=100)                   report alignments within this percentage 
                                     range of top alignment score (overrides 
                                     --max-target-seqs)
  --compress arg (=0)                compression for output files (0=none, 
                                     1=gzip)
  -e [ --evalue ] arg (=0.001)       maximum e-value to report alignments
  --min-score arg (=0)               minimum bit score to report alignments 
                                     (overrides e-value setting)
  --id arg (=0)                      minimum identity% to report an alignment
  --sensitive                        enable sensitive mode (default: fast)
  -t [ --tmpdir ] arg (=/dev/shm)    directory for temporary files
  --gapopen arg (=-1)                gap open penalty, -1=default (11 for 
                                     protein)
  --gapextend arg (=-1)              gap extension penalty, -1=default (1 for 
                                     protein)
  --matrix arg (=blosum62)           score matrix for protein alignment
  --seg arg                          enable SEG masking of queries (yes/no)

Advanced options (0=auto):
  -w [ --window ] arg (=0)        window size for local hit search
  --xdrop arg (=20)               xdrop for ungapped alignment
  -X [ --gapped-xdrop ] arg (=20) xdrop for gapped alignment in bits
  --ungapped-score arg (=0)       minimum raw alignment score to continue local
                                  extension
  --hit-band arg (=0)             band for hit verification
  --hit-score arg (=0)            minimum score to keep a tentative alignment
  --band arg (=0)                 band for dynamic programming computation
  --index-mode arg (=0)           index mode (1=10x1, 2=10x8)
  --fetch-size arg (=4096)        trace point fetch size
  --single-domain                 Discard secondary domains within one target 
                                  sequence

View options:
  -o [ --out ] arg           output file
  -f [ --outfmt ] arg (=tab) output format (tab/sam)
  --forwardonly              only show alignments of forward strand
```


## ac-diamond_view

### Tool Description
View AC-DIAMOND alignment archive (DAA) formatted file

### Metadata
- **Docker Image**: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
- **Homepage**: https://github.com/Maihj/AC-DIAMOND
- **Package**: https://anaconda.org/channels/bioconda/packages/ac-diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Syntax:
  ac-diamond COMMAND [OPTIONS]

Commands:
  makedb	Build AC-DIAMOND database from a FASTA file
  align	Align DNA query sequences against a protein reference database
  view	View AC-DIAMOND alignment archive (DAA) formatted file

General options:
  -h [ --help ]             produce help message
  -p [ --threads ] arg (=0) number of cpu threads
  -d [ --db ] arg           database file
  -a [ --daa ] arg          AC-DIAMOND alignment archive (DAA) file
  -v [ --verbose ]          enable verbose out
  --log                     enable debug log

Makedb options:
  --in arg                input reference file in FASTA format
  -b [ --block-size ] arg reference sequence block size in billions of letters 
                          (default=4)
  --sensitive             enable building index for sensitive mode 
                          (default:fast)

Aligner options:
  -z [ --query-block-size ] arg (=6) query sequence block size in billions of 
                                     letters (default=6)
  -q [ --query ] arg                 input query file
  -k [ --max-target-seqs ] arg (=25) maximum number of target sequences to 
                                     report alignments for
  --top arg (=100)                   report alignments within this percentage 
                                     range of top alignment score (overrides 
                                     --max-target-seqs)
  --compress arg (=0)                compression for output files (0=none, 
                                     1=gzip)
  -e [ --evalue ] arg (=0.001)       maximum e-value to report alignments
  --min-score arg (=0)               minimum bit score to report alignments 
                                     (overrides e-value setting)
  --id arg (=0)                      minimum identity% to report an alignment
  --sensitive                        enable sensitive mode (default: fast)
  -t [ --tmpdir ] arg (=/dev/shm)    directory for temporary files
  --gapopen arg (=-1)                gap open penalty, -1=default (11 for 
                                     protein)
  --gapextend arg (=-1)              gap extension penalty, -1=default (1 for 
                                     protein)
  --matrix arg (=blosum62)           score matrix for protein alignment
  --seg arg                          enable SEG masking of queries (yes/no)

Advanced options (0=auto):
  -w [ --window ] arg (=0)        window size for local hit search
  --xdrop arg (=20)               xdrop for ungapped alignment
  -X [ --gapped-xdrop ] arg (=20) xdrop for gapped alignment in bits
  --ungapped-score arg (=0)       minimum raw alignment score to continue local
                                  extension
  --hit-band arg (=0)             band for hit verification
  --hit-score arg (=0)            minimum score to keep a tentative alignment
  --band arg (=0)                 band for dynamic programming computation
  --index-mode arg (=0)           index mode (1=10x1, 2=10x8)
  --fetch-size arg (=4096)        trace point fetch size
  --single-domain                 Discard secondary domains within one target 
                                  sequence

View options:
  -o [ --out ] arg           output file
  -f [ --outfmt ] arg (=tab) output format (tab/sam)
  --forwardonly              only show alignments of forward strand
```


## ac-diamond_letters

### Tool Description
AC-DIAMOND is a tool for aligning DNA query sequences against a protein reference database, featuring database building, alignment, and viewing capabilities.

### Metadata
- **Docker Image**: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
- **Homepage**: https://github.com/Maihj/AC-DIAMOND
- **Package**: https://anaconda.org/channels/bioconda/packages/ac-diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Syntax:
  ac-diamond COMMAND [OPTIONS]

Commands:
  makedb	Build AC-DIAMOND database from a FASTA file
  align	Align DNA query sequences against a protein reference database
  view	View AC-DIAMOND alignment archive (DAA) formatted file

General options:
  -h [ --help ]             produce help message
  -p [ --threads ] arg (=0) number of cpu threads
  -d [ --db ] arg           database file
  -a [ --daa ] arg          AC-DIAMOND alignment archive (DAA) file
  -v [ --verbose ]          enable verbose out
  --log                     enable debug log

Makedb options:
  --in arg                input reference file in FASTA format
  -b [ --block-size ] arg reference sequence block size in billions of letters 
                          (default=4)
  --sensitive             enable building index for sensitive mode 
                          (default:fast)

Aligner options:
  -z [ --query-block-size ] arg (=6) query sequence block size in billions of 
                                     letters (default=6)
  -q [ --query ] arg                 input query file
  -k [ --max-target-seqs ] arg (=25) maximum number of target sequences to 
                                     report alignments for
  --top arg (=100)                   report alignments within this percentage 
                                     range of top alignment score (overrides 
                                     --max-target-seqs)
  --compress arg (=0)                compression for output files (0=none, 
                                     1=gzip)
  -e [ --evalue ] arg (=0.001)       maximum e-value to report alignments
  --min-score arg (=0)               minimum bit score to report alignments 
                                     (overrides e-value setting)
  --id arg (=0)                      minimum identity% to report an alignment
  --sensitive                        enable sensitive mode (default: fast)
  -t [ --tmpdir ] arg (=/dev/shm)    directory for temporary files
  --gapopen arg (=-1)                gap open penalty, -1=default (11 for 
                                     protein)
  --gapextend arg (=-1)              gap extension penalty, -1=default (1 for 
                                     protein)
  --matrix arg (=blosum62)           score matrix for protein alignment
  --seg arg                          enable SEG masking of queries (yes/no)

Advanced options (0=auto):
  -w [ --window ] arg (=0)        window size for local hit search
  --xdrop arg (=20)               xdrop for ungapped alignment
  -X [ --gapped-xdrop ] arg (=20) xdrop for gapped alignment in bits
  --ungapped-score arg (=0)       minimum raw alignment score to continue local
                                  extension
  --hit-band arg (=0)             band for hit verification
  --hit-score arg (=0)            minimum score to keep a tentative alignment
  --band arg (=0)                 band for dynamic programming computation
  --index-mode arg (=0)           index mode (1=10x1, 2=10x8)
  --fetch-size arg (=4096)        trace point fetch size
  --single-domain                 Discard secondary domains within one target 
                                  sequence

View options:
  -o [ --out ] arg           output file
  -f [ --outfmt ] arg (=tab) output format (tab/sam)
  --forwardonly              only show alignments of forward strand
```


## ac-diamond_report

### Tool Description
AC-DIAMOND: A tool for building databases, aligning DNA sequences against protein databases, and viewing alignment archives.

### Metadata
- **Docker Image**: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
- **Homepage**: https://github.com/Maihj/AC-DIAMOND
- **Package**: https://anaconda.org/channels/bioconda/packages/ac-diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Syntax:
  ac-diamond COMMAND [OPTIONS]

Commands:
  makedb	Build AC-DIAMOND database from a FASTA file
  align	Align DNA query sequences against a protein reference database
  view	View AC-DIAMOND alignment archive (DAA) formatted file

General options:
  -h [ --help ]             produce help message
  -p [ --threads ] arg (=0) number of cpu threads
  -d [ --db ] arg           database file
  -a [ --daa ] arg          AC-DIAMOND alignment archive (DAA) file
  -v [ --verbose ]          enable verbose out
  --log                     enable debug log

Makedb options:
  --in arg                input reference file in FASTA format
  -b [ --block-size ] arg reference sequence block size in billions of letters 
                          (default=4)
  --sensitive             enable building index for sensitive mode 
                          (default:fast)

Aligner options:
  -z [ --query-block-size ] arg (=6) query sequence block size in billions of 
                                     letters (default=6)
  -q [ --query ] arg                 input query file
  -k [ --max-target-seqs ] arg (=25) maximum number of target sequences to 
                                     report alignments for
  --top arg (=100)                   report alignments within this percentage 
                                     range of top alignment score (overrides 
                                     --max-target-seqs)
  --compress arg (=0)                compression for output files (0=none, 
                                     1=gzip)
  -e [ --evalue ] arg (=0.001)       maximum e-value to report alignments
  --min-score arg (=0)               minimum bit score to report alignments 
                                     (overrides e-value setting)
  --id arg (=0)                      minimum identity% to report an alignment
  --sensitive                        enable sensitive mode (default: fast)
  -t [ --tmpdir ] arg (=/dev/shm)    directory for temporary files
  --gapopen arg (=-1)                gap open penalty, -1=default (11 for 
                                     protein)
  --gapextend arg (=-1)              gap extension penalty, -1=default (1 for 
                                     protein)
  --matrix arg (=blosum62)           score matrix for protein alignment
  --seg arg                          enable SEG masking of queries (yes/no)

Advanced options (0=auto):
  -w [ --window ] arg (=0)        window size for local hit search
  --xdrop arg (=20)               xdrop for ungapped alignment
  -X [ --gapped-xdrop ] arg (=20) xdrop for gapped alignment in bits
  --ungapped-score arg (=0)       minimum raw alignment score to continue local
                                  extension
  --hit-band arg (=0)             band for hit verification
  --hit-score arg (=0)            minimum score to keep a tentative alignment
  --band arg (=0)                 band for dynamic programming computation
  --index-mode arg (=0)           index mode (1=10x1, 2=10x8)
  --fetch-size arg (=4096)        trace point fetch size
  --single-domain                 Discard secondary domains within one target 
                                  sequence

View options:
  -o [ --out ] arg           output file
  -f [ --outfmt ] arg (=tab) output format (tab/sam)
  --forwardonly              only show alignments of forward strand
```


## ac-diamond_range

### Tool Description
AC-DIAMOND is a tool for aligning DNA query sequences against a protein reference database, building databases, and viewing alignment archives.

### Metadata
- **Docker Image**: quay.io/biocontainers/ac-diamond:1.0--boost1.64_0
- **Homepage**: https://github.com/Maihj/AC-DIAMOND
- **Package**: https://anaconda.org/channels/bioconda/packages/ac-diamond/overview
- **Validation**: PASS

### Original Help Text
```text
Syntax:
  ac-diamond COMMAND [OPTIONS]

Commands:
  makedb	Build AC-DIAMOND database from a FASTA file
  align	Align DNA query sequences against a protein reference database
  view	View AC-DIAMOND alignment archive (DAA) formatted file

General options:
  -h [ --help ]             produce help message
  -p [ --threads ] arg (=0) number of cpu threads
  -d [ --db ] arg           database file
  -a [ --daa ] arg          AC-DIAMOND alignment archive (DAA) file
  -v [ --verbose ]          enable verbose out
  --log                     enable debug log

Makedb options:
  --in arg                input reference file in FASTA format
  -b [ --block-size ] arg reference sequence block size in billions of letters 
                          (default=4)
  --sensitive             enable building index for sensitive mode 
                          (default:fast)

Aligner options:
  -z [ --query-block-size ] arg (=6) query sequence block size in billions of 
                                     letters (default=6)
  -q [ --query ] arg                 input query file
  -k [ --max-target-seqs ] arg (=25) maximum number of target sequences to 
                                     report alignments for
  --top arg (=100)                   report alignments within this percentage 
                                     range of top alignment score (overrides 
                                     --max-target-seqs)
  --compress arg (=0)                compression for output files (0=none, 
                                     1=gzip)
  -e [ --evalue ] arg (=0.001)       maximum e-value to report alignments
  --min-score arg (=0)               minimum bit score to report alignments 
                                     (overrides e-value setting)
  --id arg (=0)                      minimum identity% to report an alignment
  --sensitive                        enable sensitive mode (default: fast)
  -t [ --tmpdir ] arg (=/dev/shm)    directory for temporary files
  --gapopen arg (=-1)                gap open penalty, -1=default (11 for 
                                     protein)
  --gapextend arg (=-1)              gap extension penalty, -1=default (1 for 
                                     protein)
  --matrix arg (=blosum62)           score matrix for protein alignment
  --seg arg                          enable SEG masking of queries (yes/no)

Advanced options (0=auto):
  -w [ --window ] arg (=0)        window size for local hit search
  --xdrop arg (=20)               xdrop for ungapped alignment
  -X [ --gapped-xdrop ] arg (=20) xdrop for gapped alignment in bits
  --ungapped-score arg (=0)       minimum raw alignment score to continue local
                                  extension
  --hit-band arg (=0)             band for hit verification
  --hit-score arg (=0)            minimum score to keep a tentative alignment
  --band arg (=0)                 band for dynamic programming computation
  --index-mode arg (=0)           index mode (1=10x1, 2=10x8)
  --fetch-size arg (=4096)        trace point fetch size
  --single-domain                 Discard secondary domains within one target 
                                  sequence

View options:
  -o [ --out ] arg           output file
  -f [ --outfmt ] arg (=tab) output format (tab/sam)
  --forwardonly              only show alignments of forward strand
```


## Metadata
- **Skill**: generated
