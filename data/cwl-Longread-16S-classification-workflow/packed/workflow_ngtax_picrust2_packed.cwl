{
    "$graph": [
        {
            "class": "CommandLineTool",
            "label": "Compress a directory (tar)",
            "hints": [
                {
                    "dockerPull": "debian:buster",
                    "class": "DockerRequirement"
                }
            ],
            "baseCommand": [
                "tar",
                "czfh"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.indir.basename).tar.gz"
                },
                {
                    "valueFrom": "-C"
                },
                {
                    "valueFrom": "$(inputs.indir.path)/.."
                },
                {
                    "valueFrom": "$(inputs.indir.basename)"
                }
            ],
            "inputs": [
                {
                    "type": "Directory",
                    "id": "#compress_directory.cwl/indir"
                }
            ],
            "id": "#compress_directory.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.indir.basename).tar.gz"
                    },
                    "id": "#compress_directory.cwl/outfile"
                }
            ]
        },
        {
            "class": "ExpressionTool",
            "doc": "Transforms the input files to a mentioned directory\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "id": "#files_to_folder.cwl/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "id": "#files_to_folder.cwl/files"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "Directory"
                        }
                    ],
                    "id": "#files_to_folder.cwl/folders"
                }
            ],
            "expression": "${\n  var array = []\n  if (inputs.files != null) {\n    array = array.concat(inputs.files)\n  }\n  if (inputs.folders != null) {\n    array = array.concat(inputs.folders)\n  }\n  var r = {\n     'results':\n       { \"class\": \"Directory\",\n         \"basename\": inputs.destination,\n         \"listing\": array\n       } \n     };\n   return r; \n }\n",
            "outputs": [
                {
                    "type": "Directory",
                    "id": "#files_to_folder.cwl/results"
                }
            ],
            "id": "#files_to_folder.cwl",
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "http://schema.org/dateModified": "2024-10-07",
            "http://schema.org/dateCreated": "2020-00-00",
            "http://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "http://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "baseCommand": [
                "fastqc"
            ],
            "label": "FASTQC",
            "doc": "Performs quality control on FASTQ files\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "InitialWorkDirRequirement",
                    "listing": [
                        {
                            "entry": "$({class: 'Directory', listing: []})",
                            "entryname": "FASTQC",
                            "writable": true
                        }
                    ]
                }
            ],
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/fastqc:0.12.1--hdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "0.12.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/fastqc"
                            ],
                            "package": "fastqc"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "arguments": [
                "--outdir",
                "FASTQC"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "doc": "FastQ file list",
                    "label": "FASTQ file list",
                    "inputBinding": {
                        "position": 100
                    },
                    "id": "#fastqc.cwl/fastq"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "FastQ files list",
                    "label": "FASTQ files list",
                    "inputBinding": {
                        "position": 101,
                        "prefix": "--nano"
                    },
                    "id": "#fastqc.cwl/nanopore_reads"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "id": "#fastqc.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "FASTQC/*.html"
                    },
                    "id": "#fastqc.cwl/html_files"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputBinding": {
                        "glob": "FASTQC/*.zip"
                    },
                    "id": "#fastqc.cwl/zip_files"
                }
            ],
            "id": "#fastqc.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0002-5516-8391",
                    "https://schema.org/email": "mailto:german.royvalgarcia@wur.nl",
                    "https://schema.org/name": "Germ\u00e1n Royval"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-11-26",
            "https://schema.org/dateModified": "2022-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "NGTax amplicon analysis",
            "doc": "Runs NGTAX amplicon analysis\n",
            "requirements": [
                {
                    "listing": [
                        "$(inputs.reference_db)",
                        "$(inputs.reference_db_lookup)"
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/ngtax:2.2.17",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "17.0.3"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "java"
                        },
                        {
                            "version": [
                                "2.2.9"
                            ],
                            "specs": [
                                "https://wurssb.gitlab.io/ngtax/",
                                "file:///home/bart/git/cwl/tools/ngtax/doi.org/10.3389/fgene.2019.01366"
                            ],
                            "package": "ngtax"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "doc": "Folder containing demultiplexed files_to_folder",
                    "label": "Demultiplexed folder",
                    "inputBinding": {
                        "prefix": "-folder"
                    },
                    "id": "#ngtax.cwl/folder"
                },
                {
                    "type": "int",
                    "doc": "Read length of the reverse read",
                    "label": "Reverse read length",
                    "inputBinding": {
                        "prefix": "-for_read_len"
                    },
                    "id": "#ngtax.cwl/for_read_len"
                },
                {
                    "type": "string",
                    "doc": "Forward primer used",
                    "label": "The forward primer used",
                    "inputBinding": {
                        "prefix": "-for_p"
                    },
                    "id": "#ngtax.cwl/forward_primer"
                },
                {
                    "type": "string",
                    "doc": "Subfragment that is being analysed (e.g. V1-V3 or V5-region)",
                    "label": "Subfragment name",
                    "id": "#ngtax.cwl/fragment"
                },
                {
                    "type": [
                        "null",
                        "float"
                    ],
                    "doc": "Minimum threshold detectable, expressed in percentage",
                    "label": "Minimum threshold",
                    "default": 0.1,
                    "inputBinding": {
                        "prefix": "-minimumThreshold"
                    },
                    "id": "#ngtax.cwl/minimum_threshold"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Mock3 reference selection",
                    "label": "Mock3 reference",
                    "id": "#ngtax.cwl/mock3"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Mock4 reference selection",
                    "label": "Mock4 reference",
                    "id": "#ngtax.cwl/mock4"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Wether the primers are removed or not from the input files",
                    "label": "Primers are removed",
                    "inputBinding": {
                        "prefix": "-primersRemoved"
                    },
                    "id": "#ngtax.cwl/primersRemoved"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference database used in FASTA format",
                    "label": "Reference database",
                    "secondaryFiles": {
                        "pattern": "*",
                        "required": false
                    },
                    "inputBinding": {
                        "prefix": "-refdb"
                    },
                    "id": "#ngtax.cwl/reference_db"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference database lookup table that is generated by NG-Tax (for re-use purposes)",
                    "label": "Reference database lookup table",
                    "id": "#ngtax.cwl/reference_db_lookup"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Number of rejected ASVs to be annotated",
                    "label": "Number rejected ASV annotation",
                    "inputBinding": {
                        "prefix": "-rejectedASVAnnotation"
                    },
                    "default": 100,
                    "id": "#ngtax.cwl/rejected_asv_annotation"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Read length of the reverse read",
                    "label": "Reverse read length",
                    "inputBinding": {
                        "prefix": "-rev_read_len"
                    },
                    "id": "#ngtax.cwl/rev_read_len"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Reverse primer used",
                    "label": "The reverse primer used",
                    "inputBinding": {
                        "prefix": "-rev_p"
                    },
                    "id": "#ngtax.cwl/reverse_primer"
                },
                {
                    "type": "string",
                    "doc": "Name of the sample being analysed",
                    "label": "Sample name",
                    "id": "#ngtax.cwl/sample"
                }
            ],
            "baseCommand": [
                "java",
                "-jar",
                "/NGTax.jar",
                "-ngtax",
                "-mapFile",
                "cwl_mapping_file.txt"
            ],
            "arguments": [
                {
                    "prefix": "-t",
                    "valueFrom": "$(inputs.sample)_NG-Tax_$(inputs.for_read_len).ttl"
                },
                {
                    "prefix": "-b",
                    "valueFrom": "$(inputs.sample)_NG-Tax_$(inputs.for_read_len).biom"
                },
                {
                    "prefix": "-mock3",
                    "valueFrom": "$(inputs.mock3)"
                },
                {
                    "prefix": "-mock4",
                    "valueFrom": "$(inputs.mock4)"
                },
                {
                    "prefix": "-fragment",
                    "valueFrom": "$(inputs.fragment)"
                }
            ],
            "stdout": "ngtax2.stdout.log",
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample)_NG-Tax_$(inputs.for_read_len).biom"
                    },
                    "id": "#ngtax.cwl/biom"
                },
                {
                    "$import": "#ngtax.cwl/reference_db_lookup"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "ngtax2.stdout.log"
                    },
                    "id": "#ngtax.cwl/stdout_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.sample)_NG-Tax_$(inputs.for_read_len).ttl"
                    },
                    "id": "#ngtax.cwl/turtle"
                }
            ],
            "id": "#ngtax.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2023-02-06",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "doc": "NGtax2 output conversion to prepare for biom file and ASV fasta file\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/scripts:1.0.1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.2.9"
                            ],
                            "specs": [
                                "https://wurssb.gitlab.io/ngtax/",
                                "file:///home/bart/git/cwl/tools/ngtax/doi.org/10.3389/fgene.2019.01366"
                            ],
                            "package": "ngtax"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "doc": "Fragment identifier that was used",
                    "label": "fragment identifier",
                    "id": "#ngtax_to_tsv-fasta.cwl/fragment"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#ngtax_to_tsv-fasta.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "NGTax2 turtle output file",
                    "label": "NGTax2 turtle file",
                    "id": "#ngtax_to_tsv-fasta.cwl/input"
                }
            ],
            "baseCommand": [
                "python3",
                "/scripts/ngtax_to_tsv-fasta.py"
            ],
            "arguments": [
                "-t",
                "$(inputs.input.path)",
                "-i",
                "$(inputs.identifier)",
                "-f",
                "$(inputs.fragment)"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_asv.tsv"
                    },
                    "id": "#ngtax_to_tsv-fasta.cwl/physeq_asv"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_seq.tsv"
                    },
                    "id": "#ngtax_to_tsv-fasta.cwl/physeq_seq"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*_tax.tsv"
                    },
                    "id": "#ngtax_to_tsv-fasta.cwl/physeq_tax"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.picrust.fasta"
                    },
                    "id": "#ngtax_to_tsv-fasta.cwl/picrust_fasta"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.picrust.tsv"
                    },
                    "id": "#ngtax_to_tsv-fasta.cwl/picrust_tsv"
                }
            ],
            "id": "#ngtax_to_tsv-fasta.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "PICRUSt2 pipeline",
            "doc": "PICRUSt2 (Phylogenetic Investigation of Communities by Reconstruction of Unobserved States) is a software for predicting functional abundances based only on marker gene sequences.\nFunction usually refers to gene families such as KEGG orthologs and Enzyme Classification numbers, but predictions can be made for any arbitrary trait. \nSimilarly, predictions are typically based on 16S rRNA gene sequencing data, but other marker genes can also be used.\n",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/picrust2:2.5.2--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.5.2"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/picrust2",
                                "file:///home/bart/git/cwl/tools/picrust2/doi.org/10.1038/s41587-020-0548-6"
                            ],
                            "package": "picrust2"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "baseCommand": [
                "picrust2_pipeline.py"
            ],
            "inputs": [
                {
                    "type": "File",
                    "doc": "FASTA of unaligned sequences",
                    "label": "Input fasta",
                    "inputBinding": {
                        "prefix": "-s"
                    },
                    "id": "#picrust2_pipeline.cwl/fasta"
                },
                {
                    "type": "string",
                    "doc": "Identifier for this dataset used in this workflow",
                    "label": "identifier used",
                    "id": "#picrust2_pipeline.cwl/identifier"
                },
                {
                    "type": "File",
                    "doc": "Input table of sequence abundances (BIOM, TSV, or mothur shared file format)",
                    "label": "Input table",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#picrust2_pipeline.cwl/input_table"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Flag to indicate that stratified tables should be generated at all steps (will increase run-time).",
                    "label": "Stratified tables",
                    "inputBinding": {
                        "prefix": "--stratified"
                    },
                    "id": "#picrust2_pipeline.cwl/stratified"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "number of threads to use for computational processes",
                    "label": "number of threads",
                    "default": 2,
                    "inputBinding": {
                        "prefix": "-p"
                    },
                    "id": "#picrust2_pipeline.cwl/threads"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "--in_traits IN_TRAITS - Comma-delimited list (with no spaces) of which gene families to predict from this set: COG, EC, KO, PFAM, TIGRFAM. Note that EC numbers will always be predicted unless --no_pathways is set (default: EC,KO).",
                    "label": "Comma-delimited list of which gene families to predict from",
                    "inputBinding": {
                        "prefix": "--in_traits"
                    },
                    "default": "COG,EC,KO,PFAM,TIGRFAM",
                    "id": "#picrust2_pipeline.cwl/traits"
                }
            ],
            "arguments": [
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.identifier)_PICRUSt2"
                },
                {
                    "prefix": "--in_traits",
                    "valueFrom": "$(inputs.traits)"
                }
            ],
            "stdout": "$(inputs.identifier)_picrust2.stdout.log",
            "stderr": "$(inputs.identifier)_picrust2.stderr.log",
            "outputs": [
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/COG_metagenome_out"
                    },
                    "id": "#picrust2_pipeline.cwl/COG_metagenome_out"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/EC_metagenome_out"
                    },
                    "id": "#picrust2_pipeline.cwl/EC_metagenome_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/EC_predicted.tsv.gz"
                    },
                    "id": "#picrust2_pipeline.cwl/EC_predicted.tsv.gz"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/KO_metagenome_out"
                    },
                    "id": "#picrust2_pipeline.cwl/KO_metagenome_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/KO_predicted.tsv.gz"
                    },
                    "id": "#picrust2_pipeline.cwl/KO_predicted.tsv.gz"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/PFAM_metagenome_out"
                    },
                    "id": "#picrust2_pipeline.cwl/PFAM_metagenome_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/PFAM_predicted.tsv.gz"
                    },
                    "id": "#picrust2_pipeline.cwl/PFAM_predicted.tsv.gz"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/TIGRFAM_metagenome_out"
                    },
                    "id": "#picrust2_pipeline.cwl/TIGRFAM_metagenome_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/TIGRFAM_predicted.tsv.gz"
                    },
                    "id": "#picrust2_pipeline.cwl/TIGRFAM_predicted.tsv.gz"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/intermediate"
                    },
                    "id": "#picrust2_pipeline.cwl/intermediate"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/marker_predicted_and_nsti.tsv.gz"
                    },
                    "id": "#picrust2_pipeline.cwl/marker_predicted_and_nsti.tsv.gz"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/out.tre"
                    },
                    "id": "#picrust2_pipeline.cwl/out.tre"
                },
                {
                    "type": "Directory",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_PICRUSt2/pathways_out"
                    },
                    "id": "#picrust2_pipeline.cwl/pathways_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_picrust2.stderr.log"
                    },
                    "id": "#picrust2_pipeline.cwl/stderr_out"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier)_picrust2.stdout.log"
                    },
                    "id": "#picrust2_pipeline.cwl/stdout_out"
                }
            ],
            "id": "#picrust2_pipeline.cwl",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-00-00",
            "https://schema.org/dateModified": "2023-02-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                }
            ],
            "label": "Quality assessment, amplicon classification and functional prediction",
            "doc": "Workflow for quality assessment of paired reads and classification using NGTax 2.0 and functional annotation using PICRUSt2. \nIn addition files are exported to their respective subfolders for easier data management in a later stage.\nSteps:  \n    - FastQC (read quality control)\n    - NGTax 2.0\n    - PICRUSt2\n    - Export module for ngtax\n",
            "inputs": [
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Optional Output destination used for cwl-prov reporting.",
                    "id": "#main/destination"
                },
                {
                    "type": "int",
                    "doc": "Read length of the reverse read",
                    "label": "Reverse read length",
                    "id": "#main/for_read_len"
                },
                {
                    "type": "string",
                    "doc": "Forward primer used",
                    "label": "Forward primer",
                    "id": "#main/forward_primer"
                },
                {
                    "type": "File",
                    "doc": "forward sequence file locally",
                    "label": "forward reads",
                    "id": "#main/forward_reads"
                },
                {
                    "type": "string",
                    "doc": "Subfragment that is being analysed (e.g. V1-V3 or V5-region)",
                    "label": "Subfragment name",
                    "id": "#main/fragment"
                },
                {
                    "type": "float",
                    "doc": "Minimum threshold detectable, expressed in percentage (default 0.1)",
                    "label": "Minimum threshold",
                    "default": 0.1,
                    "id": "#main/minimum_threshold"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "PICRUSt2 flag to indicate that stratified tables should be generated at all steps (will increase run-time).",
                    "label": "Stratified picrust2 tables",
                    "default": false,
                    "id": "#main/picrust2_stratified"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "doc": "Wether the primers are removed or not from the input files",
                    "label": "Primers are removed",
                    "id": "#main/primersRemoved"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference database used in FASTA format",
                    "label": "Reference database",
                    "id": "#main/reference_db"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Read length of the reverse read",
                    "label": "Reverse read length",
                    "id": "#main/rev_read_len"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Reverse primer used",
                    "label": "Reverse primer",
                    "id": "#main/reverse_primer"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "reverse sequence file locally",
                    "label": "reverse reads",
                    "id": "#main/reverse_reads"
                },
                {
                    "type": "string",
                    "doc": "Name of the sample being analysed",
                    "label": "Sample name",
                    "id": "#main/sample"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "number of threads to use for computational processes",
                    "label": "number of threads",
                    "default": 2,
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "run": "#fastqc.cwl",
                    "in": [
                        {
                            "source": [
                                "#main/forward_reads",
                                "#main/reverse_reads"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/fastqc/fastq"
                        }
                    ],
                    "out": [
                        "#main/fastqc/html_files"
                    ],
                    "id": "#main/fastqc"
                },
                {
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"1_QualityControl\")",
                            "id": "#main/fastqc_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/fastqc/html_files"
                            ],
                            "id": "#main/fastqc_files_to_folder/files"
                        }
                    ],
                    "out": [
                        "#main/fastqc_files_to_folder/results"
                    ],
                    "id": "#main/fastqc_files_to_folder"
                },
                {
                    "when": "$(inputs.fasta.size > 1024)",
                    "run": "#compress_directory.cwl",
                    "in": [
                        {
                            "source": "#main/ngtax_to_tsv-fasta/picrust_fasta",
                            "id": "#main/folder_compression/fasta"
                        },
                        {
                            "source": "#main/picrust2/intermediate",
                            "id": "#main/folder_compression/indir"
                        }
                    ],
                    "out": [
                        "#main/folder_compression/outfile"
                    ],
                    "id": "#main/folder_compression"
                },
                {
                    "run": "#ngtax.cwl",
                    "in": [
                        {
                            "source": "#main/reads_to_folder/results",
                            "id": "#main/ngtax/folder"
                        },
                        {
                            "source": "#main/for_read_len",
                            "id": "#main/ngtax/for_read_len"
                        },
                        {
                            "source": "#main/forward_primer",
                            "id": "#main/ngtax/forward_primer"
                        },
                        {
                            "source": "#main/fragment",
                            "id": "#main/ngtax/fragment"
                        },
                        {
                            "source": "#main/minimum_threshold",
                            "id": "#main/ngtax/minimum_threshold"
                        },
                        {
                            "source": "#main/primersRemoved",
                            "id": "#main/ngtax/primersRemoved"
                        },
                        {
                            "source": "#main/reference_db",
                            "id": "#main/ngtax/reference_db"
                        },
                        {
                            "source": "#main/rev_read_len",
                            "id": "#main/ngtax/rev_read_len"
                        },
                        {
                            "source": "#main/reverse_primer",
                            "id": "#main/ngtax/reverse_primer"
                        },
                        {
                            "source": "#main/sample",
                            "id": "#main/ngtax/sample"
                        }
                    ],
                    "out": [
                        "#main/ngtax/biom",
                        "#main/ngtax/turtle",
                        "#main/ngtax/stdout_out"
                    ],
                    "id": "#main/ngtax"
                },
                {
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"2_Classification\")",
                            "id": "#main/ngtax_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/ngtax/biom",
                                "#main/ngtax/turtle",
                                "#main/ngtax/stdout_out"
                            ],
                            "id": "#main/ngtax_files_to_folder/files"
                        }
                    ],
                    "out": [
                        "#main/ngtax_files_to_folder/results"
                    ],
                    "id": "#main/ngtax_files_to_folder"
                },
                {
                    "run": "#ngtax_to_tsv-fasta.cwl",
                    "in": [
                        {
                            "source": "#main/fragment",
                            "id": "#main/ngtax_to_tsv-fasta/fragment"
                        },
                        {
                            "source": "#main/sample",
                            "id": "#main/ngtax_to_tsv-fasta/identifier"
                        },
                        {
                            "source": "#main/ngtax/turtle",
                            "id": "#main/ngtax_to_tsv-fasta/input"
                        }
                    ],
                    "out": [
                        "#main/ngtax_to_tsv-fasta/picrust_fasta",
                        "#main/ngtax_to_tsv-fasta/picrust_tsv",
                        "#main/ngtax_to_tsv-fasta/physeq_asv",
                        "#main/ngtax_to_tsv-fasta/physeq_seq",
                        "#main/ngtax_to_tsv-fasta/physeq_tax"
                    ],
                    "id": "#main/ngtax_to_tsv-fasta"
                },
                {
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"4_PHYLOSEQ\")",
                            "id": "#main/phyloseq_files_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/ngtax_to_tsv-fasta/physeq_asv",
                                "#main/ngtax_to_tsv-fasta/physeq_seq",
                                "#main/ngtax_to_tsv-fasta/physeq_tax"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/phyloseq_files_to_folder/files"
                        }
                    ],
                    "out": [
                        "#main/phyloseq_files_to_folder/results"
                    ],
                    "id": "#main/phyloseq_files_to_folder"
                },
                {
                    "when": "$(inputs.fasta.size > 1024)",
                    "run": "#picrust2_pipeline.cwl",
                    "in": [
                        {
                            "source": "#main/ngtax_to_tsv-fasta/picrust_fasta",
                            "id": "#main/picrust2/fasta"
                        },
                        {
                            "source": "#main/sample",
                            "id": "#main/picrust2/identifier"
                        },
                        {
                            "source": "#main/ngtax_to_tsv-fasta/picrust_tsv",
                            "id": "#main/picrust2/input_table"
                        },
                        {
                            "source": "#main/picrust2_stratified",
                            "id": "#main/picrust2/stratified"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/picrust2/threads"
                        }
                    ],
                    "out": [
                        "#main/picrust2/EC_metagenome_out",
                        "#main/picrust2/PFAM_metagenome_out",
                        "#main/picrust2/TIGRFAM_metagenome_out",
                        "#main/picrust2/COG_metagenome_out",
                        "#main/picrust2/KO_metagenome_out",
                        "#main/picrust2/intermediate",
                        "#main/picrust2/pathways_out",
                        "#main/picrust2/EC_predicted.tsv.gz",
                        "#main/picrust2/PFAM_predicted.tsv.gz",
                        "#main/picrust2/TIGRFAM_predicted.tsv.gz",
                        "#main/picrust2/KO_predicted.tsv.gz",
                        "#main/picrust2/marker_predicted_and_nsti.tsv.gz",
                        "#main/picrust2/out.tre",
                        "#main/picrust2/stdout_out",
                        "#main/picrust2/stderr_out"
                    ],
                    "id": "#main/picrust2"
                },
                {
                    "when": "$(inputs.fasta.size > 1024)",
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"3_PICRUSt2\")",
                            "id": "#main/picrust_files_to_folder/destination"
                        },
                        {
                            "source": "#main/ngtax_to_tsv-fasta/picrust_fasta",
                            "id": "#main/picrust_files_to_folder/fasta"
                        },
                        {
                            "source": [
                                "#main/picrust2/EC_predicted.tsv.gz",
                                "#main/picrust2/PFAM_predicted.tsv.gz",
                                "#main/picrust2/TIGRFAM_predicted.tsv.gz",
                                "#main/picrust2/KO_predicted.tsv.gz",
                                "#main/picrust2/marker_predicted_and_nsti.tsv.gz",
                                "#main/picrust2/out.tre",
                                "#main/folder_compression/outfile",
                                "#main/picrust2/stdout_out",
                                "#main/picrust2/stderr_out"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/picrust_files_to_folder/files"
                        },
                        {
                            "source": [
                                "#main/picrust2/EC_metagenome_out",
                                "#main/picrust2/PFAM_metagenome_out",
                                "#main/picrust2/TIGRFAM_metagenome_out",
                                "#main/picrust2/COG_metagenome_out",
                                "#main/picrust2/KO_metagenome_out",
                                "#main/picrust2/pathways_out"
                            ],
                            "linkMerge": "merge_flattened",
                            "id": "#main/picrust_files_to_folder/folders"
                        }
                    ],
                    "out": [
                        "#main/picrust_files_to_folder/results"
                    ],
                    "id": "#main/picrust_files_to_folder"
                },
                {
                    "run": "#files_to_folder.cwl",
                    "in": [
                        {
                            "valueFrom": "$(\"reads\")",
                            "id": "#main/reads_to_folder/destination"
                        },
                        {
                            "source": [
                                "#main/forward_reads",
                                "#main/reverse_reads"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/reads_to_folder/files"
                        }
                    ],
                    "out": [
                        "#main/reads_to_folder/results"
                    ],
                    "id": "#main/reads_to_folder"
                }
            ],
            "outputs": [
                {
                    "type": "Directory",
                    "outputSource": "#main/fastqc_files_to_folder/results",
                    "id": "#main/files_to_folder_fastqc"
                },
                {
                    "type": "Directory",
                    "outputSource": "#main/ngtax_files_to_folder/results",
                    "id": "#main/files_to_folder_ngtax"
                },
                {
                    "type": "Directory",
                    "outputSource": "#main/phyloseq_files_to_folder/results",
                    "id": "#main/files_to_folder_phyloseq"
                },
                {
                    "type": "Directory",
                    "outputSource": "#main/picrust_files_to_folder/results",
                    "id": "#main/files_to_folder_picrust2"
                },
                {
                    "type": "File",
                    "doc": "Used for other workflows",
                    "outputSource": "#main/ngtax/turtle",
                    "id": "#main/turtle"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2021-01-01",
            "https://schema.org/dateModified": "2023-02-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
