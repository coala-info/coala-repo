cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod_cover
label: perl-pod-coverage_pod_cover
doc: "Run a coverage analysis of the embedded documentation (POD) of a Perl distribution.
  The script reads the file MANIFEST in the current directory and reports the documentation
  coverage of every lib/*.pm module listed in it.\n\nTool homepage: https://metacpan.org/pod/Pod::Coverage"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entryname: MANIFEST
        entry: $(inputs.manifest)
      - entryname: lib
        entry: $(inputs.lib_dir)
inputs:
  - id: manifest
    type: File
    doc: MANIFEST file of the distribution, listing the lib/*.pm modules to analyse
  - id: lib_dir
    type: Directory
    doc: lib directory of the distribution with the modules listed in the MANIFEST
outputs:
  - id: stdout
    type: stdout
    doc: Documentation coverage report
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/perl-pod-coverage:0.23--pl5.22.0_0
stdout: perl-pod-coverage_pod_cover.out
