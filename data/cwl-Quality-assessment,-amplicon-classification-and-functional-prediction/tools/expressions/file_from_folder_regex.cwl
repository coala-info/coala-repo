cwlVersion: v1.2

class: ExpressionTool

label: "File from folder regex"
doc: |
  Expression to filter a single file from a directory. Return nothing with no hit.

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
    type: string
    label: Regex (JS)
    doc: |
      JavaScript regular expression to be used on the filenames
      for example: ".*unbinned.*"
  output_file_name:
    label: Output name
    doc: Rename output file.
    type: string?
    
expression: |
  ${
    var regex = new RegExp(inputs.regex);
    var outfile;
    for (var i = 0; i < inputs.folder.listing.length; i++) {
        if (regex.test(inputs.folder.listing[i].location)){
            outfile = inputs.folder.listing[i]; 
            if (inputs.output_file_name) {
                outfile.basename = inputs.output_file_name
            }
        }
    }
    if (outfile){
        return { "out_file": outfile };
    } else {
        return { "out_file": null };
    }    
  }

outputs:
  out_file:
    type: File?


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
s:dateModified: 2024-10-07
s:dateCreated: "2024-04-00"
s:license: https://spdx.org/licenses/Apache-2.0
s:copyrightHolder: "UNLOCK - Unlocking Microbial Potential"

$namespaces:
  s: https://schema.org/


        # var empty_file;
        # empty_file = {'file':
        #                 { "class": "File",
        #                   "basename": "empty_file",
        #                   "contents": "",
        #                 }
        #              };