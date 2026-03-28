# polap CWL Generation Report

## polap_assemble

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-12-21
- **GitHub**: https://github.com/goshng/polap
- **Stars**: N/A
### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_assemble1

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_assemble2

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_readassemble

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_disassemble

### Tool Description
Disassemble a polap file.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
[info] new profile (): /root/.polap/profiles/.yaml
[2026-02-26 18:47:01 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113]  number=$(echo "$input" | grep -oE '^[0-9]+(\.[0-9]+)?') ; number=
[2026-02-26 18:47:01 (/usr/local) main@polap:71] CALLED FROM
[2026-02-26 18:47:01 (/usr/local) _run_polap_disassemble@polap-cmd-disassemble.sh:2365] CALLED FROM
[2026-02-26 18:47:01 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113] CALLED FROM
[2026-02-26 18:47:01 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113]  number=$(echo "$input" | grep -oE '^[0-9]+(\.[0-9]+)?') ; number=
[2026-02-26 18:47:01 (/usr/local) main@polap:71] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _run_polap_disassemble@polap-cmd-disassemble.sh:2365] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113]  number=$(echo "$input" | grep -oE '^[0-9]+(\.[0-9]+)?') ; number=
[2026-02-26 18:47:02 (/usr/local) main@polap:71] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _run_polap_disassemble@polap-cmd-disassemble.sh:2369] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113]  number=$(echo "$input" | grep -oE '^[0-9]+(\.[0-9]+)?') ; number=
[2026-02-26 18:47:02 (/usr/local) main@polap:71] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _run_polap_disassemble@polap-cmd-disassemble.sh:2369] CALLED FROM
[2026-02-26 18:47:02 (/usr/local) _polap_utility_convert_unit_to_bp@run-polap-function-utilities.sh:113] CALLED FROM
/usr/local/bin/polaplib/polap-cmd-disassemble.sh: line 2547: _polap_echo0: command not found
```


## polap_annotate

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_seeds

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_prepare-polishing

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_polish

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_git

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_cd

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## polap_polap

### Tool Description
Plant organelle DNA long-read assembly pipeline.

### Metadata
- **Docker Image**: quay.io/biocontainers/polap:0.5.3.1--py312hdfd78af_0
- **Homepage**: https://github.com/goshng/polap
- **Package**: https://anaconda.org/channels/bioconda/packages/polap/overview
- **Validation**: PASS

### Original Help Text
```text
POLAP - Plant organelle DNA long-read assembly pipeline.

Version v0.5.3.1-416bb09

Usage: polap [command] [--help] [-o|--outdir <arg>]
      [-l|--long-reads <arg>] [-a|--short-read1 <arg>] [-b|--short-read2 <arg>]
      [-i|--inum <arg>] [-j|--jnum <arg>] [-w|--single-min <arg>]

Commands:
  assemble - assemble plant organelle genomes using low-quality ONT data
  assemble1 - assemble a whole genome using Flye
  assemble2 - assemble an organelle genome using seed contigs
  readassemble - assemble an organelle genome
  disassemble - assemble a plastid genome by subsampling
  annotate - find organelle genes in a Flye genome assembly
  seeds - select seed contigs
  prepare-polishing - do this before polish command for short-read polishing
  polish - polish an organelle genome sequence
  assemble - execute assemble1 & assemble2 (not tested yet!)

Example:
  git clone https://github.com/goshng/polap.git
  cd polap/test
  polap --test

Place your long-read and short-read files with the followid file names at a folder:
  long-read file: l.fq
  short-read file: s1.fq, s2.fq

Then, execute:
  polap init
```


## Metadata
- **Skill**: generated
