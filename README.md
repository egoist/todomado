# todo.md

![screenshot](http://i2.tietuku.com/c82c6c7d2301aed0.gif)

- [x] You made up your mind to create a todo?

- [x] Update the body of it?

- [x] Update the status of it?

- [x] Or just drop it?

- [x] Finally you can read all of it!

## Install

Use `npm` please:

```
sudo npm install -g todo.md
```

## Usage

```bash
# Check version out
$ todo -v

# add
$ todo add -m "to have some benchmark tests"

# list
$ todo 

# Modify by task number
$ todo 0 -m "to have some other benchmark tests"

# Delete by task number
$ todo 0 -d

## Finished / Unfinished a task
$ todo 0 done[, --done]
$ todo 0 undone[, --undone]

```

### Global TODO.md

Wow! Sounds awesome! You can have a todo list globally instead of using in a project directory.

Just by passing an arguement `-g`, just like:

```bash
todo -g
todo add "global todo item" -g
```

These todos will be stored in your home directory as `TODO.md`, in OS X it is `/Users/$whoami`, wherever you are just pass `-g` to make magic.

## License

MIT.