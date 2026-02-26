cwlVersion: v1.2
class: CommandLineTool
baseCommand: captus extract
label: captus_extract
doc: "Captus-assembly: Extract; recover markers from FASTA assemblies\n\nTool homepage:
  https://github.com/edgardomortiz/Captus"
inputs:
  - id: blat_min_score
    type:
      - 'null'
      - int
    doc: Minimum BLAT score for DNA matches, decrease if the targets are very 
      divergent
    default: 20
    inputBinding:
      position: 101
      prefix: --blat_min_score
  - id: blat_path
    type:
      - 'null'
      - string
    doc: Path to BLAT >= 36x7 (this version is the first one that guarantees the
      same result both in Mac and Linux)
    default: bundled
    inputBinding:
      position: 101
      prefix: --blat_path
  - id: captus_assemblies_dir
    type: Directory
    doc: Path to an output directory from the 'assemble' step of Captus-assembly
      which is tipically called '02_assemblies'. If you DID NOT assemble any 
      sample within Captus and want to start exclusivey with FASTAs assembled 
      elsewhere, the path provided here will be created in order to contain your
      assemblies provided with '-f' into a proper directory structure needed by 
      Captus
    inputBinding:
      position: 101
      prefix: --captus_assemblies_dir
  - id: cl_cov_mode
    type:
      - 'null'
      - int
    doc: MMseqs2 sequence coverage mode 
      (https://github.com/soedinglab/mmseqs2/wiki#how-to-set-the-right-alignment-coverage-to-cluster)
    default: 1
    inputBinding:
      position: 101
      prefix: --cl_cov_mode
  - id: cl_max_copies
    type:
      - 'null'
      - int
    doc: Maximum average number of sequences per sample in a cluster. This can 
      exclude loci that are extremely paralogous
    default: 3
    inputBinding:
      position: 101
      prefix: --cl_max_copies
  - id: cl_max_seq_len
    type:
      - 'null'
      - int
    doc: Do not cluster sequences longer than this length in bp, the maximum 
      allowed by MMseqs2 is 65535. Use 0 to disable this filter
    default: 5000
    inputBinding:
      position: 101
      prefix: --cl_max_seq_len
  - id: cl_min_coverage
    type:
      - 'null'
      - int
    doc: Any sequence in a cluster has to be at least this percent included in 
      the length of the longest sequence in the cluster
    default: 80
    inputBinding:
      position: 101
      prefix: --cl_min_coverage
  - id: cl_min_identity
    type:
      - 'null'
      - string
    doc: Minimum identity percentage between sequences in a cluster, when set to
      'auto' it becomes 99% of the '--dna_min_identity' value but never less 
      than 75%
    default: auto
    inputBinding:
      position: 101
      prefix: --cl_min_identity
  - id: cl_min_samples
    type:
      - 'null'
      - string
    doc: Minimum number of samples per cluster, if set to 'auto' the number is 
      adjusted to 66% of the total number of samples or at least 4
    default: auto
    inputBinding:
      position: 101
      prefix: --cl_min_samples
  - id: cl_mode
    type:
      - 'null'
      - int
    doc: 'MMseqs2 clustering mode (https://github.com/soedinglab/mmseqs2/wiki#clustering-modes),
      options are: 0 = Greedy set cover 1 = Connected component 2 = Greedy incremental
      (analogous to CD-HIT)'
    default: 2
    inputBinding:
      position: 101
      prefix: --cl_mode
  - id: cl_rep_min_len
    type:
      - 'null'
      - int
    doc: After clustering is finished, only accept cluster representatives of at
      least this length to be part of the new miscellaneous DNA reference 
      targets. Use 0 to disable this filter
    default: 500
    inputBinding:
      position: 101
      prefix: --cl_rep_min_len
  - id: cl_rep_single
    type:
      - 'null'
      - boolean
    doc: Retain a single representative sequence per cluster, useful for example
      when you intend to map the reads to the set of targets found by clustering
    inputBinding:
      position: 101
      prefix: --cl_rep_single
  - id: cl_sensitivity
    type:
      - 'null'
      - float
    doc: "MMseqs2 sensitivity, from 1 to 7.5, only applicable when using 'easy-cluster'.
      Common reference points are: 1 (faster), 4 (fast), 7.5 (sens)"
    default: 7.5
    inputBinding:
      position: 101
      prefix: --cl_sensitivity
  - id: cl_seq_id_mode
    type:
      - 'null'
      - int
    doc: 'MMseqs2 sequence identity mode, options are: 0 = Alignment length 1 = Shorter
      sequence 2 = Longer sequence'
    default: 1
    inputBinding:
      position: 101
      prefix: --cl_seq_id_mode
  - id: cl_tmp_dir
    type:
      - 'null'
      - Directory
    doc: Where to create the temporary directory 'captus_mmseqs_tmp' for 
      MMseqs2. Clustering can become slow when done on external drives, set this
      location to a fast, preferably local, drive
    default: $HOME
    inputBinding:
      position: 101
      prefix: --cl_tmp_dir
  - id: cluster_leftovers
    type:
      - 'null'
      - boolean
    doc: Enable MMseqs2 clustering across samples of the contigs that had no 
      hits to the reference target markers. A new miscellaneous DNA reference is
      built from the best representative of each cluster in order to perform a 
      miscellaneous DNA marker extraction.
    inputBinding:
      position: 101
      prefix: --cluster_leftovers
  - id: concurrent
    type:
      - 'null'
      - string
    doc: Captus will attempt to execute this many extractions concurrently. RAM 
      and CPUs will be divided by this value for each individual process. If set
      to 'auto', Captus will set as many processes as to at least have 2GB of 
      RAM available for each process due to the RAM requirements of BLAT
    default: auto
    inputBinding:
      position: 101
      prefix: --concurrent
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging mode, parallelization is disabled so errors are logged
      to screen
    inputBinding:
      position: 101
      prefix: --debug
  - id: disable_stitching
    type:
      - 'null'
      - boolean
    doc: Use only if you are sure your target loci will be found in a single 
      contig (for example if you have a chromosome-level assembly), otherwise 
      Captus tries to join partial matches to a target that are scattered across
      multiple contigs if their structure and overlaps are compatible
    inputBinding:
      position: 101
      prefix: --disable_stitching
  - id: dna_depth_tolerance
    type:
      - 'null'
      - float
    doc: Minimum depth = 10^(log(depth of contig with best hit in locus) * 
      dna_depth_tolerance), values must be between 0 and 1 (1 is the most 
      strict)
    default: 0.5
    inputBinding:
      position: 101
      prefix: --dna_depth_tolerance
  - id: dna_min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage percentage of reference target sequence to retain 
      matches
    default: 20
    inputBinding:
      position: 101
      prefix: --dna_min_coverage
  - id: dna_min_identity
    type:
      - 'null'
      - int
    doc: Minimum identity percentage to reference target sequences to retain 
      matches
    default: 80
    inputBinding:
      position: 101
      prefix: --dna_min_identity
  - id: dna_refs
    type:
      - 'null'
      - File
    doc: Path to a FASTA nucleotide file of miscellaneous DNA reference targets
    inputBinding:
      position: 101
      prefix: --dna_refs
  - id: fastas
    type:
      - 'null'
      - type: array
        items: File
    doc: "FASTA assembly file(s) that were not assembled with Captus. Valid file name
      extensions are: .fa, .fna, .fasta, .fa.gz, .fna.gz, .fasta.gz. These FASTA files
      must contain only nucleotides (no aminoacids). All the text before the extension
      of the filename will be used as sample name. These FASTAs will be automatically
      copied to the path provided with '-a'/'--captus_assemblies_dir' using the correct
      directory structure needed by Captus. There are a few ways to provide the FASTA
      files: A directory = path to directory containing FASTA files (e.g.: -f ./my_fastas)
      A list = filenames separated by space (e.g.: -f speciesA.fa speciesB.fasta.gz)
      A pattern = UNIX matching expression (e.g.: -f ./my_fastas/*.fasta)"
    inputBinding:
      position: 101
      prefix: --fastas
  - id: ignore_depth
    type:
      - 'null'
      - boolean
    doc: Do not filter contigs based on their depth of coverage
    inputBinding:
      position: 101
      prefix: --ignore_depth
  - id: keep_all
    type:
      - 'null'
      - boolean
    doc: Do not delete any intermediate files
    inputBinding:
      position: 101
      prefix: --keep_all
  - id: mafft_path
    type:
      - 'null'
      - string
    doc: Path to MAFFT
    default: mafft/mafft.bat
    inputBinding:
      position: 101
      prefix: --mafft_path
  - id: max_loci_files
    type:
      - 'null'
      - int
    doc: When the number of markers in a reference target file exceeds this 
      number, Captus will not write a separate FASTA file per sample per marker 
      to not overload I/O. The single FASTA file containing all recovered 
      markers per sample needed by the 'align' step is still produced as are the
      rest of output files
    default: 0
    inputBinding:
      position: 101
      prefix: --max_loci_files
  - id: max_loci_scipio_x2
    type:
      - 'null'
      - int
    doc: When the number of loci in a protein reference target file exceeds this
      number, Captus will not run a second, more exhaustive round of Scipio. 
      Usually the results from the first round are extremely similar and 
      sufficient, the second round can become extremely slow as the number of 
      reference target proteins grows
    default: 2000
    inputBinding:
      position: 101
      prefix: --max_loci_scipio_x2
  - id: max_locus_overlap
    type:
      - 'null'
      - float
    doc: Maximum overlap percentage allowed between loci annotations, nuclear 
      genes usually do not overlap but certain organellar genes do
    default: 5.0
    inputBinding:
      position: 101
      prefix: --max_locus_overlap
  - id: max_paralogs
    type:
      - 'null'
      - int
    doc: Maximum number of secondary hits (copies) of any particular reference 
      target marker allowed in the output. We recommend disabling the removal of
      paralogs (secondary hits/copies) during the 'extract' step because the 
      'align' step uses a more sophisticated filter for paralogs. -1 disables 
      the removal of paralogs
    default: -1
    inputBinding:
      position: 101
      prefix: --max_paralogs
  - id: mit_depth_tolerance
    type:
      - 'null'
      - float
    doc: Minimum depth = 10^(log(depth of contig with best hit in locus) * 
      mit_depth_tolerance), values must be between 0 and 1 (1 is the most 
      strict)
    default: 0.5
    inputBinding:
      position: 101
      prefix: --mit_depth_tolerance
  - id: mit_min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage percentage of reference target protein to consider a 
      hit by a contig
    default: 20
    inputBinding:
      position: 101
      prefix: --mit_min_coverage
  - id: mit_min_identity
    type:
      - 'null'
      - int
    doc: Minimum identity percentage to retain hits to reference target proteins
    default: 65
    inputBinding:
      position: 101
      prefix: --mit_min_identity
  - id: mit_min_score
    type:
      - 'null'
      - float
    doc: Minimum Scipio score to retain hits to reference target proteins
    default: 0.2
    inputBinding:
      position: 101
      prefix: --mit_min_score
  - id: mit_refs
    type:
      - 'null'
      - string
    doc: "Set of mitochondrial protein reference target sequences, options are: SeedPlantsMIT
      = A set of mitochondrial proteins for Seed Plants, curated by us Alternatively,
      provide a path to a FASTA file containing your reference target protein sequences
      in either nucleotide or aminoacid. When the FASTA file is in nucleotides, '--mit_transtable'
      will be used to translate it to aminoacids"
    inputBinding:
      position: 101
      prefix: --mit_refs
  - id: mit_transtable
    type:
      - 'null'
      - string
    doc: 'Genetic code table to translate your mitochondrial proteins. Complete list
      of tables at: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi'
    default: '1: Standard'
    inputBinding:
      position: 101
      prefix: --mit_transtable
  - id: mmseqs_method
    type:
      - 'null'
      - string
    doc: 'MMseqs2 clustering algorithm, options are: easy-linclust = Fast linear time
      (for huge datasets), less sensitive clustering easy-cluster = Sensitive homology
      search (recommended but slower)'
    default: easy-linclust
    inputBinding:
      position: 101
      prefix: --mmseqs_method
  - id: mmseqs_path
    type:
      - 'null'
      - string
    doc: Path to MMseqs2
    default: mmseqs
    inputBinding:
      position: 101
      prefix: --mmseqs_path
  - id: nuc_depth_tolerance
    type:
      - 'null'
      - float
    doc: Minimum depth = 10^(log(depth of contig with best hit in locus) * 
      nuc_depth_tolerance), values must be between 0 and 1 (1 is the most 
      strict)
    default: 0.5
    inputBinding:
      position: 101
      prefix: --nuc_depth_tolerance
  - id: nuc_min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage percentage of reference target protein to consider a 
      hit by a contig
    default: 20
    inputBinding:
      position: 101
      prefix: --nuc_min_coverage
  - id: nuc_min_identity
    type:
      - 'null'
      - int
    doc: Minimum identity percentage to retain hits to reference target proteins
    default: 65
    inputBinding:
      position: 101
      prefix: --nuc_min_identity
  - id: nuc_min_score
    type:
      - 'null'
      - float
    doc: Minimum Scipio score to retain hits to reference target proteins.
    default: 0.13
    inputBinding:
      position: 101
      prefix: --nuc_min_score
  - id: nuc_refs
    type:
      - 'null'
      - string
    doc: "Set of nuclear protein reference target sequences, options are: Angiosperms353
      = The original set of target proteins from Angiosperms353 Mega353 = The improved
      set of target proteins from Angiosperms353 Alternatively, provide a path to
      a FASTA file containing your reference target protein sequences in either nucleotide
      or aminoacid. When the FASTA file is in nucleotides, '--nuc_transtable' will
      be used to translate it to aminoacids"
    inputBinding:
      position: 101
      prefix: --nuc_refs
  - id: nuc_transtable
    type:
      - 'null'
      - string
    doc: 'Genetic code table to translate your nuclear proteins. Complete list of
      tables at: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi'
    default: '1: Standard'
    inputBinding:
      position: 101
      prefix: --nuc_transtable
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite previous results
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: paralog_coverage_tolerance
    type:
      - 'null'
      - float
    doc: Keep paralogs if they have at least this proportion of the coverage of 
      the best hit in the locus, use 0 to disable this filter
    default: 0.33
    inputBinding:
      position: 101
      prefix: --paralog_coverage_tolerance
  - id: paralog_depth_tolerance
    type:
      - 'null'
      - float
    doc: Keep paralogs if they have at least this proportion of the depth of the
      best hit in the locus, use 0 to disable this filter. Reduce accordingly if
      you have polyploids in your dataset
    default: 0.33
    inputBinding:
      position: 101
      prefix: --paralog_depth_tolerance
  - id: paralog_identity_tolerance
    type:
      - 'null'
      - float
    doc: Keep paralogs if they have at least this proportion of the identity of 
      the best hit in the locus, use 0 to disable this filter
    default: 0.66
    inputBinding:
      position: 101
      prefix: --paralog_identity_tolerance
  - id: predict
    type:
      - 'null'
      - boolean
    doc: Scipio flags introns as dubious when the splice signals are not found 
      at the exon edges, this may indicate that there are additional aminoacids 
      in the recovered protein that are not present in the reference target 
      protein. Enable this flag to attempt translation of these dubious introns,
      if the translation does not introduce premature stop codons they will be 
      added to the recovered protein
    inputBinding:
      position: 101
      prefix: --predict
  - id: ptd_depth_tolerance
    type:
      - 'null'
      - float
    doc: Minimum depth = 10^(log(depth of contig with best hit in locus) * 
      ptd_depth_tolerance), values must be between 0 and 1 (1 is the most 
      strict)
    default: 0.5
    inputBinding:
      position: 101
      prefix: --ptd_depth_tolerance
  - id: ptd_min_coverage
    type:
      - 'null'
      - int
    doc: Minimum coverage percentage of reference target protein to consider a 
      hit by a contig
    default: 20
    inputBinding:
      position: 101
      prefix: --ptd_min_coverage
  - id: ptd_min_identity
    type:
      - 'null'
      - int
    doc: Minimum identity percentage to retain hits to reference target proteins
    default: 65
    inputBinding:
      position: 101
      prefix: --ptd_min_identity
  - id: ptd_min_score
    type:
      - 'null'
      - float
    doc: Minimum Scipio score to retain hits to reference target proteins
    default: 0.2
    inputBinding:
      position: 101
      prefix: --ptd_min_score
  - id: ptd_refs
    type:
      - 'null'
      - string
    doc: "Set of plastidial protein reference target sequences, options are: SeedPlantsPTD
      = A set of plastidial proteins for Seed Plants, curated by us Alternatively,
      provide a path to a FASTA file containing your reference target protein sequences
      in either nucleotide or aminoacid. When the FASTA file is in nucleotides, '--ptd_transtable'
      will be used to translate it to aminoacids"
    inputBinding:
      position: 101
      prefix: --ptd_refs
  - id: ptd_transtable
    type:
      - 'null'
      - string
    doc: 'Genetic code table to translate your plastidial proteins. Complete list
      of tables at: https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi'
    default: '11: Bacterial, Archaeal and Plant Plastid'
    inputBinding:
      position: 101
      prefix: --ptd_transtable
  - id: ram
    type:
      - 'null'
      - string
    doc: "Maximum RAM in GB (e.g.: 4.5) dedicated to Captus, 'auto' uses 99% of available
      RAM"
    default: auto
    inputBinding:
      position: 101
      prefix: --ram
  - id: scipio_path
    type:
      - 'null'
      - string
    doc: Path to Scipio
    default: bundled
    inputBinding:
      position: 101
      prefix: --scipio_path
  - id: show_less
    type:
      - 'null'
      - boolean
    doc: Do not show individual sample information during the run, the 
      information is still written to the log
    inputBinding:
      position: 101
      prefix: --show_less
  - id: threads
    type:
      - 'null'
      - string
    doc: Maximum number of CPUs dedicated to Captus, 'auto' uses all available 
      CPUs
    default: auto
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out
    type:
      - 'null'
      - Directory
    doc: Output directory name
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/captus:1.6.3--pyh05cac1d_0
