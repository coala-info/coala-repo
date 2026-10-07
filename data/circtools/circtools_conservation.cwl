cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - circtools
  - conservation
label: circtools_conservation
doc: "circular RNA conservation analysis (fetches orthologs from the Ensembl REST service)\n\nTool homepage: https://github.com/dieterich-lab/circtools"
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
    type:
      - 'null'
      - File
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
  - id: config
    type:
      - 'null'
      - File
    doc: 'config file containing species with their IDs required for different settings'
    inputBinding:
      position: 101
      prefix: -C
  - id: organism
    type:
      - 'null'
      - string
    doc: 'Organism of the study: mm, rn, hs, ss or cl'
    inputBinding:
      position: 101
      prefix: -O
  - id: target_species
    type:
      - 'null'
      - string
    doc: 'Target species to be used to calculate conservation score'
    inputBinding:
      position: 101
      prefix: -TS
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
  - id: gene_list_file
    type:
      - 'null'
      - type: array
        items: File
    doc: 'File containing gene names for which primers need to be designed. Need to provide this if -G option not provided'
    inputBinding:
      position: 101
      prefix: -GL
  - id: hg19
    type:
      - 'null'
      - boolean
    doc: 'Given circular coordinates for human are from hg19 and will be converted into hg38'
    inputBinding:
      position: 101
      prefix: -hg19
  - id: mm10
    type:
      - 'null'
      - boolean
    doc: 'Given circular coordinates for mouse are from mm10 and will be converted into mm39'
    inputBinding:
      position: 101
      prefix: -mm10
  - id: pairwise_flag
    type:
      - 'null'
      - boolean
    doc: 'Should pairwise alignments be performed as well? Additional barplot will be plotted in this case.'
    inputBinding:
      position: 101
      prefix: -pairwise_flag
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
stdout: circtools_conservation.out
