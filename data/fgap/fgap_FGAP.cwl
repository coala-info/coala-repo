cwlVersion: v1.2
class: CommandLineTool
baseCommand: FGAP
label: fgap_FGAP
doc: "FGAP: an automated gap closing tool. It closes the gaps (runs of N) of a draft\
  \ genome with sequences from one or more datasets (contigs, reads or other assemblies). The FGAP wrapper script takes all options\
  \ as one quoted string, so the tool builds that string.\n\nTool homepage: https://github.com/pirovc/fgap"
inputs:
  - id: draft_file
    type: File
    doc: Draft genome file in FASTA format
  - id: datasets_files
    type:
      type: array
      items: File
    doc: Dataset files in FASTA format used to close the gaps
  - id: min_score
    type:
      - 'null'
      - int
    doc: Min Score (raw) to return results from BLAST
  - id: max_evalue
    type:
      - 'null'
      - float
    doc: Max E-Value to return results from BLAST
  - id: min_identity
    type:
      - 'null'
      - int
    doc: Min identity (%) to return results from BLAST (0-100)
  - id: contig_end_length
    type:
      - 'null'
      - int
    doc: Length (bp) of contig ends to perform BLAST alignment
  - id: edge_trim_length
    type:
      - 'null'
      - int
    doc: Length of ignored bases (bp) upstream and downstream of the gap
  - id: max_remove_length
    type:
      - 'null'
      - int
    doc: Max number of bases (bp) that can be removed
  - id: max_insert_length
    type:
      - 'null'
      - int
    doc: Max number of bases (bp) that can be inserted
  - id: positive_gap
    type:
      - 'null'
      - int
    doc: Enable closing of positive gaps (with insertion), 0 or 1
  - id: zero_gap
    type:
      - 'null'
      - int
    doc: Enable closing of zero gaps (without insert any base), 0 or 1
  - id: negative_gap
    type:
      - 'null'
      - int
    doc: Enable closing of negative gaps (overlapping contig ends), 0 or 1
  - id: gap_char
    type:
      - 'null'
      - string
    doc: Base that represents the gap
  - id: blast_path
    type:
      - 'null'
      - string
    doc: Blast+ package path (only makeblastdb and blastn are needed)
  - id: blast_alignment_parameters
    type:
      - 'null'
      - string
    doc: BLAST alignment parameters (opengap,extendgap,match,mismatch,wordsize)
  - id: blast_max_results
    type:
      - 'null'
      - int
    doc: Max results from BLAST for each query
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
  - id: more_output
    type:
      - 'null'
      - int
    doc: More output files with gap regions after and before gap closing, 0 or 1
  - id: output_prefix
    type:
      - 'null'
      - string
    default: output_fgap
    doc: Output prefix (file or folder)
requirements:
  - class: InlineJavascriptRequirement
arguments:
  - position: 1
    valueFrom: |
      ${
        var a = ['-d ' + inputs.draft_file.path,
                 '-a ' + inputs.datasets_files.map(function(f) { return f.path; }).join(',')];
        var opts = {min_score: '-s', max_evalue: '-e', min_identity: '-i',
          contig_end_length: '-C', edge_trim_length: '-T', max_remove_length: '-R',
          max_insert_length: '-I', positive_gap: '-p', zero_gap: '-z', negative_gap: '-g',
          gap_char: '-c', blast_path: '-b', blast_alignment_parameters: '-l',
          blast_max_results: '-r', threads: '-t', more_output: '-m', output_prefix: '-o'};
        for (var k in opts) {
          if (inputs[k] !== null && inputs[k] !== undefined) { a.push(opts[k] + ' ' + inputs[k]); }
        }
        return a.join(' ');
      }
outputs:
  - id: results
    type:
      type: array
      items: File
    doc: Result files written with the output prefix
    outputBinding:
      glob: $(inputs.output_prefix)*
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fgap:1.8.1--hdfd78af_2
