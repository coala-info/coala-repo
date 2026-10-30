# get_homologues CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| get_homologues_add_pancore_matrices.pl | PASS | repo core and pan curve tables (12 genomes, 20 samples) sum to the expected values (58+58=116, 42+63=105) |
| get_homologues_add_pangenome_matrices.pl | PASS | two compare_clusters matrices of the repo plasmid BDBH and COG cluster dirs join into 7 taxa by 48 clusters |
| get_homologues_annotate_cluster.pl | PASS | repo sample_cluster.fna (18 transcripts) gives a 1946-column alignment of all 18 sequences with SNP and parsimony-informative sites |
| get_homologues_check_BDBHs.pl | Not completed | needs the all.bpo and all.p2o.csv files of a get_homologues.pl run, and that run fails in this image (busybox sort has no --buffer-size) |
| get_homologues_compare_clusters.pl | PASS | repo plasmid BDBH and COG cluster dirs give 24 intersection clusters, venn files and pangenome matrix |
| get_homologues_download_genomes_ncbi.pl | Not completed | needs the NCBI FTP site: the tool first calls wget on ftp.ncbi.nlm.nih.gov, which hangs for over 20 minutes here, so the e-utils step is never reached |
| get_homologues_get_homologues-est.pl | Failed | image problem: busybox sort has no --buffer-size, so the BLAST result sort step fails |
| get_homologues_get_homologues.pl | Failed | image problem: busybox sort has no --buffer-size, so the BLAST result sort step fails |
| get_homologues_hcluster_pangenome_matrix.sh | PASS | repo sample_intersection matrix (12 plasmid genomes) gives a gower distance matrix, a newick tree with all 12 taxa, heatmap and silhouette plots |
| get_homologues_make_nr_pangenome_matrix.pl | PASS | compare_clusters matrix of the repo plasmid cluster dirs gives 24 clusters kept as 24 non-redundant (distinct genes), 7 taxa, median-sequence FASTA and BLAST table |
| get_homologues_parse_pangenome_matrix.pl | PASS | core and soft-core lists equal the expected lists in the tool repo |
| get_homologues_pfam_enrich.pl | Not completed | needs the Pfam mappings (tmp/all.pfam) of a get_homologues.pl -D run, which needs the Pfam-A database and a get_homologues.pl run that fails in this image |
| get_homologues_plot_matrix_heatmap.sh | Not completed | needs an Avg_identity.tab matrix made by get_homologues.pl -A, and that run fails in this image (busybox sort); no other real square matrix with the expected header exists |
| get_homologues_plot_pancore_matrix.pl | PASS | synthetic data: core-genome curves computed from the repo sample matrix; fits and plots written |
| get_homologues_transcripts2cds.pl | Failed | image problem: perl module DB_File is missing, so the TransDecoder step dies |
| get_homologues_transcripts2cdsCPP.pl | Failed | image problem: perl module Inline is missing (the script needs Inline::CPP, which upstream says is not available in bioconda) |

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


## get_homologues_add_pancore_matrices.pl

### Tool Description
Adds pan/core data from two .tab files generated by get_homologues.pl -c, for instance to combine CDS and -a 'rRNA,tRNA' results.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
[options]: 
-h 	 this message
-i 	 first input .tab data file                           (required, generated by get_homologues.pl)
-j 	 second input .tab data file                          (required, generated by get_homologues.pl)
-o 	 name of output .tab file                             (required)
```

## get_homologues_add_pangenome_matrices.pl

### Tool Description
Adds two pangenome matrices generated by compare_clusters.pl -m, for instance to combine CDS and -a 'rRNA,tRNA' results.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
[options]: 
-h 	 this message
-i 	 first input .tab data file                           (required, generated by compare_clusters.pl)
-j 	 second input .tab data file                          (required, generated by compare_clusters.pl)
-o 	 name of output .tab file                             (required)
```

## get_homologues_annotate_cluster.pl

### Tool Description
Aligns the longest sequence of a cluster (or an external reference) to the rest of the cluster with BLAST and prints an annotated alignment.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/annotate_cluster.pl [options]

-h this message
-f input cluster FASTA file          (expects nucleotides, aligns longest seq to rest of cluster)
-o output FASTA file                 (optional, by default prints alignment to standard output)
-P sequences are peptides            (optional, uses BLASTP instead of BLASTN)
-r reference sequence FASTA          (optional, aligns cluster sequences to this external seq)
-D match Pfam domains                (optional, annotates longest seq, nucleotides on 6 frames)
-u print unaligned sequences         (optional, flips seqs, handy for multiple alignments, skips option below)
-b blunt alignment borders           (optional, also annotates SNPs/missense mutations and parsimony-informative sites)
-A file with taxon names of group A  (optional, identifies private variants of group A vs 'rest')
-B file with taxon names of group B  (optional, requires -A, group B is used as 'rest')
-c collapse overlapping fragments    (optional, example -c 40 for overlaps >= 40 residues, requires -o,
                                      this is useful to merge fragmented de-novo transcripts)

WARNING1: Clusters of transcripts often contain a fraction of BLAST hits that do not match 
the longest sequence; instead, they align towards the 5' or 3' of other sequences and are 
not included in the produced cumulative multiple sequence alignment (MSA):
 
 -----------------            <= longest/reference sequence
              -------------
    -------------
 -----------
   ------------
                      ....    <= sequences not included in MSA
                       ..

WARNING2: The resulting multiple alignment is produced by MVIEW, which does not record
deletions in the longest/reference sequence. This means that an alignment like this:

 ------  -----------            <= longest/reference sequence
    ---..----------             <= .. fragment not included in MSA
 ------  -----
   ----  --------

will in fact be saved as:

-----------------            
   -------------             
-----------
  ------------
```

## get_homologues_hcluster_pangenome_matrix.sh

### Tool Description
Computes a distance matrix from a pangenome matrix, clusters it with hclust() and plots a heatmap with heatmap.2(), with goodness of clustering statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
USAGE synopsis for: [hcluster_pangenome_matrix.sh v.1.2_16Sep21]:
       hcluster_pangenome_matrix.sh -i <string (name of matrix file)> [-d <distance> -a <algorithm> -o <format> ...]
    
    REQUIRED
       -i <string> name of matrix file 
    OPTIONAL:
     * Clustering
       -a <string> algorithm/method for clustering 
             [ward.D|ward.D2|single|complete|average(=UPGMA)] [def: ward.D2]
       -d <string> distance type [euclidean|manhattan|gower]  [def: gower]

     * Goodness of clustering
       -s <string> goodness of clustering statistic [gap|sil] [def: sil]
       -S <integer> number of random starts (gap statistic)   [def: 25]
       -m <string>  method: [firstSEmax|Tibs2001SEmax|
                             globalSEmax|firstmax|globalmax]  [def: Tibs2001SEmax]
       -n <integer> num. of bootstrap replicates (gap stat.)  [def: 100]                                                   
       -k <integer> max. number of clusters                   [def: 15; NOTE: 2<= k <= n-1 ]
   
     * Plotting
       -c <int> 1|0 to display or not the distace values      [def:0]
                    in the heatmap cells 
       -F <int> maximum number of decimals in matrix display  [1,2; def:2]
       -T <string> text for Main title                        [def:Pan-genome tree; ]
       -M <integer> margins_horizontal                        [def:20]
       -V <integer> margins_vertical                          [def:21]
       -O <string> output file format  [svg|pdf]              [def:pdf]
       -P <integer> points for plotting device                [def:15]    
       -H <integer> ouptupt device height                     [def:15]    
       -W <integer> ouptupt device width                      [def:17]     
       -A <'integer,integer'> angle to rotate row,col labels  [def NULL,NULL]
       -X <float> leaf label character expansion factor       [def 0.7]

     * Filter input pangenome_matrix_t0.tab using regular expressions:
       -x <string> regex, like: 'Escherichia|Salmonella'      [def ]
       
     * Miscelaneous
       -N <flag> print Notes and exit                         [flag]
       -v <flag> print version and exit                       [flag]

    EXAMPLE:
      hcluster_pangenome_matrix.sh -i pangenome_matrix_t0.tab -T "Pan-genome tree" -a ward.D2 -d gower -O pdf -A 'NULL,45' -X 0.8 -s sil

    AIM: compute a distance matrix from a pangenome_matrix.tab file produced after running 
         get_homologues.pl and compare_clusters.pl with options -t 0 -m .
         The pangenome_matrix.tab file processed by hclust(), and heatmap.2()
    
    OUTPUT: a newick file with extension .ph and svg|pdf output of hclust and heatmap.2 calls +
             goodness of clustering (gap|silhouette width) dentrogram and stats plot.
     
    DEPENDENCIES:
         R packages: ape, cluster, gplots, dendextend and factoextra. Run hcluster_pangenome_matrix.sh -N for installation instructions.
	 
    IMPORTANT NOTES: 
        1. to get the best display of your genome lables, these should be made as short as possible.
           This can be simply done by executing sed commands such as: 
	   sed 's/LongGenusName/L/g; s/speciesname/spn/g' pangenome_matrix_t0.tab > pangenome_matrix_t0.tabed
	2. The gap-statistic of clustering goodness is compuationally intensive and takes a long time 
	   (up to hours) to run on a large pan-genome matrix (n_genomes > 50; n_clusters > 8000) with a reasonalbe 
	   (n >= 500) number of bootstrap replicates and independent searches (S >= 20) and large numbers 
	   of potential clusters (k >= 15). The default option is the silhouette-width statistic, which is 
	   much faster to run, although also less powerful and much more conservative.
```

## get_homologues_plot_matrix_heatmap.sh

### Tool Description
Plots ordered heatmaps with row and column dendrograms from a squared numeric matrix, like the Avg_identity.tab matrices made by get_homologues.pl -A.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
need the following args: 
    
    USAGE synopsis for: [plot_matrix_heatmap.sh v.v1.0.4_31Jan18]:
       plot_matrix_heatmap.sh <string (tab-delimited matrix file)> [-t|-m|-v|-o|-p|-H|-W|-C|-r|-k|-N|-M]
    
    REQUIRED
       -i <string> *Avg_identity.tab file     
       
    OPTIONAL:
     * filter out excessive redundancy in the tab-delimited ANI matrix file
       -c <float> (maximum) identity cut-off value (e.g. 97.3) [def: 100]
       -d <int> maximum number of decimals in matrix display [0-2; def: 0]
	
     * tweak the graphical output:
       -a <integer> angle to rotate node angles           [def 45]
       -t <string> text for plot title                    [def input_tab_file_name]
       -m <integer> margins_horizontal                    [def 18]
       -v <integer> margins_vertical                      [def 18] 
       -o <string> output file format                     [def svg]
       -p <integer> points for plotting device            [def 15]    
       -H <integer> output device height                  [def 10]    
       -W <integer> output device width                   [def 15]     
       -C <flag> do not reorder clusters                  [def reorder clusters and plot dendrogram]
       -r <flag> remove column names and cell contents    [def names and cell contents are printed]
       -k <string> text for scale X-axis                  [def "Value"]
       -b <integer> right border (margin) in dendrograms  [def 10]
       -X <float> character expansion factor              [def 1.0]
     * Goodness of clustering
       -K <integer> max. number of clusters               [def: ; NOTE: 2 <= K <= n-1 ]

    RUN NJ ANALYSIS using ANI matrix (average identity matrix) generated by get_homologues.pl -A -t 0 -M|G
       -N <flag> will compute a distance matrix (ANdist) from the input similarity matrix
                 and use the former to construct a NJ tree and save it as newick string, 
		 as well as a complete linkage dendrogram for convenient cluster delimitations
		 at ANdist cutoffs of 6,5 and 4, which correspond to ANI values of 94%, 95% and 96%, respectively
		 Do not use with a binary presence-absence matrix
    
    SUBSET MATRIX WITH REGULAR EXPRESSIONS
       -x <string> regex, like: 'species1|species2'       [def ]
    
    MORE DETAILED HELP:
       -M <flag> prints gplot installation instructions and further usage information
       
    EXAMPLE:
      plot_matrix_heatmap.sh -i Avg_identity.tab -c 99.5 -d 1 -t "Genus X ANIb (OMCL all clusters)" -N -o pdf -m 22 -v 22 -p 20 -H 20 -W 30 -x 'sp1|sp2' -a 45 -b 12 -X 0.9 -K 20

    #------------------------------------------------------------------------------------------------------------------
    AIM: Plot ordered heatmaps with row and col. dendrogram, from squared numeric (distance or presence-absence) matrix,
         like the *Avg_identity.tab matrices produced by get_homologues.pl with the -A flag
          
    OUTPUT:  svg|pdf files
    
    DEPENDENCIES:
         R packages ape and gplots. Run plot_matrix_heatmap.sh -M for installation instructions.
    
    NOTES: 
      1. To improve the display, shorten the genome/taxon names as much as possible!
      2. Use -m and -v to control horizontal and vertial margins to the plot
         to fit the taxon labels, and -X character_expansion_factor to control font size
    #------------------------------------------------------------------------------------------------------------------
 

# Run check_dependencies() ... looks good: R is installed.
```

## get_homologues_make_nr_pangenome_matrix.pl

### Tool Description
Makes a non-redundant pangenome matrix by merging similar clusters of a matrix made by compare_clusters.pl.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
[options]: 
-h 	 this message
-m 	 input pangenome matrix .tab                                (required, made by compare_clusters.pl)
-t 	 consider only clusters with at least t taxa                (optional, default:1)
-l 	 min mean sequence length per cluster                       (optional, default:0)
-S 	 %sequence identity cutoff                                  (optional, default:90)
-C 	 %alignment coverage cutoff                                 (optional, default:75,
   	                                                             calculates coverage over longest sequence)
-P 	 sequences are peptides                                     (optional, by default expects nucleotides)
-n 	 number of threads for BLAST jobs                           (optional, default:2)
-e 	 sequences are (probably) incomplete ESTs                   (optional, calculates coverage over shortest)

Parameters used to match input clusters to a reference:
-r 	 reference clusters contained in directory                  (optional, example: -r cross_species_clusters)
-f 	 parse sequences in this file                               (optional, ignores -r; example: -f swissprot.faa)
-s 	 %sequence identity cutoff for matching reference seqs      (optional, default:50)
-c 	 %alignment coverage cutoff for matching reference seqs     (optional, default:50,
   	                                                             calculates coverage over longest sequence)
```

## get_homologues_transcripts2cds.pl

### Tool Description
Extracts coding sequences encoded in input transcripts, using TransDecoder and blastx or diamond hits against a protein database.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/transcripts2cds.pl [options] <input FASTA file(s) with transcript nucleotide sequences>

-h this message
-p check only 'plus' strand                                  (optional, default both strands)
-l min length for CDS                                        (optional, default=50 amino acid residues)
-g genetic code to use during translation                    (optional, default=1, example: -g 11)
-d run blastx against selected protein FASTA database file   (default=swissprot, example: -d /path/to/sequences.faa)
-E max E-value during blastx search                          (default=1e-05)
-n number of threads for blastx/diamond jobs                 (default=2)
-X use diamond instead of blastx                             (optional, much faster for many sequences)

-G show available genetic codes and exit
```

## get_homologues_transcripts2cdsCPP.pl

### Tool Description
Variant of transcripts2cds.pl that uses Inline::CPP code to extract coding sequences from transcripts.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/transcripts2cdsCPP.pl [options] <input FASTA file(s) with transcript nucleotide sequences>

-h this message
-p check only 'plus' strand                                  (optional, default both strands)
-l min length for CDS                                        (optional, default=50 amino acid residues)
-g genetic code to use during translation                    (optional, default=1, example: -g 11)
-d run blastx against selected protein FASTA database file   (default=swissprot, example: -d /path/to/sequences.faa)
-E max E-value during blastx search                          (default=1e-05)
-n number of threads for blastx/diamond jobs                 (default=2)
-X use diamond instead of blastx                             (optional, much faster for many sequences)

-G show available genetic codes and exit
```

## get_homologues_check_BDBHs.pl

### Tool Description
Retrieves the BLAST bidirectional best hits of a sequence from get_homologues.pl or get_homologues-est.pl output.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/check_BDBHs.pl [options]

-h this message
-d directory with get_homologues output    (example: /path/to/genomes_homologues)
-i sequence identifier
-s show self hits                          (optional)
-n number of hits to show per species      (optional, default: -n 1)
-D show Pfam protein domains if available  (optional)
-g guess sequence identifier for -i label  (optional, find out ids for sequence names, such as 'rpoB')
-t show only hits from this taxon          (optional, example: -t genome1.faa)
-e sequences are (possibly redundant) ESTs (optional, get coverage of short isoforms if not labelled as full-length)
```

## get_homologues_pfam_enrich.pl

### Tool Description
Tests the enrichment of Pfam domains in a set of experiment clusters against a control set of clusters.

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
usage: /usr/local/bin/pfam_enrich.pl [options]

-h this message
-d directory with get_homologues[-est] output     (required, example: /path/to/data_homologues[-est])
-c path to directory with FASTA cluster files     (required, taken as 'control' set, sitting probably inside -d)
-x file with list of 'experiment' clusters        (required, should be a subset of files in -c)
-n use nucleotide sequence .fna clusters          (optional, uses .faa protein sequences by default)
-r reference .gbk/.faa/.fna file or "taxon name"  (optional, by default gets Pfam frequencies from all taxons)
-t type of test                                   (optional, default: -t greater, [greater,two.sided,less]
-p fdr adjusted p-value threshold                 (optional, default: -p 0.05
-e cluster sequences are ESTs                     (optional, requires pre-computed Pfam mappings of deduced CDSs,
                                                             uses different regex to parse cluster FASTA files)
-f make FASTA file with experiment sequences      (optional, example: -f experiment.fasta)
-s take individual sequences as annotation units  (optional, by default Pfam domains are counted once per cluster)
```

## get_homologues_download_genomes_ncbi.pl

### Tool Description
Attempts to download a list of genomes from the NCBI (e-utils, FTP site of complete genomes and WGS repository).

### Metadata
- **Docker Image**: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
- **Homepage**: https://github.com/eead-csic-compbio/get_homologues
- **Package**: https://anaconda.org/channels/bioconda/packages/get_homologues/overview
- **Validation**: PASS

### Original Help Text
```text
# v.2.3 usage: /usr/local/bin/download_genomes_ncbi.pl <genome_list.txt>

File <genome_list.txt> must contain names of genomes to be downloaded, one per row, as explained in the manual.
Only the first column is required. Example:

NC_010159                   Yersinia_pestis_Angola      # known accession
GCA_000016445.1_ASM1644v1   Yersinia_pestis_Pestoides_F # complete genome
AAYU01                      Yersinia_pestis_B42003004   # WGS genome, possibly a draft
```

## Metadata
- **Skill**: generated
