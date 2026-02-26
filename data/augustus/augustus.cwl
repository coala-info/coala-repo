cwlVersion: v1.2
class: CommandLineTool
baseCommand: augustus
label: augustus
doc: "AUGUSTUS (3.5.0) is a gene prediction tool.\n\nTool homepage: http://bioinf.uni-greifswald.de/augustus/"
inputs:
  - id: query_filename
    type: File
    doc: "'queryfilename' is the filename (including relative path) to the file containing
      the query sequence(s) in fasta format."
    inputBinding:
      position: 1
  - id: alternatives_from_evidence
    type:
      - 'null'
      - boolean
    doc: report alternative transcripts when they are suggested by hints
    inputBinding:
      position: 102
      prefix: --alternatives-from-evidence
  - id: alternatives_from_sampling
    type:
      - 'null'
      - boolean
    doc: report alternative transcripts generated through probabilistic sampling
    inputBinding:
      position: 102
      prefix: --alternatives-from-sampling
  - id: augustus_config_path
    type:
      - 'null'
      - Directory
    doc: path to config directory (if not specified as environment variable)
    inputBinding:
      position: 102
      prefix: --AUGUSTUS_CONFIG_PATH
  - id: genemodel
    type:
      - 'null'
      - string
    doc: partial, intronless, complete, atleastone or exactlyone
    default: partial
    inputBinding:
      position: 102
      prefix: --genemodel
  - id: gff3
    type:
      - 'null'
      - boolean
    doc: output in gff3 format
    inputBinding:
      position: 102
      prefix: --gff3
  - id: hintsfile
    type:
      - 'null'
      - File
    doc: When this option is used the prediction considering hints (extrinsic 
      information) is turned on. hintsfilename contains the hints in gff format.
    inputBinding:
      position: 102
      prefix: --hintsfile
  - id: maxtracks
    type:
      - 'null'
      - int
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --maxtracks
  - id: minexonintronprob
    type:
      - 'null'
      - float
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --minexonintronprob
  - id: minmeanexonintronprob
    type:
      - 'null'
      - float
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --minmeanexonintronprob
  - id: no_in_frame_stop
    type:
      - 'null'
      - boolean
    doc: 'Do not report transcripts with in-frame stop codons. Otherwise, intron-spanning
      stop codons could occur. Default: false'
    default: false
    inputBinding:
      position: 102
      prefix: --noInFrameStop
  - id: noprediction
    type:
      - 'null'
      - boolean
    doc: If true and input is in genbank format, no prediction is made. Useful 
      for getting the annotated protein sequences.
    inputBinding:
      position: 102
      prefix: --noprediction
  - id: prediction_end
    type:
      - 'null'
      - int
    doc: A and B define the range of the sequence for which predictions should 
      be found.
    inputBinding:
      position: 102
      prefix: --predictionEnd
  - id: prediction_start
    type:
      - 'null'
      - int
    doc: A and B define the range of the sequence for which predictions should 
      be found.
    inputBinding:
      position: 102
      prefix: --predictionStart
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show a progressmeter
    default: false
    inputBinding:
      position: 102
      prefix: --progress
  - id: proteinprofile
    type:
      - 'null'
      - File
    doc: When this option is used the prediction will consider the protein 
      profile provided as parameter. The protein profile extension is described 
      in section 5 of RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --proteinprofile
  - id: sample
    type:
      - 'null'
      - int
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --sample
  - id: singlestrand
    type:
      - 'null'
      - boolean
    doc: predict genes independently on each strand, allow overlapping genes on 
      opposite strands
    default: false
    inputBinding:
      position: 102
      prefix: --singlestrand
  - id: species
    type: string
    doc: SPECIES is an identifier for the species. Use --species=help to see a 
      list.
    inputBinding:
      position: 102
      prefix: --species
  - id: strand
    type:
      - 'null'
      - string
    doc: both, forward or backward
    default: both
    inputBinding:
      position: 102
      prefix: --strand
  - id: testing_testmode
    type:
      - 'null'
      - string
    doc: 'prepare: prepare a new minimal data set to test comparative Augustus; intronless:
      run prediction over some given minimal data set'
    inputBinding:
      position: 102
      prefix: --/Testing/testMode
  - id: unique_gene_id
    type:
      - 'null'
      - boolean
    doc: 'If true, output gene identifyers like this: seqname.gN'
    inputBinding:
      position: 102
      prefix: --uniqueGeneId
  - id: utr
    type:
      - 'null'
      - boolean
    doc: predict the untranslated regions in addition to the coding sequence. 
      This currently works only for a subset of species.
    inputBinding:
      position: 102
      prefix: --UTR
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augustus:3.5.0--pl5321h9716f88_9
stdout: augustus.out
