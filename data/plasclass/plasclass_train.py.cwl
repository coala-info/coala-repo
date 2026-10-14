cwlVersion: v1.2
class: CommandLineTool
baseCommand: train.py
label: plasclass_train.py
doc: "Train new models for the PlasClass classifier from plasmid and chromosome reference sequences. The PYTHONPATH setting lets train.py find its plasclass_utils module in the image.\n\nTool homepage: https://github.com/Shamir-Lab/PlasClass"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.outdir_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/lib/python3.7/site-packages/plasclass
inputs:
  - id: plasmid
    type: File
    doc: 'plasmid file - file of plasmid reference sequences'
    inputBinding:
      position: 101
      prefix: --plasmid
  - id: chromosome
    type: File
    doc: 'chromosome file - file of chromosome reference sequences'
    inputBinding:
      position: 101
      prefix: --chromosome
  - id: num_processes
    type:
      - 'null'
      - int
    doc: 'number of processes to use (default 16)'
    inputBinding:
      position: 101
      prefix: --num_processes
  - id: kmers
    type:
      - 'null'
      - string
    doc: 'comma-separated list of k-mer lengths (default 3,4,5,6,7)'
    inputBinding:
      position: 101
      prefix: --kmers
  - id: lengths
    type:
      - 'null'
      - string
    doc: 'comma-separated list of sequence length bins (default 1000,10000,100000,500000)'
    inputBinding:
      position: 101
      prefix: --lengths
  - id: outdir_path
    type: string
    doc: 'output directory'
    inputBinding:
      position: 102
      prefix: --outdir
outputs:
  - id: outdir
    type: Directory
    doc: 'Directory with the trained models'
    outputBinding:
      glob: $(inputs.outdir_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/plasclass:0.1.1--pyhdfd78af_0
