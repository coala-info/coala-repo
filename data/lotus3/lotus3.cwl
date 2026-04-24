cwlVersion: v1.2
class: CommandLineTool
baseCommand: lotus3
label: lotus3
doc: "LotuS3 pipeline for sequence clustering and taxonomic classification.\n\nTool
  homepage: https://lotus3.earlham.ac.uk/"
inputs:
  - id: amplicon_type
    type:
      - 'null'
      - string
    doc: (SSU) small subunit (16S/18S), (LSU) large subunit (23S/28S) or 
      internal transcribed spacer (ITS|ITS1|ITS2), (custom) for custom marker 
      genes. These options will change default read qual filter parameters and 
      activate ITS specific postfiltering steps.
    inputBinding:
      position: 101
  - id: backmap_id
    type:
      - 'null'
      - float
    doc: '%id cutoff for backmapping mid-qual reads onto OTUs/zOTUs/ASVs'
    inputBinding:
      position: 101
  - id: barcode_file
    type:
      - 'null'
      - File
    doc: Filepath to fastq formated file with barcodes (this is a processed 
      mi/hiSeq format). The complementary option in a mapping file would be the 
      column "MIDfqFile".
    inputBinding:
      position: 101
      prefix: -barcode|-MID
  - id: build_phylo
    type:
      - 'null'
      - int
    doc: (0) do not build OTU phylogeny; (1) use fasttree2; (2) use IQ-TREE 2. 
      We recommend the cautious usage of the phylogenetic tree for ITS because 
      high variation of ITS sequences may lead to erroneous trees. Phylogenetic 
      trees can be of use for 16S data depending on the aim of the analysis.
    inputBinding:
      position: 101
  - id: check_map_file
    type:
      - 'null'
      - File
    doc: 'Mapping_file: only checks mapping file and exists.'
    inputBinding:
      position: 101
  - id: chim_skew
    type:
      - 'null'
      - float
    doc: Skew in chimeric fragment abundance (uchime option).
    inputBinding:
      position: 101
  - id: clustering_algorithm
    type:
      - 'null'
      - string
    doc: 'Sequence clustering algorithm: (1) UPARSE, (2) swarm, (3) cd-hit, (6) unoise3,
      (7) dada2, (8) VSEARCH. Short keyword or number can be used to indicate clustering'
    inputBinding:
      position: 101
      prefix: -clustering
  - id: config_file
    type:
      - 'null'
      - File
    doc: LotuS.cfg, config file with program paths.
    inputBinding:
      position: 101
      prefix: -c
  - id: count_chimeras
    type:
      - 'null'
      - boolean
    doc: Add chimeras to count up OTUs/ASVs.
    inputBinding:
      position: 101
  - id: create_map_file
    type:
      - 'null'
      - File
    doc: 'mapping_file: creates a new mapping file at location, based on already demultiplexed
      input (-i) dir. E.g. lotus3 -create_map mymap.txt -i /home/dir_with_demultiplex_fastq'
    inputBinding:
      position: 101
  - id: deactivate_chimera_check
    type:
      - 'null'
      - int
    doc: (0) do OTU chimera checks. (1) no chimera check at all. (2) Deactivate 
      deNovo chimera check. (3) Deactivate ref based chimera check.
    inputBinding:
      position: 101
  - id: derep_min
    type:
      - 'null'
      - string
    doc: Minimum size of dereplicated clustered, one form of noise removal. Can 
      also have a more complex syntax, see examples.
    inputBinding:
      position: 101
  - id: end_rem
    type:
      - 'null'
      - string
    doc: DNA sequence, usually reverse primer or reverse adaptor; all sequence 
      beyond this point will be removed from OTUs. This is redundant with the 
      "ReversePrimer" option from the mapping file, but gives more control (e.g.
      there is a problem with adaptors in the OTU output).
    inputBinding:
      position: 101
  - id: forward_primer
    type:
      - 'null'
      - string
    doc: give the forward primer used to amplify DNA region (e.g. 16S primer 
      fwd)
    inputBinding:
      position: 101
  - id: greengenes_species
    type:
      - 'null'
      - boolean
    doc: Create greengenes output labels instead of OTU (to be used with 
      greengenes specific programs such as BugBase).
    inputBinding:
      position: 101
  - id: id
    type:
      - 'null'
      - float
    doc: Clustering threshold for OTUs.
    inputBinding:
      position: 101
  - id: input
    type: File
    doc: Input fasta, fastq, or directory. In case that fastqFile or fnaFile and
      qualFile were specified in the mapping file, this has to be the directory 
      with input files.
    inputBinding:
      position: 101
      prefix: -i
  - id: intarget_db
    type:
      - 'null'
      - File
    doc: Keep all OTUs with good matches to this DB (.fa format). This option is
      useful if you have a set of known true positive 16S sequences, that might 
      not be represented in your tax DB and would otherwise be removed through 
      "-keepUnclassified 1".
    inputBinding:
      position: 101
  - id: itsx
    type:
      - 'null'
      - boolean
    doc: use ITSx to only retain OTUs fitting to ITS1/ITS2 hmm models; (0) 
      deactivate.
    inputBinding:
      position: 101
  - id: itsx_partial
    type:
      - 'null'
      - int
    doc: Parameters for ITSx to extract partial (%) ITS regions as well. (0) 
      deactivate.
    inputBinding:
      position: 101
  - id: keep_offtargets
    type:
      - 'null'
      - boolean
    doc: keep offtarget hits against offtargetDB in output fasta and otu matrix.
    inputBinding:
      position: 101
  - id: keep_tmp_files
    type:
      - 'null'
      - boolean
    doc: save extra tmp files like chimeric OTUs or the raw blast output in 
      extra dir. (0) do not save these.
    inputBinding:
      position: 101
  - id: keep_unclassified
    type:
      - 'null'
      - boolean
    doc: Includes unclassified OTUs (no Phylum assignment) in OTU and taxa 
      abundance matrix calculations. (0) does not report these potential 
      contaminants.
    inputBinding:
      position: 101
  - id: lca_cover
    type:
      - 'null'
      - float
    doc: Min horizontal coverage of an OTU sequence against ref DB.
    inputBinding:
      position: 101
  - id: lca_frac
    type:
      - 'null'
      - float
    doc: Min fraction of database hits at taxlevel, with identical taxonomy.
    inputBinding:
      position: 101
  - id: lca_idthresh
    type:
      - 'null'
      - string
    doc: 6 numbers, comma separated, that are min %id of OTU/ASV fasta to ref 
      database, to assign taxonomy to OTU/ASV at this taxonomic level
    inputBinding:
      position: 101
  - id: link_usearch_file
    type:
      - 'null'
      - File
    doc: Provide the absolute path to your local usearch binary file, this will 
      be installed to be useable with LotuS3 in the future.
    inputBinding:
      position: 101
  - id: lulu
    type:
      - 'null'
      - boolean
    doc: use LULU (https://github.com/tobiasgf/lulu) to merge OTUs based on 
      their occurrence.
    inputBinding:
      position: 101
  - id: mapping_file
    type: File
    doc: Mapping file
    inputBinding:
      position: 101
      prefix: -map
  - id: merge_pre_cluster_reads
    type:
      - 'null'
      - boolean
    doc: no merging or reads pre OTU/ASV/zOTU seq clustering, BUT read merging 
      after seq clustering (to get better representative sequence). (1) Merge 
      reads prior to seq clustering. WARNING!! This will considerably reduce the
      number of valid read pairs, as additional quality filters will be applied,
      algorithm is still in development !!
    inputBinding:
      position: 101
  - id: offtarget_db
    type:
      - 'null'
      - File
    doc: Remove likely contaminant OTUs/ASVs based on alignment to provided 
      fasta. This option is useful for low-bacterial biomass samples, to remove 
      possible host genome contaminations (e.g. human/mouse genome)
    inputBinding:
      position: 101
  - id: platform
    type:
      - 'null'
      - string
    doc: 'sequencing platform: PacBio, PacBio_GA, 454, AVITI, miSeq or hiSeq.'
    inputBinding:
      position: 101
      prefix: -p
  - id: qual_file
    type:
      - 'null'
      - File
    doc: .qual file associated to fasta file. This is an old format that was 
      replaced by fastq format and is rarely used nowadays.
    inputBinding:
      position: 101
      prefix: -q
  - id: rdp_thr
    type:
      - 'null'
      - float
    doc: Confidence thresshold for RDP.
    inputBinding:
      position: 101
  - id: read_overlap
    type:
      - 'null'
      - int
    doc: The maximum number of basepairs that two reads are overlapping.
    inputBinding:
      position: 101
  - id: recalc_tax_db
    type:
      - 'null'
      - boolean
    doc: recalc tax DB anew, even if exists
    inputBinding:
      position: 101
  - id: redo_tax_only
    type:
      - 'null'
      - boolean
    doc: Only redo the taxonomic assignments (useful for replacing a DB used on 
      a finished lotus run). (0) Normal lotus run.
    inputBinding:
      position: 101
  - id: ref_db
    type:
      - 'null'
      - string
    doc: '(SLV) Silva LSU (23/28S) or SSU (16/18S), (KSGP) Bacteria, Archaea, Eukaryotes
      SSU, (GG2) GreenGenes2 SSU, (HITdb) human gut specific SSU, (PR2) LSU spezialized
      on Ocean environmentas, (UNITE) ITS fungi specific, (beetax) bee gut specific
      SSU. Given that "-amplicon_type " was set to SSU or LSU, the appropriate DB
      in SLV would be used. \nDecide which reference DB will be used for a similarity
      based taxonomy annotation. Databases can be combined, with the first having
      the highest priority. E.g. "HITdb,SLV" would priority assign OTUs to PR2 taxonomy,
      but hits with a higher %id to SLV would be assigned to SLV. Can also be a custom
      fasta formatted database: in this case provide the path to the fasta file as
      well as the path to the taxonomy for the sequences using -tax4refDB. For custom
      databases QIIME2 file formats are compatible if the delimiter in the QIIME2
      taxonomy file is changed from semicolon to tab. See also online help on how
      to create a custom DB. WARNING: combining databases with incompatible tax levels
      (e.g. PR2,SLV) will result in non sensical tax levels.'
    inputBinding:
      position: 101
  - id: reverse_primer
    type:
      - 'null'
      - string
    doc: give the reverse primer used to amplify DNA region (e.g. 16S primer 
      rev)
    inputBinding:
      position: 101
  - id: save_demultiplex
    type:
      - 'null'
      - int
    doc: (1) Saves all demultiplexed reads (unfiltered) in the 
      [outputdir]/demultiplexed folder, for easier data upload. (2) Only saves 
      quality filtered demultiplexed reads and continues LotuS3 run 
      subsequently. (3) Saves demultiplexed, filtered reads into a single fq, 
      with sample ID in fastq/a header. (0) No demultiplexed reads are saved.
    inputBinding:
      position: 101
  - id: sdm_option_file
    type:
      - 'null'
      - File
    doc: SDM option file, defaults to "configs/sdm_miSeq.txt" in current dir.
    inputBinding:
      position: 101
      prefix: -s|sdmopt
  - id: sintax_thr
    type:
      - 'null'
      - float
    doc: Confidence thresshold for SINTAX.
    inputBinding:
      position: 101
  - id: swarm_distance
    type:
      - 'null'
      - string
    doc: Clustering distance for OTUs when using swarm clustering.
    inputBinding:
      position: 101
  - id: tax4ref_db
    type:
      - 'null'
      - File
    doc: In conjunction with a custom fasta file provided to argument -refDB, 
      this file contains for each fasta entry in the reference DB a taxonomic 
      annotation string, with the same number of taxonomic levels for each, tab 
      separated.
    inputBinding:
      position: 101
  - id: tax_aligner
    type:
      - 'null'
      - string
    doc: '(0) alginment deactivated, use RDPclassifier (this does not report species
      level taxonomies); (1) or (blast) use Blast; (2) or (lambda) use LAMBDA to search
      against a 16S reference database for taxonomic profiling of OTUs; (3) or (utax)
      or (sintax): use UTAΧ/SINTAX with custom databases; will use SINTAX if uparse
      ver >= 9 is found (4) or (vsearch) use VSEARCH to align OTUs to custom databases;
      (5) or (usearch) use USEARCH to align OTUs to custom databases.'
    inputBinding:
      position: 101
  - id: tax_exclude_grep
    type:
      - 'null'
      - string
    doc: Exclude taxonomic group, these OTUs will be assigned as unknown 
      instead. E.g. -taxExcludeGrep Chloroplast|Mitochondria
    inputBinding:
      position: 101
  - id: tax_group
    type:
      - 'null'
      - string
    doc: (bacteria) bacterial 16S rDNA annnotation, (fungi) fungal 18S/23S/ITS 
      annotation, (eukarya) eukaryotic (18S/23S) annotation.
    inputBinding:
      position: 101
  - id: tax_only_file
    type:
      - 'null'
      - File
    doc: Skip most of the lotus pipeline and only run a taxonomic classification
      on a fasta file. E.g. lotus3 -taxOnly <some16S.fna> -refDB SLV
    inputBinding:
      position: 101
      prefix: -taxOnly
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to be used.
    inputBinding:
      position: 101
      prefix: -t|-threads
  - id: tmp_dir
    type:
      - 'null'
      - Directory
    doc: temporary directory used to save intermediate results.
    inputBinding:
      position: 101
      prefix: -tmp|-tmpDir
  - id: tolerate_corrupt_fq
    type:
      - 'null'
      - boolean
    doc: Continue reading fastq files, even if single entries are incomplete 
      (e.g. half of qual values missing). (0) Abort lotus run, if fastq file is 
      corrupt.
    inputBinding:
      position: 101
  - id: use_best_blast_hit_only
    type:
      - 'null'
      - boolean
    doc: (1) do not use LCA (lowest common ancestor) to determine most likely 
      taxonomic level (not recommended), instead just use the best blast hit. 
      (0) LCA algorithm.
    inputBinding:
      position: 101
  - id: use_vsearch
    type:
      - 'null'
      - boolean
    doc: (0) Use usearch for internal tasks such as remapping reads on OTUs, 
      chimera checks. (1) will use vsearch for these tasks. This option is 
      independent of the -CL UPARSE/UNOISE option, and -taxAligner assignment 
      usearch/vsearch options.
    inputBinding:
      position: 101
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Level of verbosity from printing all program calls and program output 
      (3) to not even printing errors (0).
    inputBinding:
      position: 101
  - id: xtalk
    type:
      - 'null'
      - boolean
    doc: check for crosstalk. Note that this requires in most cases 64bit 
      usearch.
    inputBinding:
      position: 101
outputs:
  - id: output_dir
    type: Directory
    doc: 'Output directory. Warning: The output directory will be completely removed
      at the beginning of the LotuS3 run. Please ensure this is a new directory or
      contains only disposable data!'
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lotus3:3.03--hdfd78af_1
