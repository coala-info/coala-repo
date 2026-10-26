cwlVersion: v1.2
class: CommandLineTool
baseCommand: uniqsketch
label: uniqsketch
doc: "Creates unique sketch from a list of fasta reference files. A list of files
  containing file names in each row can be passed with @ prefix.\n\nTool homepage:
  https://github.com/amazon-science/uniqsketch"
inputs:
  - id: list_files
    type:
      - 'null'
      - File
    doc: A list of files containing file names in each row (passed with the @ prefix)
    inputBinding:
      position: 1
      valueFrom: '@$(self.basename)'
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Fasta reference files
    inputBinding:
      position: 2
  - id: bit
    type:
      - 'null'
      - int
    doc: use N bits per element in Bloom filter
    inputBinding:
      position: 103
      prefix: --bit
  - id: cov
    type:
      - 'null'
      - int
    doc: number of unique k-mers to represent a reference
    inputBinding:
      position: 103
      prefix: --cov
  - id: entropy
    type:
      - 'null'
      - float
    doc: sets the aggregate entropy rate threshold [0.65]
    inputBinding:
      position: 103
      prefix: --entropy
  - id: hash1
    type:
      - 'null'
      - int
    doc: distinct Bloom filter hash number
    inputBinding:
      position: 103
      prefix: --hash1
  - id: hash2
    type:
      - 'null'
      - int
    doc: repeat Bloom filter hash number
    inputBinding:
      position: 103
      prefix: --hash2
  - id: kmer
    type:
      - 'null'
      - int
    doc: the length of kmer
    inputBinding:
      position: 103
      prefix: --kmer
  - id: out
    type:
      - 'null'
      - string
    doc: the output sketch file name [sketch_uniq.tsv]
    inputBinding:
      position: 103
      prefix: --out
  - id: outdir
    type:
      - 'null'
      - string
    doc: dir for universe unique k-mers [outdir_uniqsketch]
    inputBinding:
      position: 103
      prefix: --outdir
  - id: sensitive
    type:
      - 'null'
      - boolean
    doc: sets sensitivity parameter c to 100
    inputBinding:
      position: 103
      prefix: --sensitive
  - id: stat
    type:
      - 'null'
      - string
    doc: the output unique kmer stat file name [db_uniq_count.tsv]
    inputBinding:
      position: 103
      prefix: --stat
  - id: threads
    type:
      - 'null'
      - int
    doc: use N parallel threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: very_sensitive
    type:
      - 'null'
      - boolean
    doc: sets sensitivity parameter c to 1000
    inputBinding:
      position: 103
      prefix: --very-sensitive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: sketch
    type:
      - 'null'
      - File
    doc: unique sketch file
    outputBinding:
      glob: |
        ${ return inputs.out ? inputs.out : 'sketch_uniq.tsv'; }
  - id: unique_kmer_stat
    type:
      - 'null'
      - File
    doc: unique k-mer statistics file
    outputBinding:
      glob: |
        ${ return inputs.stat ? inputs.stat : 'db_uniq_count.tsv'; }
  - id: unique_kmers_dir
    type:
      - 'null'
      - Directory
    doc: directory with the unique k-mers of each reference
    outputBinding:
      glob: |
        ${ return inputs.outdir ? inputs.outdir : 'outdir_uniqsketch'; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        if (inputs.files) { l = l.concat(inputs.files); }
        if (inputs.list_files) { l.push(inputs.list_files); }
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
stdout: uniqsketch.out
