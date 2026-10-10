cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - metaeuk
  - groupstoacc
label: metaeuk_groupstoacc
doc: "Replace the internal contig, target and strand identifiers with accessions from
  the headers\n\nTool homepage: https://github.com/soedinglab/metaeuk"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.contigsDB)
      - $(inputs.targetsDB)
      - $(inputs.predToCall)
inputs:
  - id: contigsDB
    type: 'File[]'
    doc: Input contigs database. All files of the MetaEuk database (name, .index, .dbtype,
      .lookup, _h, ... or the split data parts), staged together in the working directory.
    inputBinding:
      position: 1
      valueFrom: |-
        ${ var names = self.map(function(f){return f.basename;}).filter(function(b){return /\.dbtype$/.test(b) && !/_h\.dbtype$/.test(b);}); return names[0].replace(/\.dbtype$/, ''); }
  - id: targetsDB
    type: 'File[]'
    doc: Input targets database. All files of the MetaEuk database (name, .index, .dbtype,
      .lookup, _h, ... or the split data parts), staged together in the working directory.
    inputBinding:
      position: 2
      valueFrom: |-
        ${ var names = self.map(function(f){return f.basename;}).filter(function(b){return /\.dbtype$/.test(b) && !/_h\.dbtype$/.test(b);}); return names[0].replace(/\.dbtype$/, ''); }
  - id: predToCall
    type: 'File[]'
    doc: Input prediction-to-call database. All files of the MetaEuk database (name, .index, .dbtype,
      .lookup, _h, ... or the split data parts), staged together in the working directory.
    inputBinding:
      position: 3
      valueFrom: |-
        ${ var names = self.map(function(f){return f.basename;}).filter(function(b){return /\.dbtype$/.test(b) && !/_h\.dbtype$/.test(b);}); return names[0].replace(/\.dbtype$/, ''); }
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of CPU-cores used (all by default)
    inputBinding:
      position: 104
      prefix: --threads
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: 'Verbosity level: 0: quiet, 1: +errors, 2: +warnings, 3: +info'
    inputBinding:
      position: 104
      prefix: -v
  - id: pred_to_call_info_tsv
    type: string
    doc: Output prediction to call info TSV file
    inputBinding:
      position: 4
outputs:
  - id: predToCallInfoTSV
    type: File
    doc: Output prediction to call info TSV file
    outputBinding:
      glob: '$(inputs.pred_to_call_info_tsv)'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaeuk:7.bba0d80--pl5321hd6d6fdc_2
