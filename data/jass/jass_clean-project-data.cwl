cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - jass
  - clean-project-data
label: jass_clean-project-data
doc: "Cleans project data: removes the large files (worktable, csv, plots) of JASS
  projects that have not been accessed for a number of days. Projects live in the
  JASS projects directory; a writable copy of projects_dir is staged as jass_projects
  and returned.\n\nTool homepage: http://statistical-genetics.pages.pasteur.fr/jass/"
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: JASS_PROJECTS_DIR
        envValue: $(runtime.outdir)/jass_projects
  - class: InitialWorkDirRequirement
    listing:
      - entryname: jass_projects
        entry: $(inputs.projects_dir)
        writable: true
inputs:
  - id: projects_dir
    type:
      - 'null'
      - Directory
    doc: The JASS projects directory (folders named project_<id>) to clean.
  - id: max_days_without_access
    type:
      - 'null'
      - int
    doc: "A project is marked for large file deletion if the number of days elapsed
      since the last access is greater than the amount provided."
    inputBinding:
      position: 101
      prefix: --max-days-without-access
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: projects
    type:
      - 'null'
      - Directory
    doc: The projects directory after cleaning
    outputBinding:
      glob: jass_projects
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jass:2.3--pyhca03a8a_0
stdout: jass_clean-project-data.out
