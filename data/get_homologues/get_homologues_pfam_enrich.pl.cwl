cwlVersion: v1.2
class: CommandLineTool
baseCommand: pfam_enrich.pl
label: get_homologues_pfam_enrich.pl
doc: "Tests the enrichment of Pfam domains in a set of 'experiment' clusters compared with a 'control' set of clusters, using the Pfam mappings computed by get_homologues.pl -D and Fisher exact tests with FDR-adjusted p-values.\n\nTool homepage: https://github.com/eead-csic-compbio/get_homologues"
inputs:
  - id: homologues_dir
    type: Directory
    doc: directory with get_homologues[-est] output (example /path/to/data_homologues[-est])
    inputBinding:
      position: 1
      prefix: -d
  - id: control_clusters_dir
    type: Directory
    doc: path to directory with FASTA cluster files, taken as 'control' set, sitting probably inside -d
    inputBinding:
      position: 1
      prefix: -c
  - id: experiment_clusters_list
    type: File
    doc: file with list of 'experiment' clusters, should be a subset of files in -c
    inputBinding:
      position: 1
      prefix: -x
  - id: use_nucleotide_clusters
    type:
      - 'null'
      - boolean
    doc: use nucleotide sequence .fna clusters (uses .faa protein sequences by default)
    inputBinding:
      position: 1
      prefix: -n
  - id: reference
    type:
      - 'null'
      - string
    doc: reference .gbk/.faa/.fna file or "taxon name" (by default gets Pfam frequencies from all taxons)
    inputBinding:
      position: 1
      prefix: -r
  - id: test_type
    type:
      - 'null'
      - string
    doc: type of test [greater,two.sided,less] (default greater)
    inputBinding:
      position: 1
      prefix: -t
  - id: p_value_threshold
    type:
      - 'null'
      - float
    doc: fdr adjusted p-value threshold (default 0.05)
    inputBinding:
      position: 1
      prefix: -p
  - id: est_clusters
    type:
      - 'null'
      - boolean
    doc: cluster sequences are ESTs (requires pre-computed Pfam mappings of deduced CDSs, uses different regex to parse cluster FASTA files)
    inputBinding:
      position: 1
      prefix: -e
  - id: experiment_fasta
    type:
      - 'null'
      - string
    doc: make FASTA file with experiment sequences (example experiment.fasta)
    inputBinding:
      position: 1
      prefix: -f
  - id: sequences_as_units
    type:
      - 'null'
      - boolean
    doc: take individual sequences as annotation units (by default Pfam domains are counted once per cluster)
    inputBinding:
      position: 1
      prefix: -s
outputs:
  - id: experiment_fasta_file
    type:
      - 'null'
      - File
    doc: FASTA file with the experiment sequences.
    outputBinding:
      glob: $(inputs.experiment_fasta)
  - id: stdout
    type: stdout
    doc: Enriched Pfam domains with adjusted p-values.
stdout: get_homologues_pfam_enrich.pl.out
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_homologues:3.8.1--hdfd78af_0
