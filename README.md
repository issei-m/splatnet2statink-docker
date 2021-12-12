splatnet2statink-docker
=======================

The unofficial Docker image for [splatnet2statink](https://github.com/frozenpandaman/splatnet2statink).

This repository just keeps track of the original tool repository and builds an image to let it run as a containerized application.
Since this isn't the official tool repository so please go to the original if you want to read the document of the tool or send a bug-report or something.

## How to use

If you have the `config.txt` file for splatnet2statink, you can pass it via the variable `SPLATNET2STATINK_CONFIG`: 

```
$ s2scfg=$(cat config.txt) && docker run -it --rm -e SPLATNET2STATINK_CONFIG=$s2scfg isseim/splatnet2statink:v1.7.0
```

Of course, some options for the command such as `-r` are available.

**If you don't have the configuration file, you can create it by the following steps:**

1. Hit this, it will start interacting you to create a new config file

```
$ docker run -it --name s2s-for-configuration --rm isseim/splatnet2statink:v1.7.0 -t
```

2. Fill the values along questions the tool asked you
3. Once configuration finished, the tool will interact you again like this:

```
splatnet2statink v1.7.0
Pulling data from online...
Number of recent battles to upload (0-50)?
``` 

4. Open a new terminal tab and retrieve the configuration file from the container you started:

```
$ docker cp s2s-for-configuration:/opt/app/config.txt .
```

5. Back to the previous terminal, then you can now Ctrl-C to kill the container which is unnecessary anymore

## License 

[GPLv3](https://choosealicense.com/licenses/gpl-3.0/) in according with the origin tool repository.
