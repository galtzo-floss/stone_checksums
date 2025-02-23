# GemChecksums

[![Version][👽versioni]][👽version]
[![License: MIT][📄license-img]][📄license-ref]
[![Downloads Rank][👽dl-ranki]][👽dl-rank]
[![Open Source Helpers][👽oss-helpi]][👽oss-help]
[![Depfu][🔑depfui♻️]][🔑depfu]
[![CodeCov Test Coverage][🔑codecovi♻️]][🔑codecov]
[![Coveralls Test Coverage][🔑coveralls-img]][🔑coveralls]
[![CodeClimate Test Coverage][🔑cc-covi♻️]][🔑cc-cov]
[![Maintainability][🔑cc-mnti♻️]][🔑cc-mnt]
[![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf]
[![CI Current][🚎11-c-wfi]][🚎11-c-wf]
[![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf]
[![CI JRuby][🚎10-j-wfi]][🚎10-j-wf]
[![CI Supported][🚎6-s-wfi]][🚎6-s-wf]
[![CI Legacy][🚎4-lg-wfi]][🚎4-lg-wf]
[![CI Unsupported][🚎7-us-wfi]][🚎7-us-wf]
[![CI Ancient][🚎1-an-wfi]][🚎1-an-wf]
[![CI Hoary][🚎8-ho-wfi]][🚎8-ho-wf]
[![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf]
[![CI Style][🚎5-st-wfi]][🚎5-st-wf]

---

[![Liberapay Patrons][⛳liberapay-img]][⛳liberapay]
[![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor]
[![Buy me a coffee][🖇buyme-small-img]][🖇buyme]
[![Polar Shield][🖇polar-img]][🖇polar]
[![Donate to my FLOSS or refugee efforts at ko-fi.com][🖇kofi-img]][🖇kofi]
[![Donate to my FLOSS or refugee efforts using Patreon][🖇patreon-img]][🖇patreon]

A ruby shell script, and rake task, to generate SHA-256 and SHA-512 checksums of RubyGem libraries,
shipped as a RubyGem.

You may be familiar with the standard rake task `build:checksum` from RubyGems.
This gem ships an improved version as `build:checksums`, based on the
[RubyGems pull request][🔒️rubygems-checksums-pr] I started in October 2022.

```shell
rake build:checksums
```

Or giving the same result...

The script accomplishes the same thing if you prefer that:
```shell
gem_checksums
```

## Info you can shake a stick at

| Tokens to Remember      | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace]                                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby        | [![JRuby 9.1 Compat][💎jruby-9.1i]][🚎10-j-wf] [![JRuby 9.2 Compat][💎jruby-9.2i]][🚎10-j-wf] [![JRuby 9.3 Compat][💎jruby-9.3i]][🚎10-j-wf] [![JRuby 9.4 Compat][💎jruby-c-i]][🚎11-c-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]                                                                                                                                                                                                                         |
| Works with Truffle Ruby | [![Truffle Ruby 22.3 Compat][💎truby-22.3i]][🚎9-t-wf] [![Truffle Ruby 23.0 Compat][💎truby-23.0i]][🚎9-t-wf] [![Truffle Ruby 23.1 Compat][💎truby-23.1i]][🚎9-t-wf] [![Truffle Ruby 24.1 Compat][💎truby-c-i]][🚎11-c-wf] [![Truffle Ruby HEAD Compat][💎truby-headi]][🚎3-hd-wf]                                                                                                                                                                                  |
| Works with MRI Ruby 3   | [![Ruby 3.0 Compat][💎ruby-3.0i]][🚎4-lg-wf] [![Ruby 3.1 Compat][💎ruby-3.1i]][🚎6-s-wf] [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎6-s-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎6-s-wf] [![Ruby 3.4 Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]                                                                                                                                                                                         |
| Works with MRI Ruby 2   | [![Ruby 2.2 Compat][💎ruby-2.2i]][🚎8-ho-wf] [![Ruby 2.3 Compat][💎ruby-2.3i]][🚎1-an-wf] [![Ruby 2.4 Compat][💎ruby-2.4i]][🚎1-an-wf] [![Ruby 2.5 Compat][💎ruby-2.5i]][🚎1-an-wf] [![Ruby 2.6 Compat][💎ruby-2.6i]][🚎7-us-wf] [![Ruby 2.7 Compat][💎ruby-2.7i]][🚎7-us-wf]                                                                                                                                                                                       |
| Source                  | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc]                                                                                                                                                                                                                                                                                                             |
| Documentation           | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![HEAD on RubyDoc.info][📜docs-head-rd-img]][🚎yard-head] [![BDFL Blog][🚂bdfl-blog-img]][🚂bdfl-blog] [![Wiki][📜wiki-img]][📜wiki]                                                                                                                                                                                                                                                        |
| Compliance              | [![License: MIT][📄license-img]][📄license-ref] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![CodeQL][🖐codeQL-img]][🖐codeQL] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog]                                                                                                            |
| Expert 1:1 Support      | [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] `or` [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]                                                                                                                                                                                                                                                                                    |
| Enterprise Support      | [![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]<br/>💡Subscribe for support guarantees covering _all_ FLOSS dependencies!<br/>💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]!<br/>💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers! |
| Comrade BDFL 🎖️        | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact BDFL][🚂bdfl-contact-img]][🚂bdfl-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto]                                                                                                                                                              |
| `...` 💖                | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme]                                                                                                                                                                                                                             |

## Installation

Install the gem and add to your library's Gemfile by executing:

```bash
bundle add gem_checksums
```

Or add it as a development dependency to the gemspec:

```ruby
Gem::Specification.new do |spec|
  # ...
  spec.add_development_dependency("gem_checksums", "~> 1.0")
end
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install gem_checksums
```

## Usage

Once installed you can use the shell script without any changes to your code.

```shell
# prepend with `bundle exec` if gem was added to Gemfile instead of installed globally
gem_checksums
```

However, if you want to use the bundled rake task you'll need to add it to your Rakefile first.

```ruby
begin
  require "gem_checksums"
  GemChecksums.install_tasks
rescue LoadError
  task("build:checksums") do
    warn("gem_checksums is not available")
  end
end
```

Then you can do:

```shell
# prepend with `bundle exec` if gem was added to Gemfile instead of installed globally
rake build:checksums
```

It is different from, and improves on, the standard rake task in that it:
- does various checks to ensure the generated checksums will be valid
- does `git commit` the generated checksums

### ENV variables

Behavior can be controlled by ENV variables!

- `GEM_CHECKSUMS_GIT_DRY_RUN` default value is `false`
  - when `true` the `git commit` command will run with `--dry-run` flag
  - when `true` the checksum files will be unstaged and deleted
- `GEM_CHECKSUMS_CHECKSUMS_DIR` default value is `checksums` (relative path)
  - this directory will be created, relative to current working directory, if not present
- `GEM_CHECKSUMS_PACKAGE_DIR` default value is `pkg` (relative path)
  - this directory will be searched for the latest gem package to generate checksums for

### ARGV

If an argument is provided to the rake task it should be the path to
a specific `.gem` package you want to generate checksums for.

The script version does not accept arguments, and should be controlled by the ENV variables if needed.

### How To: Release gem with checksums generated by `gem_checksums`

Generating checksums makes sense when you are building and releasing a gem, so how does it fit into that process?

NOTE: This is an example process which assumes your project has bundler binstubs, and a version.rb file,
with notes for `zsh` and `bash` shells.

1. Run `bin/setup && bin/rake` as a tests, coverage, & linting sanity check
2. Update the version number in `version.rb`
3. Run `bin/setup && bin/rake` again as a secondary check, and to update `Gemfile.lock`
4. Run `git commit -am "🔖 Prepare release v<VERSION>"` to commit the changes
5. Run `git push` to trigger the final CI pipeline before release, & merge PRs
    - NOTE: Remember to [check your project's CI][🧪build]!
6. Run `export GIT_TRUNK_BRANCH_NAME="$(git remote show origin | grep 'HEAD branch' | cut -d ' ' -f5)" && echo $GIT_TRUNK_BRANCH_NAME`
7. Run `git checkout $GIT_TRUNK_BRANCH_NAME`
8. Run `git pull origin $GIT_TRUNK_BRANCH_NAME` to ensure you will release the latest trunk code
9. Set `SOURCE_DATE_EPOCH` so `rake build` and `rake release` use same timestamp, and generate same checksums
    - Run `export SOURCE_DATE_EPOCH=$EPOCHSECONDS && echo $SOURCE_DATE_EPOCH`
    - If the echo above has no output, then it didn't work.
    - Note that you'll need the `zsh/datetime` module, if running `zsh`.
    - In `bash` you can use `date +%s` instead, i.e. `export SOURCE_DATE_EPOCH=$(date +%s) && echo $SOURCE_DATE_EPOCH`
10. Run `bundle exec rake build`
11. Run `gem_checksums` (from this gem, and added to path in .envrc,
    more context [1][🔒️rubygems-checksums-pr] and [2][🔒️rubygems-guides-pr]) to create SHA-256 and SHA-512 checksums
    - Checksums will be committed automatically by the script, but not pushed
12. Run `bundle exec rake release` which will create a git tag for the version,
    push git commits and tags, and push the `.gem` file to [rubygems.org][💎rubygems]

[🧪build]: https://github.com/pboling/gem_checksums/actions
[💎rubygems]: https://rubygems.org
[🔒️rubygems-security-guide]: https://guides.rubygems.org/security/#building-gems
[🔒️rubygems-checksums-pr]: https://github.com/rubygems/rubygems/pull/6022
[🔒️rubygems-guides-pr]: https://github.com/rubygems/guides/pull/325

### Too many steps?

If you don't follow the steps above you'll end up seeing this error:

```
WARNING: Build time not provided via environment variable SOURCE_DATE_EPOCH.
         To ensure consistent SHA-256 & SHA-512 checksums,
         you must set this environment variable *before* building the gem.

IMPORTANT: After setting the build time, you *must re-build the gem*, i.e. bundle exec rake build, or gem build.

How to set the build time:

In zsh shell:
  - export SOURCE_DATE_EPOCH=$EPOCHSECONDS && echo $SOURCE_DATE_EPOCH
  - If the echo above has no output, then it didn't work.
  - Note that you'll need the `zsh/datetime` module enabled.

In fish shell:
  - set -x SOURCE_DATE_EPOCH (date +%s)
  - echo $SOURCE_DATE_EPOCH

In bash shell:
  - export SOURCE_DATE_EPOCH=$(date +%s) && echo $SOURCE_DATE_EPOCH`
```

Just do what it says!

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check TODOs (see [below](#todos)),
or check [issues][🤝issues], or [PRs][🤝pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### TODOs

- [ ] Prepend `rake build` task with check for `SOURCE_DATE_EPOCH` environment variable, and raise error if not set.

### Code Coverage

[![Coverage Graph][🔑codecov-g♻️]][🔑codecov]

### 🪇 Code of Conduct

Everyone interacting in this project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/pboling/gem_checksums/-/graphs/main][🚎contributors-gl]

## ⭐️ Star History

<a href="https://star-history.com/#pboling/gem_checksums&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=pboling/gem_checksums&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=pboling/gem_checksums&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=pboling/gem_checksums&type=Date" />
 </picture>
</a>

## 📌 Versioning

This Library adheres to [![Semantic Versioning 2.0.0][📌semver-img]][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

### 📌 Is "Platform Support" part of the public API?

Yes.  But I'm obligated to include notes...

SemVer should, but doesn't explicitly, say that dropping support for specific Platforms
is a *breaking change* to an API.
It is obvious to many, but not all, and since the spec is silent, the bike shedding is endless.

> dropping support for a platform is both obviously and objectively a breaking change

- Jordan Harband (@ljharb) [in SemVer issue 716][📌semver-breaking]

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

As a result of this policy, and the interpretive lens used by the maintainer,
you can (and should) specify a dependency on these libraries using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("gem_checksums", "~> 1.1")
```

See [CHANGELOG.md][📌changelog] for list of releases.

## 📄 License

The gem is available as open source under the terms of
the [MIT License][📄license] [![License: MIT][📄license-img]][📄license-ref].
See [LICENSE.txt][📄license] for the official [Copyright Notice][📄copyright-notice-explainer].

### © Copyright

<p>
  Copyright (c) 2022 - 2025 Peter H. Boling,
  <a href="https://railsbling.com">
    RailsBling.com
    <picture>
      <img alt="Rails Bling" height="20" src="https://railsbling.com/images/logos/RailsBling-TrainLogo.svg" />
    </picture>
  </a>
</p>

## 🤑 One more thing

You made it to the bottom of the page,
so perhaps you'll indulge me for another 20 seconds.
I maintain many dozens of gems, including this one,
because I want Ruby to be a great place for people to solve problems, big and small.
Please consider supporting my efforts via the giant yellow link below,
or one of the others at the head of this README.

[![Buy me a latte][🖇buyme-img]][🖇buyme]

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[🏘chat]: https://gitter.im/pboling/gem_checksums
[🏘chat-img]: https://img.shields.io/gitter/room/pboling/gem_checksums.svg
[⛳️gem-namespace]: https://github.com/pboling/gem_checksums/blob/main/lib/gem_checksums.rb
[⛳️namespace-img]: https://img.shields.io/badge/namespace-GemChecksums-brightgreen.svg?style=flat&logo=ruby&logoColor=white
[⛳️gem-name]: https://rubygems.org/gems/gem_checksums
[⛳️name-img]: https://img.shields.io/badge/name-gem__checksums-brightgreen.svg?style=flat&logo=rubygems&logoColor=red
[🚂bdfl-blog]: http://www.railsbling.com/tags/gem_checksums
[🚂bdfl-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂bdfl-contact]: http://www.railsbling.com/contact
[🚂bdfl-contact-img]: https://img.shields.io/badge/Contact-BDFL-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/PeterBoling-LinkedIn-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://angel.co/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https%3A%2F%2Fruby.social&style=flat&logo=mastodon&label=Ruby%20%40galtzo
[💖🦋bluesky]: https://galtzo.bsky.social
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.bsky.social-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[👨🏼‍🏫expsup-upwork]: https://www.upwork.com/freelancers/~014942e9b056abdf86?mp_source=share
[👨🏼‍🏫expsup-upwork-img]: https://img.shields.io/badge/UpWork-13544E?style=for-the-badge&logo=Upwork&logoColor=white
[👨🏼‍🏫expsup-codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[👨🏼‍🏫expsup-codementor-img]: https://img.shields.io/badge/CodeMentor-Get_Help-1abc9c?style=for-the-badge&logo=CodeMentor&logoColor=white
[🏙️entsup-tidelift]: https://tidelift.com/subscription
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/pboling/gem_checksums/
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/pboling/gem_checksums
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/RubyDoc-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜wiki]: https://gitlab.com/pboling/gem_checksums/-/wikis/home
[📜wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=Wiki&logoColor=white
[👽dl-rank]: https://rubygems.org/gems/gem_checksums
[👽dl-ranki]: https://img.shields.io/gem/rd/gem_checksums.svg
[👽oss-help]: https://www.codetriage.com/pboling/gem_checksums
[👽oss-helpi]: https://www.codetriage.com/pboling/gem_checksums/badges/users.svg
[👽version]: https://rubygems.org/gems/gem_checksums
[👽versioni]: https://img.shields.io/gem/v/gem_checksums.svg
[🔑cc-mnt]: https://codeclimate.com/github/pboling/gem_checksums/maintainability
[🔑cc-mnti♻️]: https://api.codeclimate.com/v1/badges/ff2234fcbe9051436f37/maintainability
[🔑cc-cov]: https://codeclimate.com/github/pboling/gem_checksums/test_coverage
[🔑cc-covi♻️]: https://api.codeclimate.com/v1/badges/ff2234fcbe9051436f37/test_coverage
[🔑codecov]: https://codecov.io/gh/pboling/gem_checksums
[🔑codecovi♻️]: https://codecov.io/gh/pboling/gem_checksums/branch/main/graph/badge.svg?token=iQykVGCFME
[🔑coveralls]: https://coveralls.io/github/pboling/gem_checksums?branch=main
[🔑coveralls-img]: https://coveralls.io/repos/github/pboling/gem_checksums/badge.svg?branch=main
[🔑depfu]: https://depfu.com/github/pboling/gem_checksums
[🔑depfui♻️]: https://badges.depfu.com/badges/85187dfdd2ecf7839b2ec78c64d2bf4e/count.svg
[🖐codeQL]: https://github.com/pboling/gem_checksums/security/code-scanning
[🖐codeQL-img]: https://github.com/pboling/gem_checksums/actions/workflows/codeql-analysis.yml/badge.svg
[🚎1-an-wf]: https://github.com/pboling/gem_checksums/actions/workflows/ancient.yml
[🚎1-an-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/ancient.yml/badge.svg
[🚎2-cov-wf]: https://github.com/pboling/gem_checksums/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/pboling/gem_checksums/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/heads.yml/badge.svg
[🚎4-lg-wf]: https://github.com/pboling/gem_checksums/actions/workflows/legacy.yml
[🚎4-lg-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/legacy.yml/badge.svg
[🚎5-st-wf]: https://github.com/pboling/gem_checksums/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/style.yml/badge.svg
[🚎6-s-wf]: https://github.com/pboling/gem_checksums/actions/workflows/supported.yml
[🚎6-s-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/supported.yml/badge.svg
[🚎7-us-wf]: https://github.com/pboling/gem_checksums/actions/workflows/unsupported.yml
[🚎7-us-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/unsupported.yml/badge.svg
[🚎8-ho-wf]: https://github.com/pboling/gem_checksums/actions/workflows/hoary.yml
[🚎8-ho-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/hoary.yml/badge.svg
[🚎9-t-wf]: https://github.com/pboling/gem_checksums/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/pboling/gem_checksums/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/pboling/gem_checksums/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/pboling/gem_checksums/actions/workflows/current.yml/badge.svg
[⛳liberapay-img]: https://img.shields.io/liberapay/patrons/pboling.svg?logo=liberapay
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://polar.sh/embed/seeks-funding-shield.svg?org=pboling
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/buy_me_coffee-donate-yellow.svg
[🖇kofi]: https://ko-fi.com/O5O86SNP4
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-yellow.svg
[🖇patreon]: https://patreon.com/galtzo
[💎ruby-2.2i]: https://img.shields.io/badge/Ruby-2.2-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.3i]: https://img.shields.io/badge/Ruby-2.3-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.4i]: https://img.shields.io/badge/Ruby-2.4-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.5i]: https://img.shields.io/badge/Ruby-2.5-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.6i]: https://img.shields.io/badge/Ruby-2.6-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-2.7i]: https://img.shields.io/badge/Ruby-2.7-DF00CA?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.0i]: https://img.shields.io/badge/Ruby-3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.1i]: https://img.shields.io/badge/Ruby-3.1-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-22.3i]: https://img.shields.io/badge/Truffle_Ruby-22.3-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.0i]: https://img.shields.io/badge/Truffle_Ruby-23.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-23.1i]: https://img.shields.io/badge/Truffle_Ruby-23.1-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎truby-headi]: https://img.shields.io/badge/Truffle_Ruby-HEAD-34BCB1?style=for-the-badge&logo=ruby&logoColor=blue
[💎jruby-9.1i]: https://img.shields.io/badge/JRuby-9.1-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.2i]: https://img.shields.io/badge/JRuby-9.2-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-9.3i]: https://img.shields.io/badge/JRuby-9.3-FBE742?style=for-the-badge&logo=ruby&logoColor=red
[💎jruby-c-i]: https://img.shields.io/badge/JRuby-current-FBE742?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-headi]: https://img.shields.io/badge/JRuby-HEAD-FBE742?style=for-the-badge&logo=ruby&logoColor=blue
[🤝issues]: https://github.com/pboling/gem_checksums/issues
[🤝pulls]: https://github.com/pboling/gem_checksums/pulls
[🤝contributing]: CONTRIBUTING.md
[🔑codecov-g♻️]: https://codecov.io/gh/pboling/gem_checksums/graphs/tree.svg?token=iQykVGCFME
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/pboling/gem_checksums/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=pboling/gem_checksums
[🚎contributors-gl]: https://gitlab.com/pboling/gem_checksums/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-4baaaa.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-FFDD67.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-FFDD67.svg?style=flat
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-0.073-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-brightgreen.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.txt
[📄license-ref]: https://opensource.org/licenses/MIT
[📄license-img]: https://img.shields.io/badge/License-MIT-green.svg
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-brightgreen.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/gem_checksums
[🚎yard-head]: https://rubydoc.info/github/pboling/gem_checksums/main
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇buyme-small-img]: https://img.shields.io/badge/Buy--Me--A--Coffee-✓-brightgreen.svg?style=flat
