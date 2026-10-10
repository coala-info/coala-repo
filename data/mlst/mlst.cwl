cwlVersion: v1.2
class: CommandLineTool
baseCommand: mlst
label: mlst
doc: "Scan contig files against PubMLST schemes for multi-locus sequence typing\n\n
  Tool homepage: https://github.com/tseemann/mlst"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input contig files (FASTA/GenBank/EMBL, optionally gzipped) to scan
    inputBinding:
      position: 1
  - id: blastdb
    type:
      - 'null'
      - string
    doc: BLAST database prefix (default '/usr/local/db/blast/mlst.fa')
    inputBinding:
      position: 102
      prefix: --blastdb
  - id: check
    type:
      - 'null'
      - boolean
    doc: Just check dependencies and exit
    inputBinding:
      position: 102
      prefix: --check
  - id: csv
    type:
      - 'null'
      - boolean
    doc: Output CSV instead of TSV
    inputBinding:
      position: 102
      prefix: --csv
  - id: datadir
    type:
      - 'null'
      - string
    doc: PubMLST data folders (default '/usr/local/db/pubmlst')
    inputBinding:
      position: 102
      prefix: --datadir
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Verbose debug output to stderr
    inputBinding:
      position: 102
      prefix: --debug
  - id: exclude
    type:
      - 'null'
      - string
    doc: Ignore these schemes (comma separated)
    inputBinding:
      position: 102
      prefix: --exclude
  - id: fofn
    type:
      - 'null'
      - File
    doc: File of input filenames to use
    inputBinding:
      position: 102
      prefix: --fofn
  - id: full
    type:
      - 'null'
      - boolean
    doc: More detailed output format
    inputBinding:
      position: 102
      prefix: --full
  - id: info
    type:
      - 'null'
      - boolean
    doc: More information about schemes
    inputBinding:
      position: 102
      prefix: --info
  - id: json
    type:
      - 'null'
      - string
    doc: Also write results to this file in JSON format
    inputBinding:
      position: 102
      prefix: --json
  - id: label
    type:
      - 'null'
      - string
    doc: Replace FILE with this name instead
    inputBinding:
      position: 102
      prefix: --label
  - id: legacy
    type:
      - 'null'
      - boolean
    doc: Use old legacy output with allele header row (requires --scheme)
    inputBinding:
      position: 102
      prefix: --legacy
  - id: list
    type:
      - 'null'
      - boolean
    doc: List available MLST scheme names
    inputBinding:
      position: 102
      prefix: --list
  - id: longlist
    type:
      - 'null'
      - boolean
    doc: List alleles for all MLST schemes
    inputBinding:
      position: 102
      prefix: --longlist
  - id: mincov
    type:
      - 'null'
      - float
    doc: DNA %cov to report partial/'?' allele (default 50)
    inputBinding:
      position: 102
      prefix: --mincov
  - id: minid
    type:
      - 'null'
      - float
    doc: DNA %identity of full allele to consider similar/'~' (default 95)
    inputBinding:
      position: 102
      prefix: --minid
  - id: minscore
    type:
      - 'null'
      - float
    doc: Minimum score out of 100 to match a scheme (when auto --scheme)
    inputBinding:
      position: 102
      prefix: --minscore
  - id: nopath
    type:
      - 'null'
      - boolean
    doc: Strip filename paths from FILE column
    inputBinding:
      position: 102
      prefix: --nopath
  - id: novel
    type:
      - 'null'
      - string
    doc: Save novel alleles to this FASTA file
    inputBinding:
      position: 102
      prefix: --novel
  - id: outfile
    type:
      - 'null'
      - string
    doc: Save output to this file [STDOUT]
    inputBinding:
      position: 102
      prefix: --outfile
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet - no stderr output
    inputBinding:
      position: 102
      prefix: --quiet
  - id: scheme
    type:
      - 'null'
      - string
    doc: Do not auto-detect, force this scheme
    inputBinding:
      position: 102
      prefix: --scheme
  - id: skipcheck
    type:
      - 'null'
      - boolean
    doc: Skip dependency check at runtime
    inputBinding:
      position: 102
      prefix: --skipcheck
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of BLAST threads
    inputBinding:
      position: 102
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: outfile_out
    type:
      - 'null'
      - File
    doc: Results file written with --outfile
    outputBinding:
      glob: $(inputs.outfile)
  - id: novel_out
    type:
      - 'null'
      - File
    doc: Novel alleles FASTA written with --novel
    outputBinding:
      glob: $(inputs.novel)
  - id: json_out
    type:
      - 'null'
      - File
    doc: JSON results written with --json
    outputBinding:
      glob: $(inputs.json)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mlst:2.32.2--hdfd78af_0
stdout: mlst.out
