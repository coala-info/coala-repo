cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks-integrate-alignments
label: stacks_stacks-integrate-alignments
doc: "Extract the coordinates of the RAD loci from a BAM file into locus_coordinates.tsv and rewrite catalog.fa.gz and catalog.calls with the genomic coordinates.

Tool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs:
  - id: in_path
    type: Directory
    doc: "Path to a directory containing Stacks output files."
    inputBinding:
      position: 101
      prefix: -P
  - id: bam_path
    type: File
    doc: "Path to a SAM or BAM file containing alignment of de novo catalog loci to a reference genome."
    inputBinding:
      position: 101
      prefix: -B
  - id: min_mapq
    type:
      - 'null'
      - int
    doc: "Minimum mapping quality as listed in the BAM file (default 20)."
    inputBinding:
      position: 101
      prefix: -q
  - id: min_alncov
    type:
      - 'null'
      - float
    doc: "Minimum fraction of the de novo catalog locus that must participate in the alignment (default 0.6)."
    inputBinding:
      position: 101
      prefix: -a
  - id: min_pctid
    type:
      - 'null'
      - float
    doc: "Minimum BLAST-style percent identity of the largest alignment fragment for a de novo catalog locus (default 0.6)."
    inputBinding:
      position: 101
      prefix: -p
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Provide verbose output."
    inputBinding:
      position: 101
      prefix: --verbose
  - id: out_path
    type: string
    doc: "Path to write the integrated output files."
    inputBinding:
      position: 102
      prefix: -O
outputs:
  - id: output_dir
    type: Directory
    doc: Integrated output files
    outputBinding:
      glob: $(inputs.out_path)
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.out_path) { l.push({"entryname": inputs.out_path, "entry": {"class": "Directory", "listing": []}, "writable": true}); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_stacks-integrate-alignments.out
