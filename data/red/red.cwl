cwlVersion: v1.2
class: CommandLineTool
baseCommand: Red
label: red
doc: "Red (REpeat Detector) is an automated tool for detecting repeats in genomic
  sequences.\n\nThe output directories (-sco, -cnd, -rpt, -msk) must exist before
  the run, so this wrapper creates the ones that are requested.\n\nTool homepage:
  http://toolsmith.ens.utulsa.edu"
inputs:
  - id: genome_dir
    type: Directory
    doc: Input genome directory, required. Files with ".fa" extension in this
      directory are used for completing the table of the adjusted counts and are
      scanned for repeats.
    inputBinding:
      position: 1
      prefix: -gnm
  - id: extra_sequences_dir
    type:
      - 'null'
      - Directory
    doc: Directory including additional input sequences. Files with ".fa"
      extension in this directory are NOT used for completing the table; their
      names must differ from those in the genome directory.
    inputBinding:
      position: 2
      prefix: -dir
  - id: word_length
    type:
      - 'null'
      - int
    doc: Word length equals k defining the k-mer. The default is
      floor(log_4(genome size)).
    inputBinding:
      position: 3
      prefix: -len
  - id: markov_order
    type:
      - 'null'
      - int
    doc: Order of the background Markov chain. The default is floor(k/2)-1.
    inputBinding:
      position: 4
      prefix: -ord
  - id: half_width
    type:
      - 'null'
      - int
    doc: Half width of the mask. The default is based on the GC content, 20 if
      the GC content is > 33% and < 67%, 40 otherwise.
    inputBinding:
      position: 5
      prefix: -gau
  - id: threshold
    type:
      - 'null'
      - int
    doc: The threshold score of the low adjusted scores of non-repeats. The
      default is 2.
    inputBinding:
      position: 6
      prefix: -thr
  - id: min_kmers
    type:
      - 'null'
      - int
    doc: The minimum number of the observed k-mers. The default is 3.
    inputBinding:
      position: 7
      prefix: -min
  - id: table_file
    type:
      - 'null'
      - string
    doc: File where the table of the adjusted counts is written.
    inputBinding:
      position: 8
      prefix: -tbl
  - id: scores_dir
    type:
      - 'null'
      - string
    doc: Directory where scores are saved (".scr" files).
    inputBinding:
      position: 9
      prefix: -sco
  - id: candidates_dir
    type:
      - 'null'
      - string
    doc: Directory where candidate regions are saved (".cnd" files).
    inputBinding:
      position: 10
      prefix: -cnd
  - id: repeats_dir
    type:
      - 'null'
      - string
    doc: Directory where repeats locations are saved (".rpt" files).
    inputBinding:
      position: 11
      prefix: -rpt
  - id: masked_dir
    type:
      - 'null'
      - string
    doc: Directory where masked sequences are saved (".msk" files).
    inputBinding:
      position: 12
      prefix: -msk
  - id: output_format
    type:
      - 'null'
      - int
    doc: 'The format of the output: 1 (chrName:start-end) or 2 (chrName start
      end). The output format are zero based and the end is exclusive.'
    inputBinding:
      position: 13
      prefix: -frm
  - id: hmm_file
    type:
      - 'null'
      - string
    doc: File where the HMM is saved.
    inputBinding:
      position: 14
      prefix: -hmo
  - id: threads
    type:
      - 'null'
      - int
    doc: Integer of the number of threads. The more threads, the higher the
      memory requirement. The default is the number of cores - 1, or 1 if a
      single core is found.
    inputBinding:
      position: 15
      prefix: -cor
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: scores_out
    type:
      - 'null'
      - Directory
    doc: Directory of score files
    outputBinding:
      glob: $(inputs.scores_dir)
  - id: candidates_out
    type:
      - 'null'
      - Directory
    doc: Directory of candidate region files
    outputBinding:
      glob: $(inputs.candidates_dir)
  - id: repeats_out
    type:
      - 'null'
      - Directory
    doc: Directory of repeat location files
    outputBinding:
      glob: $(inputs.repeats_dir)
  - id: masked_out
    type:
      - 'null'
      - Directory
    doc: Directory of masked sequence files
    outputBinding:
      glob: $(inputs.masked_dir)
  - id: table_out
    type:
      - 'null'
      - File
    doc: Table of the adjusted counts
    outputBinding:
      glob: $(inputs.table_file)
  - id: hmm_out
    type:
      - 'null'
      - File
    doc: Saved HMM file
    outputBinding:
      glob: $(inputs.hmm_file)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var dirs = [];
        ['scores_dir', 'candidates_dir', 'repeats_dir', 'masked_dir'].forEach(function (k) {
          if (inputs[k]) {
            dirs.push({entryname: inputs[k], entry: {class: 'Directory', basename: inputs[k], listing: []}, writable: true});
          }
        });
        return dirs;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/red:2018.09.10--h9948957_3
stdout: red.out
