cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkHgFindSpec
label: ucsc-checkhgfindspec
doc: "Test and describe search specs in hgFindSpec tables. If given a term to search,
  displays the list of tables that will be searched and how long it took to figure
  that out, then performs the search and reports the time it took. Uses ~/.hg.conf
  to determine the genome database connection; the hg_conf input is staged as .hg.conf
  in the working directory (the home directory of the tool).\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
requirements:
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing:
      - entryname: .hg.conf
        entry: $(inputs.hg_conf)
inputs:
  - id: hg_conf
    type: File
    doc: 'Genome database connection file, staged as ~/.hg.conf (for the public UCSC
      server: db.host=genome-mysql.soe.ucsc.edu, db.user=genome, db.password=)'
  - id: database
    type: string
    doc: Name of the genome database (for example hg19)
    inputBinding:
      position: 1
  - id: term_to_search
    type: ['null', string]
    doc: Term to search for; the tool lists the tables that will be searched and
      performs the search
    inputBinding:
      position: 2
  - id: show_searches
    type: ['null', boolean]
    doc: Show the order in which tables will be searched in general (done anyway
      if no term to search or options are specified)
    inputBinding:
      position: 0
      prefix: -showSearches
  - id: check_term_regex
    type: ['null', boolean]
    doc: For each search spec that includes a regular expression for terms, make
      sure that all values of the table field to be searched match the regex
    inputBinding:
      position: 0
      prefix: -checkTermRegex
  - id: check_indexes
    type: ['null', boolean]
    doc: Make sure that an index is defined on each field to be searched
    inputBinding:
      position: 0
      prefix: -checkIndexes
  - id: no_html
    type: ['null', boolean]
    doc: Do not print the html results list, just figure out the search results
      and print timing
    inputBinding:
      position: 0
      prefix: -noHtml
outputs:
  - id: stdout
    type: stdout
    doc: Search specs, tables searched and timing
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-checkhgfindspec:482--h0b57e2e_0
stdout: ucsc-checkhgfindspec.out
