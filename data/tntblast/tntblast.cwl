cwlVersion: v1.2
class: CommandLineTool
baseCommand: tntblast
label: tntblast
doc: "ThermonucleotideBLAST: searches a database of target sequences with assay-specific
  queries (PCR primer pairs, TaqMan PCR, padlock or hybridization probes) using
  melting temperature and free energy of binding.\n\nTool homepage: https://github.com/jgans/thermonucleotideBLAST"
inputs:
  - id: input_file
    type: File
    doc: "Input file of query oligos (tab-delimited assay file)"
    inputBinding:
      position: 1
      prefix: '-i'
  - id: output_file_name
    type:
      - 'null'
      - string
    doc: "Output file (default is stdout)"
    inputBinding:
      position: 2
      prefix: '-o'
  - id: database
    type: File
    doc: "Database of target sequences to search against"
    inputBinding:
      position: 3
      prefix: '-d'
  - id: local_database
    type:
      - 'null'
      - File
    doc: "Local database of target sequences to search against"
    inputBinding:
      position: 4
      prefix: '-D'
  - id: max_amplicon_length
    type:
      - 'null'
      - int
    doc: "Maximum amplicon length (default is 2000 bases)"
    inputBinding:
      position: 5
      prefix: '-l'
  - id: min_primer_tm
    type:
      - 'null'
      - float
    doc: "Minimum primer Tm"
    inputBinding:
      position: 6
      prefix: '-e'
  - id: min_probe_tm
    type:
      - 'null'
      - float
    doc: "Minimum probe Tm"
    inputBinding:
      position: 7
      prefix: '-E'
  - id: min_primer_dg
    type:
      - 'null'
      - float
    doc: "Minimum primer delta G (in Kcal/Mol) (default is no limit)"
    inputBinding:
      position: 8
      prefix: '-z'
  - id: min_probe_dg
    type:
      - 'null'
      - float
    doc: "Minimum probe delta G (in Kcal/Mol) (default is no limit)"
    inputBinding:
      position: 9
      prefix: '-Z'
  - id: max_primer_tm
    type:
      - 'null'
      - float
    doc: "Maximum primer Tm (default is no limit)"
    inputBinding:
      position: 10
      prefix: '-x'
  - id: max_probe_tm
    type:
      - 'null'
      - float
    doc: "Maximum probe Tm (default is no limit)"
    inputBinding:
      position: 11
      prefix: '-X'
  - id: max_primer_dg
    type:
      - 'null'
      - float
    doc: "Maximum primer delta G (in Kcal/Mol) (default is no limit)"
    inputBinding:
      position: 12
      prefix: '-g'
  - id: max_probe_dg
    type:
      - 'null'
      - float
    doc: "Maximum probe delta G (in Kcal/Mol) (default is no limit)"
    inputBinding:
      position: 13
      prefix: '-G'
  - id: salt_concentration
    type:
      - 'null'
      - float
    doc: "Salt concentration (in MOL) (default is 0.05 M)"
    inputBinding:
      position: 14
      prefix: '-s'
  - id: primer_strand_concentration
    type:
      - 'null'
      - float
    doc: "Primer strand concentration (in MOL) (default is 9e-07 M)"
    inputBinding:
      position: 15
      prefix: '-t'
  - id: probe_strand_concentration
    type:
      - 'null'
      - float
    doc: "Probe strand concentration (in MOL) (default is 2.5e-07 M)"
    inputBinding:
      position: 16
      prefix: '-T'
  - id: strand_ratio
    type:
      - 'null'
      - float
    doc: "Ratio of forward/reverse strand concentrations (default is 1, i.e. symmetric PCR)"
    inputBinding:
      position: 17
      prefix: '-y'
  - id: assay_format
    type:
      - 'null'
      - string
    doc: "Assay format: PCR, PROBE, PADLOCK or AFFY (default is PCR)"
    inputBinding:
      position: 18
      prefix: '-A'
  - id: hash_word_length
    type:
      - 'null'
      - int
    doc: "Hash word length, 2 to 8 (default is 7)"
    inputBinding:
      position: 19
      prefix: '-W'
  - id: output_format
    type:
      - 'null'
      - int
    doc: "Output format: 0 verbose (default), 1 fasta, 2 network files (*.atr and *.sif), 3 inverse target, 4 inverse query"
    inputBinding:
      position: 20
      prefix: '-m'
  - id: show_alignments
    type:
      - 'null'
      - string
    doc: "Show alignments, T or F (default is T)"
    inputBinding:
      position: 21
      prefix: '-a'
  - id: show_matching_sequence
    type:
      - 'null'
      - string
    doc: "Show matching sequence, T or F (default is T)"
    inputBinding:
      position: 22
      prefix: '-M'
  - id: mask_primer_sites
    type:
      - 'null'
      - string
    doc: "Mask primer binding sites, T or F (default is F)"
    inputBinding:
      position: 23
      prefix: '-k'
  - id: mask_probe_sites
    type:
      - 'null'
      - string
    doc: "Mask probe binding sites, T or F (default is F)"
    inputBinding:
      position: 24
      prefix: '-K'
  - id: replace_primer_sites
    type:
      - 'null'
      - string
    doc: "Replace primer binding sites with primer sequence, T or F (default is F)"
    inputBinding:
      position: 25
      prefix: '-r'
  - id: disable_verbose
    type:
      - 'null'
      - string
    doc: "Disable verbose terminal output, T or F (default is T)"
    inputBinding:
      position: 26
      prefix: '-v'
  - id: ignore_probes
    type:
      - 'null'
      - string
    doc: "Ignore all probe oligos in the input file, T or F (default is F)"
    inputBinding:
      position: 27
      prefix: '-p'
  - id: one_file_per_query
    type:
      - 'null'
      - string
    doc: "One output file per query, T or F (default is F)"
    inputBinding:
      position: 28
      prefix: '-n'
  - id: append_assay_name
    type:
      - 'null'
      - string
    doc: "Append assay name to output defline, T or F (default is F)"
    inputBinding:
      position: 29
      prefix: '-L'
  - id: assay_summary
    type:
      - 'null'
      - string
    doc: "Output assay summary after searching, T or F (default is F)"
    inputBinding:
      position: 30
      prefix: '-S'
  - id: primer_clamp
    type:
      - 'null'
      - int
    doc: "Number of exact 3' primer matches required (default is 0 bases)"
    inputBinding:
      position: 31
      prefix: '--primer-clamp'
  - id: min_max_primer_clamp
    type:
      - 'null'
      - int
    doc: "The minimum max number of exact 3' primer matches required (default is no limit)"
    inputBinding:
      position: 32
      prefix: '--min-max-primer-clamp'
  - id: probe_clamp5
    type:
      - 'null'
      - int
    doc: "Number of exact 5' probe matches required (default is 0 bases)"
    inputBinding:
      position: 33
      prefix: '--probe-clamp5'
  - id: probe_clamp3
    type:
      - 'null'
      - int
    doc: "Number of exact 3' probe matches required (default is 0 bases)"
    inputBinding:
      position: 34
      prefix: '--probe-clamp3'
  - id: dangle5
    type:
      - 'null'
      - string
    doc: "Allow dangling bases on the 5' query side of an alignment, T or F (default is F)"
    inputBinding:
      position: 35
      prefix: '--dangle5'
  - id: dangle3
    type:
      - 'null'
      - string
    doc: "Allow dangling bases on the 3' query side of an alignment, T or F (default is F)"
    inputBinding:
      position: 36
      prefix: '--dangle3'
  - id: plex
    type:
      - 'null'
      - string
    doc: "All input assays in a single multiple reaction, T or F (default is F)"
    inputBinding:
      position: 37
      prefix: '--plex'
  - id: temperature
    type:
      - 'null'
      - float
    doc: "Temperature for computing Delta G (in Kelvin) (default is 310.15 K)"
    inputBinding:
      position: 38
      prefix: '--temperature'
  - id: single_primer_pcr
    type:
      - 'null'
      - string
    doc: "Allow amplicons produced by a single PCR primer binding in both orientations, T or F (default is T)"
    inputBinding:
      position: 39
      prefix: '--single-primer-pcr'
  - id: target_strand
    type:
      - 'null'
      - string
    doc: "Which strand to target with probes: plus, minus or both (default is both)"
    inputBinding:
      position: 40
      prefix: '--target-strand'
  - id: max_target_len
    type:
      - 'null'
      - int
    doc: "Max sequence length before targets are split (default is 500000 bases)"
    inputBinding:
      position: 41
      prefix: '--max-target-len'
  - id: query_seg
    type:
      - 'null'
      - string
    doc: "Query segmentation algorithm: always, never or adaptive (default is never)"
    inputBinding:
      position: 42
      prefix: '--query-seg'
  - id: dump_query
    type:
      - 'null'
      - string
    doc: "Write queries to stdout, T or F (default is F)"
    inputBinding:
      position: 43
      prefix: '--dump-query'
  - id: dinkelbach
    type:
      - 'null'
      - string
    doc: "Use the Dinkelbach fractional programming algorithm, T or F (default is F)"
    inputBinding:
      position: 44
      prefix: '--dinkelbach'
  - id: max_gap
    type:
      - 'null'
      - int
    doc: "Max number of allowed gaps in a DNA duplex (default is 999)"
    inputBinding:
      position: 45
      prefix: '--max-gap'
  - id: max_mismatch
    type:
      - 'null'
      - int
    doc: "Max number of allowed mismatches in a DNA duplex (default is 999)"
    inputBinding:
      position: 46
      prefix: '--max-mismatch'
  - id: rescale_ct
    type:
      - 'null'
      - string
    doc: "Use of degenerate bases results in rescaling of oligo concentration, T or F (default is T)"
    inputBinding:
      position: 47
      prefix: '--rescale-ct'
  - id: best_match
    type:
      - 'null'
      - boolean
    doc: "Only save the best match, in Tm, between a query and target"
    inputBinding:
      position: 48
      prefix: '--best-match'
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (results when -o is not used)
  - id: result_file
    type:
      - 'null'
      - File
    doc: Output file written with -o
    outputBinding:
      glob: $(inputs.output_file_name)
  - id: network_files
    type:
      type: array
      items: File
    doc: Network output files (*.atr and *.sif) written with output format 2
    outputBinding:
      glob:
        - '*.atr'
        - '*.sif'
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tntblast:2.66--h6b557da_0
stdout: tntblast.out
