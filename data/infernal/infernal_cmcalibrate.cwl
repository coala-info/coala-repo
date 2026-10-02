cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmcalibrate
label: infernal_cmcalibrate
doc: fit exponential tails for CM E-values
inputs:
  - id: cmfile
    type: File
    doc: Input CM file to calibrate
    inputBinding:
      position: 1
  - id: length
    type:
      - 'null'
      - float
    doc: set random seq length to search in Mb to <x> (0.01<=x<=160.)
    inputBinding:
      position: 102
      prefix: -L
  - id: forecast
    type:
      - 'null'
      - boolean
    doc: don't do calibration, predict running time and exit
    inputBinding:
      position: 102
      prefix: --forecast
  - id: nforecast
    type:
      - 'null'
      - int
    doc: w/--forecast, predict time with <n> processors (maybe for MPI)
    inputBinding:
      position: 102
      prefix: --nforecast
  - id: memreq
    type:
      - 'null'
      - boolean
    doc: don't do calibration, print required memory and exit
    inputBinding:
      position: 102
      prefix: --memreq
  - id: noforecast
    type:
      - 'null'
      - boolean
    doc: do calibration, but skip running time prediction
    inputBinding:
      position: 102
      prefix: --noforecast
  - id: gtailn
    type:
      - 'null'
      - int
    doc: fit the top <n> hits/Mb in histogram for glocal modes
    inputBinding:
      position: 102
      prefix: --gtailn
  - id: ltailn
    type:
      - 'null'
      - int
    doc: fit the top <n> hits/Mb in histogram for local modes
    inputBinding:
      position: 102
      prefix: --ltailn
  - id: tailp
    type:
      - 'null'
      - float
    doc: set fraction of histogram tail to fit to exp tail to <x>
    inputBinding:
      position: 102
      prefix: --tailp
  - id: hfile
    type:
      - 'null'
      - string
    doc: save fitted score histogram(s) to file <f>
    inputBinding:
      position: 102
      prefix: --hfile
  - id: sfile
    type:
      - 'null'
      - string
    doc: save survival plot to file <f>
    inputBinding:
      position: 102
      prefix: --sfile
  - id: qqfile
    type:
      - 'null'
      - string
    doc: save Q-Q plot for score histograms to file <f>
    inputBinding:
      position: 102
      prefix: --qqfile
  - id: ffile
    type:
      - 'null'
      - string
    doc: save lambdas for different tail fit probs to file <f>
    inputBinding:
      position: 102
      prefix: --ffile
  - id: xfile
    type:
      - 'null'
      - string
    doc: save scores in fit tail to file <f>
    inputBinding:
      position: 102
      prefix: --xfile
  - id: split
    type:
      - 'null'
      - boolean
    doc: prepare partitioned calibration
    inputBinding:
      position: 102
      prefix: --split
  - id: cfile
    type:
      - 'null'
      - string
    doc: with --split, save file with commands for each partition to <f>
    inputBinding:
      position: 102
      prefix: --cfile
  - id: cbash
    type:
      - 'null'
      - boolean
    doc: with --split, output commands as a bash for loop script
    inputBinding:
      position: 102
      prefix: --cbash
  - id: proot
    type:
      - 'null'
      - string
    doc: with --split or --merge, root for partition output files is <s>
    inputBinding:
      position: 102
      prefix: --proot
  - id: part
    type:
      - 'null'
      - int
    doc: this is partition number <n> (1..<n2> from --ptot <n2>) (n>0)
    inputBinding:
      position: 102
      prefix: --part
  - id: ptot
    type:
      - 'null'
      - int
    doc: total number of partitions is <n> (n>0)
    inputBinding:
      position: 102
      prefix: --ptot
  - id: pfile
    type:
      - 'null'
      - string
    doc: with --part, save scores to file <f>
    inputBinding:
      position: 102
      prefix: --pfile
  - id: merge
    type:
      - 'null'
      - boolean
    doc: merge scores from multiple partitions for calibration
    inputBinding:
      position: 102
      prefix: --merge
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 102
      prefix: --seed
  - id: beta
    type:
      - 'null'
      - float
    doc: set tail loss prob for query dependent banding (QDB) to <x>
    inputBinding:
      position: 102
      prefix: --beta
  - id: nonbanded
    type:
      - 'null'
      - boolean
    doc: do not use QDB
    inputBinding:
      position: 102
      prefix: --nonbanded
  - id: nonull3
    type:
      - 'null'
      - boolean
    doc: turn OFF the NULL3 post hoc additional null model
    inputBinding:
      position: 102
      prefix: --nonull3
  - id: random
    type:
      - 'null'
      - boolean
    doc: use GC content of random null background model of CM
    inputBinding:
      position: 102
      prefix: --random
  - id: gc
    type:
      - 'null'
      - File
    doc: use GC content distribution from file <f>
    inputBinding:
      position: 102
      prefix: --gc
  - id: cpu
    type:
      - 'null'
      - int
    doc: number of parallel CPU workers to use for multithreads
    inputBinding:
      position: 102
      prefix: --cpu
outputs:
  - id: output_hfile
    type:
      - 'null'
      - File
    doc: save fitted score histogram(s) to file <f>
    outputBinding:
      glob: $(inputs.hfile)
  - id: output_sfile
    type:
      - 'null'
      - File
    doc: save survival plot to file <f>
    outputBinding:
      glob: $(inputs.sfile)
  - id: output_qqfile
    type:
      - 'null'
      - File
    doc: save Q-Q plot for score histograms to file <f>
    outputBinding:
      glob: $(inputs.qqfile)
  - id: output_ffile
    type:
      - 'null'
      - File
    doc: save lambdas for different tail fit probs to file <f>
    outputBinding:
      glob: $(inputs.ffile)
  - id: output_xfile
    type:
      - 'null'
      - File
    doc: save scores in fit tail to file <f>
    outputBinding:
      glob: $(inputs.xfile)
  - id: output_cfile
    type:
      - 'null'
      - File
    doc: with --split, save file with commands for each partition to <f>
    outputBinding:
      glob: $(inputs.cfile)
  - id: output_proot
    type:
      - 'null'
      - File[]
    doc: with --split or --merge, root for partition output files is <s>
    outputBinding:
      glob: $(inputs.proot)*
  - id: output_pfile
    type:
      - 'null'
      - File
    doc: with --part, save scores to file <f>
    outputBinding:
      glob: $(inputs.pfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
s:url: http://eddylab.org/infernal
$namespaces:
  s: https://schema.org/
