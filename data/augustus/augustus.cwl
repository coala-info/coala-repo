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
      prefix: --alternatives-from-evidence=true
  - id: alternatives_from_sampling
    type:
      - 'null'
      - boolean
    doc: report alternative transcripts generated through probabilistic sampling
    inputBinding:
      position: 102
      prefix: --alternatives-from-sampling=true
  - id: augustus_config_path
    type:
      - 'null'
      - Directory
    doc: path to config directory (if not specified as environment variable)
    inputBinding:
      position: 102
      prefix: --AUGUSTUS_CONFIG_PATH=
      separate: false
  - id: genemodel
    type:
      - 'null'
      - string
    doc: partial, intronless, complete, atleastone or exactlyone
    inputBinding:
      position: 102
      prefix: --genemodel=
      separate: false
  - id: gff3
    type:
      - 'null'
      - boolean
    doc: output in gff3 format
    inputBinding:
      position: 102
      prefix: --gff3=on
  - id: hintsfile
    type:
      - 'null'
      - File
    doc: When this option is used the prediction considering hints (extrinsic 
      information) is turned on. hintsfilename contains the hints in gff format.
    inputBinding:
      position: 102
      prefix: --hintsfile=
      separate: false
  - id: maxtracks
    type:
      - 'null'
      - int
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --maxtracks=
      separate: false
  - id: minexonintronprob
    type:
      - 'null'
      - float
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --minexonintronprob=
      separate: false
  - id: minmeanexonintronprob
    type:
      - 'null'
      - float
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --minmeanexonintronprob=
      separate: false
  - id: no_in_frame_stop
    type:
      - 'null'
      - boolean
    doc: 'Do not report transcripts with in-frame stop codons. Otherwise, intron-spanning
      stop codons could occur. Default: false'
    inputBinding:
      position: 102
      prefix: --noInFrameStop=true
  - id: noprediction
    type:
      - 'null'
      - boolean
    doc: If true and input is in genbank format, no prediction is made. Useful 
      for getting the annotated protein sequences.
    inputBinding:
      position: 102
      prefix: --noprediction=true
  - id: prediction_end
    type:
      - 'null'
      - int
    doc: A and B define the range of the sequence for which predictions should 
      be found.
    inputBinding:
      position: 102
      prefix: --predictionEnd=
      separate: false
  - id: prediction_start
    type:
      - 'null'
      - int
    doc: A and B define the range of the sequence for which predictions should 
      be found.
    inputBinding:
      position: 102
      prefix: --predictionStart=
      separate: false
  - id: progress
    type:
      - 'null'
      - boolean
    doc: show a progressmeter
    inputBinding:
      position: 102
      prefix: --progress=true
  - id: proteinprofile
    type:
      - 'null'
      - File
    doc: When this option is used the prediction will consider the protein 
      profile provided as parameter. The protein profile extension is described 
      in section 5 of RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --proteinprofile=
      separate: false
  - id: sample
    type:
      - 'null'
      - int
    doc: For a description of these parameters see section 2 of 
      RUNNING-AUGUSTUS.md.
    inputBinding:
      position: 102
      prefix: --sample=
      separate: false
  - id: singlestrand
    type:
      - 'null'
      - boolean
    doc: predict genes independently on each strand, allow overlapping genes on 
      opposite strands
    inputBinding:
      position: 102
      prefix: --singlestrand=true
  - id: softmasking
    type:
      - 'null'
      - string
    doc: 'True/False (from --paramlist). Treat lower-case (softmasked) bases as nonexonpart
      hints. The default depends on the species config.'
    inputBinding:
      position: 102
      prefix: --softmasking=
      separate: false
  - id: species
    type: string
    doc: SPECIES is an identifier for the species. Use --species=help to see a 
      list.
    inputBinding:
      position: 102
      prefix: --species=
      separate: false
  - id: strand
    type:
      - 'null'
      - string
    doc: both, forward or backward
    inputBinding:
      position: 102
      prefix: --strand=
      separate: false
  - id: testing_testmode
    type:
      - 'null'
      - string
    doc: 'prepare: prepare a new minimal data set to test comparative Augustus; intronless:
      run prediction over some given minimal data set'
    inputBinding:
      position: 102
      prefix: --/Testing/testMode=
      separate: false
  - id: unique_gene_id
    type:
      - 'null'
      - boolean
    doc: 'If true, output gene identifyers like this: seqname.gN'
    inputBinding:
      position: 102
      prefix: --uniqueGeneId=true
  - id: utr
    type:
      - 'null'
      - boolean
    doc: predict the untranslated regions in addition to the coding sequence. 
      This currently works only for a subset of species.
    inputBinding:
      position: 102
      prefix: --UTR=on
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/augustus:3.5.0--pl5321h9716f88_9
stdout: augustus.out
