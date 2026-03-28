* [Skip to primary navigation](#nav-primary)
* [Skip to main content](#main)
* [Skip to footer](#site-footer)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

[![Arvados Logo](/images/arvados/logo.png)](/)

[![Arvados Logo](/images/arvados/logo.png)](/)

* [Home](/)
* About
  + [Technology](/technology)
  + [Regulatory Compliance](/compliance)
  + [Standards](/standards)
  + [Releases](/releases)
* Development
  + [Developer Site](https://dev.arvados.org/)
  + [GitHub](https://github.com/arvados/arvados)
* [Community](/community)
* [Documentation](https://doc.arvados.org/)
* [Blog](/blog)

# Blog

# [Arvados 3.1 Release Highlights](/2025/03/20/arvados-release-highlights/)

Mar 20, 2025

Since the release of Arvados 3.0 last November, we’ve continued refining the entire platform to add features and make it nicer for everyone to use, whether you’re writing workflows, analyzing results, or administering a cluster. Today we’re happy to announce the release of Arvados 3.1.0 and share with you some of the biggest new features in it.

## Support for AMD ROCm Workflows

Three years ago, Arvados 2.4 introduced support for workflows and containers that use NVIDIA CUDA. Arvados 3.1 adds support for AMD ROCm GPU work alongside that. If you’ve written or used an NVIDIA CUDA workflow before, everything...
[ ]

---

Since the release of Arvados 3.0 last November, we’ve continued refining the entire platform to add features and make it nicer for everyone to use, whether you’re writing workflows, analyzing results, or administering a cluster. Today we’re happy to announce the release of Arvados 3.1.0 and share with you some of the biggest new features in it.

## Support for AMD ROCm Workflows

Three years ago, Arvados 2.4 introduced support for workflows and containers that use NVIDIA CUDA. Arvados 3.1 adds support for AMD ROCm GPU work alongside that. If you’ve written or used an NVIDIA CUDA workflow before, everything will feel very familiar. Workflow steps just need to declare they want an AMD GPU with particular hardware specifications and a minimum version of ROCm. Arvados records these as runtime constraints of the container request, and Crunch will dispatch the container to a node that can support it. Arvados continues to support your most modern and demanding workflows while handling the details of dispatch automatically for users.

With this change, API attributes and configuration settings that previously referred to “CUDA” now refer to “GPU” generally. Container requests specify which kind of GPU they want in the `gpu.stack` runtime constraint. When clients submit container requests to the API server, it will automatically translate `cuda` constraints to `gpu` as needed, so Arvados 3.1 still supports those clients without any change. If you have other custom client code, or want to learn more about these changes, our [upgrade notes](https://doc.arvados.org/v3.1/admin/upgrading.html) have more information about these changes.

## Workbench Optimizations

As always, we’re refining Workbench to make common tasks faster and easier for all users. We put a lot of effort into optimizing the rendering code for common Workbench components like data listing tables and navigation trees. Arvados 3.0 improved Workbench’s performance by optimizing the Arvados API calls it makes. Arvados 3.1 continues that work by refining Workbench’s internal data structures and rendering routines. Thanks to this, Workbench should feel snappier and more responsive for everyone using it.

Workbench now lets you resize the right-hand details panel. It also remembers the sizes that you set for both that and the left-hand navigation panel, and restores to that size any time you open one again. This lets you set sizes that work best for your client and data, and then eliminates the need to fuss with them afterwards.

[![Arvados Workbench screenshot showing a narrowed left-hand navigation panel with clipped content and an expanded right-hand details panel](/images/release-notes/v3.1/3.1.0_WorkbenchPanels.png)](/images/release-notes/v3.1/3.1.0_WorkbenchPanels.png "Arvados Workbench screenshot showing a narrowed left-hand navigation panel with clipped content and an expanded right-hand details panel")

## Richer Data Management in Command-Line Tools

We took care to make sure all our command line tools that write data like `arv-put`, `arv-copy`, and `arvados-cwl-runner` give you full control over the data you’re storing in Arvados at every step of the process. All of them now have consistent options to specify collection storage classes and replication level. `arvados-cwl-runner` still has its dedicated option to set storage classes for intermediate workflow results too. If you don’t set your own storage classes, they properly fall back to using your cluster’s default storage classes rather than a hardcoded value.

We also improved the ergonomics of `arv-copy` by having it check `settings.conf` for cluster credentials if it can’t find a cluster-specific configuration file. This way, you don’t have to write duplicate configuration for the common case where you’re regularly copying data to or from the cluster you use most often.

## And More

Arvados 3.1 also includes bug fixes across the stack; new tools to make deployment easier; and some back-end changes to support more exciting features in future releases. If you want all the nitty-gritty, that’s in our [full release notes](/release-notes/3.1.0.html). Either way, we hope you enjoy the improvements in Arvados 3.1.

tags:
[CWL](/tag/cwl),
[arvados](/tag/arvados),
[keep](/tag/keep),
[crunch](/tag/crunch),
[data management](/tag/data-management),
[release](/tag/release)

---

# [Arvados 3.0 Release Highlights](/2024/11/14/arvados-release-highlights/)

Nov 14, 2024

The whole Arvados team is thrilled to announce the release of Arvados 3.0.0. This is a major release with many significant improvements that we’ve been working on throughout this year while delivering smaller, less disruptive changes in Arvados 2.7 series of releases. With so much cool new stuff, we wanted to take this opportunity to highlight changes that most users will see and benefit from immediately.

## New Workbench Project View

The project view has been completely revamped to streamline your work and use the space to show you more information more relevant to you. The project name appears at...
[ ]

---

The whole Arvados team is thrilled to announce the release of Arvados 3.0.0. This is a major release with many significant improvements that we’ve been working on throughout this year while delivering smaller, less disruptive changes in Arvados 2.7 series of releases. With so much cool new stuff, we wanted to take this opportunity to highlight changes that most users will see and benefit from immediately.

## New Workbench Project View

The project view has been completely revamped to streamline your work and use the space to show you more information more relevant to you. The project name appears at the top of the page, followed by an action toolbar with all the operations you might want to perform. If you’re looking for more information about this project, you can pull down the chevron to see the full project description (which can include HTML) and metadata properties.

[![Arvados Workbench screenshot of a project listing a workflow definition and collections.](/images/release-notes/v3.0/3.0.0_ProjectView.png)](/images/release-notes/v3.0/3.0.0_ProjectView.png "Arvados Workbench screenshot of a project listing a workflow definition and collections.")

Below that, the contents listing is now split into two tabs: Data and Workflow Runs. The Data tab lists the project’s collections and workflow definitions. The Workflow Runs tab lists all the workflow runs under this project. Based on feedback from users, we think this will make it easier for people to focus on their common tasks: launching workflows, checking progress, and reviewing results. Whatever you’re looking for, you should be able to find it faster now that workflow runs and their outputs aren’t weaved together chronologically. It also means the listing columns are more relevant and focused: the Data tab shows information relevant to inputs and results, while the Workflow Runs tab shows another set relevant to ongoing work.

You can still sort and filter the listings just like before, so you can still limit the Data tab to showing only output collections, on the Workflow Runs tab to show processes with the oldest first. None of that functionality is going away. Instead you can think of the tabs as a sort of “pre-filter” on the listing.

## Launch Workflows With Ease

We’ve made improvements to all the different interfaces you use to run a workflow so you have the information you need at your fingertips without cross-referencing resources. After you select your workflow, the dialog shows the full workflow description, which can include instructions about how to select inputs or set parameters.

[![Arvados Workbench screenshot of the Run a Workflow dialog showing a description of its inputs.](/images/release-notes/v3.0/3.0.0_WorkflowDescription.png)](/images/release-notes/v3.0/3.0.0_WorkflowDescription.png "Arvados Workbench screenshot of the Run a Workflow dialog showing a description of its inputs.")

The input selection dialog always shows the parent project containing your selection. If you search for a project, you won’t get a flat listing of results anymore. Instead, the results will show you what projects those collections live in. To help with that even further, you can select any item to see more information about it in the right pane, even if it’s not the type of object you need to select for this input. This makes it easier to find and select the item you need from this dialog.

[![Arvados Workbench screenshot of a file selection dialog showing an individual file selection with parent projects listed above it.](/images/release-notes/v3.0/3.0.0_FilePicker.png)](/images/release-notes/v3.0/3.0.0_FilePicker.png "Arvados Workbench screenshot of a file selection dialog showing an individual file selection with parent projects listed above it.")

Workflow secret inputs are now fully supported. You can register workflows with secret inputs, launch them from Workbench, and have that data handled securely throughout.

Once you’ve started your workflow, if you’re using Arvados’ cloud dispatcher, the Logs pane will now give you updates about where your process is in the queue or the bootstrapping process. This gives users more information about what kind of turnaround time to expect. Future versions of Arvados may provide this information for other Crunch dispatchers.

Once your workflow is completed, you can go to the Resources pane of any step to get a report with more information about how that process used its hardware resources like CPU, memory, and network. If you’ve used the crunchstat-summary report before, this is the same report, but now it’s automatically generated when the workflow is run, and made available directly through Workbench. This makes it easier for users to diagnose resource problems in their workflow definitions and make appropriate adjustments.

## Performance Improvements

Under the hood, we’ve refined Workbench’s network requests to make them more efficient, so it gets the data it needs with fewer round trips. This makes searching and browsing in Workbench more responsive throughout whether you’re browsing projects, launching a workflow, or reviewing results.

Some of those speed improvements happened directly in the API server. Text searches now ignore identifier columns like UUIDs and portable data hashes, so they return more relevant results faster. API listings can now include more referenced resources. Clients like Workbench can request all the information they need in a single request.

Data management is faster thanks to various performance improvements across Keep services. The core Keepstore service has a new streaming architecture that can start sending a data block to clients before it’s fully read, reducing time to first byte and other key performance metrics. Keep still preserves integrity by terminating the connection early if the data block does not match its checksum, so clients still have that guarantee without implementing their own checks.

Consumers like keepproxy and keep-web now cache more data to make fewer network requests. They also make better use of the `replace_files` parameter to update collections to reduce the amount of data that needs to be transferred for common changes to data sets.

## Better Documentation

The reference documentation for the [Python](https://doc.arvados.org/v3.0/sdk/python/python.html) and [R SDKs](https://doc.arvados.org/v3.0/sdk/R/arvados/index.html) is now much more complete with full descriptions for every API method, parameter, and result. This documentation is generated from information in the Arvados API “discovery document,” so we can incorporate it into other SDKs’ documentation in the future.

The documentation is also streamlined because we have removed obsolete APIs from both Arvados itself and the Python SDK in Arvados 3.0. We’ve also reorganized the Python SDK so private support code is clearly marked and not covered in the reference documentation. Thanks to all this, the documentation is much more focused on the interfaces you should use, with less cruft in the way.

## That’s Not All

Arvados 3.0 has been in the works through much of the year and we’re really excited for you all to start using it. Because this is such a big release, administrators should make sure to check out the [upgrade notes](https://doc.arvados.org/v3.0/admin/upgrading.html#v3_0_0) for important information about how to upgrade their clusters. Anyone looking for even more detail about what’s new can check out our [full release notes](https://arvados.org/release-notes/3.0.0/).

If you’re not using Arvados yet, the new version is already running on our Arvados Playground, where anyone can make an account and try it out. If you’d like help installing or upgrading your own cluster, Curii has [consulting and support services](https://www.curii.com/offerings.html) that can help. Get in touch with us at info@curii.com.

tags:
[CWL](/tag/cwl),
[arvados](/tag/arvados),
[keep](/tag/keep),
[crunch](/tag/crunch),
[data management](/tag/data-management),
[release](/tag/release)

---

# [Scientific Workflow and Data Management with the Arvados Platform](/2022/10/05/workflow-data-management/)

Oct 5, 2022
• by

[Peter Amstutz](/authors/peter.amstutz/)

I recently gave a talk at the recent Bioinformatics Open Source Conference (BOSC 2022) enti