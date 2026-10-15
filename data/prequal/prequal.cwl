cwlVersion: v1.2
class: CommandLineTool
baseCommand: prequal
label: prequal
doc: "PREQUAL v.1.02\n\nTool homepage: https://github.com/simonwhelan/prequal"
inputs:
  - id: input_file
    type: File
    doc: Input file with unaligned sequences (FASTA); staged writable because the
      tool writes its outputs next to it
    inputBinding:
      position: 200
      valueFrom: $(self.basename)
  - id: corerun
    type:
      - 'null'
      - int
    doc: "X number of high posterior residues at beginning and end before a core
      region is defined [DEFAULT 3]"
    inputBinding:
      position: 102
      prefix: -corerun
  - id: nocore
    type:
      - 'null'
      - boolean
    doc: No core region will be defined [DEFAULT uses core region]
    inputBinding:
      position: 102
      prefix: -nocore
  - id: removeall
    type:
      - 'null'
      - boolean
    doc: Remove all residues rather than those outside the core region [DEFAULT
      residues in core filtered with X]
    inputBinding:
      position: 102
      prefix: -removeall
  - id: corefilter
    type:
      - 'null'
      - string
    doc: The character outputted in the core for the filtered alignment [DEFAULT is X]
    inputBinding:
      position: 102
      prefix: -corefilter
  - id: noremoverepeat
    type:
      - 'null'
      - boolean
    doc: Do not remove repeated regions of length >20. Repeats break PPs!
    inputBinding:
      position: 102
      prefix: -noremoverepeat
  - id: nodna
    type:
      - 'null'
      - boolean
    doc: Enforces banning of dna sequences. The program will fail if only DNA is input.
    inputBinding:
      position: 102
      prefix: -nodna
  - id: forceuniversal
    type:
      - 'null'
      - boolean
    doc: Enforces the usage of the universal code. Internal stop codons will be
      replaced with X for other codes.
    inputBinding:
      position: 102
      prefix: -forceuniversal
  - id: outsuffix
    type:
      - 'null'
      - string
    doc: Output file will be the original name with X as a suffix [DEFAULT .filtered]
    inputBinding:
      position: 102
      prefix: -outsuffix
  - id: dosummary
    type:
      - 'null'
      - boolean
    doc: Output summary statistics to file suffixed with .summary
    inputBinding:
      position: 102
      prefix: -dosummary
  - id: dodetail
    type:
      - 'null'
      - boolean
    doc: Output detailed statistics to file suffixed with .detail
    inputBinding:
      position: 102
      prefix: -dodetail
  - id: noPP
    type:
      - 'null'
      - boolean
    doc: Stop outputting the posterior probability matrix
    inputBinding:
      position: 102
      prefix: -noPP
  - id: pptype
    type:
      - 'null'
      - string
    doc: "Specify the algorithm used to calculate posterior probabilities: all (all
      against all sequence comparisons), closest (Y closest relatives [DEFAULT;
      Y = 10]) or longest (compare the Y longest sequences [Y = 10])"
    inputBinding:
      position: 102
      prefix: -pptype
  - id: pptype_y
    type:
      - 'null'
      - int
    doc: Number of closest or longest sequences for the pptype option (Y)
    inputBinding:
      position: 103
  - id: filterprop
    type:
      - 'null'
      - float
    doc: Filter the sequences so that in total X proportion (range 0.0 - 1.0) of
      the sequences are maintained. This can be used to tune filtering.
    inputBinding:
      position: 102
      prefix: -filterprop
  - id: filterthresh
    type:
      - 'null'
      - float
    doc: "Filter the sequences to the posterior probabilities threshold X [DEFAULT
      = 0.994] (range 0.0 - 1.0). DEFAULT filtering option with threshold"
    inputBinding:
      position: 102
      prefix: -filterthresh
  - id: filterjoin
    type:
      - 'null'
      - int
    doc: Extend filtering over regions of unfiltered sequence less than X [DEFAULT
      X = 10]
    inputBinding:
      position: 102
      prefix: -filterjoin
  - id: nofilterlist
    type:
      - 'null'
      - File
    doc: Specify a file X that contains a list of taxa names that will not be
      filtered. In X one name per line.
    inputBinding:
      position: 102
      prefix: -nofilterlist
  - id: nofilterword
    type:
      - 'null'
      - File
    doc: Specify a file X that contains a list of words and sequence names that
      contain those words will not be filtered. In X one word per line.
    inputBinding:
      position: 102
      prefix: -nofilterword
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_files
    type:
      type: array
      items: File
    doc: Filtered sequences (input name plus .filtered or the outsuffix) and the
      PP, summary and detail files
    outputBinding:
      glob:
        - "$(inputs.input_file.basename + (inputs.outsuffix ? inputs.outsuffix : '.filtered'))*"
        - $(inputs.input_file.basename).summary
        - $(inputs.input_file.basename).detail
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prequal:1.02--hb97b32f_2
stdout: prequal.out
