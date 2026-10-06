cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedparse
  - convertChr
label: bedparse_convertchr
doc: "Convert chromosome names between UCSC and Ensembl formats. The conversion\n\
  supports the hg38 assembly up to patch 11 and the mm10 assembly up to patch 4.\n\
  By default patches are not converted, but can be enabled using the -p flag.\n\
  Unrecognised chromosomes stop the program by default; they can be suppressed\n\
  (-s) or set to 'NA' (-a).\n\nTool homepage: https://github.com/tleonardi/bedparse"
inputs:
  - id: bedfile
    type:
      - 'null'
      - File
    doc: Path to the BED file.
    inputBinding:
      position: 1
  - id: assembly
    type: string
    doc: Assembly of the BED file (either hg38 or mm10).
    inputBinding:
      position: 102
      prefix: --assembly
  - id: target
    type: string
    doc: Desidered chromosome name convention (ucsc or ens).
    inputBinding:
      position: 102
      prefix: --target
  - id: allow_missing
    type:
      - 'null'
      - boolean
    doc: When a chromosome name can't be matched between USCS and Ensembl set it
      to 'NA' (by default thrown as error).
    inputBinding:
      position: 102
      prefix: --allowMissing
  - id: suppress_missing
    type:
      - 'null'
      - boolean
    doc: When a chromosome name can't be matched between USCS and Ensembl do not
      report it in the output (by default throws an error).
    inputBinding:
      position: 102
      prefix: --suppressMissing
  - id: patches
    type:
      - 'null'
      - boolean
    doc: Allows conversion of all patches up to p11 for hg38 and p4 for mm10.
    inputBinding:
      position: 102
      prefix: --patches
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedparse:0.2.3--py_0
stdout: bedparse_convertchr.out
