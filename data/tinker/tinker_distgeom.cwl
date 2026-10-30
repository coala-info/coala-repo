cwlVersion: v1.2
class: CommandLineTool
baseCommand: distgeom
label: tinker_distgeom
doc: "Tinker distance geometry: generates structures consistent with the distance bounds, chirality and planarity restraints of a molecule; the structures are written to numbered files (<name>.001, ...).\n\nTool homepage: https://dasher.wustl.edu/tinker/"
inputs:
  - id: coordinate_file
    type: File
    doc: "Cartesian coordinate file (.xyz)"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: number_of_structures
    type: int
    doc: "Number of distance geometry structures to generate"
    default: 1
    inputBinding:
      position: 2
  - id: chirality
    type: string
    doc: "Impose chirality constraints on tetrahedral atoms (Y or N)"
    default: "Y"
    inputBinding:
      position: 3
  - id: floating_chirality
    type: string
    doc: "Use floating chirality for -XH2- and -XH3 groups (Y or N); asked only when chirality is Y"
    default: "N"
    inputBinding:
      position: 4
      valueFrom: "${ return inputs.chirality == \"N\" ? null : self; }"
  - id: trigonal_planarity
    type: string
    doc: "Impose planarity and/or chirality of trigonal atoms (Y or N)"
    default: "Y"
    inputBinding:
      position: 5
  - id: torsional_planarity
    type: string
    doc: "Impose torsional planarity on adjacent trigonal atoms (Y or N)"
    default: "Y"
    inputBinding:
      position: 6
  - id: examine_bounds
    type: string
    doc: "Examine or alter the bounds matrix (Y or N)"
    default: "N"
    inputBinding:
      position: 7
  - id: select_enantiomer
    type: string
    doc: "Select the enantiomer closest to the input structure (Y or N)"
    default: "N"
    inputBinding:
      position: 8
  - id: refinement
    type: string
    doc: "Refinement of the embedded structure by M minimization or A annealing"
    default: "A"
    inputBinding:
      position: 9
  - id: key_file
    type:
      - 'null'
      - File
    doc: "Keyword (.key) file; it is staged as <base name>.key beside the main input file"
  - id: parameter_files
    type:
      - 'null'
      - File[]
    doc: "Force field parameter files named in the key file (for example mm3.prm); staged in the working directory"
outputs:
  - id: stdout
    type: stdout
    doc: "Program report written to standard output"
  - id: structures
    type: File[]
    doc: "Generated structures (<name>.001, <name>.002, ...)"
    outputBinding:
      glob: $(inputs.coordinate_file.nameroot).[0-9][0-9][0-9]
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: |
      ${
        var l = [];
        l.push({"entryname": inputs.coordinate_file.basename, "entry": inputs.coordinate_file, "writable": true});
        if (inputs.key_file) { l.push({"entryname": inputs.coordinate_file.nameroot + ".key", "entry": inputs.key_file}); }
        (inputs.parameter_files || []).forEach(function(f) { l.push({"entryname": f.basename, "entry": f}); });
        return l;
      }
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tinker:8.11.3--h8d36177_0
stdout: tinker_distgeom.out
