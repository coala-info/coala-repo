cwlVersion: v1.2
class: CommandLineTool
baseCommand: convertf
label: admixtools_convertf
doc: "A tool from the AdmixTools suite used to convert between different genetic data
  formats (e.g., EIGENSTRAT, PACKEDANCESTRYMAP, PED, etc.) using a parameter file.\n\
  \nTool homepage: https://github.com/DReichLab/AdmixTools"
inputs:
  - id: parameter_file
    type: File
    doc: The parameter file containing input/output file paths and format 
      specifications.
    inputBinding:
      position: 101
      prefix: -p
  - id: data_files
    type:
      type: array
      items: File
    doc: Genotype, SNP, individual and population list files that the 
      parameter file names. They are staged into the working directory, so 
      the parameter file must refer to them by file name only.
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: converted_files
    type:
      type: array
      items: File
    doc: Output files named by genotypeoutname, snpoutname and indivoutname in 
      the parameter file
    outputBinding:
      glob: '*'
      outputEval: |-
        ${
          var staged = inputs.data_files.map(function(f) { return f.basename; });
          return self.filter(function(f) {
            return staged.indexOf(f.basename) < 0 && f.basename != 'admixtools_convertf.out';
          });
        }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: $(inputs.data_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/admixtools:8.0.2--h75d7a4a_0
stdout: admixtools_convertf.out
