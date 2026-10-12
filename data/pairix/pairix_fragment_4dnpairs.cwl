cwlVersion: v1.2
class: CommandLineTool
baseCommand: fragment_4dnpairs.pl
label: pairix_fragment_4dnpairs
doc: "Add restriction-fragment columns (frag1, frag2) to a 4DN pairs file in
  intermediate format.\n\nTool homepage: https://github.com/4dn-dcic/pairix"
inputs:
  - id: allow_replacement
    type:
      - 'null'
      - boolean
    doc: Allow replacing existing frag1/frag2 columns (default is to abort if the columns already exist)
    inputBinding:
      position: 1
      prefix: --allow-replacement
  - id: infile
    type: File
    doc: File in intermediate format to calculate statistics on
    inputBinding:
      position: 2
  - id: outfile
    type: string
    doc: Output file name, results of the fragment search
    inputBinding:
      position: 3
  - id: site_file
    type: File
    doc: List of restriction sites, one line per chromosome (the built-in default path
      /opt/juicer/restriction_sites/hg19_DpnII.txt does not exist in this image)
    inputBinding:
      position: 4
outputs:
  - id: fragment_pairs
    type: File
    doc: Pairs file with fragment columns
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairix:0.3.9--py312h4711d71_0
