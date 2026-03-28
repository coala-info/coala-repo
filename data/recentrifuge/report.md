# recentrifuge CWL Generation Report

## recentrifuge_rcf

### Tool Description
Robust comparative analysis and contamination removal for metagenomics

### Metadata
- **Docker Image**: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/khyox/recentrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/recentrifuge/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/recentrifuge/overview
- **Total Downloads**: 91.6K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/khyox/recentrifuge
- **Stars**: N/A
### Original Help Text
```text
=-= /usr/local/bin/rcf =-= v2.1.1 - Feb 2026 =-= by Jose Manuel Martí =-=

usage: rcf [-h] [-V] [-n PATH] [--format GENERIC_FORMAT]
           (-f FILE | -g FILE | -l FILE | -r FILE | -k FILE) [-o FILE]
           [-e OUTPUT_TYPE] [-p] [--nohtml] [-a | -c CONTROLS_NUMBER]
           [-s SCORING] [-y NUMBER] [-m INT] [-x TAXID] [-i TAXID] [-z NUMBER]
           [-w INT] [-u SUMMARY_BEHAVIOR] [-t] [--nokollapse] [-d]
           [--no-strain] [--sequential] [-T NUMBER]

Robust comparative analysis and contamination removal for metagenomics

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit

input:
  Define Recentrifuge input files and formats

  -n PATH, --nodespath PATH
                        path for the nodes information files (nodes.dmp and
                        names.dmp from NCBI)
  --format GENERIC_FORMAT
                        format of the output files from a generic classifier
                        included with the option -g; It is a string like
                        "TYP:csv,TID:1,LEN:3,SCO:6,UNC:0" where valid file
                        TYPes are csv/tsv/ssv, and the rest of fields indicate
                        the number of column used (starting in 1) for the
                        TaxIDs assigned, the LENgth of the read, the SCOre
                        given to the assignment, and the taxid code used for
                        UNClassified reads
  -f FILE, --file FILE  Centrifuge output files; if a single directory is
                        entered, every .out file inside will be taken as a
                        different sample; multiple -f is available to include
                        several Centrifuge samples
  -g FILE, --generic FILE
                        output file from a generic classifier; it requires the
                        flag --format (see such option for details); if a
                        single directory is entered, every file inside will be
                        taken as a different sample; multiple -g is available
                        to include several generic samples by filename
  -l FILE, --lmat FILE  LMAT output dir or file prefix; if just "." is
                        entered, every subdirectory under the current
                        directory will be taken as a sample and scanned
                        looking for LMAT output files; multiple -l is
                        available to include several samples
  -r FILE, --clark FILE
                        CLARK full-mode output files; if a single directory is
                        entered, every .csv file inside will be taken as a
                        different sample; multiple -r is available to include
                        several CLARK, CLARK-l, and CLARK-S full-mode samples
  -k FILE, --kraken FILE
                        Kraken output files; if a single directory is entered,
                        every .krk file inside will be taken as a different
                        sample; multiple -k is available to include several
                        Kraken (version 1 or 2) samples by filename

output:
  Related to the Recentrifuge output files

  -o FILE, --outprefix FILE
                        output prefix; if not given, it will be inferred from
                        input files; an HTML filename is still accepted for
                        backwards compatibility with legacy --outhtml option
  -e OUTPUT_TYPE, --extra OUTPUT_TYPE
                        type of extra output to be generated, and can be one
                        of ['FULL', 'CSV', 'MULTICSV', 'TSV', 'DYNOMICS']
  -p, --pickle          pickle (serialize) statistics and data results in
                        pandas DataFrames (format affected by selection of
                        --extra); one additional flag and the input samples
                        will be serialized as a dict of sample names and
                        TaxTree objects
  --nohtml              suppress saving the HTML output file

tuning:
  Coarse tuning of algorithm parameters

  -a, --avoidcross      avoid cross analysis
  -c CONTROLS_NUMBER, --controls CONTROLS_NUMBER
                        this number of first samples will be treated as
                        negative controls; default is no controls
  -s SCORING, --scoring SCORING
                        type of scoring to be applied, and can be one of
                        ['SHEL', 'LENGTH', 'LOGLENGTH', 'NORMA', 'LMAT',
                        'CLARK_C', 'CLARK_G', 'KRAKEN', 'GENERIC']
  -y NUMBER, --minscore NUMBER
                        minimum score/confidence of the classification of a
                        read to pass the quality filter; all pass by default
  -m INT, --mintaxa INT
                        minimum taxa to avoid collapsing one level into the
                        parent (if not specified a value will be automatically
                        assigned)
  -x TAXID, --exclude TAXID
                        NCBI taxid code to exclude a taxon and all underneath
                        (multiple -x is available to exclude several taxid)
  -i TAXID, --include TAXID
                        NCBI taxid code to include a taxon and all underneath
                        (multiple -i is available to include several taxid);
                        by default, all the taxa are considered for inclusion

fine tuning:
  Fine tuning of algorithm parameters

  -z NUMBER, --ctrlminscore NUMBER
                        minimum score/confidence of the classification of a
                        read in control samples to pass the quality filter; it
                        defaults to "minscore"
  -w INT, --ctrlmintaxa INT
                        minimum taxa to avoid collapsing one level into the
                        parent (if not specified a value will be automatically
                        assigned)
  -u SUMMARY_BEHAVIOR, --summary SUMMARY_BEHAVIOR
                        choice for summary behaviour, and can be one of
                        ['ADD', 'ONLY', 'AVOID']
  -t, --takeoutroot     remove counts directly assigned to the "root" level
  --nokollapse          show the "cellular organisms" taxon

advanced:
  Advanced modes of running

  -d, --debug           increase output verbosity and perform additional
                        checks
  --no-strain           disable strain level as the resolution limit for the
                        robust contamination removal algorithm; by default,
                        strain level is now enabled
  --sequential          deactivate parallel processing
  -T NUMBER, --threads NUMBER
                        number of threads to use for parallel processing; 0
                        (default) means legacy mode using min(cpu_count,
                        samples)

rcf - Release 2.1.1 - Feb 2026

    Copyright (C) 2017–2026, Jose Manuel Martí Martínez
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


## recentrifuge_rgf

### Tool Description
Robust comparative analysis and contamination removal for functional metagenomics

### Metadata
- **Docker Image**: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/khyox/recentrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/recentrifuge/overview
- **Validation**: PASS

### Original Help Text
```text
=-= /usr/local/bin/rgf =-= v2.1.1 =-= Feb 2026 =-=

usage: rgf [-h] [-V] [-n PATH] -f FILE [-a | -c CONTROLS_NUMBER]
           [-e OUTPUT_TYPE] [-o FILE] [-p] [-g] [--sequential] [-T NUMBER]
           [-m INT] [-i TAXID] [-x TAXID] [-u OPTION] [-t] [-y NUMBER]

Robust comparative analysis and contamination removal for functional metagenomics

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -n PATH, --nodespath PATH
                        path for the nodes information files (nodes.dmp and
                        names.dmp adapted from GO)
  -f FILE, --file FILE  GO output files in tab separated columns with the
                        format:taxid, gi, go, score and evalue. Currently, the
                        data for the analysis is retrieved from the last 3
                        columns. Multiple -f is available to include several
                        samples.
  -a, --avoidcross      avoid cross analysis
  -c CONTROLS_NUMBER, --controls CONTROLS_NUMBER
                        this number of first samples will be treated as
                        negative controls; default is no controls. CAUTION!
                        Regentrifuge direct support of control samples is
                        experimental.

output:
  Related to the output files

  -e OUTPUT_TYPE, --extra OUTPUT_TYPE
                        type of scoring to be applied, and can be one of
                        ['FULL', 'CSV', 'MULTICSV', 'TSV', 'DYNOMICS']
  -o FILE, --outhtml FILE
                        HTML output file (if not given the filename will be
                        inferred from input files)
  -p, --pickle          pickle (serialize) statistics and data results in
                        pandas DataFrames (format affected by selection of
                        --extra); one additional flag and the input samples
                        will be serialized as a dict of sample names and
                        TaxTree objects

mode:
  Specific modes of running

  -g, --debug           increase output verbosity and perform additional
                        checks
  --sequential          deactivate parallel processing
  -T NUMBER, --threads NUMBER
                        number of threads to use for parallel processing; 0
                        (default) means legacy mode using min(cpu_count,
                        samples)

tuning:
  Fine tuning of algorithm parameters

  -m INT, --mingene INT
                        minimum genes to avoid collapsing GO genes hierarchy
                        levels
  -i TAXID, --include TAXID
                        GO code to include a GO node and all underneath
                        (multiple -i is available to include several GOs); by
                        default all the GOs are considered for inclusion
  -x TAXID, --exclude TAXID
                        GO code to exclude a GO node and all underneath
                        (multiple -x is available to exclude several GOs)
  -u OPTION, --summary OPTION
                        select to "add" summary samples to other samples, or
                        to "only" show summary samples or to "avoid" summaries
                        at all
  -t, --takeoutroot     remove counts directly assigned to the "root" level
  -y NUMBER, --minscore NUMBER
                        minimum score/confidence of the annotation of a
                        scaffold to pass the quality filter; all pass by
                        default

rgf - Release 2.1.1 - Feb 2026

    Copyright (C) 2017–2026, Jose Manuel Martí Martínez
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


## recentrifuge_rextract

### Tool Description
Selectively extract reads by Centrifuge output

### Metadata
- **Docker Image**: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/khyox/recentrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/recentrifuge/overview
- **Validation**: PASS

### Original Help Text
```text
=-= /usr/local/bin/rextract =-= v2.1.1 - Feb 2026 =-= by Jose Manuel Martí =-=

usage: rextract [-h] [-d] -f FILE [-l NUMBER] [-m NUMBER] [-n PATH]
                [-u | -i TAXID] [-x TAXID] [-y NUMBER] [-z NUMBER]
                (-q FILE | -1 FILE) [-2 FILE] [-c] [-a] [-V]

Selectively extract reads by Centrifuge output

options:
  -h, --help            show this help message and exit
  -d, --debug           increase output verbosity and perform additional
                        checks
  -f FILE, --file FILE  Centrifuge output file
  -l NUMBER, --limit NUMBER
                        limit of sequence reads to extract; default: no limit
  -m NUMBER, --maxreads NUMBER
                        maximum number of sequence reads to search for the
                        taxa; default: no maximum
  -n PATH, --nodespath PATH
                        path for the nodes information files (nodes.dmp and
                        names.dmp from NCBI)
  -y NUMBER, --minscore NUMBER
                        minimum score/confidence of the classification of a
                        read to pass the quality filter; all pass by default
  -z NUMBER, --maxscore NUMBER
                        maximum score/confidence of the classification of a
                        read to pass the quality filter; all pass by default
  -c, --compress        any generated sequence file will be gzipped
  -a, --fasta           treat all the input and output sequence files as FASTA
                        instead of the default FASTQ
  -V, --version         show program's version number and exit

selection:
  Selection of reads based on the classification

  -u, --unclassified    Just extract unclassified reads (overrides other
                        options)
  -i TAXID, --include TAXID
                        NCBI taxid code to include a taxon and all underneath
                        (multiple -i is available to include several taxid);
                        by default all the taxa is considered for inclusion
  -x TAXID, --exclude TAXID
                        NCBI taxid code to exclude a taxon and all underneath
                        (multiple -x is available to exclude several taxid)

input:
  Define Rextract input files

  -q FILE, --fastq FILE
                        single sequence file (no paired-ends), which may be
                        gzipped
  -1 FILE, --mate1 FILE
                        paired-ends sequence file (gzipped or not) for mate 1s
                        (filename usually includes _1)
  -2 FILE, --mate2 FILE
                        paired-ends sequence file (gzipped or not) for mate 2s
                        (filename usually includes _2)

rextract  - Release 2.1.1 - Feb 2026

    Copyright (C) 2017–2026, Jose Manuel Martí Martínez
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


## recentrifuge_rextraccnt

### Tool Description
Extraction from fasta with accessions as NCBI nt DB

### Metadata
- **Docker Image**: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/khyox/recentrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/recentrifuge/overview
- **Validation**: PASS

### Original Help Text
```text
=-= /usr/local/bin/rextraccnt =-= v2.1.1 - Feb 2026 =-= by Jose Manuel Martí =-=

usage: rextraccnt [-h] [-d] [-l NUMBER] [-e NUMBER] [-n PATH] [-i TAXID]
                  [-x TAXID] -m FILE [-f FILE] [-c] [-V]

Extraction from fasta with accessions as NCBI nt DB

options:
  -h, --help            show this help message and exit
  -d, --debug           increase output verbosity and perform additional
                        checks
  -l NUMBER, --limit NUMBER
                        limit of nt DB entries to extract; default: no limit
  -e NUMBER, --entrymax NUMBER
                        maximum number of nt DB entries to search for the
                        taxa; default: no maximum
  -n PATH, --nodespath PATH
                        path for the nodes information files (nodes.dmp and
                        names.dmp from NCBI)
  -m FILE, --mapfile FILE
                        Mapping (accession to taxid) file
  -c, --compress        Output FASTA file will be gzipped
  -V, --version         show program's version number and exit

selection:
  Selection of reads based on the taxonomy

  -i TAXID, --include TAXID
                        NCBI taxid code to include a taxon and all underneath
                        (multiple -i is available to include several taxid);
                        by default all the taxa is considered for inclusion
  -x TAXID, --exclude TAXID
                        NCBI taxid code to exclude a taxon and all underneath
                        (multiple -x is available to exclude several taxid)

input:
  Define input files

  -f FILE, --ntfastafile FILE
                        NCBI nt formatted FASTA file

rextraccnt  - Release 2.1.1 - Feb 2026

    Copyright (C) 2017–2026, Jose Manuel Martí Martínez
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


## recentrifuge_refasplit

### Tool Description
Symmetrically split a FASTA file into several files

### Metadata
- **Docker Image**: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/khyox/recentrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/recentrifuge/overview
- **Validation**: PASS

### Original Help Text
```text
=-= /usr/local/bin/refasplit =-= v2.1.1 - Feb 2026 =-= by Jose Manuel Martí =-=

usage: refasplit [-h] [-d] [-n NUMBER] [-i FILE] [-o PATH] [-m NUMBER] [-c]
                 [-V]

Symmetrically split a FASTA file into several files

options:
  -h, --help            show this help message and exit
  -d, --debug           increase output verbosity and perform additional
                        checks
  -n NUMBER, --num NUMBER
                        number of output FASTA files to generate
  -i FILE, --input FILE
                        single FASTA file (no paired-ends), which may be
                        gzipped
  -o PATH, --outprefix PATH
                        path with prefix for the series of FASTA output files
  -m NUMBER, --maxreads NUMBER
                        maximum number of FASTA reads to process; default: no
                        maximum
  -c, --compress        the resulting FASTA files will be gzipped
  -V, --version         show program's version number and exit

refasplit  - Release 2.1.1 - Feb 2026

    Copyright (C) 2017–2026, Jose Manuel Martí Martínez
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


## recentrifuge_retaxdump

### Tool Description
Get needed taxdump files from NCBI servers

### Metadata
- **Docker Image**: quay.io/biocontainers/recentrifuge:2.1.1--pyhdfd78af_0
- **Homepage**: https://github.com/khyox/recentrifuge
- **Package**: https://anaconda.org/channels/bioconda/packages/recentrifuge/overview
- **Validation**: PASS

### Original Help Text
```text
usage: retaxdump [-h] [-V] [-n PATH]

Get needed taxdump files from NCBI servers

options:
  -h, --help            show this help message and exit
  -V, --version         show program's version number and exit
  -n PATH, --nodespath PATH
                        path for the nodes information files (nodes.dmp and
                        names.dmp from NCBI)

retaxdump  - Release 2.1.1 - Feb 2026

    Copyright (C) 2017–2026, Jose Manuel Martí Martínez
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.
    
    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
```


## Metadata
- **Skill**: generated
