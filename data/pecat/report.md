# pecat CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pecat_assemble | PASS |  |
| pecat_config | PASS |  |
| pecat_correct | PASS |  |
| pecat_unzip | Failed | image problem: racon in the image crashes with Illegal instruction during the polishing step |

## pecat_config

### Tool Description
Generate a default PECAT configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
- **Homepage**: https://github.com/lemene/PECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/pecat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pecat.pl correct|assemble|unzip|config cfg_fname
    correct:     correct rawreads
    assemble:    generate haplotype-collapsed assembly
    unzip:       generate diploid assembly
    config:      generate default config file
```

## pecat_correct

### Tool Description
Correct raw long reads (PECAT read correction step).

### Metadata
- **Docker Image**: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
- **Homepage**: https://github.com/lemene/PECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/pecat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pecat.pl correct|assemble|unzip|config cfg_fname
    correct:     correct rawreads
    assemble:    generate haplotype-collapsed assembly
    unzip:       generate diploid assembly
    config:      generate default config file
```

## pecat_assemble

### Tool Description
Generate a haplotype-collapsed assembly from corrected reads (PECAT).

### Metadata
- **Docker Image**: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
- **Homepage**: https://github.com/lemene/PECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/pecat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pecat.pl correct|assemble|unzip|config cfg_fname
    correct:     correct rawreads
    assemble:    generate haplotype-collapsed assembly
    unzip:       generate diploid assembly
    config:      generate default config file
```

## pecat_unzip

### Tool Description
Generate a diploid assembly from a PECAT haplotype-collapsed assembly.

### Metadata
- **Docker Image**: quay.io/biocontainers/pecat:0.0.3--hdb21b49_2
- **Homepage**: https://github.com/lemene/PECAT
- **Package**: https://anaconda.org/channels/bioconda/packages/pecat/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: pecat.pl correct|assemble|unzip|config cfg_fname
    correct:     correct rawreads
    assemble:    generate haplotype-collapsed assembly
    unzip:       generate diploid assembly
    config:      generate default config file
```

## Metadata
- **Skill**: generated

