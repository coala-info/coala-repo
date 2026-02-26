cwlVersion: v1.2
class: CommandLineTool
baseCommand: proteinortho6.pl
label: proteinortho
doc: "An orthology detection tool with PoFF version 6.3.6\n\nTool homepage: https://gitlab.com/paulklemm_PHD/proteinortho/"
inputs:
  - id: fasta_files
    type:
      type: array
      items: File
    doc: one for each species, at least 2
    inputBinding:
      position: 1
  - id: alpha
    type:
      - 'null'
      - float
    doc: 'PoFF: weight of adjacencies vs. sequence similarity α[FF-adj score]+(1−α)[BLAST
      score]'
    default: 0.5
    inputBinding:
      position: 102
      prefix: -alpha
  - id: binpath
    type:
      - 'null'
      - Directory
    doc: path to your directory of local programs that are not available 
      globally (this should not be needed)
    inputBinding:
      position: 102
      prefix: -binpath
  - id: blast_program
    type:
      - 'null'
      - string
    doc: "blast program {blastp|blastn|tblastx|blastp_legacy|blastn_legacy|tblastx_legacy|diamond|usearch|ublast|lastp|lastn|rapsearch|topaz|blatp|blatn|mmseqsp|mmseqsn}.
      The chosen program need to be installed first. A suffix 'p' or 'n' indicates
      aminoacid fasta files (p) or nucleotide fasta files (n). autoblast : automatically
      detects the blast+ program (blastp,blastn,tblastn,blastx) depending on the input
      (can also be mixed together!) blast*|tblastx : standard blast+ family (blastp
      : protein files, blastn : dna files) blast*_legacy : legacy blast family (blastall)
      diamond : Only for protein files! standard diamond procedure with the additional
      --sensitive flag (disable with -notsensitive) https://github.com/bbuchfink/diamond
      usearch : usearch_local procedure with -id 0 (minimum identity percentage).
      ublast : usearch_ublast procedure. lastn : standard lastal. Only for dna files!
      http://last.cbrc.jp/ lastp : lastal using -p and BLOSUM62 scoring matrix. Only
      for protein files! rapsearch : Only for protein files! https://github.com/zhaoyanswill/RAPSearch2
      topaz : Only for protein files! https://github.com/ajm/topaz blat* : Blat family.
      blatp : for protein files! blatn : for dna files! http://hgdownload.soe.ucsc.edu/admin/
      mmseqs* : mmseqs family. mmseqsp : For protein files! mmseqsn : For dna files!
      https://github.com/soedinglab/MMseqs2"
    default: diamond
    inputBinding:
      position: 102
      prefix: -p
  - id: checkfasta
    type:
      - 'null'
      - boolean
    doc: Checks if the given fasta files are compatible with the algorithm of -p
    inputBinding:
      position: 102
      prefix: -checkfasta
  - id: clean
    type:
      - 'null'
      - boolean
    doc: remove all unnecessary files after processing
    inputBinding:
      position: 102
      prefix: -clean
  - id: conn
    type:
      - 'null'
      - float
    doc: 'min. algebraic connectivity. This is the main parameter for the clustering
      step. Choose larger values then more splits are done, resulting in more and
      smaller clusters. (There are still cluster with an alg. conn. below this given
      threshold allowed if the protein to species ratio is good enough, see -minspecies
      option below). special values: 0 : search only connected components and calculate
      the connectivity but no split is made -1 : same as 0 but the connectivity is
      not calculated'
    default: 0.1 / 1e-1
    inputBinding:
      position: 102
      prefix: -conn
  - id: core
    type:
      - 'null'
      - boolean
    doc: stop clustering if a split would result in groups that do not span 
      across all species of the inital connected component. Overrules the -conn 
      threshold.
    inputBinding:
      position: 102
      prefix: -core
  - id: core_max_prot
    type:
      - 'null'
      - int
    doc: sets the maximal number of proteins per species for the -core option
    default: 10
    inputBinding:
      position: 102
      prefix: -coreMaxProt
  - id: coverage
    type:
      - 'null'
      - int
    doc: min. coverage of best blast alignments in %. coverage between protein A
      and B = min (alignment_length_A_B/length_A, alignment_length_A_B/length_B)
      where alignment_length_A_B = column 4 of blast outfmt 6 output
    default: 50
    inputBinding:
      position: 102
      prefix: -cov
  - id: cpus
    type:
      - 'null'
      - string
    doc: number of processors to use
    default: auto
    inputBinding:
      position: 102
      prefix: -cpus
  - id: cs
    type:
      - 'null'
      - int
    doc: 'PoFF: Size of a maximum common substring (MCS) for adjacency matches'
    default: 3
    inputBinding:
      position: 102
      prefix: -cs
  - id: debug
    type:
      - 'null'
      - boolean
    doc: gives detailed information for bug tracking
    inputBinding:
      position: 102
      prefix: -debug
  - id: desc
    type:
      - 'null'
      - boolean
    doc: write description files (for NCBI FASTA input only)
    inputBinding:
      position: 102
      prefix: -desc
  - id: dups
    type:
      - 'null'
      - int
    doc: 'PoFF: number of reiterations for adjacencies heuristic, to determine duplicated
      regions'
    default: 0
    inputBinding:
      position: 102
      prefix: -dups
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value for blast (column 11 of blast outfmt 6 output)
    default: '1e-05'
    inputBinding:
      position: 102
      prefix: -e
  - id: force
    type:
      - 'null'
      - boolean
    doc: forces the recalculation of the blast results in any case in step=2. 
      Also forces the recreation of the database generation in step=1
    inputBinding:
      position: 102
      prefix: -force
  - id: fullallvsall
    type:
      - 'null'
      - boolean
    doc: Disables the pseudo reciprocal blast analysis analysis (this doubles 
      the runtime)
    inputBinding:
      position: 102
      prefix: -fullallvsall
  - id: identical
    type:
      - 'null'
      - boolean
    doc: only return entries that are 100% identical
    inputBinding:
      position: 102
      prefix: -identical
  - id: identity
    type:
      - 'null'
      - int
    doc: min. percent identity of best blast hits (column 3 (pident) of blast 
      outfmt 6 output)
    default: 25
    inputBinding:
      position: 102
      prefix: -identity
  - id: inproject
    type:
      - 'null'
      - string
    doc: load data from this namespace instead and output in -project (works 
      with intermediate files for step=2 and blast-graph for step=3). With this 
      option you can change e.g. the -sim without recalculating all intermediate
      files of -step=2
    inputBinding:
      position: 102
      prefix: -inproject
  - id: isoform
    type:
      - 'null'
      - string
    doc: "Enables the isoform merging: All isoforms are united to a single entity
      and treated as one protein in the RBH algorithm. E.g. Let I1 and I2 two isoforms,
      I1 reciprocally matches A and I2 B but no other hits are found: with this option
      the output is A-I-B (results of I1 and I2 are merged). Modus: ncbi -> if the
      word 'isoform' is found uniprot -> 'Isoform of XYZ' (You need to add the *_additional.fasta
      files) trinity -> using '_iX' suffix For more information have a look at: https://gitlab.com/paulklemm_PHD/proteinortho/-/wikis/FAQ#how-does-the-isoform-work"
    inputBinding:
      position: 102
      prefix: -isoform
  - id: jobs
    type:
      - 'null'
      - string
    doc: 'In case jobs should be distributed onto several machines, use -jobs=M/N
      N defines the number of defined job groups (e.g. PCs) M defines the set of jobs
      to run in this process Example: run with first with -step=1 to prepare data
      then to split a run on two machines use -jobs=1/2 -step=2 on PC one and -jobs=2/2
      -step=2 on PC two finally run with -step=3 to finalize'
    inputBinding:
      position: 102
      prefix: -jobs
  - id: keep
    type:
      - 'null'
      - boolean
    doc: stores temporary blast results for reuse (proteinortho_cache_project 
      directory). In a second run the intermediate blast results are loaded 
      instead of calculated. You can adjust the parameters e.g. a more strict -e
      evalue cut off and write the output to a different namespace using 
      --inproject.
    inputBinding:
      position: 102
      prefix: -keep
  - id: max_nodes
    type:
      - 'null'
      - int
    doc: only consider connected component with up to this number of nodes. If 
      exceeded, remove outlying edges accoring to the Smirnov-Grubb test or 
      greedily the worst 10 percent of edges (by weight) until satisfied. 
      Disable with 0
    default: 5000
    inputBinding:
      position: 102
      prefix: -maxnodes
  - id: nograph
    type:
      - 'null'
      - boolean
    doc: do not generate .proteinortho-graph file (pairwise orthology relations)
    inputBinding:
      position: 102
      prefix: -nograph
  - id: normal
    type:
      - 'null'
      - boolean
    doc: Disables the pseudo reciprocal blast analysis analysis (this doubles 
      the runtime)
    inputBinding:
      position: 102
      prefix: -normal
  - id: omni
    type:
      - 'null'
      - boolean
    doc: All pairwise fasta calles are combined to a single one (very memory 
      intensive), E-values are corrected to fasta specific ones.
    inputBinding:
      position: 102
      prefix: -omni
  - id: project
    type:
      - 'null'
      - string
    doc: prefix for all result file names
    default: myproject
    inputBinding:
      position: 102
      prefix: -project
  - id: pseudo_reciprocal_blast
    type:
      - 'null'
      - boolean
    doc: Disables the pseudo reciprocal blast analysis analysis (this doubles 
      the runtime)
    inputBinding:
      position: 102
      prefix: -nopseudo
  - id: range
    type:
      - 'null'
      - int
    doc: maximal length difference for any blast hit. e.g. 0 = filter for hits 
      between proteins of same length [default:disabled]
    inputBinding:
      position: 102
      prefix: -range
  - id: selfblast
    type:
      - 'null'
      - boolean
    doc: apply selfblast, detects paralogs without orthologs
    inputBinding:
      position: 102
      prefix: -selfblast
  - id: silent
    type:
      - 'null'
      - boolean
    doc: sets verbose to 0
    inputBinding:
      position: 102
      prefix: -silent
  - id: similarity
    type:
      - 'null'
      - float
    doc: 'min. reciprocal similarity for additional hits (0..1). 1 : only the best
      reciprocal hits are reported. 0 : all possible reciprocal blast matches (within
      boundaries of -e, -cov, ...) are reported'
    default: 0.95
    inputBinding:
      position: 102
      prefix: -sim
  - id: singles
    type:
      - 'null'
      - boolean
    doc: report singleton genes without any hit
    inputBinding:
      position: 102
      prefix: -singles
  - id: step
    type:
      - 'null'
      - int
    doc: "1 -> generate indices\n                2 -> run blast (and ff-adj, if -synteny
      is set)\n                3 -> clustering\n                0 -> all"
    default: 0
    inputBinding:
      position: 102
      prefix: -step
  - id: subpara_blast
    type:
      - 'null'
      - string
    doc: additional parameters for the search tool example -subparaBlast='-seg 
      no' or -subparaBlast='--more-sensitive' for diamond
    inputBinding:
      position: 102
      prefix: -subparaBlast
  - id: subpara_make_blast
    type:
      - 'null'
      - string
    doc: additional parameters for the database generation
    inputBinding:
      position: 102
      prefix: -subparaMakeBlast
  - id: synteny
    type:
      - 'null'
      - boolean
    doc: activate PoFF extension to separate similar sequences print by 
      contextual adjacencies (requires .gff for each .fasta). Each protein with 
      the ID 'XXX' needs to be refered in the gff file with the attribute 
      'Name=XXX'. For more information see 
      'https://gitlab.com/paulklemm_PHD/proteinortho#poff'
    inputBinding:
      position: 102
      prefix: -synteny
  - id: temp
    type:
      - 'null'
      - Directory
    doc: path for temporary files
    default: working directory
    inputBinding:
      position: 102
      prefix: -temp
  - id: threads_per_process
    type:
      - 'null'
      - int
    doc: number of threads per process, e.g. using -cpus=4 and 
      -threads_per_process=2 will spawn 4 workerthreads using 2 cpu cores each =
      total of 8 cores.
    default: 1
    inputBinding:
      position: 102
      prefix: -threads_per_process
  - id: xml
    type:
      - 'null'
      - boolean
    doc: produces an OrthoXML formatted file of the *.proteinortho.tsv file. You
      can use 'proteinortho2xml project.proteinortho-graph >project.xml' after 
      proteinortho as well.
    inputBinding:
      position: 102
      prefix: -xml
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proteinortho:6.3.6--h2b77389_0
stdout: proteinortho.out
