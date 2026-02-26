cwlVersion: v1.2
class: CommandLineTool
baseCommand: braker.pl
label: braker3_braker.pl
doc: "Pipeline for predicting genes with GeneMark-EX and AUGUSTUS with RNA-Seq and/or
  proteins\n\nTool homepage: https://github.com/Gaius-Augustus/BRAKER"
inputs:
  - id: add_utr
    type:
      - 'null'
      - boolean
    doc: "Adds UTRs from RNA-Seq coverage data to\n                              \
      \      augustus.hints.gtf file. Does not perform\n                         \
      \           training of AUGUSTUS or gene prediction with\n                 \
      \                   AUGUSTUS and UTR parameters.\n\t\t    DO NOT USE IN CONTAINER!\n\
      \t\t    TRY NOT TO USE AT ALL!"
    inputBinding:
      position: 101
      prefix: --addUTR
  - id: alternatives_from_evidence
    type:
      - 'null'
      - boolean
    doc: Output alternative transcripts based on explicit evidence from hints 
      (default is true).
    default: true
    inputBinding:
      position: 101
      prefix: --alternatives-from-evidence
  - id: augustus_ab_initio
    type:
      - 'null'
      - boolean
    doc: output ab initio predictions by AUGUSTUS in addition to predictions 
      with hints by AUGUSTUS
    inputBinding:
      position: 101
      prefix: --AUGUSTUS_ab_initio
  - id: augustus_args
    type:
      - 'null'
      - string
    doc: One or several command line arguments to be passed to AUGUSTUS, if 
      several arguments are given, separate them by whitespace, i.e. 
      "--first_arg=sth --second_arg=sth".
    inputBinding:
      position: 101
      prefix: --augustus_args
  - id: augustus_bin_path
    type:
      - 'null'
      - Directory
    doc: Set path to the AUGUSTUS directory that contains binaries, i.e. 
      augustus and etraining. This variable must only be set if 
      AUGUSTUS_CONFIG_PATH does not have ../bin and ../scripts of AUGUSTUS 
      relative to its location i.e. for global AUGUSTUS installations. BRAKER1 
      will assume that the directory ../scripts of AUGUSTUS is located relative 
      to the AUGUSTUS_BIN_PATH. If this is not the case, please specify 
      --AUGUSTUS_SCRIPTS_PATH.
    inputBinding:
      position: 101
      prefix: --AUGUSTUS_BIN_PATH
  - id: augustus_config_path
    type:
      - 'null'
      - Directory
    doc: Set path to config directory of AUGUSTUS (if not specified as 
      environment variable). BRAKER1 will assume that the directories ../bin and
      ../scripts of AUGUSTUS are located relative to the AUGUSTUS_CONFIG_PATH. 
      If this is not the case, please specify AUGUSTUS_BIN_PATH (and 
      AUGUSTUS_SCRIPTS_PATH if required). The braker.pl commandline argument 
      --AUGUSTUS_CONFIG_PATH has higher priority than the environment variable 
      with the same name.
    inputBinding:
      position: 101
      prefix: --AUGUSTUS_CONFIG_PATH
  - id: augustus_hints_preds
    type:
      - 'null'
      - File
    doc: File with AUGUSTUS hints predictions; will use this file as basis for 
      UTR training; only UTR training and prediction is performed if this option
      is given.
    inputBinding:
      position: 101
      prefix: --AUGUSTUS_hints_preds
  - id: augustus_scripts_path
    type:
      - 'null'
      - Directory
    doc: Set path to AUGUSTUS directory that contains scripts, i.e. 
      splitMfasta.pl. This variable must only be set if AUGUSTUS_CONFIG_PATH or 
      AUGUSTUS_BIN_PATH do not contains the ../scripts directory of AUGUSTUS 
      relative to their location, i.e. for special cases of a global AUGUSTUS 
      installation.
    inputBinding:
      position: 101
      prefix: --AUGUSTUS_SCRIPTS_PATH
  - id: bam
    type:
      - 'null'
      - type: array
        items: File
    doc: bam file with spliced alignments from RNA-Seq
    inputBinding:
      position: 101
      prefix: --bam
  - id: bamtools_path
    type:
      - 'null'
      - Directory
    doc: Set path to bamtools (if not specified as environment BAMTOOLS_PATH 
      variable). Has higher priority than the environment variable.
    inputBinding:
      position: 101
      prefix: --BAMTOOLS_PATH
  - id: blast_path
    type:
      - 'null'
      - File
    doc: Set path to NCBI blastall and formatdb executables if not specified as 
      environment variable. Has higher priority than environment variable.
    inputBinding:
      position: 101
      prefix: --BLAST_PATH
  - id: busco_lineage
    type:
      - 'null'
      - string
    doc: If you provide a BUSCO lineage, BRAKER will run compleasm on genome 
      level to generate hints from BUSCO to enhance BUSCO discovery in the 
      protein set. Also, if you provide a BUSCO lineage, BRAKER will run 
      compleasm to assess the protein sets that go into TSEBRA combination, and 
      will determine the TSEBRA mode to maximize BUSCO. Do not provide a 
      busco_lineage if you want to determina natural BUSCO sensivity of BRAKER!
    inputBinding:
      position: 101
      prefix: --busco_lineage
  - id: cdbtools_path
    type:
      - 'null'
      - Directory
    doc: cdbfasta/cdbyank are required for running 
      fix_in_frame_stop_codon_genes.py. Usage of that script can be skipped with
      option '--skip_fixing_broken_genes'.
    inputBinding:
      position: 101
      prefix: --CDBTOOLS_PATH
  - id: check_software
    type:
      - 'null'
      - boolean
    doc: Only check whether all required software is installed, no execution of 
      BRAKER
    inputBinding:
      position: 101
      prefix: --checkSoftware
  - id: compleasm_path
    type:
      - 'null'
      - Directory
    doc: Set path to compleasm (if not specified as environment variable). Has 
      higher priority than environment variable.
    inputBinding:
      position: 101
      prefix: --COMPLEASM_PATH
  - id: crf
    type:
      - 'null'
      - boolean
    doc: Execute CRF training for AUGUSTUS; resulting parameters are only kept 
      for final predictions if they show higher accuracy than HMM parameters.
    inputBinding:
      position: 101
      prefix: --crf
  - id: diamond_path
    type:
      - 'null'
      - File
    doc: Set path to diamond, this is an alternative to NCIB blast; you only 
      need to specify one out of DIAMOND_PATH or BLAST_PATH, not both. DIAMOND 
      is a lot faster that BLAST and yields highly similar results for BRAKER.
    inputBinding:
      position: 101
      prefix: --DIAMOND_PATH
  - id: downsampling_lambda
    type:
      - 'null'
      - float
    doc: "The distribution of introns in training gene structures generated by GeneMark-EX
      has a huge weight on single-exon and few-exon genes. Specifying the lambda parameter
      of a poisson distribution will make braker call a script for downsampling of
      training gene structures according to their number of introns distribution,
      i.e. genes with none or few exons will be downsampled, genes with many exons
      will be kept. Default value is 2.\n                                    If you
      want to avoid downsampling, you have to specify 0."
    default: 2.0
    inputBinding:
      position: 101
      prefix: --downsampling_lambda
  - id: email
    type:
      - 'null'
      - string
    doc: E-mail address for creating track data hub
    inputBinding:
      position: 101
      prefix: --email
  - id: esmode
    type:
      - 'null'
      - boolean
    doc: Run GeneMark-ES (genome sequence only) and train AUGUSTUS on long genes
      predicted by GeneMark-ES. Final predictions are ab initio
    inputBinding:
      position: 101
      prefix: --esmode
  - id: eval
    type:
      - 'null'
      - File
    doc: Reference set to evaluate predictions against (using evaluation scripts
      from GaTech)
    inputBinding:
      position: 101
      prefix: --eval
  - id: eval_pseudo
    type:
      - 'null'
      - File
    doc: File with pseudogenes that will be excluded from accuracy evaluation 
      (may be empty file)
    inputBinding:
      position: 101
      prefix: --eval_pseudo
  - id: extrinsic_cfg_files
    type:
      - 'null'
      - type: array
        items: string
    doc: Depending on the mode in which braker.pl is executed, it may require 
      one ore several extrinsicCfgFiles. Don't use this option unless you know 
      what you are doing!
    inputBinding:
      position: 101
      prefix: --extrinsicCfgFiles
  - id: filter_out_short
    type:
      - 'null'
      - boolean
    doc: It may happen that a "good" training gene, i.e. one that has intron 
      support from RNA-Seq in all introns predicted by GeneMark-EX, is in fact 
      too short. This flag will discard such genes that have supported introns 
      and a neighboring RNA-Seq supported intron upstream of the start codon 
      within the range of the maximum CDS size of that gene and with a 
      multiplicity that is at least as high as 20% of the average intron 
      multiplicity of that gene.
    inputBinding:
      position: 101
      prefix: --filterOutShort
  - id: flanking_dna
    type:
      - 'null'
      - int
    doc: Size of flanking region, must only be specified if 
      --AUGUSTUS_hints_preds is given (for UTR training in a separate braker.pl 
      run that builds on top of an existing run)
    inputBinding:
      position: 101
      prefix: --flanking_DNA
  - id: fungus
    type:
      - 'null'
      - boolean
    doc: 'GeneMark-EX option: run algorithm with branch point model (most useful for
      fungal genomes)'
    inputBinding:
      position: 101
      prefix: --fungus
  - id: gc_probability
    type:
      - 'null'
      - float
    doc: "Probablity for donor splice site pattern GC\n                          \
      \          for gene prediction with GeneMark-EX,\n                         \
      \           default value is 0.001"
    default: 0.001
    inputBinding:
      position: 101
      prefix: --gc_probability
  - id: genemark_gtf
    type:
      - 'null'
      - File
    doc: If skipGeneMark-ET is used, braker will by default look in the working 
      directory in folder GeneMarkET for an already existing gtf file. Instead, 
      you may provide such a file from another location. If geneMarkGtf option 
      is set, skipGeneMark-ES/ET/EP/ETP is automatically also set. Note that 
      gene and transcript ids in the final output may not match the ids in the 
      input genemark.gtf because BRAKER internally re-assigns these ids. In ETP 
      mode, this option hast to be used together with --traingenes and --hints 
      to provide BRAKER with results of a previous GeneMark-ETP run.
    inputBinding:
      position: 101
      prefix: --geneMarkGtf
  - id: genemark_path
    type:
      - 'null'
      - Directory
    doc: Set path to GeneMark-ET (if not specified as environment GENEMARK_PATH 
      variable). Has higher priority than environment variable.
    inputBinding:
      position: 101
      prefix: --GENEMARK_PATH
  - id: genome
    type: File
    doc: fasta file with DNA sequences
    inputBinding:
      position: 101
      prefix: --genome
  - id: gff3
    type:
      - 'null'
      - boolean
    doc: Output in GFF3 format (default is gtf format)
    inputBinding:
      position: 101
      prefix: --gff3
  - id: gm_max_intergenic
    type:
      - 'null'
      - int
    doc: "Adjust maximum allowed size of intergenic\n                            \
      \        regions in GeneMark-EX. If not used, the value\n                  \
      \                  is automatically determined by GeneMark-EX."
    inputBinding:
      position: 101
      prefix: --gm_max_intergenic
  - id: gmetp_results_dir
    type:
      - 'null'
      - Directory
    doc: Location of results from a previous GeneMark-ETP run, which will be 
      used to skip the GeneMark-ETP step. This option can be used instead of 
      --geneMarkGtf, --traingenes, and --hints to skip GeneMark.
    inputBinding:
      position: 101
      prefix: --gmetp_results_dir
  - id: grass
    type:
      - 'null'
      - boolean
    doc: "Switch this flag on if you are using braker.pl\n                       \
      \             for predicting genes in grasses with\n                       \
      \             GeneMark-EX. The flag will enable\n                          \
      \          GeneMark-EX to handle GC-heterogenicity\n                       \
      \             within genes more properly.\n                                \
      \    NOTHING IMPLEMENTED FOR GRASS YET!"
    inputBinding:
      position: 101
      prefix: --grass
  - id: gushr_path
    type:
      - 'null'
      - File
    doc: Set path to gushr.py exectuable (if not specified as an environment 
      variable and if executable is not in your $PATH), only required with the 
      flags --UTR=on and --addUTR=on
    inputBinding:
      position: 101
      prefix: --GUSHR_PATH
  - id: hints
    type:
      - 'null'
      - File
    doc: Alternatively to calling braker.pl with a bam or protein fasta file, it
      is possible to call it with a .gff file that contains introns extracted 
      from RNA-Seq and/or protein hints (most frequently coming from ProtHint). 
      If you wish to use the ProtHint hints, use its "prothint_augustus.gff" 
      output file. This flag also allows the usage of hints from additional 
      extrinsic sources for gene prediction with AUGUSTUS. To consider such 
      additional extrinsic information, you need to use the flag 
      --extrinsicCfgFiles to specify parameters for all sources in the hints 
      file (including the source "E" for intron hints from RNA-Seq). In ETP 
      mode, this option can be used together with --geneMarkGtf and --traingenes
      to provide BRAKER with results of a previous GeneMark-ETP run, so that the
      GeneMark-ETP step can be skipped. In this case, specify the hintsfile of a
      previous BRAKER run here, or generate a hintsfile from the GeneMark-ETP 
      working directory with the script get_etp_hints.py.
    inputBinding:
      position: 101
      prefix: --hints
  - id: java_path
    type:
      - 'null'
      - File
    doc: Set path to java executable (if not specified as environment variable 
      and if executable is not in your $PATH), only required with flags --UTR=on
      and --addUTR=on
    inputBinding:
      position: 101
      prefix: --JAVA_PATH
  - id: keep_crf
    type:
      - 'null'
      - boolean
    doc: keep CRF parameters even if they are not better than HMM parameters
    inputBinding:
      position: 101
      prefix: --keepCrf
  - id: makehub
    type:
      - 'null'
      - boolean
    doc: Create track data hub with make_hub.py for visualizing BRAKER results 
      with the UCSC GenomeBrowser
    inputBinding:
      position: 101
      prefix: --makehub
  - id: makehub_path
    type:
      - 'null'
      - Directory
    doc: Set path to make_hub.py (if option --makehub is used).
    inputBinding:
      position: 101
      prefix: --MAKEHUB_PATH
  - id: min_contig
    type:
      - 'null'
      - int
    doc: "Minimal contig length for GeneMark-EX, could\n                         \
      \           for example be set to 10000 if transmasked_fasta\n             \
      \                       option is used because transmasking might\n        \
      \                            introduce many very short contigs."
    inputBinding:
      position: 101
      prefix: --min_contig
  - id: nice
    type:
      - 'null'
      - boolean
    doc: Execute all system calls within braker.pl and its submodules with bash 
      "nice" (default nice value)
    inputBinding:
      position: 101
      prefix: --nice
  - id: no_cleanup
    type:
      - 'null'
      - boolean
    doc: Skip deletion of all files that are typically not used in an annotation
      project after running braker.pl. (For tracking any problems with a 
      braker.pl run, you might want to keep these files, therefore nocleanup can
      be activated.)
    inputBinding:
      position: 101
      prefix: --nocleanup
  - id: opt_cfg_file
    type:
      - 'null'
      - File
    doc: "Optional custom config file for AUGUSTUS\n                             \
      \       for running PPX (currently not\n                                   \
      \ implemented)"
    inputBinding:
      position: 101
      prefix: --optCfgFile
  - id: overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite existing files (except for species parameter files) Beware, 
      currently not implemented properly!
    inputBinding:
      position: 101
      prefix: --overwrite
  - id: prot_seq
    type:
      - 'null'
      - File
    doc: A protein sequence file in multi-fasta format used to generate protein 
      hints. Unless otherwise specified, braker.pl will run in "EP mode" or "ETP
      mode which uses ProtHint to generate protein hints and GeneMark-EP+ or 
      GeneMark-ETP to train AUGUSTUS.
    inputBinding:
      position: 101
      prefix: --prot_seq
  - id: prothint_path
    type:
      - 'null'
      - Directory
    doc: Set path to the directory with prothint.py. (if not specified as 
      PROTHINT_PATH environment variable). Has higher priority than environment 
      variable.
    inputBinding:
      position: 101
      prefix: --PROTHINT_PATH
  - id: python3_path
    type:
      - 'null'
      - File
    doc: Set path to python3 executable (if not specified as envirnonment 
      variable and if executable is not in your $PATH).
    inputBinding:
      position: 101
      prefix: --PYTHON3_PATH
  - id: rnaseq_sets_dir
    type:
      - 'null'
      - Directory
    doc: Locations where the local files of RNA-Seq data reside that were 
      specified with --rnaseq_sets_ids.
    inputBinding:
      position: 101
      prefix: --rnaseq_sets_dir
  - id: rnaseq_sets_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: IDs of RNA-Seq sets that are either in one of the directories specified
      with --rnaseq_sets_dir, or that can be downloaded from SRA. If you want to
      use local files, you can use unaligned reads in FASTQ format (they have to
      be named ID.fastq if unpaired or ID_1.fastq, ID_2.fastq if paired), or 
      aligned reads as a BAM file (named ID.bam).
    inputBinding:
      position: 101
      prefix: --rnaseq_sets_ids
  - id: rounds
    type:
      - 'null'
      - int
    doc: The number of optimization rounds used in optimize_augustus.pl (default
      5)
    default: 5
    inputBinding:
      position: 101
      prefix: --rounds
  - id: samtools_path
    type:
      - 'null'
      - Directory
    doc: Optionally set path to samtools (if not specified as environment 
      SAMTOOLS_PATH variable) to fix BAM files automatically, if necessary. Has 
      higher priority than environment variable.
    inputBinding:
      position: 101
      prefix: --SAMTOOLS_PATH
  - id: skip_all_training
    type:
      - 'null'
      - boolean
    doc: Skip GeneMark-EX (training and prediction), skip AUGUSTUS training, 
      only runs AUGUSTUS with pre-trained and already existing parameters (not 
      recommended). Hints from input are still generated. This option 
      automatically sets --useexisting to true.
    inputBinding:
      position: 101
      prefix: --skipAllTraining
  - id: skip_fixing_broken_genes
    type:
      - 'null'
      - boolean
    doc: If you do not have python3, you can choose to skip the fixing of stop 
      codon including genes (not recommended).
    inputBinding:
      position: 101
      prefix: --skip_fixing_broken_genes
  - id: skip_genemark_ep
    type:
      - 'null'
      - boolean
    doc: Skip GeneMark-EP and use provided GeneMark-EP output (e.g. provided 
      with --geneMarkGtf=genemark.gtf)
    inputBinding:
      position: 101
      prefix: --skipGeneMark-EP
  - id: skip_genemark_es
    type:
      - 'null'
      - boolean
    doc: Skip GeneMark-ES and use provided GeneMark-ES output (e.g. provided 
      with --geneMarkGtf=genemark.gtf)
    inputBinding:
      position: 101
      prefix: --skipGeneMark-ES
  - id: skip_genemark_et
    type:
      - 'null'
      - boolean
    doc: Skip GeneMark-ET and use provided GeneMark-ET output (e.g. provided 
      with --geneMarkGtf=genemark.gtf)
    inputBinding:
      position: 101
      prefix: --skipGeneMark-ET
  - id: skip_genemark_etp
    type:
      - 'null'
      - boolean
    doc: Skip GeneMark-ETP and use provided GeneMark-ETP output (e.g. provided 
      with --gmetp_results_dir=GeneMark-ETP/)
    inputBinding:
      position: 101
      prefix: --skipGeneMark-ETP
  - id: skip_get_anno_from_fasta
    type:
      - 'null'
      - boolean
    doc: Skip calling the python3 script getAnnoFastaFromJoingenes.py from the 
      AUGUSTUS tool suite. This script requires python3, biopython and re 
      (regular expressions) to be installed. It produces coding sequence and 
      protein FASTA files from AUGUSTUS gene predictions and provides 
      information about genes with in-frame stop codons. If you enable this 
      flag, these files will not be produced and python3 and the required 
      modules will not be necessary for running brkaker.pl.
    inputBinding:
      position: 101
      prefix: --skipGetAnnoFromFasta
  - id: skip_iterative_prediction
    type:
      - 'null'
      - boolean
    doc: Skip iterative prediction in --epmode (does not affect other modes, 
      saves a bit of runtime)
    inputBinding:
      position: 101
      prefix: --skipIterativePrediction
  - id: skip_optimize
    type:
      - 'null'
      - boolean
    doc: Skip optimize parameter step (not recommended).
    inputBinding:
      position: 101
      prefix: --skipOptimize
  - id: softmasking_off
    type:
      - 'null'
      - boolean
    doc: Turn off softmasking option (enables by default, discouraged to 
      disable!)
    inputBinding:
      position: 101
      prefix: --softmasking_off
  - id: species
    type:
      - 'null'
      - string
    doc: Species name. Existing species will not be overwritten. Uses Sp_1 etc.,
      if no species is assigned
    inputBinding:
      position: 101
      prefix: --species
  - id: splice_sites
    type:
      - 'null'
      - string
    doc: "list of splice site patterns for UTR prediction; default: GTAG, extend like
      this: --splice_sites=GTAG,ATAC,...\n                                    this
      option only affects UTR training\n                                    example
      generation, not gene prediction\n                                    by AUGUSTUS"
    inputBinding:
      position: 101
      prefix: --splice_sites
  - id: stranded
    type:
      - 'null'
      - type: array
        items: string
    doc: "If UTRs are trained, i.e.~strand-specific\n                            \
      \        bam-files are supplied and coverage\n                             \
      \       information is extracted for gene prediction, create stranded ep hints.
      The order of\n                                    strand specifications must
      correspond to the\n                                    order of bam files. Possible
      values are\n                                    +, -, .\n                  \
      \                  If stranded data is provided, ONLY coverage\n           \
      \                         data from the stranded data is used to\n         \
      \                           generate UTR examples! Coverage data from\n    \
      \                                unstranded data is used in the prediction\n\
      \                                    step, only.\n                         \
      \           The stranded label is applied to coverage\n                    \
      \                data, only. Intron hints are generated\n                  \
      \                  from all libraries treated as \"unstranded\"\n          \
      \                          (because splice site filtering eliminates\n     \
      \                               intron hints from the wrong strand, anyway)."
    inputBinding:
      position: 101
      prefix: --stranded
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Specifies the maximum number of threads that can be used during computation.
      Be aware: optimize_augustus.pl will use max. 8 threads; augustus will use max.
      nContigs in --genome=file threads.'
    inputBinding:
      position: 101
      prefix: --threads
  - id: traingenes
    type:
      - 'null'
      - File
    doc: "Training genes that are used instead of training\n                     \
      \               genes generated with GeneMark.\n                           \
      \         In ETP mode, this option can be used together\n                  \
      \                  with --geneMarkGtf and --hints to provide BRAKER\n      \
      \                              with results of a previous GeneMark-ETP run,
      so\n                                    that the GeneMark-ETP step can be skipped.\n\
      \                                    In this case, use training.gtf from that
      run as\n                                    argument."
    inputBinding:
      position: 101
      prefix: --traingenes
  - id: translation_table
    type:
      - 'null'
      - int
    doc: "Change translation table from non-standard\n                           \
      \         to something else.\n                                    DOES NOT WORK
      YET BECAUSE BRAKER DOESNT\n                                    SWITCH TRANSLATION
      TABLE FOR GENEMARK-EX, YET!"
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: transmasked_fasta
    type:
      - 'null'
      - File
    doc: "Transmasked genome FASTA file for GeneMark-EX\n                        \
      \            (to be used instead of the regular genome\n                   \
      \                 FASTA file)."
    inputBinding:
      position: 101
      prefix: --transmasked_fasta
  - id: use_existing
    type:
      - 'null'
      - boolean
    doc: Use the present config and parameter files if they exist for 'species';
      will overwrite original parameters if BRAKER performs an AUGUSTUS 
      training.
    inputBinding:
      position: 101
      prefix: --useexisting
  - id: utr
    type:
      - 'null'
      - boolean
    doc: "create UTR training examples from RNA-Seq\n                            \
      \        coverage data; requires options\n                                 \
      \   --bam=rnaseq.bam.\n                                    Alternatively, if
      UTR parameters already\n                                    exist, training
      step will be skipped and\n                                    those pre-existing
      parameters are used.\n\t\t    DO NOT USE IN CONTAINER!\n\t\t    TRY NOT TO USE
      AT ALL!"
    inputBinding:
      position: 101
      prefix: --UTR
  - id: verbosity
    type:
      - 'null'
      - int
    doc: "0 -> run braker.pl quiet (no log)\n                                    1
      -> only log warnings\n                                    2 -> also log configuration\n\
      \                                    3 -> log all major steps\n            \
      \                        4 -> very verbose, log also small steps"
    inputBinding:
      position: 101
      prefix: --verbosity
  - id: workingdir
    type:
      - 'null'
      - Directory
    doc: Set path to working directory. In the working directory results and 
      temporary files are stored
    inputBinding:
      position: 101
      prefix: --workingdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/braker3:3.0.8--hdfd78af_0
stdout: braker3_braker.pl.out
