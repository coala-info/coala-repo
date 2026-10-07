cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - primex
label: circtools_primex
doc: "circular RNA primer design\n\nTool homepage: https://github.com/dieterich-lab/circtools"
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |-
      ${
        var l = [];
        if (inputs.output_dir) { l.push({"class": "Directory", "basename": inputs.output_dir.replace(/\/+$/, ""), "listing": [], "writable": true}); }
        if (inputs.temp_dir) { l.push({"class": "Directory", "basename": inputs.temp_dir.replace(/\/+$/, ""), "listing": [], "writable": true}); }
        return l;
      }
inputs:
  - id: detect_dir
    type: File
    doc: 'CircCoordinates file from circtools detect module'
    inputBinding:
      position: 101
      prefix: -d
  - id: gtf_file
    type: File
    doc: 'GTF file of genome annotation e.g. ENSEMBL'
    inputBinding:
      position: 101
      prefix: -g
  - id: fasta_file
    type: File
    secondaryFiles:
      - .fai
    doc: 'FASTA file with genome sequence (must match annotation)'
    inputBinding:
      position: 101
      prefix: -f
  - id: organism
    type:
      - 'null'
      - string
    doc: 'Organism of the study (used for primer BLASTing): mm, rn, hs or ss'
    inputBinding:
      position: 101
      prefix: -O
  - id: sequence_file
    type:
      - 'null'
      - File
    doc: 'FASTA file containing the circRNA sequence (exons and introns)'
    inputBinding:
      position: 101
      prefix: -s
  - id: output_dir
    type:
      - 'null'
      - string
    doc: 'Output directory (created in the working directory; passed with a trailing slash)'
    inputBinding:
      position: 101
      prefix: -o
      valueFrom: '$(self)/'
  - id: title
    type:
      - 'null'
      - string
    doc: 'Title of the experiment for HTML output and file name'
    inputBinding:
      position: 101
      prefix: -T
  - id: temp_dir
    type:
      - 'null'
      - string
    doc: 'Temporary directory (created in the working directory)'
    inputBinding:
      position: 101
      prefix: -t
      valueFrom: '$(self)/'
  - id: gene_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of host gene names, e.g. CAMSAP1 RYR2'
    inputBinding:
      position: 101
      prefix: -G
  - id: id_list
    type:
      - 'null'
      - type: array
        items: string
    doc: 'Space-separated list of circRNA IDs, e.g. CAMSAP1_9_135850137_135850461_-'
    inputBinding:
      position: 101
      prefix: -i
  - id: product_size
    type:
      - 'null'
      - type: array
        items: int
    doc: 'Space-separated range for the desired PCR product. E.g. -p 80 160 [default]'
    inputBinding:
      position: 101
      prefix: -p
  - id: junction
    type:
      - 'null'
      - string
    doc: 'Should the forward [f] or reverse [r] primer be located on the BSJ? (r, n or f) [Default: n]'
    inputBinding:
      position: 101
      prefix: -j
  - id: no_blast
    type:
      - 'null'
      - boolean
    doc: 'Do not BLAST the primers (BLAST uses the NCBI web service)'
    inputBinding:
      position: 101
      prefix: -b
  - id: num_pairs
    type:
      - 'null'
      - int
    doc: 'Number of primer pairs to be designed'
    inputBinding:
      position: 101
      prefix: -n
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: output_dir_dir
    type:
      - 'null'
      - Directory
    doc: 'Output directory'
    outputBinding:
      glob: $(inputs.output_dir)
  - id: html_files
    type:
      type: array
      items: File
    doc: HTML reports (written to the working directory when no output directory is given)
    outputBinding:
      glob: '*.html'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/circtools:2.0.4--pyhdfd78af_0
stdout: circtools_primex.out
