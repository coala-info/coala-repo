cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgGoldGapGl
label: ucsc-hggoldgapgl_hgGoldGapGl
doc: "Put chromosome .agp and .gl files into browser database.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type: string
    doc: database
    inputBinding:
      position: 1
  - id: gs_dir_or_agp_file
    type: string
    doc: gsDir (if creating split tables) or agpFile (if creating single tables)
    inputBinding:
      position: 2
  - id: oo_sub_dir
    type:
      - 'null'
      - string
    doc: ooSubDir (only used when gsDir is provided)
    inputBinding:
      position: 3
  - id: chrom
    type:
      - 'null'
      - string
    doc: just do a single chromosome. Don't delete old tables.
    inputBinding:
      position: 104
      prefix: -chrom
  - id: chrom_lst
    type:
      - 'null'
      - File
    doc: chromosomes subdirs are named in chrom.lst (1, 2, ...)
    inputBinding:
      position: 104
      prefix: -chromLst
  - id: no_gl
    type:
      - 'null'
      - boolean
    doc: don't do gl bits
    inputBinding:
      position: 104
      prefix: -noGl
  - id: no_load
    type:
      - 'null'
      - boolean
    doc: do not load tables, leave SQL files instead.
    inputBinding:
      position: 104
      prefix: -noLoad
  - id: verbose
    type:
      - 'null'
      - int
    doc: n==2 brief information and SQL table create statements; n==3 show all 
      gaps
    inputBinding:
      position: 104
      prefix: -verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hggoldgapgl:377--h199ee4e_0
stdout: ucsc-hggoldgapgl_hgGoldGapGl.out
