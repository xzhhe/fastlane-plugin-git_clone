# git_clone plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-git_clone)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-git_clone`, add it to your project by running:

```bash
fastlane add_plugin git_clone
```

## About git_clone

a wrapper for git clone command

**Note to author:** Add a more detailed description about this plugin here. If your plugin contains multiple actions, make sure to mention them here.

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

```ruby
git = 'git@xx.com:xx/xxx.git'

# ok
ret = git_clone(git: git, path: '/Users/xiongzenghui/Desktop/test')
pp ret

# ok
ret = git_clone(
  git: git,
  path: '/Users/xiongzenghui/Desktop/test',
  branch: 'test'
)
pp ret

# ok
ret = git_clone(
  git: git,
  path: '/Users/xiongzenghui/Desktop/test',
  tag: '1.0.0'
)
pp ret

# ok
ret = git_clone(
  git: git,
  path: '/Users/xiongzenghui/Desktop/test',
  branch: 'test',
  depth: 1,
  single_branch: true
)
pp ret

# ok
ret = git_clone(
  git: git,
  path: '/Users/xiongzenghui/Desktop/adsasd/haha',
  commit: '4f4ba',
  single_branch: true
)
pp ret

# ok
ret = git_clone(
  git: git,
  path: '/Users/xiongzenghui/Desktop/test',
  update: true
)
pp ret
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
