# guidance

[![Gem Version](https://img.shields.io/gem/v/guidance)](https://rubygems.org/gems/guidance)
[![Gem Downloads](https://img.shields.io/gem/dt/guidance)](https://www.ruby-toolbox.com/projects/guidance)
[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/Unsupervisedcom/guideance-rails/ci.yml)](https://github.com/Unsupervisedcom/guideance-rails/actions/workflows/ci.yml)

This Gem wraps https://github.com/microsoft/guidance for use in Ruby.
See documentation at in the Guidance repo for info on how to use it.

---

- [Quick start](#quick-start)
- [Support](#support)
- [License](#license)
- [Code of conduct](#code-of-conduct)
- [Contribution guide](#contribution-guide)

## Quick start
This requires a version of python that includes the library version.
Development has been done using 3.10.9 which can be installed with the below.
You must also install Guidance.

```
env PYTHON_CONFIGURE_OPTS='--enable-shared' pyenv install 3.10
pyenv global 3.10
pip install guidance
```

To install the gem using bundle:
```
bundle add guidance
```

Via Ruby gems directly:
```
$ gem install guidance
```

```ruby
require "guidance"
```

## Support

If you want to report a bug, or have ideas, feedback or questions about the gem, [let me know via GitHub issues](https://github.com/Unsupervisedcom/guideance-rails/issues/new) and I will do my best to provide a helpful answer. Happy hacking!

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of conduct

Everyone interacting in this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Contribution guide

Pull requests are welcome!
