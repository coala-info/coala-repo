cwlVersion: v1.2
class: CommandLineTool
baseCommand: nhmmscan
label: hmmer_nhmmscan
doc: "search DNA sequence(s) against a DNA profile database\n\nTool homepage: http://hmmer.org/"
inputs:
  - id: hmmdb
    type: File
    doc: DNA profile database (pressed with hmmpress)
    secondaryFiles:
      - .h3f
      - .h3i
      - .h3m
      - .h3p
    inputBinding:
      position: 201
  - id: seqfile
    type: File
    doc: DNA sequence file to search
    inputBinding:
      position: 202
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: 'direct output to file <f>, not stdout'
    inputBinding:
      position: 104
      prefix: '-o'
  - id: tblout_path
    type:
      - 'null'
      - string
    doc: 'save parseable table of per-sequence hits to file <f>'
    inputBinding:
      position: 105
      prefix: '--tblout'
  - id: dfamtblout_path
    type:
      - 'null'
      - string
    doc: 'save table of hits to file, in Dfam format <f>'
    inputBinding:
      position: 106
      prefix: '--dfamtblout'
  - id: acc
    type:
      - 'null'
      - boolean
    doc: 'prefer accessions over names in output'
    inputBinding:
      position: 103
      prefix: '--acc'
  - id: noali
    type:
      - 'null'
      - boolean
    doc: "don't output alignments, so output is smaller"
    inputBinding:
      position: 103
      prefix: '--noali'
  - id: notextw
    type:
      - 'null'
      - boolean
    doc: 'unlimit ASCII text output line width'
    inputBinding:
      position: 103
      prefix: '--notextw'
  - id: textw
    type:
      - 'null'
      - int
    doc: 'set max width of ASCII text output lines [120] (n>=120)'
    inputBinding:
      position: 103
      prefix: '--textw'
  - id: evalue
    type:
      - 'null'
      - float
    doc: 'report models <= this E-value threshold in output [10.0] (x>0)'
    inputBinding:
      position: 103
      prefix: '-E'
  - id: score_threshold
    type:
      - 'null'
      - float
    doc: 'report models >= this score threshold in output'
    inputBinding:
      position: 103
      prefix: '-T'
  - id: incE
    type:
      - 'null'
      - float
    doc: 'consider models <= this E-value threshold as significant [0.01]'
    inputBinding:
      position: 103
      prefix: '--incE'
  - id: incT
    type:
      - 'null'
      - float
    doc: 'consider models >= this score threshold as significant'
    inputBinding:
      position: 103
      prefix: '--incT'
  - id: cut_ga
    type:
      - 'null'
      - boolean
    doc: "use profile's GA gathering cutoffs to set all thresholding"
    inputBinding:
      position: 103
      prefix: '--cut_ga'
  - id: cut_nc
    type:
      - 'null'
      - boolean
    doc: "use profile's NC noise cutoffs to set all thresholding"
    inputBinding:
      position: 103
      prefix: '--cut_nc'
  - id: cut_tc
    type:
      - 'null'
      - boolean
    doc: "use profile's TC trusted cutoffs to set all thresholding"
    inputBinding:
      position: 103
      prefix: '--cut_tc'
  - id: max
    type:
      - 'null'
      - boolean
    doc: 'Turn all heuristic filters off (less speed, more power)'
    inputBinding:
      position: 103
      prefix: '--max'
  - id: F1
    type:
      - 'null'
      - float
    doc: 'MSV threshold: promote hits w/ P <= F1 [0.02]'
    inputBinding:
      position: 103
      prefix: '--F1'
  - id: F2
    type:
      - 'null'
      - float
    doc: 'Vit threshold: promote hits w/ P <= F2 [3e-3]'
    inputBinding:
      position: 103
      prefix: '--F2'
  - id: F3
    type:
      - 'null'
      - float
    doc: 'Fwd threshold: promote hits w/ P <= F3 [3e-5]'
    inputBinding:
      position: 103
      prefix: '--F3'
  - id: nobias
    type:
      - 'null'
      - boolean
    doc: 'turn off composition bias filter'
    inputBinding:
      position: 103
      prefix: '--nobias'
  - id: qformat
    type:
      - 'null'
      - string
    doc: 'assert input <seqfile> is in format <s>'
    inputBinding:
      position: 103
      prefix: '--qformat'
  - id: nonull2
    type:
      - 'null'
      - boolean
    doc: 'turn off biased composition score corrections'
    inputBinding:
      position: 103
      prefix: '--nonull2'
  - id: z_comparisons
    type:
      - 'null'
      - float
    doc: 'set # of comparisons done, for E-value calculation'
    inputBinding:
      position: 103
      prefix: '-Z'
  - id: seed
    type:
      - 'null'
      - int
    doc: 'set RNG seed to <n> (if 0: one-time arbitrary seed) [42]'
    inputBinding:
      position: 103
      prefix: '--seed'
  - id: w_beta
    type:
      - 'null'
      - float
    doc: 'tail mass at which window length is determined'
    inputBinding:
      position: 103
      prefix: '--w_beta'
  - id: w_length
    type:
      - 'null'
      - int
    doc: 'window length - essentially max expected hit length'
    inputBinding:
      position: 103
      prefix: '--w_length'
  - id: watson
    type:
      - 'null'
      - boolean
    doc: 'only search the top strand'
    inputBinding:
      position: 103
      prefix: '--watson'
  - id: crick
    type:
      - 'null'
      - boolean
    doc: 'only search the bottom strand'
    inputBinding:
      position: 103
      prefix: '--crick'
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'number of parallel CPU workers to use for multithreads [0]'
    inputBinding:
      position: 103
      prefix: '--cpu'
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: direct output to file <f>, not stdout
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: tblout
    type:
      - 'null'
      - File
    doc: parseable table of per-sequence hits
    outputBinding:
      glob: $(inputs.tblout_path)
  - id: dfamtblout
    type:
      - 'null'
      - File
    doc: table of hits in Dfam format
    outputBinding:
      glob: $(inputs.dfamtblout_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmmer:3.4--hb6cb901_4
