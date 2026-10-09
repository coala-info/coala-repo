cwlVersion: v1.2
class: CommandLineTool
baseCommand: lotus2
label: lotus2
doc: "Lotus2 amplicon sequencing pipeline: demultiplexing, filtering, OTU/ASV clustering, chimera removal, taxonomic annotation.\n\nTool homepage: http://lotus2.earlham.ac.uk/"
inputs:
  - id: input
    type:
      - File
      - Directory
    doc: "In case that fastqFile or fnaFile and qualFile were specified in the mapping file, this has to be the directory with input files"
    inputBinding:
      position: 1
      prefix: -i
      valueFrom: "$(self.class == 'Directory' ? self.path + '/' : self.path)"
  - id: mapping_file
    type: File
    doc: "Mapping file"
    inputBinding:
      position: 2
      prefix: -m
  - id: output_dir_path
    type: string
    doc: "Output directory. The directory is completely removed at the start of the run."
    inputBinding:
      position: 3
      prefix: -o
  - id: backmap_id
    type:
      - 'null'
      - float
    doc: "%id cutoff for backmapping mid-qual reads onto OTUs/zOTUs/ASVs (Default: 0.97 or 0.99 for ASVs/zOTUs)"
    inputBinding:
      position: 4
      prefix: -backmap_id
  - id: forward_primer
    type:
      - 'null'
      - string
    doc: "give the forward primer used to amplify DNA region (e.g. 16S primer fwd)"
    inputBinding:
      position: 5
      prefix: -forwardPrimer
  - id: intarget_db
    type:
      - 'null'
      - File
    doc: "Keep all OTUs with good matches to this DB (.fa format). This option is useful if you have a set of known true positive 16S sequences, that might not be represented in your tax DB and would otherwise be removed through \"-keepUnclassified 1\"."
    inputBinding:
      position: 6
      prefix: -intargetDB
  - id: keep_offtargets
    type:
      - 'null'
      - int
    doc: "(0)?!?: keep offtarget hits against offtargetDB in output fasta and otu matrix. (Default 0)"
    inputBinding:
      position: 7
      prefix: -keepOfftargets
  - id: keep_tmp_files
    type:
      - 'null'
      - int
    doc: "(1) save extra tmp files like chimeric OTUs or the raw blast output in extra dir. (0) do not save these. (Default: 0)"
    inputBinding:
      position: 8
      prefix: -keepTmpFiles
  - id: keep_unclassified
    type:
      - 'null'
      - int
    doc: "(1) Includes unclassified OTUs (no Phylum assignment) in OTU and taxa abundance matrix calculations. (0) does not report these potential contaminants. (Default: 1)"
    inputBinding:
      position: 9
      prefix: -keepUnclassified
  - id: merge_pre_cluster_reads
    type:
      - 'null'
      - int
    doc: "(0) no merging or reads pre OTU/ASV/zOTU seq clustering, BUT read merging after seq clustering (to get better representative sequence). (1) Merge reads prior to seq clustering. WARNING!! This will considerably reduce the number of valid read pairs, as additional quality filters will be applied, algorithm is still in development !! (Default: 0)"
    inputBinding:
      position: 10
      prefix: -mergePreClusterReads
  - id: offtarget_db
    type:
      - 'null'
      - File
    doc: "Remove likely contaminant OTUs/ASVs based on alignment to provided fasta. This option is useful for low-bacterial biomass samples, to remove possible host genome contaminations (e.g. human/mouse genome)"
    inputBinding:
      position: 11
      prefix: -offtargetDB
  - id: redo_tax_only
    type:
      - 'null'
      - int
    doc: "(1) Only redo the taxonomic assignments (useful for replacing a DB used on a finished lotus run). (0) Normal lotus run. (Default: 0)"
    inputBinding:
      position: 12
      prefix: -redoTaxOnly
  - id: reverse_primer
    type:
      - 'null'
      - string
    doc: "give the reverse primer used to amplify DNA region (e.g. 16S primer rev)"
    inputBinding:
      position: 13
      prefix: -reversePrimer
  - id: save_demultiplex
    type:
      - 'null'
      - int
    doc: "(1) Saves all demultiplexed reads (unfiltered) in the [outputdir]/demultiplexed folder, for easier data upload. (2) Only saves quality filtered demultiplexed reads and continues LotuS2 run subsequently. (3) Saves demultiplexed, filtered reads into a single fq, with sample ID in fastq/a header. (0) No demultiplexed reads are saved. (Default: 0)"
    inputBinding:
      position: 14
      prefix: -saveDemultiplex
  - id: tax_only
    type:
      - 'null'
      - File
    doc: "Skip most of the lotus pipeline and only run a taxonomic classification on a fasta file. E.g. lotus2 -taxOnly <some16S.fna> -refDB SLV"
    inputBinding:
      position: 15
      prefix: -taxOnly
  - id: tolerate_corrupt_fq
    type:
      - 'null'
      - int
    doc: "(1) Continue reading fastq files, even if single entries are incomplete (e.g. half of qual values missing). (0) Abort lotus run, if fastq file is corrupt. (Default: 0)"
    inputBinding:
      position: 16
      prefix: -tolerateCorruptFq
  - id: use_vsearch
    type:
      - 'null'
      - int
    doc: "(0) Use usearch for internal tasks such as remapping reads on OTUs, chimera checks. (1) will use vsearch for these tasks. This option is independent of the -CL UPARSE/UNOISE option, and -taxAligner assignment usearch/vsearch options. (Default: 0)"
    inputBinding:
      position: 17
      prefix: -useVsearch
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "Level of verbosity from printing all program calls and program output (3) to not even printing errors (0). (Default: 1)"
    inputBinding:
      position: 18
      prefix: -verbosity
  - id: clustering_algorithm
    type:
      - 'null'
      - string
    doc: "Sequence clustering algorithm: (1) UPARSE, (2) swarm, (3) cd-hit, (6) unoise3, (7) dada2, (8) VSEARCH. Short keyword or number can be used to indicate clustering (Default: UPARSE)"
    inputBinding:
      position: 19
      prefix: -CL
  - id: chim_skew
    type:
      - 'null'
      - int
    doc: "Skew in chimeric fragment abundance (uchime option). (Default: 2)"
    inputBinding:
      position: 20
      prefix: -chim_skew
  - id: count_chimeras
    type:
      - 'null'
      - string
    doc: "Add chimeras to count up OTUs/ASVs. (Default: F)"
    inputBinding:
      position: 21
      prefix: -count_chimeras
  - id: deactivate_chimera_check
    type:
      - 'null'
      - int
    doc: "(0) do OTU chimera checks. (1) no chimera check at all. (2) Deactivate deNovo chimera check. (3) Deactivate ref based chimera check. (Default: 0)"
    inputBinding:
      position: 22
      prefix: -deactivateChimeraCheck
  - id: derep_min
    type:
      - 'null'
      - int
    doc: "Minimum size of dereplicated clustered, one form of noise removal. Can also have a more complex syntax, see examples. (Default: 8:1,4:2,3:3)"
    inputBinding:
      position: 23
      prefix: -derepMin
  - id: end_rem
    type:
      - 'null'
      - string
    doc: "DNA sequence, usually reverse primer or reverse adaptor; all sequence beyond this point will be removed from OTUs. This is redundant with the \"ReversePrimer\" option from the mapping file, but gives more control (e.g. there is a problem with adaptors in the OTU output). (Default: \"\")"
    inputBinding:
      position: 24
      prefix: -endRem
  - id: cluster_id
    type:
      - 'null'
      - float
    doc: "Clustering threshold for OTUs. (Default: 0.97)"
    inputBinding:
      position: 25
      prefix: -id
  - id: read_overlap
    type:
      - 'null'
      - int
    doc: "The maximum number of basepairs that two reads are overlapping. (Default: 300)"
    inputBinding:
      position: 26
      prefix: -readOverlap
  - id: swarm_distance
    type:
      - 'null'
      - int
    doc: "Clustering distance for OTUs when using swarm clustering. (Default: 1)"
    inputBinding:
      position: 27
      prefix: -swarm_distance
  - id: xtalk
    type:
      - 'null'
      - int
    doc: "(1) check for crosstalk. Note that this requires in most cases 64bit usearch. (Default: 0)"
    inputBinding:
      position: 28
      prefix: -xtalk
  - id: itsx
    type:
      - 'null'
      - int
    doc: "(1) use ITSx to only retain OTUs fitting to ITS1/ITS2 hmm models; (0) deactivate. (Default: 1)"
    inputBinding:
      position: 29
      prefix: -ITSx
  - id: lca_cover
    type:
      - 'null'
      - float
    doc: "Min horizontal coverage of an OTU sequence against ref DB. (Default: 0.5)"
    inputBinding:
      position: 30
      prefix: -LCA_cover
  - id: lca_frac
    type:
      - 'null'
      - float
    doc: "Min fraction of database hits at taxlevel, with identical taxonomy. (Default: 0.9)"
    inputBinding:
      position: 31
      prefix: -LCA_frac
  - id: lca_idthresh
    type:
      - 'null'
      - int
    doc: "6 numbers, comma separated, that are min %id of OTU/ASV fasta to ref database, to assign taxonomy to OTU/ASV at this taxonomic level"
    inputBinding:
      position: 32
      prefix: -LCA_idthresh
  - id: amplicon_type
    type:
      - 'null'
      - string
    doc: "(SSU) small subunit (16S/18S), (LSU) large subunit (23S/28S) or internal transcribed spacer (ITS|ITS1|ITS2), (custom) for custom marker genes. These options will change default read qual filter parameters and activate ITS specific postfiltering steps. (Default: SSU)"
    inputBinding:
      position: 33
      prefix: -amplicon_type
  - id: build_phylo
    type:
      - 'null'
      - int
    doc: "(0) do not build OTU phylogeny; (1) use fasttree2; (2) use IQ-TREE 2. (Default: 1). We recommend the cautious usage of the phylogenetic tree for ITS because high variation of ITS sequences may lead to erroneous trees. Phylogenetic trees can be of use for 16S data depending on the aim of the analysis."
    inputBinding:
      position: 34
      prefix: -buildPhylo
  - id: greengenes_species
    type:
      - 'null'
      - int
    doc: "(1) Create greengenes output labels instead of OTU (to be used with greengenes specific programs such as BugBase). (Default: 0)"
    inputBinding:
      position: 35
      prefix: -greengenesSpecies
  - id: itsx_partial
    type:
      - 'null'
      - int
    doc: "Parameters for ITSx to extract partial (%) ITS regions as well. (0) deactivate. (Default: 0)"
    inputBinding:
      position: 36
      prefix: -itsx_partial
  - id: lulu
    type:
      - 'null'
      - int
    doc: "(1) use LULU (https://github.com/tobiasgf/lulu) to merge OTUs based on their occurrence. (Default: 1)"
    inputBinding:
      position: 37
      prefix: -lulu
  - id: rdp_thr
    type:
      - 'null'
      - float
    doc: "Confidence thresshold for RDP. (Default: 0.8)"
    inputBinding:
      position: 38
      prefix: -rdp_thr
  - id: recalc_tax_db
    type:
      - 'null'
      - string
    doc: "(1) recalc tax DB anew, even if exists (Default: 0)"
    inputBinding:
      position: 39
      prefix: -recalcTaxDB
  - id: ref_db
    type:
      - 'null'
      - string
    doc: "(SLV) Silva LSU (23/28S) or SSU (16/18S), (KSGP) Bacteria, Archaea, Eukaryotes SSU, (GG2) GreenGenes2 SSU, (HITdb) human gut specific SSU, (PR2) LSU spezialized on Ocean environmentas, (UNITE) ITS fungi specific, (beetax) bee gut specific SSU. Given that \"-amplicon_type \" was set to SSU or LSU, the appropriate DB in SLV would be used. \\nDecide which reference DB will be used for a similarity based taxonomy annotation. Databases can be combined, with the first having the highest priority. E.g. \"HITdb,SLV\" would priority assign OTUs to PR2 taxonomy, but hits with a higher %id to SLV would be assigned to SLV. Can also be a custom fasta formatted database: in this case provide the path to the fasta file as well as the path to the taxonomy for the sequences using -tax4refDB. For custom databases QIIME2 file formats are compatible if the delimiter in the QIIME2 taxonomy file is changed from semicolon to tab. See also online help on how to create a custom DB. WARNING: combining databases with incompatible tax levels (e.g. PR2,SLV) will result in non sensical tax levels. (Default: none)"
    inputBinding:
      position: 40
      prefix: -refDB
  - id: sintax_thr
    type:
      - 'null'
      - float
    doc: "Confidence thresshold for SINTAX. (Default: 0.8)"
    inputBinding:
      position: 41
      prefix: -sintax_thr
  - id: tax4ref_db
    type:
      - 'null'
      - File
    doc: "In conjunction with a custom fasta file provided to argument -refDB, this file contains for each fasta entry in the reference DB a taxonomic annotation string, with the same number of taxonomic levels for each, tab separated."
    inputBinding:
      position: 42
      prefix: -tax4refDB
  - id: tax_aligner
    type:
      - 'null'
      - string
    doc: "(0) alginment deactivated, use RDPclassifier (this does not report species level taxonomies); (1) or (blast) use Blast; (2) or (lambda) use LAMBDA to search against a 16S reference database for taxonomic profiling of OTUs; (3) or (utax) or (sintax): use UTAX/SINTAX with custom databases; will use SINTAX if uparse ver >= 9 is found (4) or (vsearch) use VSEARCH to align OTUs to custom databases; (5) or (usearch) use USEARCH to align OTUs to custom databases. (Default: 0)"
    inputBinding:
      position: 43
      prefix: -taxAligner
  - id: tax_exclude_grep
    type:
      - 'null'
      - string
    doc: "Exclude taxonomic group, these OTUs will be assigned as unknown instead. E.g. -taxExcludeGrep Chloroplast|Mitochondria (Default: )"
    inputBinding:
      position: 44
      prefix: -taxExcludeGrep
  - id: tax_group
    type:
      - 'null'
      - string
    doc: "(bacteria) bacterial 16S rDNA annnotation, (fungi) fungal 18S/23S/ITS annotation, (eukarya) eukaryotic (18S/23S) annotation. (Default: bacteria)"
    inputBinding:
      position: 45
      prefix: -tax_group
  - id: use_best_blast_hit_only
    type:
      - 'null'
      - int
    doc: "(1) do not use LCA (lowest common ancestor) to determine most likely taxonomic level (not recommended), instead just use the best blast hit. (0) LCA algorithm. (Default: 0)"
    inputBinding:
      position: 46
      prefix: -useBestBlastHitOnly
  - id: barcode
    type:
      - 'null'
      - File
    doc: "Filepath to fastq formated file with barcodes (this is a processed mi/hiSeq format). The complementary option in a mapping file would be the column \"MIDfqFile\". (Default: \"\")"
    inputBinding:
      position: 47
      prefix: -barcode
  - id: config_file
    type:
      - 'null'
      - File
    doc: "LotuS.cfg, config file with program paths. (Default: <LotuS2_dir>/lOTUs.cfg)"
    inputBinding:
      position: 48
      prefix: -c
  - id: sequencing_platform
    type:
      - 'null'
      - string
    doc: "sequencing platform: PacBio, 454, AVITI, miSeq or hiSeq. (Default: miSeq)"
    inputBinding:
      position: 49
      prefix: -p
  - id: qual_file
    type:
      - 'null'
      - File
    doc: ".qual file associated to fasta file. This is an old format that was replaced by fastq format and is rarely used nowadays. (Default: \"\")"
    inputBinding:
      position: 50
      prefix: -q
  - id: sdm_option_file
    type:
      - 'null'
      - File
    doc: "SDM option file, defaults to \"configs/sdm_miSeq.txt\" in current dir. (Default: miSeq)"
    inputBinding:
      position: 51
      prefix: -s
  - id: tmp_dir
    type:
      - 'null'
      - string
    doc: "temporary directory used to save intermediate results. (Default: <outputDir>/tmpDir)"
    inputBinding:
      position: 52
      prefix: -tmp
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads to be used. (Default: 1)"
    inputBinding:
      position: 53
      prefix: -t
  - id: check_map
    type:
      - 'null'
      - File
    doc: "Mapping_file: only checks mapping file and exists."
    inputBinding:
      position: 54
      prefix: -check_map
  - id: create_map
    type:
      - 'null'
      - File
    doc: "mapping_file: creates a new mapping file at location, based on already demultiplexed input (-i) dir. E.g. lotus2 -create_map mymap.txt -i /home/dir_with_demultiplex_fastq"
    inputBinding:
      position: 55
      prefix: -create_map
  - id: link_usearch
    type:
      - 'null'
      - File
    doc: "Provide the absolute path to your local usearch binary file, this will be installed to be useable with LotuS2 in the future."
    inputBinding:
      position: 56
      prefix: -link_usearch
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with OTU table, OTU sequences, taxonomy and logs
    outputBinding:
      glob: $(inputs.output_dir_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lotus2:2.34.1--hdfd78af_1
