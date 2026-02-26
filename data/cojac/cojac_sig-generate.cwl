cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cojac
  - sig-generate
label: cojac_sig-generate
doc: "Helps generating a list of mutations frequently found in a variant by querying
  covSPECTRUM\n\nTool homepage: https://github.com/cbg-ethz/cojac"
inputs:
  - id: covariants
    type:
      - 'null'
      - File
    doc: 'import from a covariants.org TSV file instead of covSpectrum. (See: https://github.com/hodcroftlab/covariants/blob/master/defining_mutations/)'
    inputBinding:
      position: 101
      prefix: --covariants
  - id: debug
    type:
      - 'null'
      - boolean
    doc: show 'extra' query content, show API details (urls and arguments)
    inputBinding:
      position: 101
      prefix: --debug
  - id: extras
    type:
      - 'null'
      - string
    doc: "Additional LAPIS query arguments passed as a YAML flow, e.g.: '{dateFrom:
      \"2022-02-01\", variantQuery: \"[6-of: S:147E, S:152R, S:157L, S:210V, S:257S,
      S:339H, S:446S, S:460K, ORF1a:1221L, ORF1a:1640S, ORF1a:4060S]\"}'. For more
      information about LAPIS, see: https://lapis-docs.readthedocs.io/en/latest/"
    inputBinding:
      position: 101
      prefix: --extras
  - id: lintype
    type:
      - 'null'
      - string
    doc: 'switch the lineage field queried on covspectrum (e.g. nextcladePangoLineage:
      as determined with nextclade, pangoLineage: as provided by upstream sequence
      repository)'
    inputBinding:
      position: 101
      prefix: --lintype
  - id: mindelfreq
    type:
      - 'null'
      - float
    doc: Use a different minimum frequency for deletions (useful early on when 
      there are few sequences and some of those were produced by pipelines that 
      don't handle deletions)
    inputBinding:
      position: 101
      prefix: --mindelfreq
  - id: minfreq
    type:
      - 'null'
      - float
    doc: Minimum frequency for inclusion in list
    inputBinding:
      position: 101
      prefix: --minfreq
  - id: minseqs
    type:
      - 'null'
      - int
    doc: Minimum number of sequence supporting for inclusion in list
    inputBinding:
      position: 101
      prefix: --minseqs
  - id: no_debug
    type:
      - 'null'
      - boolean
    doc: show 'extra' query content, show API details (urls and arguments)
    inputBinding:
      position: 101
      prefix: --no-debug
  - id: no_quirk_no_star
    type:
      - 'null'
      - boolean
    doc: special work-around options
    inputBinding:
      position: 101
      prefix: --quirk [noStar]
  - id: quirk
    type:
      - 'null'
      - type: array
        items: string
    doc: special work-around options
    inputBinding:
      position: 101
      prefix: --quirk
  - id: url
    type:
      - 'null'
      - string
    doc: url to use when querying covspectrum (e.g. 
      https://lapis.cov-spectrum.org/open/v2, 
      https://lapis.cov-spectrum.org/gisaid/v2, etc.)
    inputBinding:
      position: 101
      prefix: --url
  - id: variant
    type: string
    doc: Pangolineage of the root variant to list
    inputBinding:
      position: 101
      prefix: --variant
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cojac:0.9.3--pyh7e72e81_0
stdout: cojac_sig-generate.out
