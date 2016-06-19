# vssh

A small wrapper around `vagrant ssh` which considerably improves speed, CDs into the current directory, and allows running arbitrary commands inside the box.

## Install

### Homebrew

```
brew install shkm/shkm/vssh
```

### Simple
Copy or symlink `vssh` to a place in your path.

## Refreshing the cache

Since we cache `vagrant ssh-config`, it'll need to be updated whenever the config changes. Simply pass `--refresh` as the first argument to `vssh` and away you go.

## Features

### Fast

Instead of going through `vagrant ssh` and waiting for ruby to start up every time, we cache `vagrant ssh-config` and use ssh directly.

How much faster is it?

On my 2014 Macbook Air:

```
$ time vssh
vssh  0.02s user 0.01s system

$ time vagrant ssh
vagrant ssh  2.18s user 0.43s system
```

### The right directory

Normally, `vagrant ssh` will drop you in `/`. With `vssh`, you'll go directly to the equivalent current directory of the host, under /vagrant. So run `vssh` from `some/directory` and you'll be dropped into `/vagrant/some/directory`.


### Arbitrary commands

Simply pass extra arguments to `vssh` to have them executed on the box, without dropping you into an interactive shell.

```
Debonair:app (master) $ uname
Darwin
Debonair:app (master) $ vssh uname
Linux
Debonair:app (master) $
```


## Limitations
We expect that the root of your app is shared as `/vagrant`. In reality this isn't always the case, so we should parse Vagrantfile or something.

## Inspiration
- Too much waiting
- A repo with projects as submodules
- [vassh](https://github.com/xwp/vassh)

