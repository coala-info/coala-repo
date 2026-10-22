cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scTagger.py, extract_sr_bc_from_lr]
label: sctagger_extract_sr_bc_from_lr
doc: "Build a list of cellular barcodes directly from the long-read segments by exact matches to a 10x barcode whitelist\n\nTool homepage: https://github.com/vpc-ccg/sctagger"
inputs:
  - id: input
    type: File
    doc: "Input TSV file generated from the extract_lr_bc step"
    inputBinding:
      prefix: -i
  - id: outfile
    type: ['null', string]
    doc: "Path to output file. The file is gzipped, so name it .tsv.gz for scTagger match_trie. Default: STDOUT"
    inputBinding:
      prefix: -o
  - id: barcode_whitelist
    type: File
    doc: "Path to TXT barcode whitelist such as the 10x Chromium v3 3M-february-2018.txt.gz barcode file"
    inputBinding:
      prefix: -wl
  - id: thresh
    type: ['null', double]
    doc: "Percentage theshold required per step to continue adding read barcodes. Default: 0.005"
    inputBinding:
      prefix: --thresh
  - id: step_size
    type: ['null', int]
    doc: "Number of barcodes processed at a time and whose sum is used to check against the theshold. Default: 1000"
    inputBinding:
      prefix: --step-size
  - id: max_barcode_cnt
    type: ['null', int]
    doc: "Max number of barcodes to keep. Default: 25000"
    inputBinding:
      prefix: --max-barcode-cnt
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (used when no output file is given)
  - id: output_file
    type: ['null', File]
    doc: Output file written with the output option
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sctagger:1.1.1--hdfd78af_0
stdout: sctagger_extract_sr_bc_from_lr.out
