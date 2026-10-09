cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cmalign
label: infernal_cmalign
doc: "align sequences to a CM\n\nTool homepage: http://eddylab.org/infernal"
inputs:
  - id: cmfile
    type: File
    doc: 'Covariance model file'
    inputBinding:
      position: 200
  - id: seqfile
    type: File
    doc: 'Sequence file to align (FASTA or GenBank)'
    inputBinding:
      position: 201
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'output the alignment to file <f>, not stdout'
    inputBinding:
      position: 101
      prefix: -o
  - id: glocal
    type:
      - 'null'
      - boolean
    doc: 'configure CM for global alignment [default: local]'
    inputBinding:
      position: 101
      prefix: -g
  - id: optacc
    type:
      - 'null'
      - boolean
    doc: 'use the Holmes/Durbin optimal accuracy algorithm [default]'
    inputBinding:
      position: 101
      prefix: --optacc
  - id: cyk
    type:
      - 'null'
      - boolean
    doc: 'use the CYK algorithm'
    inputBinding:
      position: 101
      prefix: --cyk
  - id: sample
    type:
      - 'null'
      - boolean
    doc: 'sample alignment of each seq from posterior distribution'
    inputBinding:
      position: 101
      prefix: --sample
  - id: seed
    type:
      - 'null'
      - int
    doc: 'w/--sample, set RNG seed to <n> (if 0: one-time arbitrary seed)'
    inputBinding:
      position: 101
      prefix: --seed
  - id: notrunc
    type:
      - 'null'
      - boolean
    doc: 'do not use truncated alignment algorithm'
    inputBinding:
      position: 101
      prefix: --notrunc
  - id: sub
    type:
      - 'null'
      - boolean
    doc: 'build sub CM for columns b/t HMM predicted start/end points'
    inputBinding:
      position: 101
      prefix: --sub
  - id: hbanded
    type:
      - 'null'
      - boolean
    doc: 'accelerate using CM plan 9 HMM derived bands [default]'
    inputBinding:
      position: 101
      prefix: --hbanded
  - id: tau
    type:
      - 'null'
      - float
    doc: 'set tail loss prob for HMM bands to <x> [1e-7] (1e-18<x<1)'
    inputBinding:
      position: 101
      prefix: --tau
  - id: mxsize
    type:
      - 'null'
      - float
    doc: 'set maximum allowable DP matrix size to <x> Mb [1024.0] (x>0.)'
    inputBinding:
      position: 101
      prefix: --mxsize
  - id: fixedtau
    type:
      - 'null'
      - boolean
    doc: 'do not adjust tau (tighten bands) until mx size is < limit'
    inputBinding:
      position: 101
      prefix: --fixedtau
  - id: maxtau
    type:
      - 'null'
      - float
    doc: 'set max tau <x> when tightening HMM bands [0.05] (0<x<0.5)'
    inputBinding:
      position: 101
      prefix: --maxtau
  - id: nonbanded
    type:
      - 'null'
      - boolean
    doc: 'do not use HMM bands for faster alignment'
    inputBinding:
      position: 101
      prefix: --nonbanded
  - id: small
    type:
      - 'null'
      - boolean
    doc: 'use small memory divide and conquer (d&c) algorithm'
    inputBinding:
      position: 101
      prefix: --small
  - id: sfile
    type:
      - 'null'
      - string
    doc: 'dump alignment score information to file <f>'
    inputBinding:
      position: 101
      prefix: --sfile
  - id: tfile
    type:
      - 'null'
      - string
    doc: 'dump individual sequence parsetrees to file <f>'
    inputBinding:
      position: 101
      prefix: --tfile
  - id: ifile
    type:
      - 'null'
      - string
    doc: 'dump information on per-sequence inserts to file <f>'
    inputBinding:
      position: 101
      prefix: --ifile
  - id: elfile
    type:
      - 'null'
      - string
    doc: 'dump information on per-sequence EL inserts to file <f>'
    inputBinding:
      position: 101
      prefix: --elfile
  - id: mapali
    type:
      - 'null'
      - File
    doc: 'include alignment in file <f> (same ali that CM came from)'
    inputBinding:
      position: 101
      prefix: --mapali
  - id: mapstr
    type:
      - 'null'
      - boolean
    doc: 'include structure (w/pknots) from <f> from --mapali <f>'
    inputBinding:
      position: 101
      prefix: --mapstr
  - id: noss
    type:
      - 'null'
      - boolean
    doc: 'cmbuild --noss option was used w/aln from --mapali <f>'
    inputBinding:
      position: 101
      prefix: --noss
  - id: informat
    type:
      - 'null'
      - string
    doc: 'assert <seqfile> is in format <s>: no autodetection'
    inputBinding:
      position: 101
      prefix: --informat
  - id: outformat
    type:
      - 'null'
      - string
    doc: 'output alignment in format <s> [Stockholm]'
    inputBinding:
      position: 101
      prefix: --outformat
  - id: dnaout
    type:
      - 'null'
      - boolean
    doc: 'output alignment as DNA (not RNA) sequence data'
    inputBinding:
      position: 101
      prefix: --dnaout
  - id: noprob
    type:
      - 'null'
      - boolean
    doc: 'do not include posterior probabilities in the alignment'
    inputBinding:
      position: 101
      prefix: --noprob
  - id: matchonly
    type:
      - 'null'
      - boolean
    doc: 'include only match columns in output alignment'
    inputBinding:
      position: 101
      prefix: --matchonly
  - id: miss
    type:
      - 'null'
      - boolean
    doc: 'mark seqs w/terminal gaps as fragments w/missing (~) chars'
    inputBinding:
      position: 101
      prefix: --miss
  - id: ileaved
    type:
      - 'null'
      - boolean
    doc: 'force output in interleaved Stockholm format'
    inputBinding:
      position: 101
      prefix: --ileaved
  - id: flanktoins
    type:
      - 'null'
      - float
    doc: 'change transition probs into ROOT_IL/IR to <x> (e.g. 0.1)'
    inputBinding:
      position: 101
      prefix: --flanktoins
  - id: flankselfins
    type:
      - 'null'
      - float
    doc: 'change self transit probs for ROOT_IL/IR to <x> (e.g. 0.8)'
    inputBinding:
      position: 101
      prefix: --flankselfins
  - id: regress
    type:
      - 'null'
      - string
    doc: 'save regression test data to file <f>'
    inputBinding:
      position: 101
      prefix: --regress
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: 'report extra information; mainly useful for debugging'
    inputBinding:
      position: 101
      prefix: --verbose
  - id: cpu
    type:
      - 'null'
      - int
    doc: 'number of parallel CPU workers to use for multithreads [4]'
    inputBinding:
      position: 101
      prefix: --cpu
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_outfile
    type:
      - 'null'
      - File
    doc: 'output the alignment to file <f>, not stdout'
    outputBinding:
      glob: $(inputs.outfile)
  - id: output_sfile
    type:
      - 'null'
      - File
    doc: 'dump alignment score information to file <f>'
    outputBinding:
      glob: $(inputs.sfile)
  - id: output_tfile
    type:
      - 'null'
      - File
    doc: 'dump individual sequence parsetrees to file <f>'
    outputBinding:
      glob: $(inputs.tfile)
  - id: output_ifile
    type:
      - 'null'
      - File
    doc: 'dump information on per-sequence inserts to file <f>'
    outputBinding:
      glob: $(inputs.ifile)
  - id: output_elfile
    type:
      - 'null'
      - File
    doc: 'dump information on per-sequence EL inserts to file <f>'
    outputBinding:
      glob: $(inputs.elfile)
  - id: output_regress
    type:
      - 'null'
      - File
    doc: 'save regression test data to file <f>'
    outputBinding:
      glob: $(inputs.regress)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/infernal:1.1.5--pl5321h7b50bb2_4
stdout: infernal_cmalign.out
