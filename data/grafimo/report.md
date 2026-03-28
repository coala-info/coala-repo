# grafimo CWL Generation Report

## grafimo_findmotif

### Tool Description
GRAph-based Find of Individual Motif Occurrences. GRAFIMO scans genome variation graphs in VG format (Garrison et al., 2018) to find potential binding site occurrences of DNA motif(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/grafimo:1.1.6--py310h79ef01b_0
- **Homepage**: https://github.com/pinellolab/GRAFIMO
- **Package**: https://anaconda.org/channels/bioconda/packages/grafimo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/grafimo/overview
- **Total Downloads**: 18.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/pinellolab/GRAFIMO
- **Stars**: N/A
### Original Help Text
```text
GRAFIMO version 1.1.6

Copyright (C) 2022 Manuel Tognon <manu.tognon@gmail.com> <manuel.tognon@univr.it>

GRAph-based Find of Individual Motif Occurrences.

GRAFIMO scans genome variation graphs in VG format (Garrison et al., 2018) 
to find potential binding site occurrences of DNA motif(s).

Usage:

    * to scan a set of precomputed genome variation graphs (-- SUGGESTED --):

        grafimo findmotif -d path/to/my/vgs -b BEDFILE.bed -m MOTIF.meme [options]

    * to scan a precomputed genome variation graph:
        
        grafimo findmotif -g GENOME_GRAPH.xg -b BEDFILE.bed -m MOTIF.meme [options]

    * to build a new set of genome variation graphs (one for each chromosome or a user defined subset):
        
        grafimo buildvg -l REFERENCE.fa -v VCF.vcf.gz [options]

GRAFIMO searches DNA motif(s) occurrences, given as a PWM (MEME, JASPAR format), 
in a set of genomic coordinates on VGs. Genomic coordinates are provided in tab-separated file
(e.g. ENCODE narrowPeak or UCSC BED format).

GRAFIMO scans in a single run all the genomes encoded in the input VG. 
GRAFIMO helps studying how genetic variation present within a 
population of individuals affects the binding affinity score of input DNA 
motif(s).

GRAFIMO provides the possibility to build from user data a new genome 
variation graph, by building a VG for each chromosome.

GRAFIMO results are reported in three files (stored in a directory named `grafimo_out_JOBID` by default):
    
    * TSV report, containing all the reported binding site candidates, with 
      an associated score, P-value, q-value, haplotype frequency within 
      the analyzed population and a flag stating if the current occurrence 
      contains a genomic variants

    * HTML version of the TSV report

    * GFF3 file to load the found motif candidates on the UCSC genome browser 
      as custom track

Citation:

    Tognon M, Bonnici V, Garrison E, Giugno R, Pinello L (2021) GRAFIMO: Variant and haplotype aware motif 
    scanning on pangenome graphs. PLOS Computational Biology 17(9): e1009444. 
    https://doi.org/10.1371/journal.pcbi.1009444

Run "grafimo --help" to see all command-line options.
See https://github.com/pinellolab/GRAFIMO/wiki or https://github.com/InfOmics/GRAFIMO/wiki for the full documentation.

General options:
  -h, --help            Show this help message and exit.
  --version             Show software version and exit
  -j [NCORES], --cores [NCORES]
                        Number of CPU cores to use. Use 0 to auto-detect.
                        Default: 0. To search motifs in a whole genome
                        variation graph the default is 1 (avoid memory
                        issues).
  --verbose             Print additional information about GRAFIMO run.
  --debug               Enable error traceback.
  -o [OUTDIR], --out [OUTDIR]
                        Output directory. [optional]
  workflow              Mandatory argument placed immediately after "grafimo".
                        Only two values are accepted: "buildvg" and
                        "findmotif". When called "grafimo buildvg", the
                        software will compute the genome variation graph from
                        input data (see "buildvg options" section below for
                        more arguments). When called "grafimo findmotif", the
                        software will scan the input VG(s) for potential
                        occurrences of the input motif(s) (see "findmotif
                        option" section below for more arguments).

Buildvg options:
  -l [REFERENCE-FASTA], --linear-genome [REFERENCE-FASTA]
                        Path to reference genome FASTA file.
  -v [VCF], --vcf [VCF]
                        Path to VCF file. Note that the VCF should be
                        compressed (e.g. myvcf.vcf.gz).
  --chroms-build [1 [X ...]]
                        Chromosomes for which construct the VG. By default
                        GRAFIMO constructs the VG for all chromsomes.
  --chroms-prefix-build [CHRPREFIX]
                        Prefix to append in front of chromosome numbers. To
                        name chromosome VGs with only their number (e.g.
                        1.xg), use "--chroms-prefix-build "" ". Default: .
  --chroms-namemap-build [NAME-MAP-FILE]
                        Space or tab-separated file, containing original
                        chromosome names in the first columns and the names to
                        use when storing corresponding VGs. By default the VGs
                        are named after the encoded chromosome (e.g. chr1.xg).
  --reindex             Reindex the VCF file with Tabix, even if a TBI index
                        os already available.

Findmotif options:
  -g [GENOME-GRAPH], --genome-graph [GENOME-GRAPH]
                        Path to VG pangenome variation graph (VG or XG
                        format).
  -d [GENOME-GRAPHS-DIR], --genome-graph-dir [GENOME-GRAPHS-DIR]
                        Path to the directory containing the pangenome
                        variation graphs to scan (VG or XG format)
  -b BEDFILE, --bedfile BEDFILE
                        BED file containing the genomic regions to scan for
                        occurrences of the input motif(s).
  -m MOTIF1 [MOTIF2 ...], --motif MOTIF1 [MOTIF2 ...]
                        Motif Position Weight Matrix (MEME or JASPAR format).
  -k [BACKGROUND], --bgfile [BACKGROUND]
                        Background distribution file.
  -p [PSEUDOCOUNT], --pseudo [PSEUDOCOUNT]
                        Pseudocount value used during motif PWM processing.
  -t [THRESHOLD], --threshold [THRESHOLD]
                        Statistical significance threshold value. By default
                        the threshold is applied on P-values. To apply the
                        threshold on q-values use the "--qvalueT" options.
                        Default: 0.0001.
  -q, --no-qvalue       If used, GRAFIMO skips q-value computation.
  -r, --no-reverse      If used, GRAFIMO scans only the forward strand.
  -f, --text-only       Print results to stdout.
  --chroms-find [1 [X ...]]
                        Scan only the specified chromosomes.
  --chroms-prefix-find [CHRPREFIX]
                        Prefix shared by all chromosomes. The prefix should be
                        followed by the chromosome number. If chromosome VGs
                        are stored only with their chromosome number (e.g.
                        1.xg) use "--chroms-prefix-find"" ". Default: .
  --chroms-namemap-find [NAME-MAP-FILE]
                        Space or tab-separated file, containing original
                        chromosome names in the first columns and the names
                        used to store the corresponding VGs. By default
                        GRAFIMO assumes that VGs are named after the encoded
                        chromosome (e.g. chr1.xg).
  --recomb              Consider all the possible recombinants sequences which
                        could be obtained from the genetic variants encoded in
                        the VG. With this option the haplotypes encoded in the
                        VG are ignored.
  --qvalueT             Apply motif occurrence score statistical significance
                        threshold on q-values rather than on P-values.
  --top-graphs [GRAPHS-NUM]
                        Store the PNG image of the top "GRAPHS-NUM" regions of
                        the VG (motif occurrences sorted by increasing
                        P-value).
```


## grafimo_buildvg

### Tool Description
GRAph-based Find of Individual Motif Occurrences. GRAFIMO scans genome variation graphs in VG format (Garrison et al., 2018) to find potential binding site occurrences of DNA motif(s).

### Metadata
- **Docker Image**: quay.io/biocontainers/grafimo:1.1.6--py310h79ef01b_0
- **Homepage**: https://github.com/pinellolab/GRAFIMO
- **Package**: https://anaconda.org/channels/bioconda/packages/grafimo/overview
- **Validation**: PASS

### Original Help Text
```text
GRAFIMO version 1.1.6

Copyright (C) 2022 Manuel Tognon <manu.tognon@gmail.com> <manuel.tognon@univr.it>

GRAph-based Find of Individual Motif Occurrences.

GRAFIMO scans genome variation graphs in VG format (Garrison et al., 2018) 
to find potential binding site occurrences of DNA motif(s).

Usage:

    * to scan a set of precomputed genome variation graphs (-- SUGGESTED --):

        grafimo findmotif -d path/to/my/vgs -b BEDFILE.bed -m MOTIF.meme [options]

    * to scan a precomputed genome variation graph:
        
        grafimo findmotif -g GENOME_GRAPH.xg -b BEDFILE.bed -m MOTIF.meme [options]

    * to build a new set of genome variation graphs (one for each chromosome or a user defined subset):
        
        grafimo buildvg -l REFERENCE.fa -v VCF.vcf.gz [options]

GRAFIMO searches DNA motif(s) occurrences, given as a PWM (MEME, JASPAR format), 
in a set of genomic coordinates on VGs. Genomic coordinates are provided in tab-separated file
(e.g. ENCODE narrowPeak or UCSC BED format).

GRAFIMO scans in a single run all the genomes encoded in the input VG. 
GRAFIMO helps studying how genetic variation present within a 
population of individuals affects the binding affinity score of input DNA 
motif(s).

GRAFIMO provides the possibility to build from user data a new genome 
variation graph, by building a VG for each chromosome.

GRAFIMO results are reported in three files (stored in a directory named `grafimo_out_JOBID` by default):
    
    * TSV report, containing all the reported binding site candidates, with 
      an associated score, P-value, q-value, haplotype frequency within 
      the analyzed population and a flag stating if the current occurrence 
      contains a genomic variants

    * HTML version of the TSV report

    * GFF3 file to load the found motif candidates on the UCSC genome browser 
      as custom track

Citation:

    Tognon M, Bonnici V, Garrison E, Giugno R, Pinello L (2021) GRAFIMO: Variant and haplotype aware motif 
    scanning on pangenome graphs. PLOS Computational Biology 17(9): e1009444. 
    https://doi.org/10.1371/journal.pcbi.1009444

Run "grafimo --help" to see all command-line options.
See https://github.com/pinellolab/GRAFIMO/wiki or https://github.com/InfOmics/GRAFIMO/wiki for the full documentation.

General options:
  -h, --help            Show this help message and exit.
  --version             Show software version and exit
  -j [NCORES], --cores [NCORES]
                        Number of CPU cores to use. Use 0 to auto-detect.
                        Default: 0. To search motifs in a whole genome
                        variation graph the default is 1 (avoid memory
                        issues).
  --verbose             Print additional information about GRAFIMO run.
  --debug               Enable error traceback.
  -o [OUTDIR], --out [OUTDIR]
                        Output directory. [optional]
  workflow              Mandatory argument placed immediately after "grafimo".
                        Only two values are accepted: "buildvg" and
                        "findmotif". When called "grafimo buildvg", the
                        software will compute the genome variation graph from
                        input data (see "buildvg options" section below for
                        more arguments). When called "grafimo findmotif", the
                        software will scan the input VG(s) for potential
                        occurrences of the input motif(s) (see "findmotif
                        option" section below for more arguments).

Buildvg options:
  -l [REFERENCE-FASTA], --linear-genome [REFERENCE-FASTA]
                        Path to reference genome FASTA file.
  -v [VCF], --vcf [VCF]
                        Path to VCF file. Note that the VCF should be
                        compressed (e.g. myvcf.vcf.gz).
  --chroms-build [1 [X ...]]
                        Chromosomes for which construct the VG. By default
                        GRAFIMO constructs the VG for all chromsomes.
  --chroms-prefix-build [CHRPREFIX]
                        Prefix to append in front of chromosome numbers. To
                        name chromosome VGs with only their number (e.g.
                        1.xg), use "--chroms-prefix-build "" ". Default: .
  --chroms-namemap-build [NAME-MAP-FILE]
                        Space or tab-separated file, containing original
                        chromosome names in the first columns and the names to
                        use when storing corresponding VGs. By default the VGs
                        are named after the encoded chromosome (e.g. chr1.xg).
  --reindex             Reindex the VCF file with Tabix, even if a TBI index
                        os already available.

Findmotif options:
  -g [GENOME-GRAPH], --genome-graph [GENOME-GRAPH]
                        Path to VG pangenome variation graph (VG or XG
                        format).
  -d [GENOME-GRAPHS-DIR], --genome-graph-dir [GENOME-GRAPHS-DIR]
                        Path to the directory containing the pangenome
                        variation graphs to scan (VG or XG format)
  -b BEDFILE, --bedfile BEDFILE
                        BED file containing the genomic regions to scan for
                        occurrences of the input motif(s).
  -m MOTIF1 [MOTIF2 ...], --motif MOTIF1 [MOTIF2 ...]
                        Motif Position Weight Matrix (MEME or JASPAR format).
  -k [BACKGROUND], --bgfile [BACKGROUND]
                        Background distribution file.
  -p [PSEUDOCOUNT], --pseudo [PSEUDOCOUNT]
                        Pseudocount value used during motif PWM processing.
  -t [THRESHOLD], --threshold [THRESHOLD]
                        Statistical significance threshold value. By default
                        the threshold is applied on P-values. To apply the
                        threshold on q-values use the "--qvalueT" options.
                        Default: 0.0001.
  -q, --no-qvalue       If used, GRAFIMO skips q-value computation.
  -r, --no-reverse      If used, GRAFIMO scans only the forward strand.
  -f, --text-only       Print results to stdout.
  --chroms-find [1 [X ...]]
                        Scan only the specified chromosomes.
  --chroms-prefix-find [CHRPREFIX]
                        Prefix shared by all chromosomes. The prefix should be
                        followed by the chromosome number. If chromosome VGs
                        are stored only with their chromosome number (e.g.
                        1.xg) use "--chroms-prefix-find"" ". Default: .
  --chroms-namemap-find [NAME-MAP-FILE]
                        Space or tab-separated file, containing original
                        chromosome names in the first columns and the names
                        used to store the corresponding VGs. By default
                        GRAFIMO assumes that VGs are named after the encoded
                        chromosome (e.g. chr1.xg).
  --recomb              Consider all the possible recombinants sequences which
                        could be obtained from the genetic variants encoded in
                        the VG. With this option the haplotypes encoded in the
                        VG are ignored.
  --qvalueT             Apply motif occurrence score statistical significance
                        threshold on q-values rather than on P-values.
  --top-graphs [GRAPHS-NUM]
                        Store the PNG image of the top "GRAPHS-NUM" regions of
                        the VG (motif occurrences sorted by increasing
                        P-value).
```


## Metadata
- **Skill**: generated
