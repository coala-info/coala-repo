{
    "$graph": [
        {
            "class": "CommandLineTool",
            "label": "eggNOG",
            "doc": "eggNOG is a public resource that provides Orthologous Groups (OGs)\nof proteins at different taxonomic levels, each with integrated and summarized functional annotations.\n",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/eggnog-mapper:2.1.12--pyhdfd78af_0",
                    "class": "DockerRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.1.12"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/eggnog-mapper"
                            ],
                            "package": "eggnog"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "emapper.py"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "default": 4,
                    "id": "#eggnog.cwl/cpu"
                },
                {
                    "type": [
                        "null",
                        "string",
                        "Directory"
                    ],
                    "inputBinding": {
                        "prefix": "--data_dir"
                    },
                    "label": "Directory to use for DATA_PATH",
                    "id": "#eggnog.cwl/data_dir"
                },
                {
                    "type": [
                        "null",
                        "string",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--database"
                    },
                    "label": "specify the target database for sequence searches (euk,bact,arch, host:port, local hmmpressed database)",
                    "id": "#eggnog.cwl/db"
                },
                {
                    "type": [
                        "null",
                        "string",
                        "File"
                    ],
                    "inputBinding": {
                        "prefix": "--dmnd_db"
                    },
                    "label": "Path to DIAMOND-compatible database",
                    "id": "#eggnog.cwl/db_diamond"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "separate": true,
                        "prefix": "-i"
                    },
                    "label": "Input FASTA file containing protein sequences",
                    "id": "#eggnog.cwl/input_fasta"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "inputBinding": {
                        "prefix": "-m"
                    },
                    "label": "hmmer or diamond",
                    "default": "diamond",
                    "id": "#eggnog.cwl/mode"
                }
            ],
            "arguments": [
                {
                    "position": 1,
                    "valueFrom": "--dbmem"
                },
                {
                    "position": 2,
                    "prefix": "--annotate_hits_table",
                    "valueFrom": "$(inputs.input_fasta.nameroot)_eggnog_hits_table.tsv"
                },
                {
                    "position": 3,
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.nameroot)_eggnog.tsv"
                }
            ],
            "id": "#eggnog.cwl",
            "http://schema.org/author": "Ekaterina Sakharova",
            "http://schema.org/copyrightHolder": [
                {
                    "name": "#eggnog.cwl/EMBL - European Bioinformatics Institute"
                },
                {
                    "url": "https://www.ebi.ac.uk/"
                }
            ],
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot)*annotations*"
                    },
                    "id": "#eggnog.cwl/output_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot)*orthologs*"
                    },
                    "id": "#eggnog.cwl/output_orthologs"
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "InterProScan: protein sequence classifier",
            "doc": "InterProScan is the software package that allows sequences (protein and nucleic) to be scanned against InterPro's signatures. Signatures are predictive models, provided by several different databases, that make up the InterPro consortium.\nDocumentation on how to run InterProScan 5 can be found here: https://github.com/ebi-pf-team/interproscan/wiki/HowToRun",
            "requirements": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/interproscan:5.63-95.0",
                    "class": "DockerRequirement"
                },
                {
                    "listing": [
                        {
                            "entry": "$(inputs.interproscan)",
                            "writable": true
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "networkAccess": true,
                    "class": "NetworkAccess"
                }
            ],
            "baseCommand": [
                "bash",
                "-x"
            ],
            "arguments": [
                {
                    "position": 1,
                    "valueFrom": "$(inputs.interproscan.path)/interproscan.sh"
                },
                {
                    "position": 3,
                    "prefix": "-cpu",
                    "valueFrom": "16"
                },
                {
                    "position": 5,
                    "valueFrom": "--goterms"
                },
                {
                    "position": 6,
                    "valueFrom": "-pa"
                },
                {
                    "position": 7,
                    "valueFrom": "TSV,JSON",
                    "prefix": "-f"
                },
                {
                    "position": 8,
                    "valueFrom": "--iprlookup"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "inputBinding": {
                        "position": 3,
                        "prefix": "--applications"
                    },
                    "default": "Pfam,SFLD,SMART,AntiFam,NCBIfam",
                    "id": "#interproscan.cwl/applications"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--input"
                    },
                    "label": "Input protein fasta file path",
                    "id": "#interproscan.cwl/input_fasta"
                },
                {
                    "inputBinding": {
                        "position": 1
                    },
                    "type": "Directory",
                    "label": "InterProScan program directory path",
                    "id": "#interproscan.cwl/interproscan"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.json"
                    },
                    "id": "#interproscan.cwl/json_annotations"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#interproscan.cwl/tsv_annotations"
                }
            ],
            "id": "#interproscan.cwl",
            "http://schema.org/author": "Michael Crusoe, Aleksandra Ola Tarkowska, Maxim Scheremetjew, Ekaterina Sakharova",
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0"
        },
        {
            "class": "CommandLineTool",
            "label": "Gene annotation",
            "doc": "Runs KEGG KO annotation on protein sequences using. Requires a kofamscan conda environment.\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/kofamscan:1.3.0",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.2.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/hmmer"
                            ],
                            "package": "hmmer"
                        },
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
                                "1.3.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/kofamscan"
                            ],
                            "package": "kofamscan"
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
            "inputs": [
                {
                    "type": "File",
                    "doc": "Protein sequences in fasta file format",
                    "label": "Protein fasta file",
                    "inputBinding": {
                        "position": 100
                    },
                    "id": "#kofamscan.cwl/input_fasta"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 3,
                    "inputBinding": {
                        "prefix": "--cpu"
                    },
                    "id": "#kofamscan.cwl/threads"
                }
            ],
            "baseCommand": [
                "exec_annotation"
            ],
            "arguments": [
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.basename).kofamscan"
                },
                {
                    "prefix": "--profile",
                    "valueFrom": "/profiles/prokaryote.hal"
                },
                {
                    "prefix": "--ko-list",
                    "valueFrom": "/ko_list"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.basename).kofamscan"
                    },
                    "id": "#kofamscan.cwl/output"
                }
            ],
            "id": "#kofamscan.cwl",
            "https://schema.org/author": [
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
            "https://schema.org/dateCreated": "2022-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Prodigal",
            "doc": "Prokaryotic gene prediction using Prodigal with compressed input fasta (gzip) files.",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/prodigal:2.6.3",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.6.3"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/prodigal"
                            ],
                            "package": "prodigal"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
                {
                    "listing": [
                        {
                            "entry": "$({class: 'Directory', listing: []})",
                            "entryname": "prodigal_run",
                            "writable": true
                        },
                        {
                            "entryname": "script.sh",
                            "entry": "#!/bin/bash\nif [[ $1 == *.gz ]]; then\n  gunzip -c $1 > $(inputs.identifier).fasta;\nelse\n  cp $1 $(inputs.identifier).fasta;\nfi\nshift;\nprodigal $@ < $(inputs.identifier).fasta;"
                        }
                    ],
                    "class": "InitialWorkDirRequirement"
                },
                {
                    "class": "InlineJavascriptRequirement"
                }
            ],
            "baseCommand": [
                "bash",
                "-x",
                "script.sh"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.input_fasta.path)",
                    "shellQuote": false
                },
                {
                    "valueFrom": "$(inputs.identifier).prodigal.gff",
                    "prefix": "-o"
                },
                {
                    "valueFrom": "$(inputs.identifier).prodigal.ffn",
                    "prefix": "-d"
                },
                {
                    "valueFrom": "$(inputs.identifier).prodigal.faa",
                    "prefix": "-a"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).prodigal.faa"
                    },
                    "id": "#prodigal.cwl/predicted_proteins_faa"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).prodigal.ffn"
                    },
                    "id": "#prodigal.cwl/predicted_proteins_ffn"
                },
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).prodigal.gff"
                    },
                    "id": "#prodigal.cwl/predicted_proteins_out"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Codon table to use",
                    "default": 11,
                    "inputBinding": {
                        "prefix": "-g"
                    },
                    "id": "#prodigal.cwl/codon_table"
                },
                {
                    "type": "string",
                    "doc": "Identifier for the output files",
                    "id": "#prodigal.cwl/identifier"
                },
                {
                    "type": "File",
                    "id": "#prodigal.cwl/input_fasta"
                },
                {
                    "doc": "Input is a meta-genome or an isolate genome",
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#prodigal.cwl/mode/single",
                                "#prodigal.cwl/mode/meta"
                            ]
                        }
                    ],
                    "inputBinding": {
                        "prefix": "-p"
                    },
                    "id": "#prodigal.cwl/mode"
                }
            ],
            "id": "#prodigal.cwl",
            "https://schema.org/author": [
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
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-6867-2039",
                    "https://schema.org/name": "Ekaterina Sakharova"
                }
            ],
            "https://schema.org/copyrightHolder'": "EMBL - European Bioinformatics Institute",
            "https://schema.org/license'": "https://www.apache.org/licenses/LICENSE-2.0",
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-06-00",
            "https://schema.org/dateModified": "2022-08-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "https://schema.org/copyrightNotice": " Copyright < 2022 EMBL - European Bioinformatics Institute This file has been modified by UNLOCK - Unlocking Microbial Potential "
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
                },
                {
                    "class": "LoadListingRequirement"
                }
            ],
            "label": "Genome annotation",
            "doc": "Workflow for genome annotation from FASTA format",
            "inputs": [
                {
                    "type": "int",
                    "doc": "Codon table used for gene prediction (4/11)",
                    "label": "Codon table",
                    "id": "#main/codon_table"
                },
                {
                    "type": "Directory",
                    "doc": "Path to the eggnog data directory",
                    "label": "EggNOG data directory",
                    "loadListing": "no_listing",
                    "id": "#main/eggnog_data_dir"
                },
                {
                    "type": "File",
                    "doc": "Path to the eggnog database",
                    "label": "EggNOG database",
                    "id": "#main/eggnog_db"
                },
                {
                    "type": "File",
                    "doc": "Path to the eggnog diamond database",
                    "label": "EggNOG diamond database",
                    "id": "#main/eggnog_db_diamond"
                },
                {
                    "type": "File",
                    "doc": "Genome sequence in FASTA format",
                    "label": "FASTA input file",
                    "id": "#main/fasta"
                },
                {
                    "type": "Directory",
                    "doc": "Path to the interproscan application directory",
                    "label": "InterProScan path",
                    "loadListing": "no_listing",
                    "id": "#main/interpro"
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
                    "run": "#eggnog.cwl",
                    "in": [
                        {
                            "source": "#main/eggnog_data_dir",
                            "id": "#main/eggnog/data_dir"
                        },
                        {
                            "source": "#main/eggnog_db",
                            "id": "#main/eggnog/db"
                        },
                        {
                            "source": "#main/eggnog_db_diamond",
                            "id": "#main/eggnog/db_diamond"
                        },
                        {
                            "source": "#main/prodigal/predicted_proteins_faa",
                            "id": "#main/eggnog/input_fasta"
                        }
                    ],
                    "out": [
                        "#main/eggnog/output_annotations",
                        "#main/eggnog/output_orthologs"
                    ],
                    "id": "#main/eggnog"
                },
                {
                    "run": "#interproscan.cwl",
                    "in": [
                        {
                            "source": "#main/prodigal/predicted_proteins_faa",
                            "id": "#main/interproscan/input_fasta"
                        },
                        {
                            "source": "#main/interpro",
                            "id": "#main/interproscan/interpro"
                        }
                    ],
                    "out": [
                        "#main/interproscan/tsv_annotations",
                        "#main/interproscan/json_annotations"
                    ],
                    "id": "#main/interproscan"
                },
                {
                    "run": "#kofamscan.cwl",
                    "in": [
                        {
                            "source": "#main/prodigal/predicted_proteins_faa",
                            "id": "#main/kofamscan/input_fasta"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/kofamscan/threads"
                        }
                    ],
                    "out": [
                        "#main/kofamscan/output"
                    ],
                    "id": "#main/kofamscan"
                },
                {
                    "run": "#prodigal.cwl",
                    "in": [
                        {
                            "source": "#main/codon_table",
                            "id": "#main/prodigal/codon_table"
                        },
                        {
                            "source": "#main/fasta",
                            "id": "#main/prodigal/input_fasta"
                        }
                    ],
                    "out": [
                        "#main/prodigal/predicted_proteins_out",
                        "#main/prodigal/predicted_proteins_ffn",
                        "#main/prodigal/predicted_proteins_faa"
                    ],
                    "id": "#main/prodigal"
                }
            ],
            "outputs": [
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": [
                        "#main/interproscan/tsv_annotations",
                        "#main/interproscan/json_annotations"
                    ],
                    "id": "#main/interproscan_out"
                },
                {
                    "type": "File",
                    "outputSource": "#main/kofamscan/output",
                    "id": "#main/kofamscan_out"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": [
                        "#main/prodigal/predicted_proteins_out",
                        "#main/prodigal/predicted_proteins_ffn",
                        "#main/prodigal/predicted_proteins_faa"
                    ],
                    "id": "#main/prodigal_out"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
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
            "https://schema.org/dateModified": "2022-05-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$schemas": [
        "https://schema.org/version/latest/schemaorg-current-https.rdf",
        "http://edamontology.org/EDAM_1.16.owl",
        "https://schema.org/version/latest/schemaorg-current-http.rdf",
        "http://edamontology.org/EDAM_1.20.owl"
    ],
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
