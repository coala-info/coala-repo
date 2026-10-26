cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - comparesketch
label: uniqsketch_comparesketch
doc: "Compare two sets of fasta reference files |LIST1|*|LIST2|. Fasta files can be in compressed formats such as gz, bz, zip. Two lists of files containing file paths in each row.\n\nTool homepage: https://github.com/amazon-science/uniqsketch"
inputs:
  - id: list1
    type: File
    doc: file with the paths of the first set of fasta files, one per row
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: list2
    type: File
    doc: file with the paths of the second set of fasta files, one per row
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: fasta_files
    type:
      type: array
      items: File
    doc: fasta files named in the two lists (staged in the working directory so that the paths resolve)
  - id: threads
    type:
      - 'null'
      - int
    doc: use N parallel threads [1]
    inputBinding:
      position: 101
      prefix: --threads
  - id: kmer
    type:
      - 'null'
      - int
    doc: the length of kmer [81]
    inputBinding:
      position: 101
      prefix: --kmer
  - id: bit
    type:
      - 'null'
      - int
    doc: use N bits per element in Bloom filter [16]
    inputBinding:
      position: 101
      prefix: --bit
  - id: hash
    type:
      - 'null'
      - int
    doc: Bloom filter hash number [3]
    inputBinding:
      position: 101
      prefix: --hash
  - id: gsize
    type:
      - 'null'
      - int
    doc: approximate size for reference sequence [5000000]
    inputBinding:
      position: 101
      prefix: --gsize
  - id: out
    type:
      - 'null'
      - string
    doc: the output similarity file name [reference_similarity.tsv]
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: similarity
    type: File
    doc: pairwise similarity table
    outputBinding:
      glob: |
        ${ return inputs.out ? inputs.out : 'reference_similarity.tsv'; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [inputs.list1, inputs.list2];
        return l.concat(inputs.fasta_files);
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uniqsketch:1.1.0--h077b44d_0
stdout: uniqsketch_comparesketch.out
