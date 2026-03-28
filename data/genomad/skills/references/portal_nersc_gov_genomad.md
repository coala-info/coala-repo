Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark mode

[ ]
[ ]

Hide navigation sidebar

Hide table of contents sidebar

Toggle site navigation sidebar

geNomad

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

![Light Logo](_static/figures/logo_light.svg)
![Dark Logo](_static/figures/logo_light.svg)

* geNomad

Using geNomad

* [Installation](installation.html)
* [Quickstart](quickstart.html)
* [The geNomad pipeline](pipeline.html)
* [Frequently asked questions](faq.html)

Theory

* [Hybrid classification framework and score aggregation](score_aggregation.html)
* [Marker-based classification features](marker_features.html)
* [Neural network-based classification](nn_classification.html)
* [Provirus identification](provirus_identification.html)
* [Taxonomic assignment of virus genomes](taxonomic_assignment.html)
* [Score calibration](score_calibration.html)
* [Post-classification filtering](post_classification_filtering.html)

Back to top

Toggle Light / Dark / Auto color theme

Toggle table of contents sidebar

# geNomad[#](#genomad "Permalink to this heading")

geNomad is a tool that identifies virus and plasmid genomes from nucleotide sequences. It provides state-of-the-art classification performance and can be used to quickly find mobile genetic elements from genomes, metagenomes, or metatranscriptomes.

**Speed**

geNomad is significantly faster than similar tools and can be used to process large datasets.

**Taxonomic assignment**

The identified viruses are assigned to taxonomic lineages that follow the latest [ICTV](https://talk.ictvonline.org/) taxonomy release.

**Functional annotation**

Genes encoded by viruses and plasmids are functionally annotated using geNomad’s marker database.

## Get started[#](#svg-version-1-1-width-0-85em-height-0-85em-class-sd-octicon-sd-octicon-rocket-viewbox-0-0-16-16-aria-hidden-true-path-fill-rule-evenodd-d-m14-064-0a8-75-8-75-0-00-6-187-2-563l-459-458c-314-314-616-641-904-979h3-31a1-75-1-75-0-00-1-49-833l-11-7-607a-75-75-0-00-418-1-11l3-102-954c-037-051-079-1-124-145l2-429-2-428c-046-046-094-088-145-125l-954-3-102a-75-75-0-001-11-418l2-774-1-707a1-75-1-75-0-00-833-1-49v9-485c-338-288-665-59-979-904l-458-459a8-75-8-75-0-0016-1-936v1-75a1-75-1-75-0-0014-25-0h-186zm10-5-10-625c-088-06-177-118-266-175l-2-35-1-521-548-1-783-1-949-1-2a-25-25-0-00-119-213v-2-066zm3-678-8-116l5-2-5-766c-058-09-117-178-176-266h3-309a-25-25-0-00-213-119l-1-2-1-95-1-782-547zm5-26-4-493a7-25-7-25-0-0114-063-1-5h-186a-25-25-0-01-25-25v-186a7-25-7-25-0-01-2-123-5-127l-459-458a15-21-15-21-0-01-2-499-2-02l-2-317-1-5-2-143-2-143-1-5-2-317a15-25-15-25-0-012-02-2-5l-458-458h-002zm12-5a1-1-0-11-2-0-1-1-0-012-0zm-8-44-9-56a1-5-1-5-0-10-2-12-2-12c-734-73-1-047-2-332-1-15-3-003a-23-23-0-00-265-265c-671-103-2-273-416-3-005-1-148z-path-svg-get-started "Permalink to this heading")

To start using geNomad, read the installation and quickstart guides below. In case you want to learn more details about how geNomad works, visit the pages listed in the sidebar.

Installation

Instructions on how to install geNomad in your computer or server.

Quickstart

Learn how to run geNomad and interpret its results.

## Web app[#](#svg-version-1-1-width-0-85em-height-0-85em-class-sd-octicon-sd-octicon-browser-viewbox-0-0-16-16-aria-hidden-true-path-fill-rule-evenodd-d-m0-2-75c0-1-784-784-1-1-75-1h12-5c-966-0-1-75-784-1-75-1-75v10-5a1-75-1-75-0-0114-25-15h1-75a1-75-1-75-0-010-13-25v2-75zm1-75-25a-25-25-0-00-25-25v4-5h2v-2h1-75zm5-2-5v2h2v-2h5zm3-5-0v2h6v2-75a-25-25-0-00-25-25h8-5zm6-3-5h-13v7-25c0-138-112-25-25-25h12-5a-25-25-0-00-25-25v6z-path-svg-web-app "Permalink to this heading")

geNomad is available as a web application on the [Galaxy](https://usegalaxy.org/root?tool_id=toolshed.g2.bx.psu.edu/repos/ufz/genomad_end_to_end/genomad_end_to_end) and [NMDC EDGE](https://nmdc-edge.org/virus_plasmid/workflow) platforms. There you can upload your sequence data, visualize the results in your browser, and download the data to your computer.

## Citing geNomad[#](#svg-version-1-1-width-0-85em-height-0-85em-class-sd-octicon-sd-octicon-bookmark-viewbox-0-0-16-16-aria-hidden-true-path-fill-rule-evenodd-d-m4-75-2-5a-25-25-0-00-25-25v9-91l3-023-2-489a-75-75-0-01-954-0l3-023-2-49v2-75a-25-25-0-00-25-25h-6-5zm3-2-75c3-1-784-3-784-1-4-75-1h6-5c-966-0-1-75-784-1-75-1-75v11-5a-75-75-0-01-1-227-579l8-11-722l-3-773-3-107a-75-75-0-013-14-25v2-75z-path-svg-citing-genomad "Permalink to this heading")

If you use geNomad in your work, please consider citing its manuscript:

**Identification of mobile genetic elements with geNomad**
Camargo, A. P., Roux, S., Schulz, F., Babinski, M., Xu, Y., Hu, B., Chain, P. S. G., Nayfach, S., & Kyrpides, N. C. — *Nature Biotechnology* (2023), DOI: 10.1038/s41587-023-01953-y.

## Ask a question or report a bug[#](#svg-version-1-1-width-0-85em-height-0-85em-class-sd-octicon-sd-octicon-question-viewbox-0-0-16-16-aria-hidden-true-path-fill-rule-evenodd-d-m8-1-5a6-5-6-5-0-100-13-6-5-6-5-0-000-13zm0-8a8-8-0-1116-0a8-8-0-010-8zm9-3a1-1-0-11-2-0-1-1-0-012-0zm6-92-6-085c-081-16-19-299-34-398-145-097-371-187-74-187-28-0-553-087-738-225a-613-613-0-019-6-25c0-177-04-264-077-318a-956-956-0-01-277-245c-076-051-158-1-258-161l-007-004a7-728-7-728-0-00-313-195-2-416-2-416-0-00-692-661-75-75-0-001-248-832-956-956-0-01-276-245-6-3-6-3-0-01-26-16l-006-004c-093-057-204-123-313-195-222-149-487-355-692-662-214-32-329-702-329-1-15-0-76-36-1-348-863-1-725a2-76-2-76-0-008-4c-631-0-1-155-16-1-572-438-413-276-68-638-849-977a-75-75-0-101-342-67z-path-svg-ask-a-question-or-report-a-bug "Permalink to this heading")

If you want to ask a question about geNomad or report a problem you had with it, please create an issue in the  [GitHub repository](https://github.com/apcamargo/genomad/).

[Next

Installation](installation.html)

Copyright © 2023, Antonio Camargo

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)