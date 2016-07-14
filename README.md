# vssh

A faster, funkier alternative to `vagrant ssh`.

## Install

### Homebrew

```
brew install shkm/brew/vssh
```

### Generic
Copy or symlink `vssh` to a place in your path.


## Features

### Fast

`vagrant ssh` is slow. `vssh` is fast.

On my 2014 Macbook Air:

```
$ time vssh
vssh  0.02s user 0.01s system

$ time vagrant ssh
vagrant ssh  2.18s user 0.43s system
```

### Contextual

`vssh` figures out which directory it should be in after SSHing into the box.

Easiest way to describe this is with an example. Assuming vagrant user is `vagrant` and your project's route is synced to `/vagrant`:

```
$ pwd
my_vagrant_project/foo/bar

$ vagrant ssh
$ pwd
/home/vagrant

$ vssh
$ pwd
/vagrant/foo/bar
```

### Convenient

Oh, yeah, you can just throw a command at `vssh` and it'll execute inside the box without leaving you there. This uses a login shell and same directory rules as plain old `vssh`.

```
$ uname
Darwin

$ vssh uname
Linux
```

## Details

Either run `vssh` or `vssh some_command` to ssh into the box or run a command inside it, respectively. `vssh --help` is always available.

vssh generates two files: `.vagrant/ssh_config` and `.vagrant/vssh.cfg`.

### `ssh_config`

`ssh_config` is populated if not found (this actually calls vagrant, and is therefore slow). if your box's ssh config changes, you can refresh this with `vssh --refresh`.

### `vssh.cfg`
`vssh.cfg` is generated interactively if not found. Currently the only required option is the root directory you'd like to be dumped into relative to your host directory.

Assuming your main synced folder (`.`) is mounted at `/vagrant`, you'd set the root directory to `/vagrant`.

To re-run `vssh.cfg` generation, execute `vssh --generate`


## Tests

Tests are written in cucumber/ruby because it's what I know what couldn't find a better alternative :-). To run them, you'll need Virtualbox, vagrant, and some reasonable ruby version.

```
bundle install
bundle exec cucumber
```

Do note that I've decided to go with a fairly large CentOS box to test the vagrant stuff, and this will be created on your machine. I happened to already have this on my machine, but feel free to make a PR for a small box.

## Inspiration
- Too much waiting
- A repo with projects as submodules
- [vassh](https://github.com/xwp/vassh)

