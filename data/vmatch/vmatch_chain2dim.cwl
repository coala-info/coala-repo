cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chain2dim
label: vmatch_chain2dim
doc: "Compute chains of matches (two-dimensional chaining) from a Vmatch match file in open format (see Vmatchtrans.pl open).

Tool homepage: http://www.vmatch.de/"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: matchfile
    type: File
    doc: "Match file in open format, e.g. written by Vmatchtrans.pl open"
    inputBinding:
      position: 200
  - id: global_chain
    type:
      - 'null'
      - boolean
    doc: "global chaining"
    inputBinding:
      position: 1
      prefix: -global
  - id: global_gc
    type:
      - 'null'
      - boolean
    doc: "switch on gap costs (L1-model) for global chaining; use with global_chain"
    inputBinding:
      position: 2
      valueFrom: "${ return self ? \"gc\" : null; }"
  - id: global_ov
    type:
      - 'null'
      - boolean
    doc: "allow overlaps between matches in global chaining; use with global_chain"
    inputBinding:
      position: 2
      valueFrom: "${ return self ? \"ov\" : null; }"
  - id: local_chain
    type:
      - 'null'
      - boolean
    doc: "compute local chains (L1-model); maximum score chains unless local_param is given"
    inputBinding:
      position: 3
      prefix: -local
  - id: local_param
    type:
      - 'null'
      - string
    doc: "parameter of local chaining: a positive number k, optionally followed by b or p"
    inputBinding:
      position: 4
  - id: wf
    type:
      - 'null'
      - float
    doc: "specify weight factor > 0.0 to obtain the score of a fragment (requires local or global gc/ov chaining)"
    inputBinding:
      position: 101
      prefix: -wf
  - id: maxgap
    type:
      - 'null'
      - int
    doc: "maximal width of gap in chain"
    inputBinding:
      position: 101
      prefix: -maxgap
  - id: outprefix
    type:
      - 'null'
      - string
    doc: "specify prefix of files to output chains"
    inputBinding:
      position: 101
      prefix: -outprefix
  - id: withinborders
    type:
      - 'null'
      - boolean
    doc: "only compute chains which do not cross sequence borders"
    inputBinding:
      position: 101
      prefix: -withinborders
  - id: thread
    type:
      - 'null'
      - boolean
    doc: "thread the chains, i.e. close the gaps"
    inputBinding:
      position: 5
      prefix: -thread
  - id: thread_keywords
    type:
      - 'null'
      - string[]
    doc: "keywords minlen1 minlen2 maxerror1 maxerror2, each followed by a number; use with thread"
    inputBinding:
      position: 6
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "do not output the chains and only report their lengths and scores"
    inputBinding:
      position: 101
      prefix: -silent
  - id: v
    type:
      - 'null'
      - boolean
    doc: "be verbose"
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: chain_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Chain files written with the given prefix
    outputBinding:
      glob: $(inputs.outprefix)*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_chain2dim.out
