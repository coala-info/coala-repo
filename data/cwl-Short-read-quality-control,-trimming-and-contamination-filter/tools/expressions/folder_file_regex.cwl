cwlVersion: v1.2

class: ExpressionTool

doc: |
  Expression to filter files (by name) in a directory using a regular expression.


requirements:
  InlineJavascriptRequirement: {}
hints:
  LoadListingRequirement:
    loadListing: shallow_listing

inputs:
  folder:
    label: Input folder
    doc: Folder with only files
    type: Directory
  regex:
    label: Regex (JS)
    doc: |
      JavaScript regular expression to be used on the filenames
      MetaBAT2 example: "bin\.[0-9]+\.fa"
    type: string
  exclude:
    type: boolean
    label: Reverse
    doc: Exclude files with regex. (default false)
  output_folder_name:
    type: string?
    label: Output folder name
    doc: Output folder name. When output folder is true. (default 'filtered')
  output_as_folder:
    type: boolean
    label: Output as folder
    doc: Output files in folder when true. (default false)

expression: |
  ${
    var regex = new RegExp(inputs.regex);
    var array = [];
    if (inputs.exclude == false) {
      for (var i = 0; i < inputs.folder.listing.length; i++) {
        if (regex.test(inputs.folder.listing[i].location)){
          array = array.concat(inputs.folder.listing[i]);
        }
      }
    } else {
      for (var i = 0; i < inputs.folder.listing.length; i++) {
        if (!regex.test(inputs.folder.listing[i].location)){
          array = array.concat(inputs.folder.listing[i]);
        }  
      }    
    }
    if (inputs.output_as_folder) {
          var r = {
       'output_folder':
         { "class": "Directory",
           "basename": inputs.output_folder_name,
           "listing": array
         }
       };
    } else {
      r = array;
    }
     return r;
  }

outputs:
  output_folder:
    type: Directory?
  output_files:
    type: File[]?

s:author:
  - class: s:Person
    s:identifier: https://orcid.org/0009-0001-1350-5644
    s:email: mailto:changlin.ke@wur.nl
    s:name: Changlin Ke
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-8172-8981
    s:email: mailto:jasper.koehorst@wur.nl
    s:name: Jasper Koehorst
  - class: s:Person
    s:identifier: https://orcid.org/0000-0001-9524-5964
    s:email: mailto:bart.nijsse@wur.nl
    s:name: Bart Nijsse

s:citation: https://m-unlock.nl
s:codeRepository: https://gitlab.com/m-unlock/cwl
s:dateCreated: "2022-10-00"
s:dateModified: "2022-10-00"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/
