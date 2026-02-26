cwlVersion: v1.2
class: CommandLineTool
baseCommand: braker.pl
label: braker2_braker.pl
doc: "Pipeline for predicting genes with GeneMark-EX and AUGUSTUS with RNA-Seq and/or
  proteins\n\nTool homepage: https://github.com/Gaius-Augustus/BRAKER"
inputs:
  - id: add_utr
    type:
      - 'null'
      - string
    doc: Adds UTRs from RNA-Seq coverage data to augustus.hints.gtf file. Does 
      not perform training of AUGUSTUS or gene prediction with AUGUSTUS and UTR 
      parameters.
    inputBinding:
      position: 101
      prefix: --addUTR
  - id: alignment_tool_path
    type:
      - 'null'
      - Directory
    doc: Set path to alignment tool (GenomeThreader, Spaln, or Exonerate) if not
      specified as environment ALIGNMENT_TOOL_PATH variable. Has higher priority
      than environment variable.
    inputBinding:
      position: 101
      prefix: --ALIGNMENT_TOOL_PATH
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
      - File
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
      - Directory
    doc: Set path to NCBI blastall and formatdb executables if not specified as 
      environment variable. Has higher priority than environment variable.
    inputBinding:
      position: 101
      prefix: --BLAST_PATH
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
  - id: cfg_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Depending on the mode in which braker.pl is executed, it may require 
      one ore several extrinsicCfgFiles. Don't use this option unless you know 
      what you are doing!
    inputBinding:
      position: 101
      prefix: --CfgFiles
  - id: check_software
    type:
      - 'null'
      - boolean
    doc: Only check whether all required software is installed, no execution of 
      BRAKER
    inputBinding:
      position: 101
      prefix: --checkSoftware
  - id: cores
    type:
      - 'null'
      - int
    doc: 'Specifies the maximum number of cores that can be used during computation.
      Be aware: optimize_augustus.pl will use max. 8 cores; augustus will use max.
      nContigs in --genome=file cores.'
    inputBinding:
      position: 101
      prefix: --cores
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
      - Directory
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
    doc: The distribution of introns in training gene structures generated by 
      GeneMark-EX has a huge weight on single-exon and few-exon genes. 
      Specifying the lambda parameter of a poisson distribution will make braker
      call a script for downsampling of training gene structures according to 
      their number of introns distribution, i.e. genes with none or few exons 
      will be downsampled, genes with many exons will be kept. Default value is 
      2. If you want to avoid downsampling, you have to specify 0.
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
  - id: epmode
    type:
      - 'null'
      - boolean
    doc: Run ProtHint to generate protein hints (if not already specified with 
      --hints option) and use the hints in GeneMark-EP+ to create a training set
      for AUGUSTUS.
    inputBinding:
      position: 101
      prefix: --epmode
  - id: esmode
    type:
      - 'null'
      - boolean
    doc: Run GeneMark-ES (genome sequence only) and train AUGUSTUS on long genes
      predicted by GeneMark-ES. Final predictions are ab initio
    inputBinding:
      position: 101
      prefix: --esmode
  - id: etpmode
    type:
      - 'null'
      - boolean
    doc: Use RNA-Seq and protein hints in GeneMark-ETP+ to create a training set
      for AUGUSTUS. The protein hints are generated by ProtHint (see --epmode).
    inputBinding:
      position: 101
      prefix: --etpmode
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
    doc: Probablity for donor splice site pattern GC for gene prediction with 
      GeneMark-EX, default value is 0.001
    default: 0.001
    inputBinding:
      position: 101
      prefix: --gc_probability
  - id: gene_mark_gtf
    type:
      - 'null'
      - File
    doc: If skipGeneMark-ET is used, braker will by default look in the working 
      directory in folder GeneMarkET for an already existing gtf file. Instead, 
      you may provide such a file from another location. If geneMarkGtf option 
      is set, skipGeneMark-ES/ET/EP/ETP is automatically also set. Note that 
      gene and transcript ids in the final output may not match the ids in the 
      input genemark.gtf because BRAKER internally re-assigns these ids.
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
    doc: Adjust maximum allowed size of intergenic regions in GeneMark-EX. If 
      not used, the value is automatically determined by GeneMark-EX.
    inputBinding:
      position: 101
      prefix: --gm_max_intergenic
  - id: grass
    type:
      - 'null'
      - boolean
    doc: Switch this flag on if you are using braker.pl for predicting genes in 
      grasses with GeneMark-EX. The flag will enable GeneMark-EX to handle 
      GC-heterogenicity within genes more properly. NOTHING IMPLEMENTED FOR 
      GRASS YET!
    inputBinding:
      position: 101
      prefix: --grass
  - id: gth2traingenes
    type:
      - 'null'
      - boolean
    doc: Generate training gene structures for AUGUSTUS from GenomeThreader 
      alignments. (These genes can either be used for training AUGUSTUS alone 
      with --trainFromGth; or in addition to GeneMark-ET training genes if also 
      a bam-file is supplied.)
    inputBinding:
      position: 101
      prefix: --gth2traingenes
  - id: gushr_path
    type:
      - 'null'
      - Directory
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
      file (including the source "E" for intron hints from RNA-Seq)
    inputBinding:
      position: 101
      prefix: --hints
  - id: java_path
    type:
      - 'null'
      - Directory
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
    doc: Minimal contig length for GeneMark-EX, could for example be set to 
      10000 if transmasked_fasta option is used because transmasking might 
      introduce many very short contigs.
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
    doc: Optional custom config file for AUGUSTUS for running PPX (currently not
      implemented)
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
  - id: prg
    type:
      - 'null'
      - string
    doc: 'Specify an alternative method for generating hints from similarity of protein
      sequence data to genome data (alternative to the default --epmode/--etpmode
      in which ProtHint is used to generate the protein hints). Available methods
      are: gth (GenomeThreader), exonerate (Exonerate), or spaln (Spaln2). Note that
      this option is suitable only for proteins of closely related species (while
      the --epmode is generally applicable). This option is required in case --prot_aln
      option is used.'
    inputBinding:
      position: 101
      prefix: --prg
  - id: prot_aln
    type:
      - 'null'
      - File
    doc: 'Alignment file generated from aligning protein sequences against the genome
      with either Exonerate (--prg=exonerate), or Spaln (--prg=spaln), or GenomeThreader
      (--prg=gth). This option can be used as an alternative to --prot_seq file or
      protein hints in the --hints file. To prepare alignment file, run Spaln2 with
      the following command: spaln -O0 ... > spalnfile To prepare alignment file,
      run Exonerate with the following command: exonerate --model protein2genome \
      --showtargetgff T ... > exfile To prepare alignment file, run GenomeThreader
      with the following command: gth -genomic genome.fa  -protein \ protein.fa -gff3out
      \ -skipalignmentout ... -o gthfile A valid option prg=... must be specified
      in combination with --prot_aln. Generating tool will not be guessed. Currently,
      hints from protein alignment files are only used in the prediction step with
      AUGUSTUS.'
    inputBinding:
      position: 101
      prefix: --prot_aln
  - id: prot_seq
    type:
      - 'null'
      - File
    doc: A protein sequence file in multi-fasta format used to generate protein 
      hints. Unless otherwise specified, braker.pl will run in "EP mode" which 
      uses ProtHint to generate protein hints and GeneMark-EP+ to train 
      AUGUSTUS.
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
      - Directory
    doc: Set path to python3 executable (if not specified as envirnonment 
      variable and if executable is not in your $PATH).
    inputBinding:
      position: 101
      prefix: --PYTHON3_PATH
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
      with --geneMarkGtf=genemark.gtf)
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
      modules will not be necessary for running braker.pl.
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
  - id: softmasking
    type:
      - 'null'
      - boolean
    doc: Softmasking option for soft masked genome files. (Disabled by default.)
    inputBinding:
      position: 101
      prefix: --softmasking
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
      - type: array
        items: string
    doc: 'list of splice site patterns for UTR prediction; default: GTAG, extend like
      this: --splice_sites=GTAG,ATAC,... this option only affects UTR training example
      generation, not gene prediction by AUGUSTUS'
    inputBinding:
      position: 101
      prefix: --splice_sites
  - id: stranded
    type:
      - 'null'
      - type: array
        items: string
    doc: If UTRs are trained, i.e.~strand-specific bam-files are supplied and 
      coverage information is extracted for gene prediction, create stranded ep 
      hints. The order of strand specifications must correspond to the order of 
      bam files. Possible values are +, -, . If stranded data is provided, ONLY 
      coverage data from the stranded data is used to generate UTR examples! 
      Coverage data from unstranded data is used in the prediction step, only. 
      The stranded label is applied to coverage data, only. Intron hints are 
      generated from all libraries treated as "unstranded" (because splice site 
      filtering eliminates intron hints from the wrong strand, anyway).
    inputBinding:
      position: 101
      prefix: --stranded
  - id: train_from_gth
    type:
      - 'null'
      - boolean
    doc: No GeneMark-Training, train AUGUSTUS from GenomeThreader alignments
    inputBinding:
      position: 101
      prefix: --trainFromGth
  - id: translation_table
    type:
      - 'null'
      - int
    doc: Change translation table from non-standard to something else. DOES NOT 
      WORK YET BECAUSE BRAKER DOESNT SWITCH TRANSLATION TABLE FOR GENEMARK-EX, 
      YET!
    inputBinding:
      position: 101
      prefix: --translation_table
  - id: transmasked_fasta
    type:
      - 'null'
      - File
    doc: Transmasked genome FASTA file for GeneMark-EX (to be used instead of 
      the regular genome FASTA file).
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
      - string
    doc: create UTR training examples from RNA-Seq coverage data; requires 
      options --bam=rnaseq.bam and --softmasking. Alternatively, if UTR 
      parameters already exist, training step will be skipped and those 
      pre-existing parameters are used.
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
    dockerPull: quay.io/biocontainers/braker2:2.1.6--hdfd78af_5
stdout: braker2_braker.pl.out
