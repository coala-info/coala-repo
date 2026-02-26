cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtotree
label: gtotree_GToTree
doc: "This program takes input genomes from various sources and ultimately produces
  a phylogenomic tree.\n\nTool homepage: https://github.com/AstrobioMike/GToTree/wiki/what-is-gtotree%3F"
inputs:
  - id: add_gtdb_taxonomy
    type:
      - 'null'
      - boolean
    doc: add GTDB taxonomy; Provide this flag with no arguments if you'd like to
      add taxonomy from the Genome Taxonomy Database (GTDB; 
      gtdb.ecogenomic.org). This will only be effective for input genomes 
      provided as NCBI accessions (provided to the `-a` argument). This can be 
      used in combination with the `-t` flag, in which case any input accessions
      not represented in the GTDB will have NCBI taxonomic infomation added 
      (with '_NCBI' appended). See `-L` argument for specifying desired ranks, 
      and see helper script `gtt-get-accessions-from-GTDB` for help getting 
      input accessions based on GTDB taxonomy searches.
    default: false
    inputBinding:
      position: 101
      prefix: -D
  - id: add_ncbi_taxonomy
    type:
      - 'null'
      - boolean
    doc: add NCBI taxonomy; Provide this flag with no arguments if you'd like to
      add NCBI taxonomy info to the sequence headers for any genomes with NCBI 
      taxids. This will will largely be effective for input genomes provided as 
      NCBI accessions (provided to the `-a` argument), but any input GenBank 
      files will also be searched for an NCBI taxid. See `-L` argument for 
      specifying desired ranks.
    default: false
    inputBinding:
      position: 101
      prefix: -t
  - id: amino_acid_files
    type:
      - 'null'
      - File
    doc: single-column file with the paths to each amino acid file, each file 
      should hold the coding sequences for just one genome
    inputBinding:
      position: 101
      prefix: -A
  - id: best_hit_mode
    type:
      - 'null'
      - boolean
    doc: "best-hit mode; Provide this flag with no arguments if you'd like to run
      GToTree in \"best-hit\" mode. By default, if a SCG has more than one hit in
      a given genome, GToTree won't include a sequence for that target from that genome
      in the final alignment. With this flag provided, GToTree will use the best hit.
      See here for more discussion: github.com/AstrobioMike/GToTree/wiki/things-to-consider"
    default: false
    inputBinding:
      position: 101
      prefix: -B
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: debug mode; Provide this flag with no arguments if you'd like to keep 
      the temporary directory. (Mostly useful for debugging.)
    default: false
    inputBinding:
      position: 101
      prefix: -d
  - id: fasta_files
    type:
      - 'null'
      - File
    doc: single-column file with the paths to each fasta file
    inputBinding:
      position: 101
      prefix: -f
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: force overwrite; Provide this flag with no arguments if you'd like to 
      force overwriting the output directory if it exists.
    default: false
    inputBinding:
      position: 101
      prefix: -F
  - id: genbank_files
    type:
      - 'null'
      - File
    doc: single-column file with the paths to each GenBank file
    inputBinding:
      position: 101
      prefix: -g
  - id: genome_hits_cutoff
    type:
      - 'null'
      - float
    doc: genome hits cutoff; A float between 0-1 specifying the minimum fraction
      of hits a genome must have of the SCG-set. For example, if there are 100 
      target genes in the HMM profile, and Genome X only has hits to 49 of them,
      it will be removed from analysis with default value 0.5.
    default: 0.5
    inputBinding:
      position: 101
      prefix: -G
  - id: genome_labels_mapping
    type:
      - 'null'
      - File
    doc: mapping file specifying desired genome labels. A two- or three-column 
      tab-delimited file where column 1 holds either the file name or NCBI 
      accession of the genome to name (depending on the input source), column 2 
      holds the desired new genome label, and column 3 holds something to be 
      appended to either initial or modified labels (e.g. useful for "tagging" 
      genomes in the tree based on some characteristic). Columns 2 or 3 can be 
      empty, and the file does not need to include all input genomes.
    inputBinding:
      position: 101
      prefix: -m
  - id: keep_alignments
    type:
      - 'null'
      - boolean
    doc: keep individual target gene alignments; Keep individual alignment 
      files.
    default: false
    inputBinding:
      position: 101
      prefix: -k
  - id: ko_targets_file
    type:
      - 'null'
      - File
    doc: single-column file of KO targets to search each genome for. Table of 
      hit counts, fastas of hit sequences, and files compatible with the iToL 
      web-based tree-viewer will be generated for each target. See visualization
      of gene presence/absence example at 
      github.com/AstrobioMike/GToTree/wiki/example-usage for example.
    inputBinding:
      position: 101
      prefix: -K
  - id: lineage_ranks
    type:
      - 'null'
      - string
    doc: specify wanted lineage ranks; A comma-separated list of the taxonomic 
      ranks you'd like added to the labels if adding taxonomic information. 
      E.g., all would be "-L 
      Domain,Phylum,Class,Order,Family,Genus,Species,Strain". Note that 
      strain-level information is available through NCBI, but not GTDB.
    default: Domain,Phylum,Class,Species,Strain
    inputBinding:
      position: 101
      prefix: -L
  - id: ncbi_accessions
    type:
      - 'null'
      - File
    doc: single-column file of NCBI assembly accessions
    inputBinding:
      position: 101
      prefix: -a
  - id: no_tree
    type:
      - 'null'
      - boolean
    doc: do not make a tree; No tree. Generate alignment only.
    default: false
    inputBinding:
      position: 101
      prefix: -N
  - id: nucleotide_mode
    type:
      - 'null'
      - boolean
    doc: nucleotide mode; Make alignment and/or tree with nucleotide sequences 
      instead of amino-acid sequences. Note this mode can only accept NCBI 
      accessions (passed to `-a`) and genome fasta files (passed to `-f` as 
      input sources. (GToTree still finds target genes based on amino-acid HMM 
      searches.)
    default: false
    inputBinding:
      position: 101
      prefix: -z
  - id: num_cpus
    type:
      - 'null'
      - int
    doc: num cpus; The number of cpus you'd like to use during the HMM search. 
      (Given these are individual small searches on single genomes, 2 is 
      probably always sufficient. Keep in mind this will be multiplied by the 
      number of jobs running concurrently if also modifying the `-j` parameter.)
    default: 2
    inputBinding:
      position: 101
      prefix: -n
  - id: num_jobs
    type:
      - 'null'
      - int
    doc: "num jobs; The number of jobs you'd like to run in parallel during steps
      that are parallelizable. This includes things like downloading input accession
      genomes and running parallel alignments, and portions of the tree step if using
      FastTreeMP or VeryFastTree.\n\n                  Note that I've occassionally
      noticed NCBI not being happy with over ~50\n                  downloads being
      attempted concurrently. So if using a `-j` setting around\n                \
      \  there or higher, and GToTree is saying a lot of input accessions were not\n\
      \                  successfully downloaded, consider trying with a lower `-j`
      setting."
    default: 1
    inputBinding:
      position: 101
      prefix: -j
  - id: num_muscle_threads
    type:
      - 'null'
      - int
    doc: num muscle threads; The number of threads muscle will use during 
      alignment. (Keep in mind this will be multiplied by the number of jobs 
      running concurrently if also modifying the `-j` parameter.)
    default: 5
    inputBinding:
      position: 101
      prefix: -M
  - id: output_dir
    type:
      - 'null'
      - string
    doc: Specify the desired output directory.
    default: GToTree_output
    inputBinding:
      position: 101
      prefix: -o
  - id: override_super5_alignment
    type:
      - 'null'
      - boolean
    doc: override super5 alignment; If working with greater than 1,000 target 
      genomes, GToTree will by default use the 'super5' muscle alignment 
      algorithm to increase the speed of the alignments (see 
      github.com/AstrobioMike/GToTree/wiki/things-to-consider#working-with-many-genomes
      for more details and the note just above there on using representative 
      genomes). Anyway, provide this flag with no arguments if you don't want to
      speed up the alignments.
    default: false
    inputBinding:
      position: 101
      prefix: -X
  - id: pfam_targets_file
    type:
      - 'null'
      - File
    doc: single-column file of Pfam targets to search each genome for. Table of 
      hit counts, fastas of hit sequences, and files compatible with the iToL 
      web-based tree-viewer will be generated for each target. See visualization
      of gene presence/absence example at 
      github.com/AstrobioMike/GToTree/wiki/example-usage for example.
    inputBinding:
      position: 101
      prefix: -p
  - id: scg_hmm_file
    type: File
    doc: location of the uncompressed target SCGs HMM file being used, or just 
      the HMM name if the 'GToTree_HMM_dir' env variable is set to the 
      appropriate location (which is done by conda install), run 'gtt-hmms' by 
      itself to view the available gene-sets)
    inputBinding:
      position: 101
      prefix: -H
  - id: sequence_length_cutoff
    type:
      - 'null'
      - float
    doc: sequence length cutoff; A float between 0-1 specifying the range about 
      the median of sequences to be retained. For example, if the median length 
      of a set of sequences is 100 AAs, those seqs longer than 120 or shorter 
      than 80 will be filtered out before alignment of that gene set with the 
      default 0.2 setting.
    default: 0.2
    inputBinding:
      position: 101
      prefix: -c
  - id: tree_program
    type:
      - 'null'
      - string
    doc: tree program to use; Which program to use for tree generation. 
      Currently supported are "FastTree", "FastTreeMP", "VeryFastTree", and 
      "IQ-TREE". These run with default settings only (and IQ-TREE includes "-m 
      MFP" and "-B 1000"). To run any with more specific options (and there is a
      lot of room for variation here), you can use the output alignment file 
      from GToTree (and the partitions file if wanted for mixed-model 
      specification) as input into a dedicated treeing program (the GToTree `-N`
      option will generate the alignment only to skip internal treeing if 
      wanted).
    default: FastTreeMP if available, FastTree if not
    inputBinding:
      position: 101
      prefix: -T
  - id: use_http
    type:
      - 'null'
      - boolean
    doc: use http instead of ftp; Provide this flag with no arguments if your 
      system can't use ftp, and you'd like to try using http.
    default: false
    inputBinding:
      position: 101
      prefix: -P
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
stdout: gtotree_GToTree.out
