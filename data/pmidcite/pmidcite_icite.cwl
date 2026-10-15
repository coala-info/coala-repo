cwlVersion: v1.2
class: CommandLineTool
baseCommand: icite
label: pmidcite_icite
doc: "Run NIH's iCite given PubMed IDs\n\nTool homepage: http://github.com/dvklopfenstein/pmidcite"
inputs:
  - id: pmids
    type:
      - 'null'
      - type: array
        items: string
    doc: PubMed IDs (PMIDs)
    inputBinding:
      position: 1
  - id: append_outfile
    type:
      - 'null'
      - string
    doc: Append current citation report to an ASCII text file. Create if needed.
    inputBinding:
      position: 102
      prefix: --append_outfile
  - id: cite
    type:
      - 'null'
      - boolean
    doc: publication citation for the pmidcite project
    inputBinding:
      position: 102
      prefix: --cite
  - id: dir_icite
    type:
      - 'null'
      - string
    doc: Write PMID icite reports into directory
    inputBinding:
      position: 102
      prefix: --dir_icite
  - id: dir_icite_py
    type:
      - 'null'
      - string
    doc: Write PMID iCite information into directory which contains temporary 
      working files
    inputBinding:
      position: 102
      prefix: --dir_icite_py
  - id: dir_pubmed_txt
    type:
      - 'null'
      - string
    doc: Write PubMed entry into directory
    inputBinding:
      position: 102
      prefix: --dir_pubmed_txt
  - id: force_download
    type:
      - 'null'
      - boolean
    doc: Download PMID iCite information to a Python file, over-writing if 
      necessary.
    inputBinding:
      position: 102
      prefix: --force_download
  - id: force_write
    type:
      - 'null'
      - boolean
    doc: if an existing outfile file exists, overwrite it.
    inputBinding:
      position: 102
      prefix: --force_write
  - id: generate_rcfile
    type:
      - 'null'
      - boolean
    doc: Generate a sample configuration file according to the current 
      configuration.
    inputBinding:
      position: 102
      prefix: --generate-rcfile
  - id: group1_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 1
    inputBinding:
      position: 102
      prefix: '-1'
  - id: group2_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 2
    inputBinding:
      position: 102
      prefix: '-2'
  - id: group3_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 3
    inputBinding:
      position: 102
      prefix: '-3'
  - id: group4_min
    type:
      - 'null'
      - float
    doc: Minimum NIH percentile to be placed in group 4
    inputBinding:
      position: 102
      prefix: '-4'
  - id: infile
    type:
      - 'null'
      - type: array
        items: File
    doc: Read PMIDs from a file containing one PMID per line.
    inputBinding:
      position: 102
      prefix: --infile
  - id: load_citations
    type:
      - 'null'
      - boolean
    doc: Load and print of papers and clinical studies that cited the requested 
      paper.
    inputBinding:
      position: 102
      prefix: --load_citations
  - id: load_references
    type:
      - 'null'
      - boolean
    doc: Load and print the references for each requested paper.
    inputBinding:
      position: 102
      prefix: --load_references
  - id: long_format
    type:
      - 'null'
      - boolean
    doc: Print a multi-line description for each paper.
    inputBinding:
      position: 102
      prefix: --long-format
  - id: md
    type:
      - 'null'
      - boolean
    doc: Print using markdown table format.
    inputBinding:
      position: 102
      prefix: --md
  - id: no_references
    type:
      - 'null'
      - boolean
    doc: '(DEPRECATED) Do not load or print a descriptive list of references. DEPRECATED
      -- Use instead: -c -r'
    inputBinding:
      position: 102
      prefix: --no_references
  - id: print_header
    type:
      - 'null'
      - boolean
    doc: Print column headings on one line.
    inputBinding:
      position: 102
      prefix: --print_header
  - id: print_keys
    type:
      - 'null'
      - boolean
    doc: Print the keys describing the abbreviations.
    inputBinding:
      position: 102
      prefix: --print_keys
  - id: print_nih_dividers
    type:
      - 'null'
      - boolean
    doc: Print the NIH percentile grouper divider percentages
    inputBinding:
      position: 102
      prefix: --print-NIH-dividers
  - id: print_rcfile
    type:
      - 'null'
      - boolean
    doc: Print the location of the pmidcite configuration file
    inputBinding:
      position: 102
      prefix: --print-rcfile
  - id: pubmed
    type:
      - 'null'
      - boolean
    doc: Download PubMed entry containing title, abstract, authors, journal, 
      MeSH, etc.
    inputBinding:
      position: 102
      prefix: --pubmed
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Load and print a descriptive list of citations and references for each 
      paper.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: write_each_pmid_report
    type:
      - 'null'
      - boolean
    doc: Write each PMIDs' iCite report with citations/references to 
      <dir_icite>/PMID.txt
    inputBinding:
      position: 102
      prefix: -O
  - id: outfile_path
    type:
      - 'null'
      - string
    doc: Write current citation report to an ASCII text file.
    inputBinding:
      position: 102
      prefix: --outfile
outputs:
  - id: stdout
    type: stdout
    doc: Citation report printed to standard output
  - id: outfile
    type:
      - 'null'
      - File
    doc: Write current citation report to an ASCII text file.
    outputBinding:
      glob: $(inputs.outfile_path)
  - id: appended_outfile
    type:
      - 'null'
      - File
    doc: Citation report appended to this text file
    outputBinding:
      glob: $(inputs.append_outfile)
  - id: icite_reports_dir
    type:
      - 'null'
      - Directory
    doc: Directory with one iCite report per PMID
    outputBinding:
      glob: $(inputs.dir_icite)
  - id: pubmed_entries_dir
    type:
      - 'null'
      - Directory
    doc: Directory with the PubMed entries
    outputBinding:
      glob: $(inputs.dir_pubmed_txt)
  - id: icite_py_dir
    type:
      - 'null'
      - Directory
    doc: Directory with temporary working files holding the iCite information
    outputBinding:
      glob: $(inputs.dir_icite_py)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        ['dir_icite', 'dir_icite_py', 'dir_pubmed_txt'].forEach(function(k) {
          if (inputs[k]) { l.push({entryname: inputs[k], entry: {class: 'Directory', listing: []}, writable: true}); }
        });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pmidcite:0.3.1--pyhdfd78af_0
stdout: pmidcite_icite.out
