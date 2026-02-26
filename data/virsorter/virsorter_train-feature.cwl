cwlVersion: v1.2
class: CommandLineTool
baseCommand: virsorter_train-feature
label: virsorter_train-feature
doc: "Training features for customized classifier.\n\nExecutes a snakemake workflow
  to do the following: 1) prepare random DNA\nfragments from viral and nonviral genome
  data  2) extract feature from\nrandom DNA fragments to make ftrfile\n\nTool homepage:
  https://github.com/simroux/VirSorter"
inputs:
  - id: frags_per_genome
    type:
      - 'null'
      - int
    doc: "number of random DNA fragments collected from\n                        \
      \      each genome"
    default: 5
    inputBinding:
      position: 101
      prefix: --frags-per-genome
  - id: genome_as_bin
    type:
      - 'null'
      - boolean
    doc: "if applied, each file (genome bin) is a genome\n                       \
      \       in --seqfile, else each sequence is a genome"
    inputBinding:
      position: 101
      prefix: --genome-as-bin
  - id: hallmark
    type:
      - 'null'
      - File
    doc: "hallmark gene hmm list from -hmm for training (a\n                     \
      \         tab separated file with three columns: 1. hmm\n                  \
      \            name, 2. gene name of hmm, 3. hmm bit score\n                 \
      \             cutoff); default to the one used for dsDNAphage\n            \
      \                  in VirSorter2"
    inputBinding:
      position: 101
      prefix: --hallmark
  - id: hmm
    type:
      - 'null'
      - File
    doc: "customized viral HMMs for training; default to\n                       \
      \       the one used in VirSorter2"
    inputBinding:
      position: 101
      prefix: --hmm
  - id: jobs
    type:
      - 'null'
      - int
    doc: 'max # of jobs in parallel'
    default: 20
    inputBinding:
      position: 101
      prefix: --jobs
  - id: max_orf_per_seq
    type:
      - 'null'
      - int
    doc: "Max # of orf used for computing taxonomic\n                            \
      \  features; if # of orf in a seq exceeds the max\n                        \
      \      limit, it is sub-sampled to this # to reduce\n                      \
      \        computation; to turn off this, set it to -1"
    default: 20
    inputBinding:
      position: 101
      prefix: --max-orf-per-seq
  - id: min_length
    type:
      - 'null'
      - int
    doc: minimum size of random DNA fragment for training
    default: 1000
    inputBinding:
      position: 101
      prefix: --min-length
  - id: prodigal_train
    type:
      - 'null'
      - File
    doc: "customized training db from prodigal; default to\n                     \
      \         the one used in prodigal --meta mode"
    inputBinding:
      position: 101
      prefix: --prodigal-train
  - id: seqfile
    type: string
    doc: "genome sequence file for training; for file\n                          \
      \    pattern globbing, put quotes around the pattern,\n                    \
      \          eg. \"fasta-dir/*.fa\""
    inputBinding:
      position: 101
      prefix: --seqfile
  - id: use_conda_off
    type:
      - 'null'
      - boolean
    doc: "Stop using the conda envs (vs2.yaml) that come\n                       \
      \       with this package and use what are installed in\n                  \
      \            current system; Only useful when you want to\n                \
      \              install dependencies on your own with your own\n            \
      \                  preferred versions"
    inputBinding:
      position: 101
      prefix: --use-conda-off
  - id: working_dir
    type: Directory
    doc: output directory
    inputBinding:
      position: 101
      prefix: --working-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virsorter:2.2.4--pyhdfd78af_2
stdout: virsorter_train-feature.out
