Contents

Menu

Expand

Light mode

Dark mode

Auto light/dark, in light mode

Auto light/dark, in dark mode

[ ]
[ ]

[Skip to content](#furo-main-content)

[csvkit 2.2.0 documentation](index.html)

[csvkit 2.2.0 documentation](index.html)

* [Tutorial](tutorial.html)[ ]
* [Reference](cli.html)[ ]
* [Tips and Troubleshooting](tricks.html)
* [Contributing to csvkit](contributing.html)
* Release process
* [License](license.html)
* [Changelog](changelog.html)

Back to top

[View this page](_sources/release.rst.txt "View this page")

# Release process[¶](#release-process "Link to this heading")

1. All tests pass on continuous integration
2. The changelog is up-to-date and dated
3. If new options are added, regenerate the usage information in the documentation with, for example:

   ```
   stty cols 80
   csvformat -h
   stty sane
   ```
4. The version number is correct in:

   * pyproject.toml
   * docs/conf.py
   * csvkit/cli.py
5. Regenerate the man pages:

   ```
   sphinx-build -b man docs man
   ```
6. Check for new authors:

   ```
   git log --perl-regexp --author='^((?!James McKinney).*)$'
   ```
7. Tag the release:

   ```
   git tag -a x.y.z -m 'x.y.z release.'
   git push --follow-tags
   ```

[Next

License](license.html)
[Previous

Contributing to csvkit](contributing.html)

Copyright © 2016, Christopher Groskopf and James McKinney

Made with [Sphinx](https://www.sphinx-doc.org/) and [@pradyunsg](https://pradyunsg.me)'s
[Furo](https://github.com/pradyunsg/furo)