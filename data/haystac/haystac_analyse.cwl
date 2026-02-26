cwlVersion: v1.2
class: CommandLineTool
baseCommand: haystac analyse
label: haystac_analyse
doc: "Analyse a sample against a database\n\nTool homepage: https://github.com/antonisdim/haystac"
inputs:
  - id: adna
    type:
      - 'null'
      - boolean
    doc: 'Set new flag defaults for aDNA sample analysis: mismatch-probability=0.20,
      min-prob=0.5, mapdamage=True'
    default: false
    inputBinding:
      position: 101
      prefix: --aDNA
  - id: batch
    type:
      - 'null'
      - string
    doc: Batch number for large`haystac analyse` workflows (e.g. --batch 
      align_all_accessions=1/3). You will need to execute all batches before 
      haystac is able to finish its workflow to the end.
    inputBinding:
      position: 101
      prefix: --batch
  - id: bowtie2_threads
    type:
      - 'null'
      - int
    doc: Number of threads bowtie2 will use to align a sample against every 
      individual genome in the database
    default: 4
    inputBinding:
      position: 101
      prefix: --bowtie2-threads
  - id: cores
    type:
      - 'null'
      - int
    doc: Maximum number of CPU cores to use
    default: 20
    inputBinding:
      position: 101
      prefix: --cores
  - id: database
    type: Directory
    doc: Path to the database output directory
    inputBinding:
      position: 101
      prefix: --database
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Enable debugging mode
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: genera
    type:
      - 'null'
      - type: array
        items: string
    doc: List of genera to restrict the abundance calculations
    default: '[]'
    inputBinding:
      position: 101
      prefix: --genera
  - id: mapdamage
    type:
      - 'null'
      - boolean
    doc: Perform mapdamage analysis for ancient samples
    default: false
    inputBinding:
      position: 101
      prefix: --mapdamage
  - id: mem
    type:
      - 'null'
      - int
    doc: Maximum memory (MB) to use
    default: 63985
    inputBinding:
      position: 101
      prefix: --mem
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum posterior probability to assign an aligned read to a given 
      species
    default: 0.75
    inputBinding:
      position: 101
      prefix: --min-prob
  - id: mismatch_probability
    type:
      - 'null'
      - float
    doc: Base mismatch probability
    default: 0.05
    inputBinding:
      position: 101
      prefix: --mismatch-probability
  - id: mode
    type: string
    doc: Analysis mode for the selected sample [filter, align, likelihoods, 
      probabilities, abundances, reads]
    inputBinding:
      position: 101
      prefix: --mode
  - id: sample
    type: Directory
    doc: Path to the sample output directory
    inputBinding:
      position: 101
      prefix: --sample
  - id: snakemake
    type:
      - 'null'
      - string
    doc: Pass additional flags to the `snakemake` scheduler.
    inputBinding:
      position: 101
      prefix: --snakemake
  - id: unlock
    type:
      - 'null'
      - boolean
    doc: Unlock the output directory following a crash or hard restart
    default: false
    inputBinding:
      position: 101
      prefix: --unlock
outputs:
  - id: output
    type: Directory
    doc: Path to the analysis output directory
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haystac:0.4.12--pyhcf36b3e_0
