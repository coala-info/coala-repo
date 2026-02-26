cwlVersion: v1.2
class: CommandLineTool
baseCommand: RepeatModeler
label: repeatmodeler_RepeatModeler
doc: "Model repetitive DNA\n\nTool homepage: https://www.repeatmasker.org/RepeatModeler"
inputs:
  - id: cdhit_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the CD-Hit sequence clustering package.
    inputBinding:
      position: 101
      prefix: -cdhit_dir
  - id: database
    type: string
    doc: The name of the sequence database to run an analysis on. This is the 
      name that was provided to the BuildDatabase script using the "-name" 
      option.
    inputBinding:
      position: 101
      prefix: -database
  - id: genome_sample_size_max
    type:
      - 'null'
      - int
    doc: "Optionally change the maximum sample size (bp). The sample sizes for RECON
      are increased until this number is reached (default: 270MB in 5 rounds, or 243MB
      in 6 rounds for '-quick' option)."
    inputBinding:
      position: 101
      prefix: -genomeSampleSizeMax
  - id: genometools_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the GenomeTools package.
    inputBinding:
      position: 101
      prefix: -genometools_dir
  - id: ltr_retriever_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the LTR_Retriever v2.9.0 structural LTR
      analysis package.
    inputBinding:
      position: 101
      prefix: -ltr_retriever_dir
  - id: ltr_struct
    type:
      - 'null'
      - boolean
    doc: Run the LTR structural discovery pipeline ( LTR_Harvest and 
      LTR_retreiver ) and combine results with the RepeatScout/RECON pipeline.
    inputBinding:
      position: 101
      prefix: -LTRStruct
  - id: mafft_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the MAFFT multiple alignment program.
    inputBinding:
      position: 101
      prefix: -mafft_dir
  - id: ninja_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the Ninja phylogenetic analysis 
      package.
    inputBinding:
      position: 101
      prefix: -ninja_dir
  - id: num_additional_rounds
    type:
      - 'null'
      - int
    doc: Optionally increase the number of rounds. The sample size for 
      additional rounds will change by size multiplier (currently 3).
    inputBinding:
      position: 101
      prefix: -numAddlRounds
  - id: quick
    type:
      - 'null'
      - boolean
    doc: In RepeatModeler 2.0.4 due to improvements in masking and 
      parallelization the sample sizes have increased improving sensitivity. 
      Using the quick option reverts back to the original sample sizes (pre 
      2.0.4) allowing for similar sensitivity as before, at a faster rate.
    inputBinding:
      position: 101
      prefix: -quick
  - id: recon_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the RECON de-novo repeatfinding 
      program.
    inputBinding:
      position: 101
      prefix: -recon_dir
  - id: recover_dir
    type:
      - 'null'
      - Directory
    doc: If a run fails in the middle of processing, it may be possible recover 
      some results and continue where the previous run left off. Simply supply 
      the output directory where the results of the failed run were saved and 
      the program will attempt to recover and continue the run.
    inputBinding:
      position: 101
      prefix: -recoverDir
  - id: repeatafterme_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the RepeatAfterMe ( 0.0.6 or higher ) 
      extension program.
    inputBinding:
      position: 101
      prefix: -repeatafterme_dir
  - id: repeatmasker_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of RepeatMasker (RM 4.1.5 or higher)
    inputBinding:
      position: 101
      prefix: -repeatmasker_dir
  - id: rmblast_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the RMBLAST (2.14.1 or higher)
    inputBinding:
      position: 101
      prefix: -rmblast_dir
  - id: rscout_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation of the RepeatScout ( 1.0.7 or higher ) 
      de-novo repeatfinding program.
    inputBinding:
      position: 101
      prefix: -rscout_dir
  - id: srand
    type:
      - 'null'
      - int
    doc: Optionally set the seed of the random number generator to a known value
      before the batches are randomly selected ( using Fisher Yates Shuffling ).
      This is only useful if you need to reproduce the sample choice between 
      runs. This should be an integer number.
    inputBinding:
      position: 101
      prefix: -srand
  - id: threads
    type:
      - 'null'
      - int
    doc: Specify the maximum number of threads which can be used by the program 
      at any one time. Note that the '-pa' parameter in previous releases 
      controlled the number of sequence batches compared in parallel using 
      rmblastn (each running 4 threads). Therefore, if '-pa 4' was used 
      previously the new thread parameter should be set to '-threads 16'.
    inputBinding:
      position: 101
      prefix: -threads
  - id: trf_dir
    type:
      - 'null'
      - Directory
    doc: The full path to TRF program. TRF must be named "trf". ( 4.0.9 or 
      higher )
    inputBinding:
      position: 101
      prefix: -trf_dir
  - id: ucsctools_dir
    type:
      - 'null'
      - Directory
    doc: The path to the installation directory of the UCSC TwoBit Tools 
      (twoBitToFa, faToTwoBit, twoBitInfo etc).
    inputBinding:
      position: 101
      prefix: -ucsctools_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatmodeler:2.0.7--pl5321hdfd78af_0
stdout: repeatmodeler_RepeatModeler.out
