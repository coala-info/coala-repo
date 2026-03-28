# get_homologues CWL Generation Report

## get_homologues_get_homologues.pl

### Tool Description
This program uses BLAST (and optionally HMMER/Pfam) to define clusters of 'orthologous' genomic sequences and pan/core-genome gene sets. Several algorithms are available and search parameters are customizable. It is designed to process (in a HPC computer cluster) files contained in a directory (-d), so that new .faa/.gbk files can be added while conserving previous BLAST results. In general the program will try to re-use previous results when run with the same input directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Total Downloads**: 10.9K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/eead-csic-compbio/get_homologues
- **Stars**: N/A
### Original Help Text
```text
usage: /usr/local/bin/get_homologues.pl [options]

-h this message
-v print version, credits and checks installation
-d directory with input FASTA files ( .faa / .fna ),           (overrides -i,
   GenBank files ( .gbk ), 1 per genome, or a subdirectory      use of pre-clustered sequences
   ( subdir.clusters / subdir_ ) with pre-clustered sequences   ignores -c, -g)
   ( .faa / .fna ); allows for new files to be added later;    
   creates output folder named 'directory_homologues'
-i input amino acid FASTA file with [taxon names] in headers,  (required unless -d is set)
   creates output folder named 'file_homologues'

Optional parameters:
-o only run BLAST/Pfam searches and exit                       (useful to pre-compute searches)
-c report genome composition analysis                          (follows order in -I file if enforced,
                                                                ignores -r,-t,-e)
-R set random seed for genome composition analysis             (optional, requires -c, example -R 1234,
                                                                required for mixing -c with -c -a runs)
-m runmode [local|cluster|dryrun|/path/custom/HPC.conf]        (def: local, path overrides ./HPC.conf)
-n nb of threads for BLAST/HMMER/MCL in 'local' runmode        (default=2)
-I file with .faa/.gbk files in -d to be included              (takes all by default, requires -d)

Algorithms instead of default bidirectional best-hits (BDBH):
-G use COGtriangle algorithm (COGS, PubMed=20439257)           (requires 3+ genomes|taxa)
-M use orthoMCL algorithm (OMCL, PubMed=12952885)

Options that control sequence similarity searches:
-X use diamond instead of blastp                               (optional, set threads with -n)
-C min %coverage in BLAST pairwise alignments                  (range [1-100],default=75)
-E max E-value                                                 (default=1e-05,max=0.01)
-D require equal Pfam domain composition                       (best with -m cluster or -n threads)
   when defining similarity-based orthology
-S min %sequence identity in BLAST query/subj pairs            (range [1-100],default=1 [BDBH|OMCL])
-N min BLAST neighborhood correlation PubMed=18475320          (range [0,1],default=0 [BDBH|OMCL])
-b compile core-genome with minimum BLAST searches             (ignores -c [BDBH])

Options that control clustering:
-t report sequence clusters including at least t taxa          (default t=numberOfTaxa,
                                                                t=0 reports all clusters [OMCL|COGS])
-a report clusters of sequence features in GenBank files       (requires -d and .gbk files,
   instead of default 'CDS' GenBank features                    example -a 'tRNA,rRNA',
                                                                NOTE: uses blastn instead of blastp,
                                                                ignores -g,-D)
-g report clusters of intergenic sequences flanked by ORFs     (requires -d and .gbk files)
   in addition to default 'CDS' clusters
-f filter by %length difference within clusters                (range [1-100], by default sequence
                                                                length is not checked)
-r reference proteome .faa/.gbk file                           (by default takes file with
                                                                least sequences; with BDBH sets
                                                                first taxa to start adding genes)
-e exclude clusters with inparalogues                          (by default inparalogues are
                                                                included)
-x allow sequences in multiple COG clusters                    (by default sequences are allocated
                                                                to single clusters [COGS])
-F orthoMCL inflation value                                    (range [1-5], default=1.5 [OMCL])
-A calculate average identity of clustered sequences,          (optional, creates tab-separated matrix,
   by default uses blastp results but can use blastn with -a    recommended with -t 0 [OMCL|COGS])
-P compute % conserved proteins (POCP) & align fraction (AF),  (optional, creates tab-separated matrices,
   by default uses blastp results but can use blastn with -a    recommended with -t 0 [OMCL|COGS])
-z add soft-core to genome composition analysis                (optional, requires -c [OMCL|COGS])

 This program uses BLAST (and optionally HMMER/Pfam) to define clusters of 'orthologous'
 genomic sequences and pan/core-genome gene sets. Several algorithms are available
 and search parameters are customizable. It is designed to process (in a HPC computer
 cluster) files contained in a directory (-d), so that new .faa/.gbk files can be added
 while conserving previous BLAST results. In general the program will try to re-use
 previous results when run with the same input directory.
```


## get_homologues_get_homologues-est.pl

### Tool Description
This program uses BLASTN/HMMER to define clusters of 'orthologous' transcripts and pan/core-trancriptome sets. Different algorithm choices are available and search parameters are customizable. It is designed to process (in a HPC computer cluster) files contained in a directory (-d), so that new .fna/.faa files can be added while conserving previous BLASTN/HMMER results. In general the program will try to re-use previous results when run with the same input directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/get_homologues-est.pl [options]

-h this message
-v print version, credits and checks installation
-d directory with input FASTA files (.fna , optionally .faa),  (use of pre-clustered sequences
   1 per sample, or subdirectories (subdir.clusters/subdir_)    ignores -c)
   with pre-clustered sequences (.faa/.fna ). Files matching
   tag 'flcdna' are handled as full-length transcripts.
   Allows for files to be added later.
   Creates output folder named 'directory_est_homologues'

Optional parameters:
-o only run BLASTN/Pfam searches and exit                      (useful to pre-compute searches)
-i cluster redundant isoforms, including those that can be     (min overlap, default: -i 40,
   concatenated with no overhangs, and perform                  use -i 0 to disable)
   calculations with longest
-c report transcriptome composition analysis                   (follows order in -I file if enforced,
                                                                with -t N skips clusters occup<N [OMCL],
                                                                ignores -r,-e)
-R set random seed for genome composition analysis             (optional, requires -c, example -R 1234)
-m runmode [local|cluster|dryrun|dryrun|/path/custom/HPC.conf] (def: local, path overrides ./HPC.conf)
-n nb of threads for BLASTN/HMMER/MCL in 'local' runmode       (default=2)
-I file with .fna files in -d to be included                   (takes all by default, requires -d)

Algorithms instead of default bidirectional best-hits (BDBH):
-M use orthoMCL algorithm (OMCL, PubMed=12952885)

Options that control sequence similarity searches:
-C min %coverage of shortest sequence in BLAST alignments      (range [1-100],default: -C 75)
-E max E-value                                                 (default: -E 1e-05 , max=0.01)
-D require equal Pfam domain composition                       (best with -m cluster or -n threads)
   when defining similarity-based orthology
-S min %sequence identity in BLAST query/subj pairs            (range [1-100],default: -S 95 [BDBH|OMCL])
-b compile core-transcriptome with minimum BLAST searches      (ignores -c [BDBH])

Options that control clustering:
-t report sequence clusters including at least t taxa          (default: t=numberOfTaxa,
                                                                t=0 reports all clusters [OMCL])
-L add redundant isoforms to clusters                          (optional, requires -i)
-r reference transcriptome .fna file                           (by default takes file with
                                                                least sequences; with BDBH sets
                                                                first taxa to start adding genes)
-e exclude clusters with inparalogues                          (by default inparalogues are
                                                                included)
-F orthoMCL inflation value                                    (range [1-5], default: -F 1.5 [OMCL])
-A calculate average identity of clustered sequences,          (optional, creates tab-separated matrix,
 uses blastn results                                            [OMCL])
-P calculate percentage of conserved sequences (POCS),         (optional, creates tab-separated matrix,
 uses blastn results, best with CDS                             [OMCL])
-z add soft-core to genome composition analysis                (optional, requires -c [OMCL])

This program uses BLASTN/HMMER to define clusters of 'orthologous' transcripts
and pan/core-trancriptome sets. Different algorithm choices are available
and search parameters are customizable. It is designed to process (in a HPC computer
cluster) files contained in a directory (-d), so that new .fna/.faa files can be added
while conserving previous BLASTN/HMMER results. In general the program will try to re-use
previous results when run with the same input directory.
```


## get_homologues_compare_clusters.pl

### Tool Description
Compares cluster directories generated by get_homologues.pl

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
[options]: 
-h 	 this message
-d 	 comma-separated names of cluster directories                  (min 1 required, example -d dir1,dir2)
-o 	 output directory                                              (required, intersection cluster files are copied there)
-n 	 use nucleotide sequence .fna clusters                         (optional, uses .faa protein sequences by default)
-r 	 take first cluster dir as reference set, which might contain  (optional, by default cluster dirs are expected
   	 a single representative sequence per cluster                   to be derived from the same taxa; overrides -t,-I)
-s 	 use only clusters with syntenic genes                         (optional, parses neighbours in FASTA headers)
-t 	 use only clusters with single-copy orthologues from taxa >= t (optional, default takes all intersection clusters; example -t 10)
-I 	 produce clusters with single-copy seqs from ALL taxa in file  (optional, example -I include_list; overrides -t)
-m 	 produce intersection pangenome matrices                       (optional, ideally expects cluster directories generated
   	                                                                with get_homologues.pl -t 0)
-x 	 produce cluster report in OrthoXML format                     (optional)
-T 	 produce parsimony-based pangenomic tree                       (optional, requires -m)
```


## get_homologues_parse_pangenome_matrix.pl

### Tool Description
Parses the pangenome matrix generated by compare_clusters.pl to report cluster types and perform various analyses.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
[options]: 
-h 	 this message
-m 	 input pangenome matrix .tab                               (required, made by compare_clusters.pl)
-s 	 report cloud,shell,soft core and core clusters            (optional, creates plot if R is installed)
-l 	 list taxa names present in clusters reported in -m matrix (optional, recommended before using -p option)
-n 	 do not compute cloud, matrix does not have cloud clusters (optional, requires -s)
-x 	 produce matrix of intersection pangenome clusters         (optional, requires -s)
-I 	 use only taxon names included in file                     (optional, ignores -A,-g,-e)
-A 	 file with taxon names (.faa,.gbk,.nucl files) of group A  (optional, example -A clade_list_pathogenic.txt)
-B 	 file with taxon names (.faa,.gbk,.nucl files) of group B  (optional, example -B clade_list_symbiotic.txt)
-a 	 find genes/clusters which are absent in B                 (optional, requires -B)
-g 	 find genes/clusters present in A which are absent in B    (optional, requires -A & -B)
-e 	 find gene family expansions in A with respect to B        (optional, requires -A & -B)
-S 	 skip clusters with occupancy <S                           (optional, requires -x/-a/-g, example -S 2)
-P 	 % of -A & -B genomes that must comply presence/absence    (optional, default=100, requires -g)
-R 	 % of -B genomes that must comply presence/absence         (optional, requires -g & -P, if set -P applies to -A only)
-p 	 plot pangenes on the genome map of this group A taxon     (optional, example -p 'Escherichia coli K12',
   	                                                            requires -g, -A & -B, only works with clusters
   	                                                            derived from input files in GenBank format)
```


## get_homologues_plot_pancore_matrix.pl

### Tool Description
Plot pancore matrix

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
[options]: 
-h 	 this message
-i 	 input .tab data file                   (required, generated by get_homologues.pl)
-f 	 type of fit [pan|core_Tettelin|core_Willenbrock|core_both]
   	                                        (default: core_Tettelin, PubMed:16172379,18088402)
-F 	 font scale for fitted formulas         (optional, default=0.8)
-a 	 save snapshots for animations in dir   (optional, example: -a animation)
```


## Metadata
- **Skill**: generated
