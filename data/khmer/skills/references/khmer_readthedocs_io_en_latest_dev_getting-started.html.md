### Navigation

* [index](../genindex.html "General Index")
* [next](a-quick-guide-to-testing.html "A quick guide to testing (for khmer)") |
* [previous](CODE_OF_CONDUCT.html "Contributor Code of Conduct") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](../index.html) »
* [The khmer developer documentation](index.html) »

## Contents

* Getting started with khmer development
  + [One-time preparation](#one-time-preparation)
  + [Building khmer and running the tests](#building-khmer-and-running-the-tests)
  + [Claiming an issue and starting to develop](#claiming-an-issue-and-starting-to-develop)
  + [After your first issue is successfully merged…](#after-your-first-issue-is-successfully-merged)

#### Previous topic

[Contributor Code of Conduct](CODE_OF_CONDUCT.html "previous chapter")

#### Next topic

[A quick guide to testing (for khmer)](a-quick-guide-to-testing.html "next chapter")

### This Page

* [Show Source](../_sources/dev/getting-started.rst.txt)

1. [Docs](../index.html)
2. [The khmer developer documentation](index.html)
3. Getting started with khmer development

# [Getting started with khmer development](#id1)[¶](#getting-started-with-khmer-development "Permalink to this headline")

Contents

* [Getting started with khmer development](#getting-started-with-khmer-development)
  + [One-time preparation](#one-time-preparation)
  + [Building khmer and running the tests](#building-khmer-and-running-the-tests)
  + [Claiming an issue and starting to develop](#claiming-an-issue-and-starting-to-develop)
  + [After your first issue is successfully merged…](#after-your-first-issue-is-successfully-merged)

This document is for people who would like to contribute to khmer. It
walks first-time contributors through making their own copy of khmer,
building it, and submitting changes for review and merge into the master
copy of khmer.

---

Start by making your own copy of khmer and setting yourself up for
development; then, build khmer and run the tests; and finally, claim
an issue and start developing! If you’re unfamiliar with git and branching in
particular, check out the
[git-scm book](http://git-scm.com/book/en/Git-Branching). We’ve also provided
a quick guide to the khmer code base here: [A quick guide to the khmer codebase](codebase-guide.html).

## [One-time preparation](#id2)[¶](#one-time-preparation "Permalink to this headline")

1. Install prerequisites and set up a virtual environment following the [installation instructions in the user documentation](../user/install.html#user-install-prereqs).

   Note

   DO NOT proceed to the final step and install khmer with pip!
2. Install additional prerequisites using your system’s package manager.

   1. Mac OS X

      > brew install astyle gcovr cppcheck enchant
   2. Debian / Ubuntu

      > sudo apt-get install -y git astyle gcovr cppcheck enchant
   3. Red Hat / Fedora / CentOS

      > sudo yum install -y git astyle gcovr cppcheck enchant
3. Create a [GitHub](http://github.com) account.

   We use GitHub to manage khmer contributions.
4. Fork [github.com/dib-lab/khmer](https://github.com/dib-lab/khmer).

   Visit that page, and then click on the ‘fork’ button (upper right).
   This makes a copy of the khmer source code in your own GitHub account.
5. Clone your copy of khmer to your local development environment.

   Your shell command should look something like:

   ```
   git clone https://github.com/your-github-username/khmer.git
   ```

   This makes a local copy of khmer on your development machine.
6. Add a git reference to the khmer dib-lab repository:

   ```
   cd khmer
   git remote add dib https://github.com/dib-lab/khmer.git
   ```

   This makes it easy for you to pull down the latest changes in the
   main repository.
7. Install Python developement dependencies

   From within the khmer directory, invoke:

   ```
   make install-dep
   ```

   If you have chosen not using a virtual environment, you may need to invoke `sudo make install-dep` instead.
   This will install several packages used in khmer testing and development.

## [Building khmer and running the tests](#id3)[¶](#building-khmer-and-running-the-tests "Permalink to this headline")

1. Build khmer:

   ```
   make
   ```

   This compiles the C++ source code into something that Python can run.
   If the command fails, we apologize!
   Please [go create a new issue](https://github.com/dib-lab/khmer/issues?direction=desc&sort=created&state=open), paste in the failure message, and we’ll try to help you work through it!
2. Run the tests:

   ```
   make test
   ```

   This will run all of the Python tests in the `tests/` directory.
   You should see lots of output, with something like:

   ```
   ====== 1289 passed, 1 skipped, 25 deselected, 1 xpassed in 50.98 seconds =======
   ```

   at the end.

Congratulations! You’re ready to develop!

## [Claiming an issue and starting to develop](#id4)[¶](#claiming-an-issue-and-starting-to-develop "Permalink to this headline")

1. Find an open issue and claim it.

   Go to [the list of open khmer issues](https://github.com/dib-lab/khmer/issues?direction=desc&sort=created&state=open) and find one you like; we suggest starting with [the low-hanging fruit issues](https://github.com/dib-lab/khmer/issues?direction=desc&labels=low-hanging-fruit&page=1&sort=created&state=open)).

   Once you’ve found an issue you like, make sure that no one has been assigned to it (see “assignee”, bottom right near “notifications”).
   Then, add a comment “I am working on this issue.”
   You’ve staked your claim!

   (We’re trying to avoid having multiple people working on the same issue.)
2. In your local copy of the source code, update your master branch from the main khmer master branch:

   ```
   git checkout master
   git pull dib master
   ```

   (This pulls in all of the latest changes from whatever we’ve been doing on `dib-lab`.)

   If git complains about a “merge conflict” when you execute `git pull`, refer to the **Resolving merge conflicts** section of [Guidelines for continued development](guidelines-continued-dev.html).
3. Create a new branch and link it to your fork on GitHub:

   ```
   git checkout -b fix/brief_issue_description
   git push -u origin fix/brief_issue_description
   ```

   where you replace “fix/brief\_issue\_description” with 2-3 words, separated by underscores, describing the issue.

   (This is the set of changes you’re going to ask to be merged into khmer.)
4. Make some changes and commit them.

   Though this will largely be issue-dependent the basics of committing are simple.
   After you’ve made a cohesive set of changes, run the command git status.
   This will display a list of all the files git has noticed you changed. A file
   in the ‘untracked’ section are files that haven’t existed previously in the repository but git has noticed.

   To commit changes you have to ‘stage’ them—this is done by issuing the following command:

   ```
   git add path/to/file
   ```

   Once you have staged your changes, it’s time to make a commit:

   ```
   git commit -m 'Here you provide a brief description of your changes'
   ```

   Please make your commit message informative but concise - these messages become part of the ‘official’ history of the project.

   Once your changes have been committed, push them up to the remote branch:

   ```
   git push origin
   ```

   again.
5. Periodically update your branch from the main khmer master branch:

   ```
   git pull dib master
   ```

   (This pulls in all of the latest changes from whatever we’ve been doing on `dib-lab` - important especially during periods of fast change or for long-running pull requests.)
6. Run the tests and/or build the docs *before* pushing to GitHub:

   ```
   make doc test pep8 diff-cover
   ```

   Make sure they all pass!
7. Push your branch to your own GitHub fork:

   ```
   git push origin
   ```

   (This pushes all of your changes to your own fork.)
8. Repeat until you’re ready to merge your changes into “official” khmer.
9. Set up a Pull Request asking to merge your changes into the main khmer
   repository.

   In a Web browser, go to your GitHub fork of khmer, e.g.:

   ```
   https://github.com/your-github-username/khmer
   ```

   and you will see a list of “recently pushed branches” just above the source code listing.
   On the right side of that should be a “Compare & pull request” green button.
   Click on it.
   This will open up a submission form with a pull request checklist.
   In this form:

   > * add a descriptive title (e.g. “updated tests for XXX”)
   > * include any relevant comments about your submission in the main body of the pull request text, above the checklist
   > * make sure to include any relevant issue numbers in the comments (e.g. “fixes issue #532”)

   then click “Create pull request.”

   (This creates a new issue where we can all discuss your proposed changes;
   the khmer team will be automatically notified and you will receive e-mail notifications as we add comments.
   See [GitHub flow](http://scottchacon.com/2011/08/31/github-flow.html) for more info.)
10. Review the pull request checklist and make any necessary additional changes.

    Check off as many of the boxes as you can from the checklist that is automatically added to the first comment of the Pull Request discussion.
    If you have an ORCID ID<https://orcid.org/> post that as well.
    This will make it much easier for the khmer team to include you in khmer publications.

    As you add new commits to address bugs or formatting issues, you can keep pushing your changes to the pull request by doing:

    ```
    git push origin
    ```
11. When you are ready to have the pull request reviewed, please mention @luizirber, @camillescott, @standage, @betatim, and/or @ctb with the comment ‘Ready for review!’
12. The khmer team will now review your pull request and communicate with you through the pull request page.
    Please feel free to add ‘ping!’ and an @ in the comments if you are looking for feedback—this will alert us that you are still on the line.

    If this is your first issue, please *don’t* take another issue until we’ve merged your first one. Thanks!
13. If we request changes, return to the step “Make some changes and commit them” and go from there.
    Any additional commits you make and push to your branch will automatically be added to the pull request.

After your submission passes peer review and the test suite (`make test` is run on continuous integration server automatically for each pull request), your contribution will be merged into the main codebase.
Congratulations on making your first contribution to the khmer library!
You’re now an experienced GitHub user and an official khmer contributor!

## [After your first issue is successfully merged…](#id5)[¶](#after-your-first-issue-is-successfully-merged "Permalink to this headline")

Before getting started with your second (or third, or fourth, or nth) contribution, there are a couple of steps you need to take to clean up your local copy of the code:

```
git checkout master
git pull dib master
git branch -d fix/brief_issue_description     # delete the branch locally
git push origin :fix/brief_issue_description  # delete the branch on your GitHub fork
```

This will syncronize your local main (master) branch with the central khmer repository—including your newly integrated contribution—and delete the branch you used to make your submission.

Now your local copy of the code is teed up for another contribution.
If you find another issue that interests you, go back to the beginning of these instructions and repeat!
You will also want to take a look at [Guidelines for continued development](guidelines-continued-dev.html).

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)
[comments powered by Disqus](http://disqus.com)

[Contributor Code of Conduct](CODE_OF_CONDUCT.html "previous chapter (use the left arrow)")

[A quick guide to testing (for khmer)](a-quick-guide-to-testing.html "next chapter (use the right arrow)")

### Navigation

* [index](../genindex.html "General Index")
* [next](a-quick-guide-to-testing.html "A quick guide to testing (for khmer)") |
* [previous](CODE_OF_CONDUCT.html "Contributor Code of Conduct") |
* [khmer 3.0.0a1+98.gfe0ce11 documentation](../index.html) »
* [The khmer developer documentation](index.html) »

© Copyright 2010-2014 the authors.. Created using [Sphinx](http://sphinx.pocoo.org/).