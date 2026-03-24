{
    "$graph": [
        {
            "class": "CommandLineTool",
            "id": "#bakta.cwl",
            "label": "Bakta: rapid & standardized annotation of bacterial genomes, MAGs & plasmids",
            "doc": "The software and documentation can be found here:\nhttps://github.com/oschwengers/bakta\n\nNecessary database files can be found here:\nhttps://doi.org/10.5281/zenodo.4247252\n",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "ramMin": 4096,
                    "coresMin": 1,
                    "class": "ResourceRequirement"
                }
            ],
            "hints": [
                {
                    "class": "LoadListingRequirement",
                    "loadListing": "deep_listing"
                },
                {
                    "class": "NetworkAccess",
                    "networkAccess": true
                },
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/bakta:1.9.4-db-light5.1",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "1.9.4"
                            ],
                            "specs": [
                                "https://github.com/oschwengers/bakta",
                                "doi.org/10.1099/mgen.0.000685"
                            ],
                            "package": "bakta"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "arguments": [
                {
                    "prefix": "--db",
                    "valueFrom": "${\n  // check if custom profile directory is used\n  if (inputs.db){\n    return inputs.db.path\n  }\n  // else use default built-in bakta db-light database\n  else { \n    return \"/bakta-db_v5.1-light\";\n  }\n}\n"
                }
            ],
            "inputs": [
                {
                    "doc": "Genome assembly in Fasta format",
                    "id": "#bakta.cwl/bakta/fasta_file",
                    "inputBinding": {
                        "position": 100
                    },
                    "type": "File"
                },
                {
                    "doc": "Database path (default = build-in light database)",
                    "id": "#bakta.cwl/bakta/db",
                    "type": [
                        "null",
                        "Directory"
                    ]
                },
                {
                    "doc": "Minimum contig size (default = 1; 200 in compliant mode)",
                    "id": "#bakta.cwl/bakta/min_contig_length",
                    "inputBinding": {
                        "prefix": "--min-contig-length"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Prefix for output files",
                    "id": "#bakta.cwl/bakta/prefix",
                    "inputBinding": {
                        "prefix": "--prefix"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Output directory (default = current working directory)",
                    "id": "#bakta.cwl/bakta/output",
                    "inputBinding": {
                        "prefix": "--output"
                    },
                    "type": [
                        "null",
                        "Directory"
                    ]
                },
                {
                    "doc": "Force overwriting existing output folder (except for current working directory)",
                    "id": "#bakta.cwl/bakta/force",
                    "inputBinding": {
                        "prefix": "--force"
                    },
                    "default": true,
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Genus name",
                    "id": "#bakta.cwl/bakta/genus",
                    "inputBinding": {
                        "prefix": "--genus"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Species name",
                    "id": "#bakta.cwl/bakta/species",
                    "inputBinding": {
                        "prefix": "--species"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Strain name",
                    "id": "#bakta.cwl/bakta/strain",
                    "inputBinding": {
                        "prefix": "--strain"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Plasmid name",
                    "id": "#bakta.cwl/bakta/plasmid",
                    "inputBinding": {
                        "prefix": "--plasmid"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "All sequences are complete replicons (chromosome/plasmid[s])",
                    "id": "#bakta.cwl/bakta/complete",
                    "inputBinding": {
                        "prefix": "--complete"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Prodigal training file for CDS prediction",
                    "id": "#bakta.cwl/bakta/prodigal_tf_file",
                    "inputBinding": {
                        "prefix": "--prodigal-tf"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Translation table 11/4 (default = 11)",
                    "id": "#bakta.cwl/bakta/translation_table",
                    "inputBinding": {
                        "prefix": "--translation-table"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Gram type (default = ?)",
                    "id": "#bakta.cwl/bakta/gram",
                    "inputBinding": {
                        "prefix": "--gram"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Locus prefix (default = contig)",
                    "id": "#bakta.cwl/bakta/locus",
                    "inputBinding": {
                        "prefix": "--locus"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Locus tag prefix (default = autogenerated)",
                    "id": "#bakta.cwl/bakta/locus_tag",
                    "inputBinding": {
                        "prefix": "--locus-tag"
                    },
                    "type": [
                        "null",
                        "string"
                    ]
                },
                {
                    "doc": "Keep original contig headers",
                    "id": "#bakta.cwl/bakta/keep_contig_headers",
                    "inputBinding": {
                        "prefix": "--keep-contig-headers"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Force Genbank/ENA/DDJB compliance",
                    "id": "#bakta.cwl/bakta/compliant",
                    "inputBinding": {
                        "prefix": "--compliant"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Replicon information table (tsv/csv)",
                    "id": "#bakta.cwl/bakta/replicons",
                    "inputBinding": {
                        "prefix": "--replicons"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Genbank/GFF3 file of trusted regions for pre-detected feature coordinates",
                    "id": "#bakta.cwl/bakta/regions",
                    "inputBinding": {
                        "prefix": "--regions"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Fasta file of trusted protein sequences for CDS annotation",
                    "id": "#bakta.cwl/bakta/proteins",
                    "inputBinding": {
                        "prefix": "--proteins"
                    },
                    "type": [
                        "null",
                        "File"
                    ]
                },
                {
                    "doc": "Run in metagenome mode",
                    "id": "#bakta.cwl/bakta/meta",
                    "inputBinding": {
                        "prefix": "--meta"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip tRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_tRNA",
                    "inputBinding": {
                        "prefix": "--skip-trna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip tmRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_tmrna",
                    "inputBinding": {
                        "prefix": "--skip-tmrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip rRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_rrna",
                    "inputBinding": {
                        "prefix": "--skip-rrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ncRNA detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ncrna",
                    "inputBinding": {
                        "prefix": "--skip-ncrna"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ncRNA region detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ncrna_region",
                    "inputBinding": {
                        "prefix": "--skip-ncrna-region"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip CRISPR detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_crispr",
                    "inputBinding": {
                        "prefix": "--skip-crispr"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip CDS detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_cds",
                    "inputBinding": {
                        "prefix": "--skip-cds"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip Pseudogene detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_pseudo",
                    "inputBinding": {
                        "prefix": "--skip-pseudo"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip sORF detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_sorf",
                    "inputBinding": {
                        "prefix": "--skip-sorf"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip gap detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_gap",
                    "inputBinding": {
                        "prefix": "--skip-gap"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip ori detection & annotation",
                    "id": "#bakta.cwl/bakta/skip_ori",
                    "inputBinding": {
                        "prefix": "--skip-ori"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Skip genome plotting",
                    "id": "#bakta.cwl/bakta/skip_plot",
                    "inputBinding": {
                        "prefix": "--skip-plot"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Print verbose information",
                    "id": "#bakta.cwl/bakta/verbose",
                    "inputBinding": {
                        "prefix": "--verbose"
                    },
                    "default": true,
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Run Bakta in debug mode",
                    "id": "#bakta.cwl/bakta/debug",
                    "inputBinding": {
                        "prefix": "--debug"
                    },
                    "type": [
                        "null",
                        "boolean"
                    ]
                },
                {
                    "doc": "Threads",
                    "id": "#bakta.cwl/bakta/threads",
                    "inputBinding": {
                        "prefix": "--threads"
                    },
                    "type": [
                        "null",
                        "int"
                    ]
                },
                {
                    "doc": "Directory for temporary files (default = system dependent auto detection)",
                    "id": "#bakta.cwl/bakta/tmp_dir",
                    "inputBinding": {
                        "prefix": "--tmp-dir"
                    },
                    "type": [
                        "null",
                        "Directory"
                    ]
                }
            ],
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0003-4216-2721",
                    "https://schema.org/email": "mailto:oliver.schwengers@computational.bio.uni-giessen.de",
                    "https://schema.org/name": "Oliver Schwengers"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2024-07-08",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential",
            "outputs": [
                {
                    "doc": "Hypothetical CDS AA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/hypo_sequences_cds",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.hypotheticals.faa"
                    }
                },
                {
                    "doc": "Information on hypothetical CDS as TSV",
                    "id": "#bakta.cwl/bakta/hypo_annotation_tsv",
                    "type": "File",
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "*.hypotheticals.tsv"
                    }
                },
                {
                    "doc": "Annotation as TSV",
                    "id": "#bakta.cwl/bakta/annotation_tsv",
                    "type": "File",
                    "format": "http://edamontology.org/format_3475",
                    "outputBinding": {
                        "glob": "${ if (inputs.prefix !== null) { return inputs.prefix + '.tsv'; } else{ return inputs.fasta_file.basename.replace(/\\.[^/.]+$/, '') + '.tsv'; } }"
                    }
                },
                {
                    "doc": "Annotation summary as txt",
                    "id": "#bakta.cwl/bakta/summary_txt",
                    "type": "File",
                    "format": "http://edamontology.org/format_2330",
                    "outputBinding": {
                        "glob": "*.txt"
                    }
                },
                {
                    "doc": "Annotation as JSON",
                    "id": "#bakta.cwl/bakta/annotation_json",
                    "type": "File",
                    "format": "http://edamontology.org/format_3464",
                    "outputBinding": {
                        "glob": "*.json"
                    }
                },
                {
                    "doc": "Annotation as GFF3",
                    "id": "#bakta.cwl/bakta/annotation_gff3",
                    "type": "File",
                    "format": "http://edamontology.org/format_1939",
                    "outputBinding": {
                        "glob": "*.gff3"
                    }
                },
                {
                    "doc": "Annotation as GenBank",
                    "id": "#bakta.cwl/bakta/annotation_gbff",
                    "type": "File",
                    "format": "http://edamontology.org/format_1936",
                    "outputBinding": {
                        "glob": "*.gbff"
                    }
                },
                {
                    "doc": "Annotation as EMBL",
                    "id": "#bakta.cwl/bakta/annotation_embl",
                    "type": "File",
                    "format": "http://edamontology.org/format_1927",
                    "outputBinding": {
                        "glob": "*.embl"
                    }
                },
                {
                    "doc": "Genome Sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_fna",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.fna"
                    }
                },
                {
                    "doc": "Gene DNA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_ffn",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "*.ffn"
                    }
                },
                {
                    "doc": "CDS AA sequences as Fasta",
                    "id": "#bakta.cwl/bakta/sequences_cds",
                    "type": "File",
                    "format": "http://edamontology.org/format_2200",
                    "outputBinding": {
                        "glob": "${ if (inputs.prefix !== null) { return inputs.prefix + '.faa'; } else{ return inputs.fasta_file.basename.replace(/\\.[^/.]+$/, '') + '.faa'; } }"
                    }
                },
                {
                    "doc": "Circular genome plot as PNG",
                    "id": "#bakta.cwl/bakta/plot_png",
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3603",
                    "outputBinding": {
                        "glob": "*.png"
                    }
                },
                {
                    "doc": "Circular genome plot as SVG",
                    "id": "#bakta.cwl/bakta/plot_svg",
                    "type": [
                        "null",
                        "File"
                    ],
                    "format": "http://edamontology.org/format_3604",
                    "outputBinding": {
                        "glob": "*.svg"
                    }
                }
            ]
        },
        {
            "class": "CommandLineTool",
            "label": "compress a file multithreaded with pigz",
            "hints": [
                {
                    "dockerPull": "quay.io/biocontainers/pigz:2.8",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "2.8"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/pigz"
                            ],
                            "package": "pigz"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "baseCommand": [
                "pigz",
                "-c"
            ],
            "arguments": [
                {
                    "valueFrom": "$(inputs.inputfile)"
                }
            ],
            "stdout": "$(inputs.inputfile.basename).gz",
            "inputs": [
                {
                    "type": "File",
                    "id": "#pigz.cwl/inputfile"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "prefix": "-p"
                    },
                    "id": "#pigz.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.inputfile.basename).gz"
                    },
                    "id": "#pigz.cwl/outfile"
                }
            ],
            "id": "#pigz.cwl",
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
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
                                "https://anaconda.org/bioconda/eggnog-mapper",
                                "https://doi.org/10.1101/2021.06.03.446934"
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
                    "id": "#eggnog-mapper.cwl/cpu"
                },
                {
                    "type": "boolean",
                    "inputBinding": {
                        "prefix": "--dbmem"
                    },
                    "doc": "Use this option to allocate the whole eggnog.db DB in memory. Database will be unloaded after execution. (default false)",
                    "default": false,
                    "id": "#eggnog-mapper.cwl/dbmem"
                },
                {
                    "type": [
                        {
                            "type": "record",
                            "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog",
                            "fields": [
                                {
                                    "type": "Directory",
                                    "inputBinding": {
                                        "prefix": "--data_dir"
                                    },
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/data_dir"
                                },
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--database"
                                    },
                                    "doc": "eggNOG database file",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/db"
                                },
                                {
                                    "type": "File",
                                    "inputBinding": {
                                        "prefix": "--dmnd_db"
                                    },
                                    "doc": "eggNOG database file for diamond blast search",
                                    "name": "#eggnog-mapper.cwl/eggnog_dbs/eggnog/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#eggnog-mapper.cwl/eggnog_dbs"
                },
                {
                    "type": [
                        {
                            "type": "enum",
                            "symbols": [
                                "#eggnog-mapper.cwl/go_evidence/experimental",
                                "#eggnog-mapper.cwl/go_evidence/non-electronic",
                                "#eggnog-mapper.cwl/go_evidence/all"
                            ],
                            "inputBinding": {
                                "prefix": "--go_evidence"
                            }
                        }
                    ],
                    "default": "non-electronic",
                    "doc": "Defines what type of GO terms should be used for annotation. \nexperimental = Use only terms inferred from experimental evidence. \nnon-electronic = Use only non-electronically curated terms.\nDefault non-electronic.\n",
                    "id": "#eggnog-mapper.cwl/go_evidence"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "separate": true,
                        "prefix": "-i"
                    },
                    "label": "Input FASTA file containing protein sequences",
                    "id": "#eggnog-mapper.cwl/input_fasta"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#eggnog-mapper.cwl/mode/diamond",
                                "#eggnog-mapper.cwl/mode/hmmer"
                            ],
                            "inputBinding": {
                                "prefix": "-m"
                            }
                        }
                    ],
                    "default": "diamond",
                    "doc": "Run with hmmer or diamond. Default diamond",
                    "id": "#eggnog-mapper.cwl/mode"
                }
            ],
            "arguments": [
                {
                    "position": 2,
                    "prefix": "--annotate_hits_table",
                    "valueFrom": "$(inputs.input_fasta.nameroot)"
                },
                {
                    "position": 3,
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.nameroot)"
                }
            ],
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
                    "id": "#eggnog-mapper.cwl/output_annotations"
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
                    "id": "#eggnog-mapper.cwl/output_orthologs"
                }
            ],
            "id": "#eggnog-mapper.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/author": "Ekaterina Sakharova"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                }
            ],
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/dateCreated": "2019-06-14",
            "http://schema.org/dateModified": "2024-10-03"
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
            "label": "InterProScan",
            "doc": "InterProScan is the software package that allows sequences to be scanned  against InterPro's signatures. Signatures are predictive models,  provided by several different databases, that make up the InterPro consortium.\nYou need to to download a copy of InterProScan v5 here:  https://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/\nBefore you run InterProScan 5 for the first time, you should run the command: > python3 setup.py -f interproscan.properties\nDocumentation on InterProScan can be found here: https://interproscan-docs.readthedocs.io",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/interproscan_v5:base",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "5"
                            ],
                            "specs": [
                                "https://doi.org/10.1093/bioinformatics/btu031"
                            ],
                            "package": "interproscan"
                        },
                        {
                            "version": [
                                "21.0.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/openjdk"
                            ],
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "5.32"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/perl"
                            ],
                            "package": "perl"
                        },
                        {
                            "version": [
                                "3.12.2"
                            ],
                            "specs": [
                                "https://anaconda.org/conda-forge/python"
                            ],
                            "package": "python"
                        }
                    ],
                    "class": "SoftwareRequirement"
                }
            ],
            "requirements": [
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
                    "valueFrom": "$(inputs.interproscan_directory.path)/interproscan.sh"
                },
                {
                    "prefix": "--output-file-base",
                    "position": 9,
                    "valueFrom": "$(inputs.protein_fasta.nameroot).interproscan"
                }
            ],
            "inputs": [
                {
                    "type": "string",
                    "inputBinding": {
                        "position": 4,
                        "prefix": "--applications"
                    },
                    "default": "Pfam,SFLD,SMART,AntiFam,NCBIfam",
                    "label": "Applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "id": "#interproscan_v5.cwl/applications"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 7,
                        "prefix": "--goterms"
                    },
                    "label": "GOterms",
                    "doc": "Lookup of corresponding Gene Ontology annotation (IMPLIES -iprlookup option). Default true",
                    "id": "#interproscan_v5.cwl/goterms"
                },
                {
                    "inputBinding": {
                        "position": 1
                    },
                    "type": "Directory",
                    "label": "IPR directory",
                    "doc": "InterProScan (full) program directory path",
                    "id": "#interproscan_v5.cwl/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 6,
                        "prefix": "--iprlookup"
                    },
                    "label": "IPR lookup",
                    "doc": "Also include lookup of corresponding InterPro annotation in the TSV and GFF3 output formats. Default true",
                    "id": "#interproscan_v5.cwl/ipr_lookup"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "default": "TSV,JSON",
                    "inputBinding": {
                        "position": 5,
                        "prefix": "--formats"
                    },
                    "label": "Output format",
                    "doc": "Optional, case-insensitive, comma separated list of output formats. Supported formats are TSV, XML, JSON, and GFF3. Default  JSON,TSV",
                    "id": "#interproscan_v5.cwl/output_formats"
                },
                {
                    "type": [
                        "null",
                        "boolean"
                    ],
                    "default": true,
                    "inputBinding": {
                        "position": 8,
                        "prefix": "--pathways"
                    },
                    "label": "Pathways",
                    "doc": "Lookup of corresponding Pathway annotation (IMPLIES -iprlookup option). Default true",
                    "id": "#interproscan_v5.cwl/pathways"
                },
                {
                    "type": "File",
                    "inputBinding": {
                        "position": 2,
                        "prefix": "--input"
                    },
                    "label": "Input protein fasta file path",
                    "id": "#interproscan_v5.cwl/protein_fasta"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 1,
                    "inputBinding": {
                        "position": 3,
                        "prefix": "--cpu"
                    },
                    "id": "#interproscan_v5.cwl/threads"
                }
            ],
            "outputs": [
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.gff3"
                    },
                    "id": "#interproscan_v5.cwl/gff3_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.json"
                    },
                    "id": "#interproscan_v5.cwl/json_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.tsv"
                    },
                    "id": "#interproscan_v5.cwl/tsv_annotations"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputBinding": {
                        "glob": "*.xml"
                    },
                    "id": "#interproscan_v5.cwl/xml_annotations"
                }
            ],
            "id": "#interproscan_v5.cwl",
            "http://schema.org/author": [
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/author": "Michael Crusoe, Aleksandra Ola Tarkowska, Maxim Scheremetjew, Ekaterina Sakharova"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "http://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "http://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "http://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "http://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "http://schema.org/Person",
                    "http://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "http://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "http://schema.org/name": "Changlin Ke"
                }
            ],
            "http://schema.org/copyrightHolder": "EMBL - European Bioinformatics Institute",
            "http://schema.org/license": "https://www.apache.org/licenses/LICENSE-2.0",
            "http://schema.org/dateCreated": "2019-06-14",
            "http://schema.org/dateModified": "2024-03-00",
            "http://schema.org/citation": "https://m-unlock.nl",
            "http://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl"
        },
        {
            "class": "CommandLineTool",
            "label": "KofamScan",
            "doc": "KofamScan / KofamKOALA assigns K numbers to the user's sequence data by HMMER/HMMSEARCH against KOfam, a customized HMM database of KEGG Orthologs (KOs). \nK number assignments with scores above the predefined thresholds for individual KOs are more reliable than other proposed assignments. \nSuch high score assignments are highlighted with asterisks '*' in the output. \nThe K number assignments facilitate the interpretation of the annotation results by linking the user's sequence data to the KEGG pathways and EC numbers..\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/kofamscan:1.3.0-db.2024-01-01",
                    "class": "DockerRequirement"
                },
                {
                    "packages": [
                        {
                            "version": [
                                "3.2.1"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/hmmer",
                                "file:///home/bart/git/cwl/tools/kofamscan/doi.org/10.1093/nar/gkr367"
                            ],
                            "package": "hmmer"
                        },
                        {
                            "version": [
                                "1.3.0"
                            ],
                            "specs": [
                                "https://anaconda.org/bioconda/kofamscan",
                                "file:///home/bart/git/cwl/tools/kofamscan/doi.org/10.1093/bioinformatics/btu031"
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
            "baseCommand": [
                "exec_annotation"
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        {
                            "type": "enum",
                            "symbols": [
                                "#kofamscan.cwl/format/detail",
                                "#kofamscan.cwl/format/detail-tsv",
                                "#kofamscan.cwl/format/mapper",
                                "#kofamscan.cwl/format/mapper-one-line"
                            ],
                            "inputBinding": {
                                "prefix": "--format"
                            }
                        }
                    ],
                    "default": "detail-tsv",
                    "doc": "Format of the output. (default detail-tsv)\ndetail:          Detail for each hits (including hits below threshold)\ndetail-tsv:      Tab separeted values for detail format\nmapper:          KEGG Mapper compatible format\nmapper-one-line: Similar to mapper, but all hit KOs are listed in one line\n",
                    "id": "#kofamscan.cwl/format"
                },
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
                        "File"
                    ],
                    "id": "#kofamscan.cwl/ko_list"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Profile directory",
                    "doc": "Use a custom profile directory instead of the build-in version.",
                    "id": "#kofamscan.cwl/profile_directory"
                },
                {
                    "label": "Profile organism",
                    "type": [
                        "null",
                        "string"
                    ],
                    "doc": "Specify organism profile; 'eukaryote' and 'prokaryote' are valid choices for the build-in database. Takes the \".hal\" file in the profile directory with given name.",
                    "id": "#kofamscan.cwl/profile_organism"
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
            "arguments": [
                {
                    "prefix": "-f",
                    "valueFrom": "detail-tsv"
                },
                {
                    "prefix": "-o",
                    "valueFrom": "$(inputs.input_fasta.nameroot).KofamKOALA.txt"
                },
                {
                    "prefix": "--profile",
                    "valueFrom": "${\n  // set profile organism subset (.hal) file\n  var po = \"\";\n  if (inputs.profile_organism){\n    po = \"/\"+inputs.profile_organism+\".hal\" ;\n  }\n  // check if custom profile directory is used\n  if (inputs.profile_directory){\n    return inputs.profile_directory.path+po\n  }\n  // else use default built-in kofam database\n  else { \n    return \"/profiles\"+po;\n  }\n}\n"
                },
                {
                    "prefix": "--ko-list",
                    "valueFrom": "${\n  if (inputs.ko_list){\n    return inputs.ko_list;\n  } else {\n    return '/ko_list';\n  }\n}\n"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.input_fasta.nameroot).KofamKOALA.txt"
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
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2022-00-00",
            "https://schema.org/dateModified": "2024-03-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Genome conversion",
            "doc": "Runs Genome conversion tool from SAPP\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
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
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
                    "type": [
                        "null",
                        "int"
                    ],
                    "doc": "Codon table used for this organism",
                    "label": "Codon table",
                    "inputBinding": {
                        "prefix": "-codon"
                    },
                    "id": "#conversion.cwl/codon_table"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference genome file used in EMBL format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion.cwl/embl"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "doc": "Reference genome file used in fasta format",
                    "label": "Reference genome",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion.cwl/fasta"
                },
                {
                    "type": "string",
                    "doc": "Name of the sample being analysed",
                    "label": "Sample name",
                    "inputBinding": {
                        "prefix": "-id"
                    },
                    "id": "#conversion.cwl/identifier"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar"
            ],
            "arguments": [
                {
                    "valueFrom": "${\n  if (inputs.embl) {\n    return '-embl2rdf';\n  }\n  if (inputs.fasta) {\n    return '-fasta2rdf';\n  }\n}\n"
                },
                {
                    "valueFrom": "${\n  if (inputs.fasta) {\n    return '-genome';\n  } \n  return null;\n}\n"
                },
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.identifier).ttl"
                }
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.identifier).ttl"
                    },
                    "id": "#conversion.cwl/output"
                }
            ],
            "id": "#conversion.cwl",
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -kofamscan",
            "doc": "SAPP conversion from eggNOG-mapper output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
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
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.eggnog.ttl' will be added.",
                    "id": "#conversion_eggnog.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_eggnog.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_eggnog.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).eggnog.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-eggnog"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).eggnog.ttl"
                    },
                    "id": "#conversion_eggnog.cwl/eggnog_ttl"
                }
            ],
            "id": "#conversion_eggnog.cwl",
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2025-05-05",
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -interproscan",
            "doc": "SAPP conversion from InterProScan 5 output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
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
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.interproscan.ttl' will be added.",
                    "id": "#conversion_interproscan.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_interproscan.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_interproscan.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).interproscan.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-interpro"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).interproscan.ttl"
                    },
                    "id": "#conversion_interproscan.cwl/interproscan_ttl"
                }
            ],
            "id": "#conversion_interproscan.cwl",
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/dateModified": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "SAPP conversion -kofamscan",
            "doc": "SAPP conversion from KoFamScan/KoFamKOALA output to GBOL RDF file (TTL)\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
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
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/conversion/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "Limit",
                    "doc": "Limit the number of hits per locus tag (0=no limit) (optional). Default 0",
                    "inputBinding": {
                        "prefix": "-limit"
                    },
                    "default": 0,
                    "id": "#conversion_kofamscan.cwl/limit"
                },
                {
                    "type": "string",
                    "label": "Output prefix",
                    "doc": "Output filename prefix. Suffix '.KoFamKOALA.ttl' will be added.",
                    "id": "#conversion_kofamscan.cwl/output_prefix"
                },
                {
                    "type": "File",
                    "label": "RDF",
                    "doc": "Input RDF file",
                    "inputBinding": {
                        "prefix": "-input"
                    },
                    "id": "#conversion_kofamscan.cwl/rdf"
                },
                {
                    "type": "File",
                    "label": "KofamScan tsv",
                    "doc": "KofamScan detail-tsv output",
                    "inputBinding": {
                        "prefix": "-resultFile"
                    },
                    "id": "#conversion_kofamscan.cwl/resultfile"
                }
            ],
            "arguments": [
                {
                    "prefix": "-output",
                    "valueFrom": "$(inputs.output_prefix).KoFamKOALA.ttl"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5G",
                "-jar",
                "/SAPP-2.0.jar",
                "-kofamscan"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output_prefix).KoFamKOALA.ttl"
                    },
                    "id": "#conversion_kofamscan.cwl/kofamscan_ttl"
                }
            ],
            "id": "#conversion_kofamscan.cwl",
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2023-09-00",
            "https://schema.org/dateModified": "2024-04-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "CommandLineTool",
            "label": "Genome conversion",
            "doc": "Runs Genome conversion tool from SAPP\n",
            "hints": [
                {
                    "dockerPull": "docker-registry.wur.nl/m-unlock/docker/sapp:2.0",
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
                            "package": "openjdk"
                        },
                        {
                            "version": [
                                "2.0"
                            ],
                            "specs": [
                                "https://sapp.gitlab.io/docs/index.html",
                                "file:///home/bart/git/cwl/tools/sapp/doi.org/10.1101/184747"
                            ],
                            "package": "sapp"
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
                    "doc": "RDF file in any format with the right extension",
                    "label": "RDF input file (hdt, ttl, nt, etc...)",
                    "inputBinding": {
                        "prefix": "-i"
                    },
                    "id": "#toHDT.cwl/input"
                },
                {
                    "type": "string",
                    "doc": "Name of the output file with the right extension",
                    "label": "RDF output file (hdt, ttl, nt, etc...)",
                    "inputBinding": {
                        "prefix": "-o"
                    },
                    "id": "#toHDT.cwl/output"
                }
            ],
            "baseCommand": [
                "java",
                "-Xmx5g",
                "-jar",
                "/SAPP-2.0.jar",
                "-convert"
            ],
            "outputs": [
                {
                    "type": "File",
                    "outputBinding": {
                        "glob": "$(inputs.output)"
                    },
                    "id": "#toHDT.cwl/hdt_output"
                }
            ],
            "id": "#toHDT.cwl",
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
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateModified": "2024-10-07",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        },
        {
            "class": "Workflow",
            "requirements": [
                {
                    "class": "InlineJavascriptRequirement"
                },
                {
                    "class": "MultipleInputFeatureRequirement"
                },
                {
                    "class": "ScatterFeatureRequirement"
                },
                {
                    "class": "StepInputExpressionRequirement"
                },
                {
                    "class": "SubworkflowFeatureRequirement"
                }
            ],
            "label": "Microbial (meta-) genome annotation",
            "doc": "Workflow for microbial genome annotation.",
            "outputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "outputSource": "#main/bakta_to_folder_compressed/results",
                    "id": "#main/bakta_folder_compressed"
                },
                {
                    "type": "Directory",
                    "outputSource": "#main/bakta_to_folder_uncompressed/results",
                    "id": "#main/bakta_folder_uncompressed"
                },
                {
                    "type": {
                        "type": "array",
                        "items": "File"
                    },
                    "outputSource": "#main/compress_other/outfile",
                    "linkMerge": "merge_flattened",
                    "pickValue": "all_non_null",
                    "id": "#main/compressed_other_files"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "outputSource": "#main/workflow_sapp_conversion/hdt_file",
                    "id": "#main/sapp_hdt_file"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "array",
                            "items": "File"
                        }
                    ],
                    "outputSource": "#main/uncompressed_other/outfiles",
                    "id": "#main/uncompressed_other_files"
                }
            ],
            "inputs": [
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "Bakta DB",
                    "doc": "Bakta database directory (default bakta-db_v5.1-light built in the container) (optional)\n",
                    "id": "#main/bakta_db"
                },
                {
                    "type": "int",
                    "default": 11,
                    "doc": "Codon table 11/4. Default = 11",
                    "label": "Codon table",
                    "id": "#main/codon_table"
                },
                {
                    "type": "boolean",
                    "doc": "Compress output files. Default false",
                    "default": false,
                    "id": "#main/compress_output"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination (prov only)",
                    "doc": "Not used in this workflow. Output destination used in cwl-prov reporting only.",
                    "id": "#main/destination"
                },
                {
                    "type": [
                        "null",
                        {
                            "type": "record",
                            "name": "#main/eggnog_dbs/eggnog_dbs",
                            "fields": [
                                {
                                    "type": [
                                        "null",
                                        "Directory"
                                    ],
                                    "doc": "Directory containing all data files for the eggNOG database.",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/data_dir"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/db"
                                },
                                {
                                    "type": [
                                        "null",
                                        "File"
                                    ],
                                    "doc": "eggNOG database file for diamond blast search",
                                    "name": "#main/eggnog_dbs/eggnog_dbs/diamond_db"
                                }
                            ]
                        }
                    ],
                    "id": "#main/eggnog_dbs"
                },
                {
                    "type": "File",
                    "label": "Genome fasta file",
                    "doc": "Genome fasta file used for annotation (required)",
                    "id": "#main/genome_fasta"
                },
                {
                    "type": "string",
                    "default": "Pfam",
                    "label": "Interproscan applications",
                    "doc": "Comma separated list of analyses:\nFunFam,SFLD,PANTHER,Gene3D,Hamap,PRINTS,ProSiteProfiles,Coils,SUPERFAMILY,SMART,CDD,PIRSR,ProSitePatterns,AntiFam,Pfam,MobiDBLite,PIRSF,NCBIfam\ndefault Pfam,SFLD,SMART,AntiFam,NCBIfam\n",
                    "id": "#main/interproscan_applications"
                },
                {
                    "type": [
                        "null",
                        "Directory"
                    ],
                    "label": "InterProScan 5 directory",
                    "doc": "Directory of the (full) InterProScan 5 program. When not given InterProscan will not run. (optional)",
                    "id": "#main/interproscan_directory"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan filter",
                    "doc": "Limit max number of entries of kofamscan hits per locus in SAPP. Default 5",
                    "default": 5,
                    "id": "#main/kofamscan_limit_sapp"
                },
                {
                    "type": "boolean",
                    "label": "metagenome",
                    "doc": "Run in metagenome mode. Affects only protein prediction. Default false",
                    "default": false,
                    "id": "#main/metagenome"
                },
                {
                    "type": "boolean",
                    "label": "Run eggNOG-mapper",
                    "doc": "Run with eggNOG-mapper annotation. Requires eggnog database files. Default false",
                    "default": false,
                    "id": "#main/run_eggnog"
                },
                {
                    "type": "boolean",
                    "label": "Run InterProScan",
                    "doc": "Run with eggNOG-mapper annotation. Requires InterProScan v5 program files. Default false",
                    "default": false,
                    "id": "#main/run_interproscan"
                },
                {
                    "type": "boolean",
                    "label": "Run kofamscan",
                    "doc": "Run with KEGG KO KoFamKOALA annotation. Default false",
                    "default": false,
                    "id": "#main/run_kofamscan"
                },
                {
                    "type": "boolean",
                    "doc": "Run SAPP (Semantic Annotation Platform with Provenance) on the annotations. Default true",
                    "default": true,
                    "id": "#main/sapp_conversion"
                },
                {
                    "type": "boolean",
                    "label": "Skip bakta CRISPR array prediction using PILER-CR",
                    "doc": "Skip CRISPR prediction",
                    "default": false,
                    "id": "#main/skip_bakta_crispr"
                },
                {
                    "type": "boolean",
                    "label": "Skip plot",
                    "doc": "Skip Bakta plotting",
                    "default": false,
                    "id": "#main/skip_bakta_plot"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "doc": "Number of threads to use for computational processes. Default 4",
                    "label": "Number of threads",
                    "id": "#main/threads"
                }
            ],
            "steps": [
                {
                    "label": "Bakta",
                    "doc": "Bacterial genome annotation tool",
                    "when": "$(inputs.bakta_db !== null)",
                    "run": "#bakta.cwl",
                    "in": [
                        {
                            "source": "#main/bakta_db",
                            "id": "#main/bakta/db"
                        },
                        {
                            "source": "#main/genome_fasta",
                            "id": "#main/bakta/fasta_file"
                        },
                        {
                            "default": true,
                            "id": "#main/bakta/keep_contig_headers"
                        },
                        {
                            "source": "#main/metagenome",
                            "id": "#main/bakta/meta"
                        },
                        {
                            "source": "#main/skip_bakta_crispr",
                            "id": "#main/bakta/skip_crispr"
                        },
                        {
                            "source": "#main/skip_bakta_plot",
                            "id": "#main/bakta/skip_plot"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/bakta/threads"
                        },
                        {
                            "source": "#main/codon_table",
                            "id": "#main/bakta/translation_table"
                        }
                    ],
                    "out": [
                        "#main/bakta/hypo_sequences_cds",
                        "#main/bakta/hypo_annotation_tsv",
                        "#main/bakta/annotation_tsv",
                        "#main/bakta/summary_txt",
                        "#main/bakta/annotation_json",
                        "#main/bakta/annotation_gff3",
                        "#main/bakta/annotation_gbff",
                        "#main/bakta/annotation_embl",
                        "#main/bakta/sequences_fna",
                        "#main/bakta/sequences_ffn",
                        "#main/bakta/sequences_cds",
                        "#main/bakta/plot_png",
                        "#main/bakta/plot_svg"
                    ],
                    "id": "#main/bakta"
                },
                {
                    "label": "Compressed Bakta folder",
                    "doc": "Move all compressed bakta files to a folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.compress_output)",
                    "in": [
                        {
                            "source": "#main/compress_output",
                            "id": "#main/bakta_to_folder_compressed/compress_output"
                        },
                        {
                            "source": "#main/genome_fasta",
                            "valueFrom": "$(\"bakta_\"+self.nameroot)",
                            "id": "#main/bakta_to_folder_compressed/destination"
                        },
                        {
                            "source": [
                                "#main/compress_bakta/outfile",
                                "#main/bakta/plot_png"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/bakta_to_folder_compressed/files"
                        }
                    ],
                    "out": [
                        "#main/bakta_to_folder_compressed/results"
                    ],
                    "id": "#main/bakta_to_folder_compressed"
                },
                {
                    "label": "Uncompressed Bakta folder",
                    "doc": "Move all uncompressed bakta files to a folder",
                    "run": "#files_to_folder.cwl",
                    "when": "$(inputs.compress_output == false)",
                    "in": [
                        {
                            "source": "#main/compress_output",
                            "id": "#main/bakta_to_folder_uncompressed/compress_output"
                        },
                        {
                            "source": "#main/genome_fasta",
                            "valueFrom": "$(\"bakta_\"+self.nameroot)",
                            "id": "#main/bakta_to_folder_uncompressed/destination"
                        },
                        {
                            "source": [
                                "#main/bakta/hypo_sequences_cds",
                                "#main/bakta/hypo_annotation_tsv",
                                "#main/bakta/annotation_tsv",
                                "#main/bakta/summary_txt",
                                "#main/bakta/annotation_json",
                                "#main/bakta/annotation_gff3",
                                "#main/bakta/annotation_gbff",
                                "#main/bakta/annotation_embl",
                                "#main/bakta/sequences_fna",
                                "#main/bakta/sequences_ffn",
                                "#main/bakta/sequences_cds",
                                "#main/bakta/plot_svg",
                                "#main/bakta/plot_png"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/bakta_to_folder_uncompressed/files"
                        }
                    ],
                    "out": [
                        "#main/bakta_to_folder_uncompressed/results"
                    ],
                    "id": "#main/bakta_to_folder_uncompressed"
                },
                {
                    "label": "Compress Bakta",
                    "run": "#pigz.cwl",
                    "when": "$(inputs.compress_output)",
                    "scatter": [
                        "#main/compress_bakta/inputfile"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#main/compress_output",
                            "id": "#main/compress_bakta/compress_output"
                        },
                        {
                            "source": [
                                "#main/bakta/hypo_sequences_cds",
                                "#main/bakta/hypo_annotation_tsv",
                                "#main/bakta/annotation_tsv",
                                "#main/bakta/summary_txt",
                                "#main/bakta/annotation_json",
                                "#main/bakta/annotation_gff3",
                                "#main/bakta/annotation_gbff",
                                "#main/bakta/annotation_embl",
                                "#main/bakta/sequences_fna",
                                "#main/bakta/sequences_ffn",
                                "#main/bakta/sequences_cds",
                                "#main/bakta/plot_svg"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/compress_bakta/inputfile"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/compress_bakta/threads"
                        }
                    ],
                    "out": [
                        "#main/compress_bakta/outfile"
                    ],
                    "id": "#main/compress_bakta"
                },
                {
                    "label": "Compressed other",
                    "doc": "Compress files when compression is true",
                    "when": "$(inputs.compress_output)",
                    "run": "#pigz.cwl",
                    "scatter": [
                        "#main/compress_other/inputfile"
                    ],
                    "scatterMethod": "dotproduct",
                    "in": [
                        {
                            "source": "#main/compress_output",
                            "id": "#main/compress_other/compress_output"
                        },
                        {
                            "source": [
                                "#main/kofamscan/output",
                                "#main/interproscan/json_annotations",
                                "#main/interproscan/tsv_annotations",
                                "#main/eggnogmapper/output_annotations",
                                "#main/eggnogmapper/output_orthologs"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/compress_other/inputfile"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/compress_other/threads"
                        }
                    ],
                    "out": [
                        "#main/compress_other/outfile"
                    ],
                    "id": "#main/compress_other"
                },
                {
                    "label": "eggNOG-mapper",
                    "when": "$(inputs.run_eggnog && inputs.eggnog !== null && inputs.input_fasta.size > 1024)",
                    "run": "#eggnog-mapper.cwl",
                    "in": [
                        {
                            "source": "#main/threads",
                            "id": "#main/eggnogmapper/cpu"
                        },
                        {
                            "source": "#main/eggnog_dbs",
                            "id": "#main/eggnogmapper/eggnog_dbs"
                        },
                        {
                            "source": "#main/bakta/sequences_cds",
                            "id": "#main/eggnogmapper/input_fasta"
                        },
                        {
                            "source": "#main/run_eggnog",
                            "id": "#main/eggnogmapper/run_eggnog"
                        }
                    ],
                    "out": [
                        "#main/eggnogmapper/output_annotations",
                        "#main/eggnogmapper/output_orthologs"
                    ],
                    "id": "#main/eggnogmapper"
                },
                {
                    "label": "InterProScan 5",
                    "when": "$(inputs.run_interproscan && inputs.interproscan_directory !== null && inputs.protein_fasta.size > 1024)",
                    "run": "#interproscan_v5.cwl",
                    "in": [
                        {
                            "source": "#main/interproscan_applications",
                            "id": "#main/interproscan/applications"
                        },
                        {
                            "source": "#main/interproscan_directory",
                            "id": "#main/interproscan/interproscan_directory"
                        },
                        {
                            "source": "#main/bakta/sequences_cds",
                            "id": "#main/interproscan/protein_fasta"
                        },
                        {
                            "source": "#main/run_interproscan",
                            "id": "#main/interproscan/run_interproscan"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/interproscan/threads"
                        }
                    ],
                    "out": [
                        "#main/interproscan/tsv_annotations",
                        "#main/interproscan/json_annotations"
                    ],
                    "id": "#main/interproscan"
                },
                {
                    "label": "KofamScan",
                    "when": "$(inputs.run_kofamscan && inputs.input_fasta.size > 1024)",
                    "run": "#kofamscan.cwl",
                    "in": [
                        {
                            "source": "#main/bakta/sequences_cds",
                            "id": "#main/kofamscan/input_fasta"
                        },
                        {
                            "source": "#main/run_kofamscan",
                            "id": "#main/kofamscan/run_kofamscan"
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
                    "label": "Uncompressed other",
                    "doc": "Gather files when compression is false",
                    "when": "$(inputs.compress_output == false)",
                    "run": {
                        "class": "ExpressionTool",
                        "requirements": [
                            {
                                "class": "InlineJavascriptRequirement"
                            }
                        ],
                        "inputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#main/uncompressed_other/run/files"
                            }
                        ],
                        "outputs": [
                            {
                                "type": {
                                    "type": "array",
                                    "items": "File"
                                },
                                "id": "#main/uncompressed_other/run/outfiles"
                            }
                        ],
                        "expression": "${return {'outfiles': inputs.files} }\n"
                    },
                    "in": [
                        {
                            "source": "#main/compress_output",
                            "id": "#main/uncompressed_other/compress_output"
                        },
                        {
                            "source": [
                                "#main/kofamscan/output",
                                "#main/interproscan/json_annotations",
                                "#main/interproscan/tsv_annotations",
                                "#main/eggnogmapper/output_annotations",
                                "#main/eggnogmapper/output_orthologs"
                            ],
                            "linkMerge": "merge_flattened",
                            "pickValue": "all_non_null",
                            "id": "#main/uncompressed_other/files"
                        }
                    ],
                    "out": [
                        "#main/uncompressed_other/outfiles"
                    ],
                    "id": "#main/uncompressed_other"
                },
                {
                    "label": "SAPP conversion",
                    "doc": "Convert annotation output to SAPP (RDF) format",
                    "when": "$(inputs.sapp_conversion && inputs.embl_file.size > 1024)",
                    "run": "#workflow_sapp_conversion.cwl",
                    "in": [
                        {
                            "source": "#main/bakta/annotation_embl",
                            "id": "#main/workflow_sapp_conversion/embl_file"
                        },
                        {
                            "valueFrom": "$(inputs.embl_file.nameroot)",
                            "id": "#main/workflow_sapp_conversion/identifier"
                        },
                        {
                            "source": "#main/interproscan/json_annotations",
                            "id": "#main/workflow_sapp_conversion/interproscan_output"
                        },
                        {
                            "source": "#main/kofamscan_limit_sapp",
                            "id": "#main/workflow_sapp_conversion/kofamscan_limit"
                        },
                        {
                            "source": "#main/kofamscan/output",
                            "id": "#main/workflow_sapp_conversion/kofamscan_output"
                        },
                        {
                            "source": "#main/sapp_conversion",
                            "id": "#main/workflow_sapp_conversion/sapp_conversion"
                        },
                        {
                            "source": "#main/threads",
                            "id": "#main/workflow_sapp_conversion/threads"
                        }
                    ],
                    "out": [
                        "#main/workflow_sapp_conversion/hdt_file"
                    ],
                    "id": "#main/workflow_sapp_conversion"
                }
            ],
            "id": "#main",
            "https://schema.org/author": [
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-9524-5964",
                    "https://schema.org/email": "mailto:bart.nijsse@wur.nl",
                    "https://schema.org/name": "Bart Nijsse"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0000-0001-8172-8981",
                    "https://schema.org/email": "mailto:jasper.koehorst@wur.nl",
                    "https://schema.org/name": "Jasper Koehorst"
                },
                {
                    "class": "https://schema.org/Person",
                    "https://schema.org/identifier": "https://orcid.org/0009-0001-1350-5644",
                    "https://schema.org/email": "mailto:changlin.ke@wur.nl",
                    "https://schema.org/name": "Changlin Ke"
                }
            ],
            "https://schema.org/citation": "https://m-unlock.nl",
            "https://schema.org/codeRepository": "https://gitlab.com/m-unlock/cwl",
            "https://schema.org/dateCreated": "2020-00-00",
            "https://schema.org/dateModified": "2025-08-04",
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
            "label": "SAPP conversion Workflow",
            "doc": "Workflow for converting annotation tool output into a GBOL RDF file (TTL/HDT) using SAPP.\nCurrent implemented tools:\n    - Bakta (embl)\n    - InterProScan\n    - eggNOG-mapper\n    - Kofamscan\n",
            "outputs": [
                {
                    "type": "File",
                    "doc": "Output directory",
                    "outputSource": "#workflow_sapp_conversion.cwl/compress_hdt/outfile",
                    "id": "#workflow_sapp_conversion.cwl/hdt_file"
                }
            ],
            "inputs": [
                {
                    "type": "int",
                    "doc": "The codon table used for gene prediction",
                    "label": "Codon table",
                    "default": 11,
                    "id": "#workflow_sapp_conversion.cwl/codon_table"
                },
                {
                    "type": [
                        "null",
                        "string"
                    ],
                    "label": "Output Destination",
                    "doc": "Output destination used for cwl-prov reporting.",
                    "id": "#workflow_sapp_conversion.cwl/destination"
                },
                {
                    "label": "eggnog-mapper output",
                    "doc": "eggnog-mapper output file. Annotations tsv file (optional)",
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/eggnog_output"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/embl_file"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "FASTA input file",
                    "doc": "Genome sequence in FASTA format",
                    "id": "#workflow_sapp_conversion.cwl/genome_fasta"
                },
                {
                    "type": "string",
                    "doc": "Identifier of the sample being converted",
                    "label": "Identifier",
                    "id": "#workflow_sapp_conversion.cwl/identifier"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "InterProScan output",
                    "doc": "InterProScan output file. JSON or TSV (optional)",
                    "id": "#workflow_sapp_conversion.cwl/interproscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "label": "SAPP kofamscan filter",
                    "doc": "Limit the number of hits per locus tag to be converted (0=no limit) (optional). Default 0",
                    "id": "#workflow_sapp_conversion.cwl/kofamscan_limit"
                },
                {
                    "type": [
                        "null",
                        "File"
                    ],
                    "label": "kofamscan output",
                    "doc": "KoFamScan / KoFamKOALA output file. detail-tsv (optional)",
                    "id": "#workflow_sapp_conversion.cwl/kofamscan_output"
                },
                {
                    "type": [
                        "null",
                        "int"
                    ],
                    "default": 4,
                    "id": "#workflow_sapp_conversion.cwl/threads"
                }
            ],
            "steps": [
                {
                    "label": "Compress HDT",
                    "run": "#pigz.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/turtle_to_hdt/hdt_output",
                            "id": "#workflow_sapp_conversion.cwl/compress_hdt/inputfile"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/threads",
                            "id": "#workflow_sapp_conversion.cwl/compress_hdt/threads"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/compress_hdt/outfile"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/compress_hdt"
                },
                {
                    "when": "$(inputs.embl != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/codon_table",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/codon_table"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/embl_file",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/embl"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/embl_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/embl_conversion/output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/embl_conversion"
                },
                {
                    "when": "$(inputs.fasta != null)",
                    "run": "#conversion.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/codon_table",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/codon_table"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/genome_fasta",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/fasta"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/genome_conversion/identifier"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/genome_conversion/output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/genome_conversion"
                },
                {
                    "label": "eggNOG conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_eggnog.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/output_prefix"
                        },
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/eggnog_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_eggnog/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_eggnog/eggnog_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_eggnog"
                },
                {
                    "label": "InterProScan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_interproscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/output_prefix"
                        },
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/interproscan_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_interproscan/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_interproscan"
                },
                {
                    "label": "Kofamscan conversion",
                    "when": "$(inputs.resultfile !== null)",
                    "run": "#conversion_kofamscan.cwl",
                    "in": [
                        {
                            "source": "#workflow_sapp_conversion.cwl/kofamscan_limit",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/limit"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/output_prefix"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/embl_conversion/output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/rdf"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/kofamscan_output",
                            "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan/resultfile"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/sapp_kofamscan"
                },
                {
                    "label": "TTL to HDT",
                    "run": "#toHDT.cwl",
                    "in": [
                        {
                            "source": [
                                "#workflow_sapp_conversion.cwl/sapp_eggnog/eggnog_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_interproscan/interproscan_ttl",
                                "#workflow_sapp_conversion.cwl/sapp_kofamscan/kofamscan_ttl",
                                "#workflow_sapp_conversion.cwl/embl_conversion/output"
                            ],
                            "pickValue": "first_non_null",
                            "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt/input"
                        },
                        {
                            "source": "#workflow_sapp_conversion.cwl/identifier",
                            "valueFrom": "$(self).SAPP.hdt",
                            "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt/output"
                        }
                    ],
                    "out": [
                        "#workflow_sapp_conversion.cwl/turtle_to_hdt/hdt_output"
                    ],
                    "id": "#workflow_sapp_conversion.cwl/turtle_to_hdt"
                }
            ],
            "id": "#workflow_sapp_conversion.cwl",
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
            "https://schema.org/dateModified": "2025-05-05",
            "https://schema.org/license": "https://spdx.org/licenses/Apache-2.0",
            "https://schema.org/copyrightHolder": "UNLOCK - Unlocking Microbial Potential"
        }
    ],
    "cwlVersion": "v1.2",
    "$schemas": [
        "http://edamontology.org/EDAM_1.18.owl",
        "https://schema.org/version/latest/schemaorg-current-https.rdf",
        "https://schema.org/version/latest/schemaorg-current-http.rdf",
        "http://edamontology.org/EDAM_1.16.owl",
        "http://edamontology.org/EDAM_1.20.owl"
    ],
    "$namespaces": {
        "s": "https://schema.org/"
    }
}
