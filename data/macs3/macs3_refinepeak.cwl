cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - macs3
  - refinepeak
label: macs3_refinepeak
doc: Refine peak summits and compute enrichment scores using MACS3
inputs:
  - id: bed_file
    type: File
    doc: Candidate peak file in BED format. REQUIRED.
    inputBinding:
      position: 101
      prefix: -b
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: Buffer size for incrementally increasing internal array size to store 
      reads alignment information.
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: cutoff
    type:
      - 'null'
      - int
    doc: Cutoff. Regions with SPP wtd score lower than cutoff will not be 
      considerred.
    inputBinding:
      position: 101
      prefix: --cutoff
  - id: format
    type:
      - 'null'
      - string
    doc: Format of tag file, "AUTO", "BED" or "ELAND" or "ELANDMULTI" or 
      "ELANDEXPORT" or "SAM" or "BAM" or "BOWTIE".
    inputBinding:
      position: 101
      prefix: --format
  - id: ifile
    type:
      type: array
      items: File
    doc: ChIP-seq alignment file. If multiple files are given as '-t A B C', 
      then they will all be read and combined. Note that pair-end data is not 
      supposed to work with this command. REQUIRED.
    inputBinding:
      position: 101
      prefix: --ifile
  - id: o_prefix
    type:
      - 'null'
      - string
    doc: Output file prefix. Mutually exclusive with -o/--ofile.
    inputBinding:
      position: 101
      prefix: --o-prefix
  - id: ofile
    type: string
    doc: Output file name. Mutually exclusive with --o-prefix.
    inputBinding:
      position: 101
      prefix: --ofile
  - id: outdir
    type: string
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    inputBinding:
      position: 101
      prefix: --outdir
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Scan window size on both side of the summit (default: 100bp)'
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: output_outdir
    type:
      - 'null'
      - Directory
    doc: 'If specified all output files will be written to that directory. Default:
      the current working directory'
    outputBinding:
      glob: $(inputs.outdir)
  - id: output_ofile
    type:
      - 'null'
      - File
    doc: Output file name. Mutually exclusive with --o-prefix.
    outputBinding:
      glob: $(inputs.ofile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/macs3:3.0.4--py310h5a5e57a_0
s:url: https://pypi.org/project/MACS3/
$namespaces:
  s: https://schema.org/
