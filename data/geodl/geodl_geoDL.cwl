cwlVersion: v1.2
class: CommandLineTool
baseCommand: geoDL
label: geodl_geoDL
doc: "Download fastq from The European Nucleotide Archive (ENA) http://www.ebi.ac.uk/ena
  website using a GSE geo http://www.ncbi.nlm.nih.gov/geo/info/seq.html accession,
  ENA study accession or a metadata file from ENA\n\nTool homepage: https://github.com/jduc/geoDL"
inputs:
  - id: input_type
    type: string
    doc: Specify which type of input
    inputBinding:
      position: 1
  - id: accession_or_file
    type: string
    doc: "geo:  GSE accession number, eg: GSE13373\n                             \
      \ Map the GSE accession to the ENA study accession and fetch the metadata\n\
      \                        \n                        meta: Use metadata file instead
      of fetching it on ENA website (bypass GEO)\n                              Meta
      data should include at minima the following columns: ['Fastq files\n       \
      \                       (ftp)', 'Submitter's sample name']\n               \
      \         \n                        ena:  ENA study accession number, eg: PRJEB13373\n\
      \                              Fetch the metadata directely on the ENA website"
    inputBinding:
      position: 2
  - id: colname
    type:
      - 'null'
      - string
    doc: "Name of the column to use in the metadata file to name\n               \
      \         the samples"
    inputBinding:
      position: 103
      prefix: --colname
  - id: dry_run
    type:
      - 'null'
      - boolean
    doc: "Don't actually download anything, just print the wget\ncmds"
    inputBinding:
      position: 103
      prefix: --dry
  - id: samples
    type:
      - 'null'
      - type: array
        items: string
    doc: "Space separated list of GSM samples to download. For\n                 \
      \       ENA mode, subset the metadata"
    inputBinding:
      position: 103
      prefix: --samples
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/geodl:1.0b5.1--py36_0
stdout: geodl_geoDL.out
