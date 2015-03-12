# todo.md

![screenshot](http://i2.tietuku.com/770df0328fd6f8e6.gif)

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

## License

MIT.