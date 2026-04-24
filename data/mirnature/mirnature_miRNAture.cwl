cwlVersion: v1.2
class: CommandLineTool
baseCommand: miRNAture
label: mirnature_miRNAture
doc: "Seems that you did pass an empty flag, please refer to documentation.\n\nTool
  homepage: https://github.com/Bierinformatik/miRNAture"
inputs:
  - id: blast_queries_folder
    type:
      - 'null'
      - Directory
    doc: "Path of blast query sequences in FASTA format to be searched\non the subject
      sequence."
    inputBinding:
      position: 101
      prefix: -blastQueriesFolder
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: "Path to pre-calculated data directory containing RFAM and\nmiRBase covariance,
      hidden markov models, and necessary\nfiles to run MIRfix."
    inputBinding:
      position: 101
      prefix: -datadir
  - id: debug_mode
    type:
      - 'null'
      - boolean
    doc: Activate the Perl DEBUGGER to run miRNAture.
    inputBinding:
      position: 101
      prefix: -dbug
  - id: man
    type:
      - 'null'
      - boolean
    doc: Prints an extended help page and exits.
    inputBinding:
      position: 101
      prefix: -man
  - id: mirfix_path
    type:
      - 'null'
      - File
    doc: Alternative path of the MIRfix.py program.
    inputBinding:
      position: 101
      prefix: -mirfix_path
  - id: mode
    type:
      - 'null'
      - string
    doc: "Homology search modes: blast, hmm, rfam, mirbase, infernal,\nuser and/or
      final. It is possible to perform individual\nanalysis, but it is always recommended
      to include the final\noption to merge multiple results."
    inputBinding:
      position: 101
      prefix: -mode
  - id: parallel
    type:
      - 'null'
      - boolean
    doc: Activate parallel jobs processing (1) or not (0).
    inputBinding:
      position: 101
      prefix: -parallel
  - id: parallel_slurm
    type:
      - 'null'
      - boolean
    doc: "Activate SLURM resource manager to submit parallel jobs (1)\nor not (0)."
    inputBinding:
      position: 101
      prefix: -parallel_slurm
  - id: repetition_cutoff
    type:
      - 'null'
      - string
    doc: "Setup number of maximum loci number that will be evaluated\nby the mature's
      annotation stage. By default, miRNAture will\ndetect miRNA families that report
      high number of loci (> 200\nloci). Then, it will select the top 100 candidates
      in terms\nof alignment scores, as candidates for the validation stage\n(default,200,100).
      The designed values could be modified by\nthe following flag:\n'relax,Number_Loci,Candidates_to_evaluate'.
      This option\nallows to the user to select the threshold values to detect\nrepetitive
      families. The first parameter is <relax>,\nwhich tells miRNAture to change the
      default configuration. The\nnext one, <Number_Loci> is the threshold of loci
      number to\nclassify a family as repetitive. The last one,\n<Candidates_to_evaluate>,
      is the number of candidates prone\nto be evaluated in the next evaluation section.
      The rest\ncandidates are included as homology 'potential' candidates."
    inputBinding:
      position: 101
      prefix: -repetition_cutoff
  - id: species_genome
    type:
      - 'null'
      - File
    doc: Path of target sequences to be analyzed in FASTA format.
    inputBinding:
      position: 101
      prefix: -species_genome
  - id: species_name
    type:
      - 'null'
      - string
    doc: "Species or sequence source's scientific name. The format\nmust be: Genera_species,
      separated by '_'."
    inputBinding:
      position: 101
      prefix: -species_name
  - id: species_tag
    type:
      - 'null'
      - string
    doc: "Experiment tag. Will help to identify the generated files\nalong miRNA output
      files."
    inputBinding:
      position: 101
      prefix: -species_tag
  - id: stage
    type:
      - 'null'
      - string
    doc: "Selects the stage to be run on miRNAture. The options are:\n'homology',
      'no_homology', 'validation', 'evaluation',\n'summarise' or 'complete'."
    inputBinding:
      position: 101
      prefix: -stage
  - id: strategy
    type:
      - 'null'
      - string
    doc: "This flag is blast mode specific. It corresponds to blast\nstrategies that
      would be used to search miRNAs. It must be\nindicated along with -m Blast flag."
    inputBinding:
      position: 101
      prefix: -strategy
  - id: subset_models
    type:
      - 'null'
      - File
    doc: "Target list of CMs to be searched on subject\ngenome/sequences. If not indicated,
      miRNAture will run all\nRFAM v14.4 metazoan miRNA models."
    inputBinding:
      position: 101
      prefix: -subset_models
  - id: user_models
    type:
      - 'null'
      - Directory
    doc: "Directory with additional hidden Markov (HMMs) or covariance\nmodels (CMs)
      provided by the user. This must be contain a\ncorresponding HMMs/ and CMs/ folders,
      which the user models\nwill be identified."
    inputBinding:
      position: 101
      prefix: -user_models
outputs:
  - id: workdir
    type:
      - 'null'
      - Directory
    doc: Working directory path to write all miRNAture results.
    outputBinding:
      glob: $(inputs.workdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mirnature:1.1--pl5321hdfd78af_2
