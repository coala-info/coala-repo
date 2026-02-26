# hifihla CWL Generation Report

## hifihla_call-reads

### Tool Description
Call HLA loci from an aligned BAM of HiFi reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/hifihla
- **Package**: https://anaconda.org/channels/bioconda/packages/hifihla/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hifihla/overview
- **Total Downloads**: 5.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/PacificBiosciences/hifihla
- **Stars**: N/A
### Original Help Text
```text
Call HLA loci from an aligned BAM of HiFi reads

Usage: hifihla call-reads [OPTIONS] --abam <ALIGNED_READS>

Options:
  -j, --threads <THREADS>      Analysis threads [default: 1]
  -v, --verbose...             Enable verbose output
      --log-level <LOG_LEVEL>  Alternative to repeated -v/--verbose: set log level via key. [default: Warn]
  -h, --help                   Print help
  -V, --version                Print version

Input Options:
  -a, --abam <ALIGNED_READS>     Input assembly aligned to GRCh38 (no alts)
  -l, --loci [<LOCI>...]         Input comma-sep loci to extract [default: all]
  -d, --max_depth <MAX_DEPTH>    Maximum reads per locus [default: 50]
  -p, --partial                  Include partially-spanning reads
  -t, --haplotypes <HAPLOTYPES>  Haplotypes in sample [default: 2] [possible values: 1, 2]
  -s, --seed <SEED>              Random number seed for downsampling to max_depth [default: 42]

Output Options:
  -o, --out_prefix <OUT_PREFIX>  Output prefix
      --outdir <OUTDIR>          Output directory [deprecated]
  -f, --full_length              Full length IMGT records only (exclude exon-only records)
  -x, --max_matches <MATCHES>    Maximum matches in output report [default: 10]
  -m, --min_allele_freq <MAF>    Minimum allele frequency [default: 0.1]
  -b, --min_cdf <MINCDF>         Minimum binomial CDF to call het/hom [default: 0.001]

Presets:
      --preset <PRESET>  Sequence type presets [possible values: te, wgs]

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## hifihla_call-contigs

### Tool Description
Extract HLA loci from assembled MHC contigs & call star alleles on extracted sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/hifihla
- **Package**: https://anaconda.org/channels/bioconda/packages/hifihla/overview
- **Validation**: PASS

### Original Help Text
```text
Extract HLA loci from assembled MHC contigs & call star alleles on extracted sequences

Usage: hifihla call-contigs [OPTIONS] --abam <ALIGNED_ASSEMBLY> --hap1 <HAP1_FA>

Options:
  -a, --abam <ALIGNED_ASSEMBLY>  Input assembly aligned to GRCh38
  -p, --hap1 <HAP1_FA>           Input hap1 assembly fa(.gz)
  -m, --hap2 <HAP2_FA>           Input hap2 assembly fa(.gz) (optional)
  -o, --out_prefix <OUT_PREFIX>  Output prefix
      --outdir <OUTDIR>          Output directory [deprecated]
  -l, --loci [<LOCI>...]         Input comma-sep loci to extract [default: all]
  -s, --min_length <MINLENGTH>   Minimum length of extracted targets [default: 1000]
  -f, --full_length              Full length IMGT records only
  -x, --max_matches <MATCHES>    Maximum equivalent matches per query in report [default: 10]
  -j, --threads <THREADS>        Analysis threads [default: 1]
  -v, --verbose...               Enable verbose output
      --log-level <LOG_LEVEL>    Alternative to repeated -v/--verbose: set log level via key.
                                 Equivalence to -v/--verbose:
                                       => "Warn"
                                    -v => "Info"
                                   -vv => "Debug"
                                  -vvv => "Trace" [default: Warn]
  -h, --help                     Print help
  -V, --version                  Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## hifihla_call-consensus

### Tool Description
Call HLA Star (*) alleles from consensus sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/hifihla
- **Package**: https://anaconda.org/channels/bioconda/packages/hifihla/overview
- **Validation**: PASS

### Original Help Text
```text
Call HLA Star (*) alleles from consensus sequences

Usage: hifihla call-consensus [OPTIONS] --fasta <FASTA>

Options:
  -f, --fasta <FASTA>            Input fasta file of consensus sequences
  -o, --out_prefix <OUT_PREFIX>  Output prefix
      --outdir <OUTDIR>          Output directory [deprecated]
  -c, --cdna                     Enable cDNA-only calling
  -e, --exon2                    Require Exon2 in query sequence
  -l, --full_length              Full length IMGT records only
  -j, --threads <THREADS>        Analysis threads [default: 1]
  -x, --max_matches <MATCHES>    Maximum equivalent matches per query in report [default: 10]
  -v, --verbose...               Enable verbose output
      --log-level <LOG_LEVEL>    Alternative to repeated -v/--verbose: set log level via key.
                                 Equivalence to -v/--verbose:
                                       => "Warn"
                                    -v => "Info"
                                   -vv => "Debug"
                                  -vvv => "Trace" [default: Warn]
  -h, --help                     Print help
  -V, --version                  Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## hifihla_align-imgt

### Tool Description
Align queries to IMGT/HLA genomic accession sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/hifihla
- **Package**: https://anaconda.org/channels/bioconda/packages/hifihla/overview
- **Validation**: PASS

### Original Help Text
```text
Align queries to IMGT/HLA genomic accession sequences

Usage: hifihla align-imgt [OPTIONS]

Options:
  -f, --fasta <FASTA>           Fasta with query sequence(s)
  -q, --qids [<QIDS>...]        Comma-sep query IDs
  -t, --targets [<TARGETS>...]  Comma-sep target IDs (map refs)
  -n, --tnames [<TNAMES>...]    Comma-sep target Names (map refs)
  -e, --exact                   Exact target name matches only (default starts-with)
  -j, --threads <THREADS>       Analysis threads [default: 1]
  -v, --verbose...              Enable verbose output
      --log-level <LOG_LEVEL>   Alternative to repeated -v/--verbose: set log level via key.
                                Equivalence to -v/--verbose:
                                      => "Warn"
                                   -v => "Info"
                                  -vv => "Debug"
                                 -vvv => "Trace" [default: Warn]
  -h, --help                    Print help
  -V, --version                 Print version

Copyright (C) 2004-2026     Pacific Biosciences of California, Inc.
This program comes with ABSOLUTELY NO WARRANTY; it is intended for
Research Use Only and not for use in diagnostic procedures.
```


## Metadata
- **Skill**: generated

## hifihla

### Tool Description
Call HLA loci from an aligned BAM of HiFi reads

### Metadata
- **Docker Image**: quay.io/biocontainers/hifihla:0.3.1--hdfd78af_0
- **Homepage**: https://github.com/PacificBiosciences/hifihla
- **Package**: https://anaconda.org/channels/bioconda/packages/hifihla/overview
- **Validation**: PASS
### Original Help Text
```text
Usage: hifihla <COMMAND>

Commands:
  call-reads      Call HLA loci from an aligned BAM of HiFi reads
  call-contigs    Extract HLA loci from assembled MHC contigs & call star alleles on extracted sequences
  call-consensus  Call HLA Star (*) alleles from consensus sequences
  align-imgt      Align queries to IMGT/HLA genomic accession sequences
  help            Print this message or the help of the given subcommand(s)

Options:
  -h, --help     Print help
  -V, --version  Print version
```

