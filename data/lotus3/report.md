# lotus3 CWL Generation Report

## lotus3

### Tool Description
LotuS3 pipeline for sequence clustering and taxonomic classification.

### Metadata
- **Docker Image**: quay.io/biocontainers/lotus3:3.03--hdfd78af_1
- **Homepage**: https://lotus3.earlham.ac.uk/
- **Package**: https://anaconda.org/channels/bioconda/packages/lotus3/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lotus3/overview
- **Total Downloads**: 335
- **Last updated**: 2025-06-18
- **GitHub**: https://github.com/hildebra/LotuS3
- **Stars**: N/A
### Original Help Text
```text
Lotus3 usage:
lotus3 -i <input fasta|fastq|dir> -o <output_dir> -m/-map <mapping_file>

Minimal example (from lotus3 dir):
./lotus3 -i Example/ -m Example/miSeqMap.sm.txt -o myTestRun -CL vsearch

#### OPTIONS ####

Basic Options:

  -i <file|dir>           In case that fastqFile or fnaFile and qualFile were 
                          specified in the mapping file, this has to be the 
                          directory with input files 
  -m|-map <file>          Mapping file 
  -o <dir>                Warning: The output directory will be completely 
                          removed at the beginning of the LotuS3 run. Please 
                          ensure this is a new directory or contains only 
                          disposable data! 


Workflow Options:

  -backmap_id <0-1>       %id cutoff for backmapping mid-qual reads onto 
                          OTUs/zOTUs/ASVs (Default: 0.97 or 0.99 for ASVs/zOTUs) 
  -forwardPrimer <string>
                          give the forward primer used to amplify DNA region 
                          (e.g. 16S primer fwd) 
  -intargetDB <file>      Keep all OTUs with good matches to this DB (.fa 
                          format). This option is useful if you have a set of 
                          known true positive 16S sequences, that might not be 
                          represented in your tax DB and would otherwise be 
                          removed through \"-keepUnclassified 1\". 
  -keepOfftargets <0|1>   (0)?!?: keep offtarget hits against offtargetDB in 
                          output fasta and otu matrix. (Default 0) 
  -keepTmpFiles <0|1>     (1) save extra tmp files like chimeric OTUs or the 
                          raw blast output in extra dir. (0) do not save these. 
                          (Default: 0) 
  -keepUnclassified <0|1>
                          (1) Includes unclassified OTUs (no Phylum assignment) 
                          in OTU and taxa abundance matrix calculations. (0) 
                          does not report these potential contaminants. 
                          (Default: 1) 
  -mergePreClusterReads <0|1>
                          (0) no merging or reads pre OTU/ASV/zOTU seq 
                          clustering, BUT read merging after seq clustering (to 
                          get better representative sequence). (1) Merge reads 
                          prior to seq clustering. WARNING!! This will 
                          considerably reduce the number of valid read pairs, as 
                          additional quality filters will be applied, algorithm 
                          is still in development !! (Default: 0) 
  -offtargetDB <file>     Remove likely contaminant OTUs/ASVs based on 
                          alignment to provided fasta. This option is useful for 
                          low-bacterial biomass samples, to remove possible host 
                          genome contaminations (e.g. human/mouse genome) 
  -redoTaxOnly <0|1>      (1) Only redo the taxonomic assignments (useful for 
                          replacing a DB used on a finished lotus run). (0) 
                          Normal lotus run. (Default: 0) 
  -reversePrimer <string>
                          give the reverse primer used to amplify DNA region 
                          (e.g. 16S primer rev) 
  -saveDemultiplex <0|1|2|3>
                          (1) Saves all demultiplexed reads (unfiltered) in the 
                          [outputdir]/demultiplexed folder, for easier data 
                          upload. (2) Only saves quality filtered demultiplexed 
                          reads and continues LotuS3 run subsequently. (3) Saves 
                          demultiplexed, filtered reads into a single fq, with 
                          sample ID in fastq/a header. (0) No demultiplexed 
                          reads are saved. (Default: 0) 
  -taxOnly <file>         Skip most of the lotus pipeline and only run a 
                          taxonomic classification on a fasta file. E.g. lotus3 
                          -taxOnly <some16S.fna> -refDB SLV 
  -tolerateCorruptFq <0|1>
                          (1) Continue reading fastq files, even if single 
                          entries are incomplete (e.g. half of qual values 
                          missing). (0) Abort lotus run, if fastq file is 
                          corrupt. (Default: 0) 
  -useVsearch <0|1>       (0) Use usearch for internal tasks such as remapping 
                          reads on OTUs, chimera checks. (1) will use vsearch 
                          for these tasks. This option is independent of the -CL 
                          UPARSE/UNOISE option, and -taxAligner assignment 
                          usearch/vsearch options. (Default: 0) 
  -verbosity <0-3>        Level of verbosity from printing all program calls 
                          and program output (3) to not even printing errors 
                          (0). (Default: 1) 


Clustering Options:

  -CL|-clustering <uparse|swarm|cdhit|unoise|dada2|vsearch>
                          Sequence clustering algorithm: (1) UPARSE, (2) swarm, 
                          (3) cd-hit, (6) unoise3, (7) dada2, (8) VSEARCH. Short 
                          keyword or number can be used to indicate clustering 
                          (Default: UPARSE) 
  -chim_skew <num>        Skew in chimeric fragment abundance (uchime option). 
                          (Default: 2) 
  -count_chimeras<T/F>    Add chimeras to count up OTUs/ASVs. (Default: F) 
  -deactivateChimeraCheck <0|1|2|3>
                          (0) do OTU chimera checks. (1) no chimera check at 
                          all. (2) Deactivate deNovo chimera check. (3) 
                          Deactivate ref based chimera check. (Default: 0) 
  -derepMin<num>          Minimum size of dereplicated clustered, one form of 
                          noise removal. Can also have a more complex syntax, 
                          see examples. (Default: 8:1,4:2,3:3) 
  -endRem <string>        DNA sequence, usually reverse primer or reverse 
                          adaptor; all sequence beyond this point will be 
                          removed from OTUs. This is redundant with the 
                          "ReversePrimer" option from the mapping file, but 
                          gives more control (e.g. there is a problem with 
                          adaptors in the OTU output). (Default: "") 
  -id <0-1>               Clustering threshold for OTUs. (Default: 0.97) 
  -readOverlap <num>      The maximum number of basepairs that two reads are 
                          overlapping. (Default: 300) 
  -swarm_distance <1,2,3,..> 
                          Clustering distance for OTUs when using swarm 
                          clustering. (Default: 1) 
  -xtalk <0|1>            (1) check for crosstalk. Note that this requires in 
                          most cases 64bit usearch. (Default: 0) 


Taxonomy Options:

  -ITSx <0|1>             (1) use ITSx to only retain OTUs fitting to ITS1/ITS2 
                          hmm models; (0) deactivate. (Default: 1) 
  -LCA_cover <0-1>        Min horizontal coverage of an OTU sequence against 
                          ref DB. (Default: 0.5) 
  -LCA_frac <0-1>         Min fraction of database hits at taxlevel, with 
                          identical taxonomy. (Default: 0.9) 
  -LCA_idthresh <97,95,93,91,88,78>
                          6 numbers, comma separated, that are min %id of 
                          OTU/ASV fasta to ref database, to assign taxonomy to 
                          OTU/ASV at this taxonomic level 
  -amplicon_type <SSU|LSU|ITS|ITS1|ITS2|custom>
                          (SSU) small subunit (16S/18S), (LSU) large subunit 
                          (23S/28S) or internal transcribed spacer 
                          (ITS|ITS1|ITS2), (custom) for custom marker genes. 
                          These options will change default read qual filter 
                          parameters and activate ITS specific postfiltering 
                          steps. (Default: SSU) 
  -buildPhylo <0,1,2,>    (0) do not build OTU phylogeny; (1) use fasttree2; 
                          (2) use IQ-TREE 2. (Default: 1). We recommend the 
                          cautious usage of the phylogenetic tree for ITS 
                          because high variation of ITS sequences may lead to 
                          erroneous trees. Phylogenetic trees can be of use for 
                          16S data depending on the aim of the analysis. 
  -greengenesSpecies <0|1>
                          (1) Create greengenes output labels instead of OTU 
                          (to be used with greengenes specific programs such as 
                          BugBase). (Default: 0) 
  -itsx_partial <0-100>   Parameters for ITSx to extract partial (%) ITS 
                          regions as well. (0) deactivate. (Default: 0) 
  -lulu <0|1>             (1) use LULU (https://github.com/tobiasgf/lulu) to 
                          merge OTUs based on their occurrence. (Default: 1) 
  -rdp_thr <0-1>          Confidence thresshold for RDP. (Default: 0.8) 
  -recalcTaxDB <0,1>      (1) recalc tax DB anew, even if exists (Default: 0) 
  -refDB <KSGP|SLV|GG2|HITdb|PR2|UNITE|beetax>
                          (SLV) Silva LSU (23/28S) or SSU (16/18S), (KSGP) 
                          Bacteria, Archaea, Eukaryotes SSU, (GG2) GreenGenes2 
                          SSU, (HITdb) human gut specific SSU, (PR2) LSU 
                          spezialized on Ocean environmentas, (UNITE) ITS fungi 
                          specific, (beetax) bee gut specific SSU. Given that 
                          \"-amplicon_type \" was set to SSU or LSU, the 
                          appropriate DB in SLV would be used. \nDecide which 
                          reference DB will be used for a similarity based 
                          taxonomy annotation. Databases can be combined, with 
                          the first having the highest priority. E.g. 
                          "HITdb,SLV" would priority assign OTUs to PR2 
                          taxonomy, but hits with a higher %id to SLV would be 
                          assigned to SLV. Can also be a custom fasta formatted 
                          database: in this case provide the path to the fasta 
                          file as well as the path to the taxonomy for the 
                          sequences using -tax4refDB. For custom databases 
                          QIIME2 file formats are compatible if the delimiter in 
                          the QIIME2 taxonomy file is changed from semicolon to 
                          tab. See also online help on how to create a custom 
                          DB. WARNING: combining databases with incompatible tax 
                          levels (e.g. PR2,SLV) will result in non sensical tax 
                          levels. (Default: none) 
  -sintax_thr <0-1>       Confidence thresshold for SINTAX. (Default: 0.8) 
  -tax4refDB <file>       In conjunction with a custom fasta file provided to 
                          argument -refDB, this file contains for each fasta 
                          entry in the reference DB a taxonomic annotation 
                          string, with the same number of taxonomic levels for 
                          each, tab separated. 
  -taxAligner <0|blast|lambda|utax|sintax|vsearch|usearch>
                          (0) alginment deactivated, use RDPclassifier (this 
                          does not report species level taxonomies); (1) or 
                          (blast) use Blast; (2) or (lambda) use LAMBDA to 
                          search against a 16S reference database for taxonomic 
                          profiling of OTUs; (3) or (utax) or (sintax): use 
                          UTAX/SINTAX with custom databases; will use SINTAX if 
                          uparse ver >= 9 is found (4) or (vsearch) use VSEARCH 
                          to align OTUs to custom databases; (5) or (usearch) 
                          use USEARCH to align OTUs to custom databases. 
                          (Default: 0) 
  -taxExcludeGrep <string>
                          Exclude taxonomic group, these OTUs will be assigned 
                          as unknown instead. E.g. -taxExcludeGrep 
                          Chloroplast|Mitochondria (Default: ) 
  -tax_group <bacteria|fungi|eukarya>
                          (bacteria) bacterial 16S rDNA annnotation, (fungi) 
                          fungal 18S/23S/ITS annotation, (eukarya) eukaryotic 
                          (18S/23S) annotation. (Default: bacteria) 
  -useBestBlastHitOnly <0|1>
                          (1) do not use LCA (lowest common ancestor) to 
                          determine most likely taxonomic level (not 
                          recommended), instead just use the best blast hit. (0) 
                          LCA algorithm. (Default: 0) 


Further Options:

  -barcode|-MID <file>    Filepath to fastq formated file with barcodes (this 
                          is a processed mi/hiSeq format). The complementary 
                          option in a mapping file would be the column 
                          "MIDfqFile". (Default: "") 
  -c <file>               LotuS.cfg, config file with program paths. (Default: 
                          <LotuS3_dir>/lOTUs.cfg) 
  -p <454/miSeq/hiSeq/PacBio>
                          sequencing platform: PacBio, PacBio_GA, 454, AVITI, 
                          miSeq or hiSeq. (Default: miSeq) 
  -q <file>               .qual file associated to fasta file. This is an old 
                          format that was replaced by fastq format and is rarely 
                          used nowadays. (Default: "") 
  -s|sdmopt <file>        SDM option file, defaults to "configs/sdm_miSeq.txt" 
                          in current dir. (Default: miSeq) 
  -tmp|-tmpDir <dir>      temporary directory used to save intermediate 
                          results. (Default: <outputDir>/tmpDir) 
  -t|-threads <num>       number of threads to be used. (Default: 1) 


Other uses of pipeline (quits after execution):

  -check_map <file>       Mapping_file: only checks mapping file and exists. 
  -create_map <file>      mapping_file: creates a new mapping file at location, 
                          based on already demultiplexed input (-i) dir. E.g. 
                          lotus3 -create_map mymap.txt -i 
                          /home/dir_with_demultiplex_fastq 
  -link_usearch <file>    Provide the absolute path to your local usearch 
                          binary file, this will be installed to be useable with 
                          LotuS3 in the future. 
  -taxOnly <file>         Skip most of the lotus pipeline and only run a 
                          taxonomic classification on a fasta file. E.g. lotus3 
                          -taxOnly <some16S.fna> -refDB SLV 
  -v                      Print LotuS3 version
```

