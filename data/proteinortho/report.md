# proteinortho CWL Generation Report

## proteinortho

### Tool Description
An orthology detection tool with PoFF version 6.3.6

### Metadata
- **Docker Image**: quay.io/biocontainers/proteinortho:6.3.6--h2b77389_0
- **Homepage**: https://gitlab.com/paulklemm_PHD/proteinortho/
- **Package**: https://anaconda.org/channels/bioconda/packages/proteinortho/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/proteinortho/overview
- **Total Downloads**: 186.4K
- **Last updated**: 2025-06-12
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
*****************************************************************
[1;32mProteinortho[0m with PoFF version 6.3.6 - An orthology detection tool
*****************************************************************

     |
  [1;36m  /[0m [1;31m\  [0m
  [1;36m /\[0m[1;31m /\ [0m
  [1;36m/ [1;31m/[1;36m \ [1;31m\[0m

Usage: proteinortho6.pl [OPTIONS] FASTA1 FASTA2 [FASTA...] (one for each species, at least 2)
Options:
   [General options]
   -project=    prefix for all result file names [default: myproject]
   -inproject=  load data from this namespace instead and output in -project (works with 
                intermediate files for step=2 and blast-graph for step=3).
                With this option you can change e.g. the -sim without recalculating all 
                intermediate files of -step=2
   -cpus=       number of processors to use [default: auto]
   -threads_per_process= number of threads per process [default: 1], 
                e.g. using -cpus=4 and -threads_per_process=2 will spawn 4 workerthreads 
                using 2 cpu cores each = total of 8 cores.
   -silent      sets verbose to 0
   -temp=       path for temporary files [default: working directory]
   -keep        stores temporary blast results for reuse (proteinortho_cache_project directory). 
                In a second run the intermediate blast results are loaded instead of calculated.
                You can adjust the parameters e.g. a more strict -e evalue cut off and write 
                the output to a different namespace using --inproject.
   -force       forces the recalculation of the blast results in any case in step=2. Also forces 
                the recreation of the database generation in step=1
   -clean       remove all unnecessary files after processing
   -step=       1 -> generate indices
                2 -> run blast (and ff-adj, if -synteny is set)
                3 -> clustering
                0 -> all (default)
   -isoform=    Enables the isoform merging: All isoforms are united to a single entity and 
                treated as one protein in the RBH algorithm. 
                E.g. Let I1 and I2 two isoforms, I1 reciprocally matches A and I2 B but no other
                hits are found: with this option the output is A-I-B (results of I1 and I2 are 
                merged). 
                Modus:
                ncbi -> if the word 'isoform' is found 
                uniprot -> 'Isoform of XYZ' (You need to add the *_additional.fasta files)
                trinity -> using '_iX' suffix
                For more information have a look at: 
                  https://gitlab.com/paulklemm_PHD/proteinortho/-/wikis/FAQ#how-does-the-isoform-work

   [Search options]
   -p=          blast program [default: diamond]

                {blastp|blastn|tblastx|blastp_legacy|blastn_legacy|tblastx_legacy|diamond|usearch|ublast|
                  lastp|lastn|rapsearch|topaz|blatp|blatn|mmseqsp|mmseqsn}

                The chosen program need to be installed first.
                A suffix 'p' or 'n' indicates aminoacid fasta files (p) or nucleotide fasta files (n).

                  autoblast : automatically detects the blast+ program (blastp,blastn,tblastn,blastx) 
                              depending on the input (can also be mixed together!)
                  blast*|tblastx : standard blast+ family (blastp : protein files, blastn : dna files)
                  blast*_legacy : legacy blast family (blastall)
                  diamond : Only for protein files! standard diamond procedure with the additional 
                            --sensitive flag (disable with -notsensitive)
                            https://github.com/bbuchfink/diamond
                  usearch : usearch_local procedure with -id 0 (minimum identity percentage).
                  ublast : usearch_ublast procedure.
                  lastn : standard lastal. Only for dna files! http://last.cbrc.jp/
                  lastp : lastal using -p and BLOSUM62 scoring matrix. Only for protein files!
                  rapsearch : Only for protein files! https://github.com/zhaoyanswill/RAPSearch2
                  topaz : Only for protein files! https://github.com/ajm/topaz
                  blat* : Blat family. blatp : for protein files! blatn : for dna files!
                          http://hgdownload.soe.ucsc.edu/admin/
                  mmseqs* : mmseqs family. mmseqsp : For protein files! mmseqsn : For dna files!
                            https://github.com/soedinglab/MMseqs2
   -nopseudo|normal|fullallvsall  Disables the pseudo reciprocal blast analysis analysis (this doubles the runtime)
   -omni        All pairwise fasta calles are combined to a single one (very memory intensive), 
                E-values are corrected to fasta specific ones.
   -e=          E-value for blast [default: 1e-05]
                (column 11 of blast outfmt 6 output)
   -selfblast   apply selfblast, detects paralogs without orthologs
   -sim=        min. reciprocal similarity for additional hits (0..1) [default: 0.95]
                1 : only the best reciprocal hits are reported
                0 : all possible reciprocal blast matches (within boundaries of -e, -cov, ...) are reported
   -identity=   min. percent identity of best blast hits [default: 25]
                (column 3 (pident) of blast outfmt 6 output)
   -cov=        min. coverage of best blast alignments in % [default: 50]
                coverage between protein A and B 
                  = min (alignment_length_A_B/length_A, alignment_length_A_B/length_B)
                where alignment_length_A_B = column 4 of blast outfmt 6 output
   -subparaBlast=    additional parameters for the search tool
                example -subparaBlast='-seg no' or -subparaBlast='--more-sensitive' for diamond
   -subparaMakeBlast=    additional parameters for the database generation
   -checkfasta  Checks if the given fasta files are compatible with the algorithm of -p
   -identical   only return entries that are 100% identical
   -range=      maximal length difference for any blast hit. e.g. 0 = filter for hits between 
                proteins of same length [default:disabled]

   [Synteny options]
   -synteny     activate PoFF extension to separate similar sequences print
                by contextual adjacencies (requires .gff for each .fasta)
                Each protein with the ID 'XXX' needs to be refered in the gff file with the attribute 'Name=XXX'
                For more information see 'https://gitlab.com/paulklemm_PHD/proteinortho#poff'
   -dups=       PoFF: number of reiterations for adjacencies heuristic,
                to determine duplicated regions (default: 0)
   -cs=         PoFF: Size of a maximum common substring (MCS) for
                adjacency matches (default: 3)
   -alpha=      PoFF: weight of adjacencies vs. sequence similarity
                α[FF-adj score]+(1−α)[BLAST score]
                (default: 0.5)

   [Clustering options]
   -singles     report singleton genes without any hit
   -conn=       min. algebraic connectivity [default: 0.1 / 1e-1]
                This is the main parameter for the clustering step. 
                Choose larger values then more splits are done, resulting in more and smaller clusters. 
                (There are still cluster with an alg. conn. below this given threshold allowed if the protein 
                to species ratio is good enough, see -minspecies option below).
                special values:
                0 : search only connected components and calculate the connectivity but no split is made
                -1 : same as 0 but the connectivity is not calculated
   -xml         produces an OrthoXML formatted file of the *.proteinortho.tsv file. 
                You can use 'proteinortho2xml project.proteinortho-graph >project.xml' after proteinortho as well.
   -nograph     do not generate .proteinortho-graph file (pairwise orthology relations)
   -core        stop clustering if a split would result in groups that do not span across all species of 
                the inital connected component. Overrules the -conn threshold.
   -coreMaxProt=  sets the maximal number of proteins per species for the -core option (default:10).
   -maxnodes=    only consider connected component with up to this number of nodes. If exceeded, remove 
                 outlying edges accoring to the Smirnov-Grubb test or greedily the worst 10 percent of edges 
                 (by weight) until satisfied. Disable with 0 [default:5000]

   [Misc options]
   -desc        write description files (for NCBI FASTA input only)
   -debug       gives detailed information for bug tracking
   -binpath=    path to your directory of local programs that are not available globally (this should not be needed)

   [Large compute jobs]
    In case jobs should be distributed onto several machines, use
   -jobs=M/N    N defines the number of defined job groups (e.g. PCs)
                M defines the set of jobs to run in this process
                Example: run with first with -step=1 to prepare data then to split a run on two machines use 
                -jobs=1/2 -step=2 on PC one and -jobs=2/2 -step=2 on PC two finally run with -step=3 to finalize

   [output files]
     [RBH *.blast-graph]

       The reciprocal best hit graph. 
       First two comment line announces 2 species (# ecoli.faa<tab>human.faa) as well as the median values 
       evalue_ab,bitscore_ab,evalue_ba,bitscore_ba. 
       Following these header lines, each line corresponds to a reciprocal best hit of 2 proteins/genes 
       (columns 1 and 2) of the announced species. The output format is shown below.
       *seqidA*,*seqidB* = the 2 ids/names of the proteins involved 
       *evalue_ab* = evalue with seqidA as query and seqidB as part of the database 
       *bitscore_ab* = bitscore with seqidA as query ...
       *evalue_ba* = evalue with seqidB as query ...

       | seqidA<tab>seqidB<tab>evalue_ab<tab>bitscore_ab<tab>evalue_ba<tab>bitscore_ba    
       | # ecoli.faa<tab>human.faa
       | # 1.91e-112<tab>357.5<tab>1.825e-113<tab>360
       | L_10<tab>C_10;test<tab>4.32e-151<tab>447<tab>4.30e-151<tab>446
       | L_11<tab>C_11<tab>1.17e-68<tab>209<tab>3.00e-69<tab>210
       | (...)

     [orthology groups *.proteinortho.tsv]

       The clustered reciprocal best hit graph or the orthology groups.
       Every line corresponds to an orthology group. 
       The first 3 columns characterize the general properties of that group: number of proteins, species, 
       and algebraic connectivity. The higher the algebraic connectivity the more edges are there and the 
       better the group is connected to itself. 
       Then a column for each species follows containing the proteins of these species. 
       If a species contributes with more than one protein to a group of orthologs, then they are ordered 
       by descending connectivity.
       The '*' represents that this species does not contribute to the group.

       | Species<tab>Genes<tab>alg.-conn.<tab>ecoli.faa<tab>human.faa<tab>snail.faa<tab>wale.faa<tab>mouse.faa
       | 5<tab>5<tab>0.715<tab>C_10<tab>C_10;test<tab>E_10<tab>L_10<tab>M_10
       | 4<tab>6<tab>0.115<tab>*<tab>C_12<tab>E_315<tab>L_313<tab>M_313
       | (...)

       The first group is comprised of 5 proteins of 5 species: 'C_10' of ecoli.faa, 'C_10;test' of human.faa, 
       'E_10' of snail.faa, 'L_10' of wale.faa, and 'M_10' of mouse.faa.
       The alg.-conn. (algebraic connectivity) of 0.715 indicates the connectivity of this group, the higher 
       the more edges are connecting these 5 proteins (at most there can be 10 and at least there need to be 4).
       The second group contains 6 proteins distributed over 4 species. The star indicates the species where 
       no protein was found (in this case ecoli.faa).

       | seqidA<tab>seqidB<tab>evalue_ab<tab>bitscore_ab<tab>evalue_ba<tab>bitscore_ba    
       | # ecoli.faa<tab>human.faa
       | # 1.91e-112<tab>357.5<tab>1.825e-113<tab>360
       | L_10<tab>C_10;test<tab>4.32e-151<tab>447<tab>4.30e-151<tab>446
       | L_11<tab>C_11<tab>1.17e-68<tab>209<tab>3.00e-69<tab>210
       | (...)

     [orthology pairs *.proteinortho-graph]

       Similar to orthology groups, but each edge is printed individually.
       The output is formatted the same as the RBH graph.
       For example extracting all hits of the second group of the example orthology-group output 
       ('4<tab>6<tab>0.115<tab>*<tab>C_12<tab>E_315<tab>L_313<tab>M_313') using grep 
       (-E, regular expression='(C_12|E_315|L_313|M_313).*(C_12|E_315|L_313|M_313)', input file=proteinortho-graph) 
       would reveal all edges of this groups:

       | seqidA<tab>seqidB<tab>evalue_ab<tab>bitscore_ab<tab>evalue_ba<tab>bitscore_ba    
       | M_313<tab>C_12<tab>1.18e-115<tab>407<tab>6.12e-116<tab>407
       | C_12<tab>E_315<tab>4.50e-127<tab>445<tab>4.09e-127<tab>445
       | L_313<tab>M_313<tab>0.00e+00<tab>1368<tab>0.00e+00<tab>1368
       | L_313<tab>C_12<tab>3.76e-114<tab>402<tab>1.94e-114<tab>402

       Especially L_313 and M_313 are very similar, probably identical.
       The group cotnains 4 edges out of the 6 possible edges for a group of 4 proteins. The missing 
       edges are M_313-E_315 as well as L_313-E_315. This means that E_315 is only connected to the 
       other 3 proteins via C_12 and thus could be considered as a weak link in the group.

For more information: https://gitlab.com/paulklemm_PHD/proteinortho
Do you have suggestions or need more help: write a mail to lechner@staff.uni-marburg.de.

Klemm, P., Stadler, P. F., & Lechner, M. Proteinortho6: Pseudo-reciprocal best alignment heuristic for graph-based detection of (co-) orthologs. Frontiers in Bioinformatics, 3, 1322477. doi:10.3389/fbinf.2023.1322477
```


## Metadata
- **Skill**: generated

## proteinortho

### Tool Description
An orthology detection tool with PoFF version 6.3.6

### Metadata
- **Docker Image**: quay.io/biocontainers/proteinortho:6.3.6--h2b77389_0
- **Homepage**: https://gitlab.com/paulklemm_PHD/proteinortho/
- **Package**: https://anaconda.org/channels/bioconda/packages/proteinortho/overview
- **Validation**: PASS
### Original Help Text
```text
*****************************************************************
[1;32mProteinortho[0m with PoFF version 6.3.6 - An orthology detection tool
*****************************************************************

     |
  [1;36m  /[0m [1;31m\  [0m
  [1;36m /\[0m[1;31m /\ [0m
  [1;36m/ [1;31m/[1;36m \ [1;31m\[0m

Usage: proteinortho6.pl [OPTIONS] FASTA1 FASTA2 [FASTA...] (one for each species, at least 2)
Options:
   [General options]
   -project=    prefix for all result file names [default: myproject]
   -inproject=  load data from this namespace instead and output in -project (works with 
                intermediate files for step=2 and blast-graph for step=3).
                With this option you can change e.g. the -sim without recalculating all 
                intermediate files of -step=2
   -cpus=       number of processors to use [default: auto]
   -threads_per_process= number of threads per process [default: 1], 
                e.g. using -cpus=4 and -threads_per_process=2 will spawn 4 workerthreads 
                using 2 cpu cores each = total of 8 cores.
   -silent      sets verbose to 0
   -temp=       path for temporary files [default: working directory]
   -keep        stores temporary blast results for reuse (proteinortho_cache_project directory). 
                In a second run the intermediate blast results are loaded instead of calculated.
                You can adjust the parameters e.g. a more strict -e evalue cut off and write 
                the output to a different namespace using --inproject.
   -force       forces the recalculation of the blast results in any case in step=2. Also forces 
                the recreation of the database generation in step=1
   -clean       remove all unnecessary files after processing
   -step=       1 -> generate indices
                2 -> run blast (and ff-adj, if -synteny is set)
                3 -> clustering
                0 -> all (default)
   -isoform=    Enables the isoform merging: All isoforms are united to a single entity and 
                treated as one protein in the RBH algorithm. 
                E.g. Let I1 and I2 two isoforms, I1 reciprocally matches A and I2 B but no other
                hits are found: with this option the output is A-I-B (results of I1 and I2 are 
                merged). 
                Modus:
                ncbi -> if the word 'isoform' is found 
                uniprot -> 'Isoform of XYZ' (You need to add the *_additional.fasta files)
                trinity -> using '_iX' suffix
                For more information have a look at: 
                  https://gitlab.com/paulklemm_PHD/proteinortho/-/wikis/FAQ#how-does-the-isoform-work

   [Search options]
   -p=          blast program [default: diamond]

                {blastp|blastn|tblastx|blastp_legacy|blastn_legacy|tblastx_legacy|diamond|usearch|ublast|
                  lastp|lastn|rapsearch|topaz|blatp|blatn|mmseqsp|mmseqsn}

                The chosen program need to be installed first.
                A suffix 'p' or 'n' indicates aminoacid fasta files (p) or nucleotide fasta files (n).

                  autoblast : automatically detects the blast+ program (blastp,blastn,tblastn,blastx) 
                              depending on the input (can also be mixed together!)
                  blast*|tblastx : standard blast+ family (blastp : protein files, blastn : dna files)
                  blast*_legacy : legacy blast family (blastall)
                  diamond : Only for protein files! standard diamond procedure with the additional 
                            --sensitive flag (disable with -notsensitive)
                            https://github.com/bbuchfink/diamond
                  usearch : usearch_local procedure with -id 0 (minimum identity percentage).
                  ublast : usearch_ublast procedure.
                  lastn : standard lastal. Only for dna files! http://last.cbrc.jp/
                  lastp : lastal using -p and BLOSUM62 scoring matrix. Only for protein files!
                  rapsearch : Only for protein files! https://github.com/zhaoyanswill/RAPSearch2
                  topaz : Only for protein files! https://github.com/ajm/topaz
                  blat* : Blat family. blatp : for protein files! blatn : for dna files!
                          http://hgdownload.soe.ucsc.edu/admin/
                  mmseqs* : mmseqs family. mmseqsp : For protein files! mmseqsn : For dna files!
                            https://github.com/soedinglab/MMseqs2
   -nopseudo|normal|fullallvsall  Disables the pseudo reciprocal blast analysis analysis (this doubles the runtime)
   -omni        All pairwise fasta calles are combined to a single one (very memory intensive), 
                E-values are corrected to fasta specific ones.
   -e=          E-value for blast [default: 1e-05]
                (column 11 of blast outfmt 6 output)
   -selfblast   apply selfblast, detects paralogs without orthologs
   -sim=        min. reciprocal similarity for additional hits (0..1) [default: 0.95]
                1 : only the best reciprocal hits are reported
                0 : all possible reciprocal blast matches (within boundaries of -e, -cov, ...) are reported
   -identity=   min. percent identity of best blast hits [default: 25]
                (column 3 (pident) of blast outfmt 6 output)
   -cov=        min. coverage of best blast alignments in % [default: 50]
                coverage between protein A and B 
                  = min (alignment_length_A_B/length_A, alignment_length_A_B/length_B)
                where alignment_length_A_B = column 4 of blast outfmt 6 output
   -subparaBlast=    additional parameters for the search tool
                example -subparaBlast='-seg no' or -subparaBlast='--more-sensitive' for diamond
   -subparaMakeBlast=    additional parameters for the database generation
   -checkfasta  Checks if the given fasta files are compatible with the algorithm of -p
   -identical   only return entries that are 100% identical
   -range=      maximal length difference for any blast hit. e.g. 0 = filter for hits between 
                proteins of same length [default:disabled]

   [Synteny options]
   -synteny     activate PoFF extension to separate similar sequences print
                by contextual adjacencies (requires .gff for each .fasta)
                Each protein with the ID 'XXX' needs to be refered in the gff file with the attribute 'Name=XXX'
                For more information see 'https://gitlab.com/paulklemm_PHD/proteinortho#poff'
   -dups=       PoFF: number of reiterations for adjacencies heuristic,
                to determine duplicated regions (default: 0)
   -cs=         PoFF: Size of a maximum common substring (MCS) for
                adjacency matches (default: 3)
   -alpha=      PoFF: weight of adjacencies vs. sequence similarity
                α[FF-adj score]+(1−α)[BLAST score]
                (default: 0.5)

   [Clustering options]
   -singles     report singleton genes without any hit
   -conn=       min. algebraic connectivity [default: 0.1 / 1e-1]
                This is the main parameter for the clustering step. 
                Choose larger values then more splits are done, resulting in more and smaller clusters. 
                (There are still cluster with an alg. conn. below this given threshold allowed if the protein 
                to species ratio is good enough, see -minspecies option below).
                special values:
                0 : search only connected components and calculate the connectivity but no split is made
                -1 : same as 0 but the connectivity is not calculated
   -xml         produces an OrthoXML formatted file of the *.proteinortho.tsv file. 
                You can use 'proteinortho2xml project.proteinortho-graph >project.xml' after proteinortho as well.
   -nograph     do not generate .proteinortho-graph file (pairwise orthology relations)
   -core        stop clustering if a split would result in groups that do not span across all species of 
                the inital connected component. Overrules the -conn threshold.
   -coreMaxProt=  sets the maximal number of proteins per species for the -core option (default:10).
   -maxnodes=    only consider connected component with up to this number of nodes. If exceeded, remove 
                 outlying edges accoring to the Smirnov-Grubb test or greedily the worst 10 percent of edges 
                 (by weight) until satisfied. Disable with 0 [default:5000]

   [Misc options]
   -desc        write description files (for NCBI FASTA input only)
   -debug       gives detailed information for bug tracking
   -binpath=    path to your directory of local programs that are not available globally (this should not be needed)

   [Large compute jobs]
    In case jobs should be distributed onto several machines, use
   -jobs=M/N    N defines the number of defined job groups (e.g. PCs)
                M defines the set of jobs to run in this process
                Example: run with first with -step=1 to prepare data then to split a run on two machines use 
                -jobs=1/2 -step=2 on PC one and -jobs=2/2 -step=2 on PC two finally run with -step=3 to finalize

   [output files]
     [RBH *.blast-graph]

       The reciprocal best hit graph. 
       First two comment line announces 2 species (# ecoli.faa<tab>human.faa) as well as the median values 
       evalue_ab,bitscore_ab,evalue_ba,bitscore_ba. 
       Following these header lines, each line corresponds to a reciprocal best hit of 2 proteins/genes 
       (columns 1 and 2) of the announced species. The output format is shown below.
       *seqidA*,*seqidB* = the 2 ids/names of the proteins involved 
       *evalue_ab* = evalue with seqidA as query and seqidB as part of the database 
       *bitscore_ab* = bitscore with seqidA as query ...
       *evalue_ba* = evalue with seqidB as query ...

       | seqidA<tab>seqidB<tab>evalue_ab<tab>bitscore_ab<tab>evalue_ba<tab>bitscore_ba    
       | # ecoli.faa<tab>human.faa
       | # 1.91e-112<tab>357.5<tab>1.825e-113<tab>360
       | L_10<tab>C_10;test<tab>4.32e-151<tab>447<tab>4.30e-151<tab>446
       | L_11<tab>C_11<tab>1.17e-68<tab>209<tab>3.00e-69<tab>210
       | (...)

     [orthology groups *.proteinortho.tsv]

       The clustered reciprocal best hit graph or the orthology groups.
       Every line corresponds to an orthology group. 
       The first 3 columns characterize the general properties of that group: number of proteins, species, 
       and algebraic connectivity. The higher the algebraic connectivity the more edges are there and the 
       better the group is connected to itself. 
       Then a column for each species follows containing the proteins of these species. 
       If a species contributes with more than one protein to a group of orthologs, then they are ordered 
       by descending connectivity.
       The '*' represents that this species does not contribute to the group.

       | Species<tab>Genes<tab>alg.-conn.<tab>ecoli.faa<tab>human.faa<tab>snail.faa<tab>wale.faa<tab>mouse.faa
       | 5<tab>5<tab>0.715<tab>C_10<tab>C_10;test<tab>E_10<tab>L_10<tab>M_10
       | 4<tab>6<tab>0.115<tab>*<tab>C_12<tab>E_315<tab>L_313<tab>M_313
       | (...)

       The first group is comprised of 5 proteins of 5 species: 'C_10' of ecoli.faa, 'C_10;test' of human.faa, 
       'E_10' of snail.faa, 'L_10' of wale.faa, and 'M_10' of mouse.faa.
       The alg.-conn. (algebraic connectivity) of 0.715 indicates the connectivity of this group, the higher 
       the more edges are connecting these 5 proteins (at most there can be 10 and at least there need to be 4).
       The second group contains 6 proteins distributed over 4 species. The star indicates the species where 
       no protein was found (in this case ecoli.faa).

       | seqidA<tab>seqidB<tab>evalue_ab<tab>bitscore_ab<tab>evalue_ba<tab>bitscore_ba    
       | # ecoli.faa<tab>human.faa
       | # 1.91e-112<tab>357.5<tab>1.825e-113<tab>360
       | L_10<tab>C_10;test<tab>4.32e-151<tab>447<tab>4.30e-151<tab>446
       | L_11<tab>C_11<tab>1.17e-68<tab>209<tab>3.00e-69<tab>210
       | (...)

     [orthology pairs *.proteinortho-graph]

       Similar to orthology groups, but each edge is printed individually.
       The output is formatted the same as the RBH graph.
       For example extracting all hits of the second group of the example orthology-group output 
       ('4<tab>6<tab>0.115<tab>*<tab>C_12<tab>E_315<tab>L_313<tab>M_313') using grep 
       (-E, regular expression='(C_12|E_315|L_313|M_313).*(C_12|E_315|L_313|M_313)', input file=proteinortho-graph) 
       would reveal all edges of this groups:

       | seqidA<tab>seqidB<tab>evalue_ab<tab>bitscore_ab<tab>evalue_ba<tab>bitscore_ba    
       | M_313<tab>C_12<tab>1.18e-115<tab>407<tab>6.12e-116<tab>407
       | C_12<tab>E_315<tab>4.50e-127<tab>445<tab>4.09e-127<tab>445
       | L_313<tab>M_313<tab>0.00e+00<tab>1368<tab>0.00e+00<tab>1368
       | L_313<tab>C_12<tab>3.76e-114<tab>402<tab>1.94e-114<tab>402

       Especially L_313 and M_313 are very similar, probably identical.
       The group cotnains 4 edges out of the 6 possible edges for a group of 4 proteins. The missing 
       edges are M_313-E_315 as well as L_313-E_315. This means that E_315 is only connected to the 
       other 3 proteins via C_12 and thus could be considered as a weak link in the group.

For more information: https://gitlab.com/paulklemm_PHD/proteinortho
Do you have suggestions or need more help: write a mail to lechner@staff.uni-marburg.de.

Klemm, P., Stadler, P. F., & Lechner, M. Proteinortho6: Pseudo-reciprocal best alignment heuristic for graph-based detection of (co-) orthologs. Frontiers in Bioinformatics, 3, 1322477. doi:10.3389/fbinf.2023.1322477
```

