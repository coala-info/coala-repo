cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pandora
  - get_vcf_ref
label: pandora_get_vcf_ref
doc: "Outputs a fasta suitable for use as the VCF reference using input sequences\n
  \nTool homepage: https://github.com/rmcolq/pandora"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [{entry: inputs.prg, writable: true}];
        if (inputs.kmer_prgs) { l.push({entry: inputs.kmer_prgs, writable: true}); }
        return l;
      }
inputs:
  - id: prg
    type: File
    doc: PRG to index (in fasta format)
    inputBinding:
      position: 1
  - id: query
    type:
      - 'null'
      - File
    doc: Fast{a,q} file of sequences to retrive the PRG reference for
    inputBinding:
      position: 2
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress the output with gzip
    inputBinding:
      position: 103
      prefix: --compress
  - id: verbosity
    type:
      - 'null'
      - boolean
    doc: Verbosity of logging
    inputBinding:
      position: 103
      prefix: -v
  - id: kmer_prgs
    type:
      - 'null'
      - Directory
    doc: The kmer_prgs directory made by pandora index (staged beside the PRG)
outputs:
  - id: vcf_ref
    type: File
    doc: Fasta suitable for use as the VCF reference, written by pandora to <PRG>.vcf_ref.fa.gz
    outputBinding:
      glob: $(inputs.prg.basename).vcf_ref.fa*
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pandora:0.9.2--h4ac6f70_0
stdout: pandora_get_vcf_ref.out
