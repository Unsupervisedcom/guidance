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
### Install
This requires a version of python that includes the library version.
Development has been done using 3.10.9 which can be installed with the below.
You must also install Guidance.

```
env PYTHON_CONFIGURE_OPTS='--enable-shared' pyenv install 3.10
pyenv global 3.10
pip install -U guidance
```

To install the gem using bundle:
```
bundle add guidance
```

Via Ruby gems directly:
```
$ gem install guidance
```
### Configuration
You will need to configure credentials for the backing LLM service you use.
This is not well-documented in Guidance but can be found in the source fairly easy
such as at https://github.com/microsoft/guidance/blob/d2c5e3cbb730e337b9bee20520eb694bd43e5f38/guidance/llms/_openai.py#L160
which for OpenAI. For OpenAI (as the most common service), the easiest option is
using an env variable for the below:

```bash
export OPENAI_API_KEY=<your key>
```
These keys can be found at https://platform.openai.com/account/api-keys if you
have an account.

### Usage
```ruby
require "guidance"
```

## Troubleshooting
#### Python Not Found
Make sure you installed with the library version installed. Note that even with that
option, we have seen issues with Python 3.7 but have not fully analyzed the issue.

#### Guidance module not found
Make sure you installed the pip module.

PyCall also uses the library version of Python which does not get its paths
set the same way. Try finding where your guidance library was installed and
adding it to the ENV var "PYTHONPATH"

## Support

If you want to report a bug, or have ideas, feedback or questions about the gem, [let me know via GitHub issues](https://github.com/Unsupervisedcom/guideance-rails/issues/new) and I will do my best to provide a helpful answer. Happy hacking!

## License

The gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of conduct

Everyone interacting in this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).

## Contribution guide

Pull requests are welcome!
